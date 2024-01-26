<%-- 
    Document   : commentForm
    Created on : 24 Dec 2023, 02:07:02
    Author     : Joat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.webpoi.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>ADD POI COMMENT</h1>
        <br />
        <%
            User user = (User) session.getAttribute("user");

            if (user != null) {
                out.println("Welcome, " + user.getName() + "!");                
            } else {
                response.sendRedirect("./loginDao.jsp");
            }
        %>
        <br />
        <form action="./addCommentDao.jsp" method="post">
            <p>Enter POI name:<input type="text" name="name" value="" /></p>
            <p>Enter comment:<input type="text" name="comment" value="" /></p>
            <br />
            <input type="submit" value="Submit" />
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
