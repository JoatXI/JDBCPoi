<%-- 
    Document   : adminPage
    Created on : 23 Dec 2023, 18:10:18
    Author     : Joat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.webpoi.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>WebPOI Page</title>
    </head>
    <body>
        <h1>POINTS OF INTEREST APP</h1>
        <br />
        <%
            User user = (User) session.getAttribute("user");

            if (user != null) {
                out.println("Welcome, " + user.getName() + "!");                
            } else {
                // User not logged in, redirect to login page
                response.sendRedirect("./loginDao.jsp");
            }
            %><br /><%
        %>
        <br />
        <form action="./logout.jsp" method="get">
                <input type="submit" value="Logout">
        </form>
        <br />
        
        <h2>ADD POI</h2>
        <form action="./addPoiDao.jsp" method="post">
            <p>POI name:<input type="text" name="name" value="" /></p>
            <p>POI location:<input type="text" name="location" value="" /></p>
            <p>POI type:
                <select name='type'>
                    <option>Restaurant</option>
                    <option>Bar</option>
                    <option>Museum</option>
                </select>
            </p>
            <p>
            <input type="submit" value="Add POI" />
        </form> 
        <br />
        
        <h2>SEARCH POI BY TYPE</h2>
        <form method="get" action="./searchTypeDao.jsp">
            <p>POI type:
                <select name="type">
                    <option>Restaurant</option>
                    <option>Bar</option>
                    <option>Museum</option>
                </select>
            </p>
            <input type="submit" value="Search" />
        </form>
        <br />
        
        <h2>SEARCH POI BY LOCATION</h2>
        <form method="get" action="./searchLocDao.jsp">
            <p>POI location: <input name="location" /></p>
            <input type="submit" value="Search" />
        </form>
        <br />
        
        <h2>LIKE A POI</h2>
        <form method="post" action="./pointsOfInterestDao.jsp">
            <input type="submit" value="Like POIs" />
        </form>
        <br />
        
        <h2>COMMENT ON POI</h2>
        <form action="./commentForm.jsp" method="post">
            <input type="submit" value="Go Add Comments" />
        </form>
        <br />
        
        <h2>VIEW POI COMMENTS</h2>
        <form action="./viewComments.jsp" method="post">
            <input type="submit" value="View Comments" />
        </form>
        <br />
        
        <h2>VIEW USERS LIST</h2>
        <form method="post" action="./userListDao.jsp">
            <input type="submit" value="View Users" />
        </form>
        <br />
        
        <h2>DELETE A USER</h2>
        <form method="post" action="./deleteUserForm.jsp">
            <input type="submit" value="Go Delete User" />
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
