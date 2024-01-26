<%-- 
    Document   : registerDao
    Created on : 23 Dec 2023, 21:11:46
    Author     : Joat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.mycompany.webpoi.User"%>
<%@page import="com.mycompany.webpoi.UserDao"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>REGISTER USER</h1>
        <br />
        <%
            Connection conn = null;

            try {
                Class.forName("org.sqlite.JDBC");
                conn = DriverManager.getConnection("jdbc:sqlite:E:\\GitWorks\\AE2\\Database\\poi.db");
                
                Statement stmt0 = conn.createStatement();
                stmt0.executeUpdate("CREATE TABLE if not exists users(name string, username string, password string, adminStatus boolean)");

                UserDao uDao = new UserDao(conn, "users");
                
                String name = request.getParameter("name");
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                boolean adminStatus = "on".equals(request.getParameter("admin")); // Check if the checkbox is checked
                
                // Check if the username is already taken
                if (uDao.checkUsername(username)) {
                    out.println("Username already exists. Click to <a href='./registrationForm.jsp'>Register</a> with a different Username.");
                } else {
                    // Register the user
                    User newUser = new User(name, username, password, adminStatus); // adminStatus returns a boolean regular(false) or admin(true) user
                    uDao.addUser(newUser);
                    out.println("Registration successful! Click to <a href='./index.jsp'>login</a>.");
                }
                
            } catch(SQLException e) {
                out.println("<strong>Error with database: " + e + "</strong>");
            } finally {
                if (conn != null) {
                    try {
                        conn.close();
                    }
                    catch(SQLException closeException) {
                        out.println("<strong>Error with closing database: " + closeException + "</strong>");
                    }
                }
            }
        %>
    </body>
</html>
