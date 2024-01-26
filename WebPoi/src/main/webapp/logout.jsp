<%-- 
    Document   : logout
    Created on : 23 Dec 2023, 01:45:26
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
        <h1>POINTS OF INTEREST APP</h1>
        
        <%
            // Invalidate the session to logout
            session.invalidate();
            response.sendRedirect("./index.jsp");
        %>
    </body>
</html>
