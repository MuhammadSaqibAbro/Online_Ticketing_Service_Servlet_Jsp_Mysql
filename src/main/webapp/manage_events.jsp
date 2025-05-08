<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Events</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
        #chart-container {
            width: 50%;
            margin: auto;
        }
    </style>
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

                Map<String, Integer> categoryClicks = new HashMap<>();

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

                            // Add clicks to categoryClicks map
                            categoryClicks.put(category, categoryClicks.getOrDefault(category, 0) + clicks);
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
                                    <form method="post" action="delete_event.jsp" style="display:inline;">
                                        <input type="hidden" name="event_id" value="<%= eventId %>">
                                        <button type="submit">Delete</button>
                                    </form>
                                </td>
                            </tr>
            <% 
                        }
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='10'>Error: " + e.getMessage() + "</td></tr>");
                    e.printStackTrace(); // Print stack trace to the server log for debugging
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        out.println("<tr><td colspan='10'>Error closing resources: " + e.getMessage() + "</td></tr>");
                        e.printStackTrace(); // Print stack trace to the server log for debugging
                    }
                }
            %>
        </table>
    </div>
    <div class="container">
        <button onclick="window.location.href='create_event.jsp'">Create new event</button>
    </div>
    <div id="chart-container">
        <canvas id="categoryChart"></canvas>
    </div>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const ctx = document.getElementById('categoryChart').getContext('2d');
            const categoryData = {
                <% 
                    for (Map.Entry<String, Integer> entry : categoryClicks.entrySet()) {
                        String key = entry.getKey();
                        Integer value = entry.getValue();
                %>
                "<%= key %>": <%= value %>,
                <% 
                    } 
                %>
            };
            const labels = Object.keys(categoryData);
            const data = Object.values(categoryData);

            new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Clicks by Category',
                        data: data,
                        backgroundColor: [
                            '#ff6384',
                            '#36a2eb',
                            '#cc65fe',
                            '#ffce56',
                            '#009688',
                            '#795548'
                        ],
                        hoverBackgroundColor: [
                            '#ff6384',
                            '#36a2eb',
                            '#cc65fe',
                            '#ffce56',
                            '#009688',
                            '#795548'
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    const label = context.label || '';
                                    const value = context.raw || 0;
                                    const total = data.reduce((a, b) => a + b, 0);
                                    const percentage = ((value / total) * 100).toFixed(2);
                                    return `${label}: ${value} (${percentage}%)`;
                                }
                            }
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>
