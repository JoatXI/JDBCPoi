<%-- 
    Document   : editUserForm
    Created on : 25 Dec 2023, 19:58:16
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
        <h1>EDIT USER DETAILS</h1>
        <br />
        <%
            User user = (User) session.getAttribute("user");

            if (user != null) {
                out.println("Welcome, " + user.getName() + "!<br />");                
            } else {
                response.sendRedirect("./loginDao.jsp");
            }
            %><br /><%
            out.println("To edit the details of a USER you should provide the Current USERNAME of the USER along with the new USERNAME and other details you want to edit");
        %>
        <form action="./editUserDao.jsp" method="get">
            <label for="name">New Name:</label>
            <input type="text" name="name" required>
            <br>
            
            <label for="name">Current Username:</label>
            <input type="text" name="currUsername" required>
            <br>
            
            <label for="username">New Username:</label>
            <input type="text" name="username" required>
            <br>

            <label for="password">New Password:</label>
            <input type="password" name="password" required>
            <br>
            
            <input type="submit" value="Update">
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
