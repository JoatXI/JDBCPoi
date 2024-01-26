<%-- 
    Document   : deleteCommentDao
    Created on : 26 Dec 2023, 01:45:56
    Author     : Joat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.util.ArrayList" %>
<%@page import="com.mycompany.webpoi.CommentDao" %>
<%@page import="com.mycompany.webpoi.Comment" %>
<%@page import="com.mycompany.webpoi.User" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>DELETE COMMENT</h1>
        <br />
        <%
            Connection conn = null;

            try {
                Class.forName("org.sqlite.JDBC");
                conn = DriverManager.getConnection("jdbc:sqlite:E:\\GitWorks\\AE2\\Database\\poi.db");
                
                User user = (User) session.getAttribute("user");

                String idString = request.getParameter("id");

                CommentDao cDao = new CommentDao(conn, "comments");
                long id = Long.parseLong(idString);
                
                boolean deleteSuccess = cDao.deleteComment(id);

                if (deleteSuccess) {
                    if(user.isAdmin()) {
                        out.println("Comment Deleted Successfully! Return to <a href='./adminPage.jsp'>Homepage</a>.");
                    } else {
                        out.println("Comment Deleted Successfully! Return to <a href='./userPage.jsp'>Homepage</a>.");
                    }
                } else {
                    out.println("Error! Comments Not Found Click <a href='./viewComments.jsp'>HERE</a> to go back.");
                }
                
            } catch (SQLException e) {
                out.println("<strong>Error with database: " + e + "</strong>");
            } finally {
                // Close the connection if it was made successfully
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
