<%-- 
    Document   : editUserDao
    Created on : 25 Dec 2023, 20:19:34
    Author     : Joat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.util.ArrayList" %>
<%@page import="com.mycompany.webpoi.UserDao" %>
<%@page import="com.mycompany.webpoi.User" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>EDIT USER DETAILS</h1>
        <br />
        <%
            Connection conn = null;

            try {
                Class.forName("org.sqlite.JDBC");
                conn = DriverManager.getConnection("jdbc:sqlite:E:\\GitWorks\\AE2\\Database\\poi.db");

                User user = (User) session.getAttribute("user");

                // Retrieves user details from the form
                String currUsername = request.getParameter("currUsername");
                String newUsername = request.getParameter("username");
                String newName = request.getParameter("name");
                String newPassword = request.getParameter("password");

                UserDao uDao = new UserDao(conn, "poi");
                boolean updateSuccess = uDao.updateUser(currUsername, newName, newUsername, newPassword);

                if(updateSuccess) {
                    // Redirect to a success page message
                    if(user.isAdmin()) {
                        out.println("User Details Successfully Updated! Return to <a href='./adminPage.jsp'>Homepage</a>.");
                    } else {
                        out.println("User Details Successfully Updated! Return to <a href='./userPage.jsp'>Homepage</a>.");
                    }
                } else {
                    out.println("Error! User Not Found. Click <a href='./editUserForm.jsp'>Here</a> to go back.");
                }

            } catch(SQLException e) {
                out.println("<strong>Error with database: " + e + "</strong>");
            }    
            finally {
                // Close the connection if it was made successfully
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
