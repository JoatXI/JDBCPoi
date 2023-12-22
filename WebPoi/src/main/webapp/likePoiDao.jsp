<%-- 
    Document   : likePoiDao
    Created on : 22 Dec 2023, 00:35:12
    Author     : Joat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.ArrayList" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="com.mycompany.webpoi.Poi" %>
<%@page import="com.mycompany.webpoi.PoiDao" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Like A POI</h1>
        
        <%
            Connection conn = null;

            try {
                Class.forName("org.sqlite.JDBC");
                conn = DriverManager.getConnection("jdbc:sqlite:S:\\#CODED\\JDBCPoi\\Database\\poi.db");

                PoiDao dao = new PoiDao(conn, "poi");

                String name = request.getParameter("poiName");

                boolean likeSuccess = dao.likePoi(name);

                if(likeSuccess) {
                    out.println("POI liked successfully!");
                } else {
                    out.println("Failed to like POI or POI not found!");
                }
            } catch (SQLException | ClassNotFoundException e) {
                out.println("<strong>Error with database: " + e + "</strong>");
            } finally {
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
