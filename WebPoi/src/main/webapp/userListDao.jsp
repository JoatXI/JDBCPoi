<%-- 
    Document   : userListDao
    Created on : 25 Dec 2023, 21:55:01
    Author     : Joat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.ArrayList" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="com.mycompany.webpoi.User" %>
<%@page import="com.mycompany.webpoi.UserDao" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>VIEW USER</h1>
        <br />
        <%
            Connection conn = null;

            try {
                Class.forName("org.sqlite.JDBC");
                conn = DriverManager.getConnection("jdbc:sqlite:E:\\GitWorks\\AE2\\Database\\poi.db");
                
                User user = (User) session.getAttribute("user");

                Statement stmt0 = conn.createStatement();
                stmt0.executeUpdate("CREATE TABLE if not exists users(name string, username string, password string)");

                UserDao dao = new UserDao(conn, "users");
                
                
                ArrayList<User> userList = dao.displayUsers();

                for (User currentUser : userList) {
                    // Displays information about the current Users
                    %>
                    <p>Name: <%= currentUser.getName() %></p>
                    <p>Username: <%= currentUser.getUsername() %></p>
                    
                    <form action="./editUserForm.jsp" method="post">
                        <input type="hidden" name="username" value="<%=currentUser.getUsername()%>" />
                        <input type="submit" value="Edit User" />
                    </form>
                    <%
                }
                %><br /><%
                if(user.isAdmin()) {
                    out.println("Click to Return to <a href='./adminPage.jsp'>Homepage</a>.");
                } else {
                    out.println("Click to Return to <a href='./userPage.jsp'>Homepage</a>.");
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
