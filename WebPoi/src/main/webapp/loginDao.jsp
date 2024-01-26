<%-- 
    Document   : loginDao
    Created on : 22 Dec 2023, 03:46:40
    Author     : Joat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="com.mycompany.webpoi.User" %>
<%@page import="com.mycompany.webpoi.UserDao" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>USER LOGIN</h1>
        <br />
        <%
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            Connection conn = null;

            try {
                Class.forName("org.sqlite.JDBC");
                conn = DriverManager.getConnection("jdbc:sqlite:E:\\GitWorks\\AE2\\Database\\poi.db");

                Statement stmt0 = conn.createStatement();
                stmt0.executeUpdate("CREATE TABLE if not exists users(username string, password string, adminStatus boolean)");

                UserDao dao = new UserDao(conn, "users");

                //Authenticate the user
                User authedUser = dao.authenticateLogin(username, password);

                if(authedUser != null) {
                    // Set user attribute in the session
                    session.setAttribute("user", authedUser);

                    // Redirect to the appropriate user page
                    if (authedUser.isAdmin()) {
                        response.sendRedirect("./adminPage.jsp");
                    } else {
                        response.sendRedirect("./userPage.jsp");
                    }
                } else {
                    response.sendRedirect("./logout.jsp");
                }

            } catch(SQLException e) {
                out.println("<strong>Error with database: " + e + "</strong>");
            }    
            finally {
                if(conn != null) {
                    try {
                        conn.close();
                    } catch(SQLException closeException) {
                        out.println("<strong>Error with closing database: " + closeException + "</strong>");
                    }
                }
            }
        %>
    </body>
</html>
