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

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Add POI</h1>
        
        <%
            
        Connection conn = null;
        
        try {
            Class.forName("org.sqlite.JDBC");
            conn = DriverManager.getConnection("jdbc:sqlite:S:\\GitWorks\\AE2\\Database\\poi.db");
            
            Statement stmt0 = conn.createStatement();
            stmt0.executeUpdate("CREATE TABLE if not exists poi(name string, type string, location string, likes integer)");
        
            PoiDao dao = new PoiDao(conn, "poi");
            
            String name = request.getParameter("name"),
                    type = request.getParameter("type"),
                    location = request.getParameter("location"),
                    likesParam = request.getParameter("likes");
                    
            long likes = (likesParam != null && !likesParam.isEmpty()) ? Long.parseLong(likesParam) : 0L;
            Poi p = new Poi(name, type, location);
            p.setLikes(likes);
            
            dao.addPoi(p);
            out.println("Poi added to the database!");
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
