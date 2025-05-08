<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Event Details</title>
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
        .event-details {
            background-color: #204060;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        }
        .event-details img {
            width: 100%;
            height: auto;
            border-radius: 10px;
        }
        .event-details h2 {
            margin-top: 0;
        }
        .event-details p {
            margin: 10px 0;
        }
        .purchase-button {
            background-color: #102031;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            display: inline-block;
        }
        .purchase-button:hover {
            background-color: #1a1a2e;
        }
        .search-form {
            margin-bottom: 20px;
        }
        .search-form input[type="text"] {
            padding: 8px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .search-form input[type="submit"] {
            background-color: #102031;
            color: white;
            border: none;
            padding: 8px 16px;
            cursor: pointer;
            border-radius: 5px;
        }
        .search-form input[type="submit"]:hover {
            background-color: #1a1a2e;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="search-form">
            <form method="get" action="eventDetails.jsp">
                <label for="eventId">Enter Event ID:</label>
                <input type="text" id="eventId" name="eventId" required>
                <input type="submit" value="Search">
            </form>
        </div>
        <div class="event-details">
            <%
                String eventIdParam = request.getParameter("eventId");
                if (eventIdParam != null && !eventIdParam.isEmpty()) {
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

                            String sql = "SELECT * FROM events WHERE id = ?";
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setInt(1, eventId);
                            rs = pstmt.executeQuery();

                            if (rs.next()) {
                                String name = rs.getString("name");
                                String date = rs.getString("date");
                                String time = rs.getString("time");
                                String location = rs.getString("location");
                                double seatedPrice = rs.getDouble("seated_price");
                                double standingPrice = rs.getDouble("standing_price");
                                String image = rs.getString("image");

                                out.println("<h2>" + name + "</h2>");
                                out.println("<img src='" + image + "' alt='" + name + "'>");
                                out.println("<p>Date: " + date + "</p>");
                                out.println("<p>Time: " + time + "</p>");
                                out.println("<p>Location: " + location + "</p>");
                                out.println("<p>Seated Ticket: $" + seatedPrice + "</p>");
                                out.println("<p>Standing Ticket: $" + standingPrice + "</p>");
                                out.println("<a href='purchase.jsp?eventId=" + eventId + "&ticketType=seated' class='purchase-button'>Purchase Seated Ticket</a>");
                                out.println("<a href='purchase.jsp?eventId=" + eventId + "&ticketType=standing' class='purchase-button'>Purchase Standing Ticket</a>");
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
                    out.println("<p>No event ID provided.</p>");
                }
            %>
        </div>
    </div>
</body>
</html>
