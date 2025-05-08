<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Summary</title>
    <style>
        body {
            background-color: #102031;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            color: white;
            padding: 20px;
        }
        .summary {
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
        HttpSession sessionpayment = request.getSession(false);
        String username = (sessionpayment != null) ? (String) sessionpayment.getAttribute("username") : null;

        if (username == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        String url = "jdbc:mysql://localhost:3306/ticketsystem";
        String user = "root";
        String password = "123456";

        Connection conn = null;
        PreparedStatement selectStmt = null;
        ResultSet rs = null;

        String eventId = request.getParameter("event_id");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            String selectSQL = "SELECT event_name, category, event_date, event_time, location, seated_price, standing_price FROM events WHERE id=?";
            selectStmt = conn.prepareStatement(selectSQL);
            selectStmt.setInt(1, Integer.parseInt(eventId));
            rs = selectStmt.executeQuery();

            if (rs.next()) {
                String eventName = rs.getString("event_name");
                String category = rs.getString("category");
                java.sql.Date eventDate = rs.getDate("event_date");
                java.sql.Time eventTime = rs.getTime("event_time");
                String location = rs.getString("location");
                String seatedPrice = rs.getString("seated_price");
                String standingPrice = rs.getString("standing_price");

                String discountMessage = "";
                boolean freeTicket = false;

                String purchaseSQL = "SELECT COUNT(*) FROM purchases WHERE username=?";
                PreparedStatement purchaseStmt = conn.prepareStatement(purchaseSQL);
                purchaseStmt.setString(1, username);
                ResultSet purchaseRs = purchaseStmt.executeQuery();
                if (purchaseRs.next() && purchaseRs.getInt(1) % 5 == 4) {
                    discountMessage = "Congratulations! This is your 5th purchase, so it's free!";
                    freeTicket = true;
                }

    %>
    <div class="summary">
        <h2>Order Summary</h2>
        <p>Event Name: <%= eventName %></p>
        <p>Category: <%= category %></p>
        <p>Event Date: <%= eventDate %></p>
        <p>Event Time: <%= eventTime %></p>
        <p>Location: <%= location %></p>
        <p>Seated Price: <%= seatedPrice %></p>
        <p>Standing Price: <%= standingPrice %></p>
        <p><%= discountMessage %></p>
        <form method="post" action="payment.jsp">
            <input type="hidden" name="event_id" value="<%= eventId %>">
            <input type="hidden" name="free_ticket" value="<%= freeTicket %>">
            <input type="hidden" name="price" value="<%= seatedPrice %>">
            <button type="submit">Confirm Order</button>
        </form>
    </div>
    <%
            } else {
                out.println("<h2>Event not found.</h2>");
            }
        } catch (Exception e) {
            out.println("<h2>Error: " + e.getMessage() + "</h2>");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (selectStmt != null) selectStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("<h2>Error closing resources: " + e.getMessage() + "</h2>");
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
