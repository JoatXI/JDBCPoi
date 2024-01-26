<%-- 
    Document   : addPoiDao
    Created on : 21 Dec 2023, 21:25:08
    Author     : Joat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.Statement" %>
<%@page import="com.mycompany.webpoi.PoiDao" %>
<%@page import="com.mycompany.webpoi.Poi" %>
<%@page import="com.mycompany.webpoi.User" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ADD POI</title>
    </head>
    <body>
        <h1>ADD POI</h1>
        <br />
        <%
            
            Connection conn = null;

            try {
                Class.forName("org.sqlite.JDBC");
                conn = DriverManager.getConnection("jdbc:sqlite:E:\\GitWorks\\AE2\\Database\\poi.db");

                User user = (User) session.getAttribute("user");

                Statement stmt0 = conn.createStatement();
                stmt0.executeUpdate("CREATE TABLE if not exists poi(name string, type string, location string, likes INTEGER)");

                PoiDao dao = new PoiDao(conn, "poi");

                String name = request.getParameter("name"),
                        type = request.getParameter("type"),
                        location = request.getParameter("location"),
                        likesParam = request.getParameter("likes");

                long likes = (likesParam != null && !likesParam.isEmpty()) ? Long.parseLong(likesParam) : 0L;
                Poi p = new Poi(name, type, location, likes);
                p.setLikes(likes);

                dao.addPoi(p);
                if(user.isAdmin()) {
                    out.println("POI successfully added. Click to Return to <a href='./adminPage.jsp'>Homepage</a>.");
                } else {
                    out.println("POI successfully added. Click to Return to <a href='./userPage.jsp'>Homepage</a>.");
                }

            } catch(SQLException e) {
                out.println("<strong>Error with database: " + e + "</strong>");
            }    
            finally {
                if(conn != null) {
                    try {
                        conn.close();
                    } catch(SQLException closeException) {
                        out.println("<strong>Error with closing database: " + closeException + "</strong>");
                    }
                }
            }
        %>
    </body>
</html>
