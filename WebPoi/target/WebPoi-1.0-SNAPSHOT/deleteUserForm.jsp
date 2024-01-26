<%-- 
    Document   : deleteUserForm
    Created on : 25 Dec 2023, 23:36:17
    Author     : Joat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            User user = (User) session.getAttribute("user");

            if (user != null) {
                out.println("Welcome, " + user.getName() + "!<br />");                
            } else {
                // User not logged in, redirect to login page
                response.sendRedirect("./loginDao.jsp");
            }
            %><br /><%
            out.println("To DELETE a current USER you should provide the USERNAME of the USER");
        %>
        <br />
        <form action="./deleteUserDao.jsp" method="get">
            <label for="username">Enter Username:</label>
            <input type="text" name="username" required>
            <br />
            
            <input type="submit" value="Delete">
        </form>
        <br />
        <%
            if(user.isAdmin()) {
                out.println("Click to Return to <a href='./adminPage.jsp'>Homepage</a>.");
            } else {
                out.println("Click to Return to <a href='./userPage.jsp'>Homepage</a>.");
            }
        %>
    </body>
</html>
