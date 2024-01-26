<%-- 
    Document   : viewComments
    Created on : 24 Dec 2023, 21:14:14
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
        <h1>VIEW COMMENTS</h1>
        <br />
        <%
            User user = (User) session.getAttribute("user");

            if (user != null) {
                out.println("Welcome, " + user.getName() + "!");                
            } else {
                // User not logged in, redirect to login page
                response.sendRedirect("./loginDao.jsp");
            }
        %>
        <br />
        <form action="./viewCommentsDao.jsp" method="post">
            <p>Enter POI name:<input type="text" name="poiName" value="" /></p>
            <br />
            <input type="submit" value="View Comments" />
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
