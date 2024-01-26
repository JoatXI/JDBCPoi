<%-- 
    Document   : likePoiDao
    Created on : 22 Dec 2023, 00:35:12
    Author     : Joat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="com.mycompany.webpoi.Poi" %>
<%@page import="com.mycompany.webpoi.PoiDao" %>
<%@page import="com.mycompany.webpoi.User" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>LIKE A POI</h1>
        <br />
        <%
            Connection conn = null;

            try {
                Class.forName("org.sqlite.JDBC");
                conn = DriverManager.getConnection("jdbc:sqlite:E:\\GitWorks\\AE2\\Database\\poi.db");
                
                User user = (User) session.getAttribute("user");

                PoiDao dao = new PoiDao(conn, "poi");

                String name = request.getParameter("poiName");
                
                boolean likeSuccess = dao.likePoi(name);

                if(likeSuccess) {
                    if(user.isAdmin()) {
                        out.println("POI successfully liked. Click to Return to <a href='./adminPage.jsp'>Homepage</a>.");
                    } else {
                        out.println("POI successfully liked. Click to Return to <a href='./userPage.jsp'>Homepage</a>.");
                    }
                } else {
                    out.println("Error! Could Not like POI. Click <a href='./pointsOfInterestDao.jsp'>HERE</a> to go back.");
                }
                
            } catch (SQLException e) {
                out.println("<strong>Error with database: " + e + "</strong>");
            } 
            finally {
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException closeException) {
                        out.println("<strong>Error with closing database: " + closeException + "</strong>");
                    }
                }
            }
        %>
    </body>
</html>
