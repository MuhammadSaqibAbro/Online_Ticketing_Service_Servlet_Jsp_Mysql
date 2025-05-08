<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Action</title>
</head>
<body>
    <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if ("admin".equals(username) && "Admin@123".equals(password)) {
            session.setAttribute("username", username);
            session.setAttribute("loggedIn", true);
            response.sendRedirect("eventForUser.jsp");
        } else {
            out.println("<h2>Login Failed. Invalid username or password.</h2>");
            out.println("<a href='login.jsp'>Try Again</a>");
        }
    %>
</body>
</html>
