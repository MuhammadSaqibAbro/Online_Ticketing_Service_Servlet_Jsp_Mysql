<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Purchase</title>
    <style>
        body {
            background-color: #102031;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            color: white;
            padding: 20px;
        }
        .container {
            background-color: #1a1a2e;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            max-width: 600px;
            margin: auto;
        }
        .container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #204060;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        button:hover {
            background-color: #1a2e40;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Confirm Purchase</h2>
        <%
            String url = "jdbc:mysql://localhost:3306/ticketsystem";
            String user = "root";
            String password = "123456";
            
            Connection conn = null;
            PreparedStatement insertStmt = null;
            ResultSet rs = null;

            String eventId = request.getParameter("event_id");
            String eventName = request.getParameter("event_name");
            String category = request.getParameter("category");
            String eventDate = request.getParameter("event_date");
            String eventTime = request.getParameter("event_time");
            String location = request.getParameter("location");
            String seatedPrice = request.getParameter("seated_price");
            String standingPrice = request.getParameter("standing_price");
            int seatedTickets = Integer.parseInt(request.getParameter("seated_tickets"));
            int standingTickets = Integer.parseInt(request.getParameter("standing_tickets"));
            double totalPrice = seatedTickets * Double.parseDouble(seatedPrice) + standingTickets * Double.parseDouble(standingPrice);

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);

                String insertSQL = "INSERT INTO purchase (event_id, event_name, category, event_date, event_time, location, seated_tickets, standing_tickets, total_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                insertStmt = conn.prepareStatement(insertSQL);

                insertStmt.setInt(1, Integer.parseInt(eventId));
                insertStmt.setString(2, eventName);
                insertStmt.setString(3, category);
                insertStmt.setDate(4, Date.valueOf(eventDate));
                insertStmt.setTime(5, Time.valueOf(eventTime));
                insertStmt.setString(6, location);
                insertStmt.setInt(7, seatedTickets);
                insertStmt.setInt(8, standingTickets);
                insertStmt.setDouble(9, totalPrice);

                int rowsInserted = insertStmt.executeUpdate();

                if (rowsInserted > 0) {
                    out.println("<h2>Event purchased successfully!</h2>");
                    out.println("<p>Total Price: $" + totalPrice + "</p>");
                } else {
                    out.println("<h2>Failed to purchase event.</h2>");
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
        <button onclick="window.location.href='all_events.jsp'">Back to Events</button>
    </div>
</body>
</html>
