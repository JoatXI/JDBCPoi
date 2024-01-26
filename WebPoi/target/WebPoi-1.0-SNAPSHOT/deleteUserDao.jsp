<%-- 
    Document   : deleteUserDao
    Created on : 25 Dec 2023, 23:45:36
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
        <h1>DELETE USER</h1>
        <br />
        <%
            Connection conn = null;

            try {
                Class.forName("org.sqlite.JDBC");
                conn = DriverManager.getConnection("jdbc:sqlite:E:\\GitWorks\\AE2\\Database\\poi.db");

                User user = (User) session.getAttribute("user");
                
                // Retrieve user details from the form
                String username = request.getParameter("username");

                UserDao uDao = new UserDao(conn, "users");
                boolean deleteSuccess = uDao.deleteUser(username);
                
                if(deleteSuccess) {
                    if(user.isAdmin()) {
                        out.println("User Deleted Successfully! Return to <a href='./adminPage.jsp'>Homepage</a>.");
                    } else {
                        out.println("User Deleted Successfully! Return to <a href='./userPage.jsp'>Homepage</a>.");
                    }
                } else {
                    out.println("Error! User Not Found! Click <a href='./deleteUserForm.jsp'>HERE</a> to try again. Make sure you enter a current user USERNAME.");
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
