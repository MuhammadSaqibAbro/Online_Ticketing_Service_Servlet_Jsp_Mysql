<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment</title>
    <style>
        body {
            background-color: #102031;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            color: white;
            text-align: center;
            padding: 20px;
        }
        .payment {
            background-color: #204060;
            padding: 20px;
            border-radius: 10px;
            display: inline-block;
            text-align: left;
        }
        button {
            padding: 10px 20px;
            background-color: #204060;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 20px;
        }
        button:hover {
            background-color: #1a2e40;
        }
    </style>
</head>
<body>
    <%
        HttpSession sessionPayment = request.getSession(false);
        String usernamePayment = (sessionPayment != null) ? (String) sessionPayment.getAttribute("username") : null;

        if (usernamePayment == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        String url = "jdbc:mysql://localhost:3306/ticketsystem";
        String user = "root";
        String password = "123456";

        Connection conn = null;
        PreparedStatement insertStmt = null;

        String eventId = request.getParameter("event_id");
        boolean freeTicket = Boolean.parseBoolean(request.getParameter("free_ticket"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            String insertSQL = "INSERT INTO purchases (username, event_id, price) VALUES (?, ?, ?)";
            insertStmt = conn.prepareStatement(insertSQL);
            insertStmt.setString(1, usernamePayment);
            insertStmt.setInt(2, Integer.parseInt(eventId));
            insertStmt.setDouble(3, freeTicket ? 0.0 : Double.parseDouble(request.getParameter("price")));

            int rows = insertStmt.executeUpdate();

            if (rows > 0) {
                out.println("<div class='payment'>");
                out.println("<h2>Payment Successful!</h2>");
                out.println("<p>Thank you for your purchase. Your tickets have been booked successfully.</p>");
                out.println("</div>");
            } else {
                out.println("<h2>Payment Failed.</h2>");
            }
        } catch (Exception e) {
            out.println("<h2>Error: " + e.getMessage() + "</h2>");
            e.printStackTrace();
        } finally {
            try {
                if (insertStmt != null) insertStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("<h2>Error closing resources: " + e.getMessage() + "</h2>");
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
