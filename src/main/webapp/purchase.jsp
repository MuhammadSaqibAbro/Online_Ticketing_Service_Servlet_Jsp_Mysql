<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Purchase Tickets</title>
    <style>
        body {
            background-color: #102031;
            font-family: Arial, sans-serif;
            color: white;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
        }
        .purchase-details {
            background-color: #204060;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        }
        .purchase-details h2 {
            margin-top: 0;
        }
        .purchase-details p {
            margin: 10px 0;
        }
        .confirm-button {
            background-color: #102031;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            display: inline-block;
            margin-right: 10px;
        }
        .confirm-button:hover {
            background-color: #1a1a2e;
        }
        .cancel-button {
            background-color: #102031;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            display: inline-block;
        }
        .cancel-button:hover {
            background-color: #1a1a2e;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="purchase-details">
            <%
                String eventIdParam = request.getParameter("eventId");
                String ticketType = request.getParameter("ticketType");
                
                if (eventIdParam != null && !eventIdParam.isEmpty() && ticketType != null && !ticketType.isEmpty()) {
                    try {
                        int eventId = Integer.parseInt(eventIdParam);

                        String url = "jdbc:mysql://localhost:3306/ticketsystem";
                        String user = "root";
                        String password = "123456";

                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection(url, user, password);

                            // Fetch event details for confirmation
                            String sql = "SELECT name, date, time, location";
                            if (ticketType.equals("seated")) {
                                sql += ", seated_price AS price";
                            } else if (ticketType.equals("standing")) {
                                sql += ", standing_price AS price";
                            }
                            sql += " FROM events WHERE id = ?";
                            
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setInt(1, eventId);
                            rs = pstmt.executeQuery();

                            if (rs.next()) {
                                String eventName = rs.getString("name");
                                String eventDate = rs.getString("date");
                                String eventTime = rs.getString("time");
                                String eventLocation = rs.getString("location");
                                double ticketPrice = rs.getDouble("price");

                                %>
                                <h2>Purchase Details</h2>
                                <p>Event: <%= eventName %></p>
                                <p>Date: <%= eventDate %></p>
                                <p>Time: <%= eventTime %></p>
                                <p>Location: <%= eventLocation %></p>
                                <p>Ticket Type: <%= ticketType.equals("seated") ? "Seated" : "Standing" %> Ticket</p>
                                <p>Price: $<%= ticketPrice %></p>
                                <form method="post" action="confirmPurchase.jsp">
                                    <input type="hidden" name="eventId" value="<%= eventId %>">
                                    <input type="hidden" name="ticketType" value="<%= ticketType %>">
                                    <input type="hidden" name="ticketPrice" value="<%= ticketPrice %>">
                                    <button type="submit" class="confirm-button">Confirm Purchase</button>
                                    <a href="eventDetails.jsp?eventId=<%= eventId %>" class="cancel-button">Cancel</a>
                                </form>
                                <%
                            } else {
                                out.println("<p>Event not found.</p>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("<p>Error: " + e.getMessage() + "</p>");
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (pstmt != null) pstmt.close();
                                if (conn != null) conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    } catch (NumberFormatException e) {
                        out.println("<p>Invalid event ID.</p>");
                    }
                } else {
                    out.println("<p>Invalid request. Missing parameters.</p>");
                }
            %>
        </div>
    </div>
</body>
</html>
>