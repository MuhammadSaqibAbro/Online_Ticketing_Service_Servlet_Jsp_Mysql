<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Events</title>
    <style>
        body {
            background-color: #102031;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            color: white;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #204060;
        }
        .container {
            margin: 20px 0;
        }
        button {
            padding: 10px 20px;
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
    <script>
        function confirmBuy(eventId) {
            if (confirm("Are you sure you want to buy this event?")) {
                document.getElementById('purchase_form_' + eventId).submit();
            }
        }
    </script>
</head>
<body>
    <h2>All Events</h2>
    <div class="container">
        <table>
            <tr>
                <th>Event Name</th>
                <th>Category</th>
                <th>Clicks</th>
                <th>Event Date</th>
                <th>Event Time</th>
                <th>Location</th>
                <th>Seated Price</th>
                <th>Standing Price</th>
                <th>Image</th>
                <th>Action</th>
            </tr>
            <% 
                String url = "jdbc:mysql://localhost:3306/ticketsystem";
                String user = "root";
                String password = "123456";

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, password);

                    String sql = "SELECT id, event_name, category, clicks, event_date, event_time, location, seated_price, standing_price, image_path FROM events";

                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();

                    if (!rs.isBeforeFirst()) {
                        out.println("<tr><td colspan='10'>No events found.</td></tr>");
                    } else {
                        while (rs.next()) {
                            int eventId = rs.getInt("id");
                            String eventName = rs.getString("event_name");
                            String category = rs.getString("category");
                            int clicks = rs.getInt("clicks");
                            java.sql.Date eventDate = rs.getDate("event_date");
                            java.sql.Time eventTime = rs.getTime("event_time");
                            String location = rs.getString("location");
                            String seatedPrice = rs.getString("seated_price");
                            String standingPrice = rs.getString("standing_price");
                            String imagePath = rs.getString("image_path");
            %>
                            <tr>
                                <td><%= eventName %></td>
                                <td><%= category %></td>
                                <td><%= clicks %></td>
                                <td><%= eventDate %></td>
                                <td><%= eventTime %></td>
                                <td><%= location %></td>
                                <td><%= seatedPrice %></td>
                                <td><%= standingPrice %></td>
                                <td><img src="<%= imagePath %>" alt="Event Image" width="100"></td>
                                <td>
                                    <form id="purchase_form_<%= eventId %>" method="post" action="order_summary.jsp">
                                        <input type="hidden" name="event_id" value="<%= eventId %>">
                                        <button type="button" onclick="confirmBuy(<%= eventId %>)">Buy</button>
                                    </form>
                                </td>
                            </tr>
            <% 
                        }
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='10'>Error: " + e.getMessage() + "</td></tr>");
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        out.println("<tr><td colspan='10'>Error closing resources: " + e.getMessage() + "</td></tr>");
                        e.printStackTrace();
                    }
                }
            %>
        </table>
    </div>
</body>
</html>
