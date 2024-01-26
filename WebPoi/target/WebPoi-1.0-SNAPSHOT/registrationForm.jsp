<%-- 
    Document   : registerionForm
    Created on : 23 Dec 2023, 16:23:15
    Author     : Joat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>REGISTER NEW USER</h1>
        <br />
        
        <form action="./registerDao.jsp" method="get">
            <label for="name">Name:</label>
            <input type="text" name="name" required>
            <br>
            
            <label for="username">Username:</label>
            <input type="text" name="username" required>
            <br>

            <label for="password">Password:</label>
            <input type="password" name="password" required>
            <br>
            
            <label for="admin">Register as Admin:</label>
            <input type="checkbox" name="admin">
            <br />
            <input type="submit" value="Register">
        </form>
        <br />
    </body>
</html>
