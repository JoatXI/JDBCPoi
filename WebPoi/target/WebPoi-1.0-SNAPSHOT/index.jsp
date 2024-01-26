<%-- 
    Document   : index
    Created on : 23 Dec 2023, 01:13:37
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
        <h2>LOGIN/REGISTER</h2>
        
        <form action="./loginDao.jsp" method="get">
            <label for="username">Username:</label>
            <input type="text" name="username" required>
            <br>

            <label for="password">Password:</label>
            <input type="password" name="password" required>
            <br>

            <input type="submit" value="Login">
        </form>
        <br />
        
        <p>New User?</p>
        <br />
        <!-- Registration Page-->
        <form action="./registrationForm.jsp" method="post">
            <input type="submit" value="Register">
        </form>
    </body>
</html>
