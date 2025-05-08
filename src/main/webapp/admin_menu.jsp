<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrator Menu</title>
    <style>
        /* Reset and basic styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            background-color: #102031;
            color: white;
            line-height: 1.6;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
            background-color: #204060;
            border-bottom: 2px solid #1a1a2e;
        }
        header h1 {
            font-size: 24px;
            margin: 0;
        }
        nav {
            display: flex;
            gap: 15px;
        }
        nav a {
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        nav a:hover {
            background-color: #1a1a2e;
        }
        .section {
            background-color: #1a1a2e;
            color: white;
            padding: 20px;
            margin-top: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        }
        .section h2 {
            font-size: 20px;
            margin-bottom: 10px;
            border-bottom: 2px solid #204060;
            padding-bottom: 5px;
        }
        .section p {
            margin-bottom: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            padding: 10px;
            border: 1px solid #204060;
            text-align: left;
        }
        th {
            background-color: #204060;
        }
        td {
            background-color: #102031;
        }
        .create-button {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 20px;
            background-color: #204060;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .create-button:hover {
            background-color: #406080;
        }
    </style>
</head>
<body>
    <header class="container">
        <h1>Administrator Menu</h1>
        <nav>
            <a href="view_users.jsp">View Users</a>
            <a href="manage_events.jsp">Manage Events</a>
            <a href="view_purchased_events.jsp">View Purchased Events</a>
        </nav>
    </header>

    <div class="container">
        <div class="section">
            <h2>Events</h2>
            <table>
                <thead>
                    <tr>
                        <th>Event Name</th>
                        <th>Category</th>
                        <th>Clicks</th>
                        <th>Event Date</th>
                        <th>Event Time</th>
                        <th>Location</th>
                        <th>Seated Price</th>
                        <th>Standing Price</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- Fetch and display events from database here --%>
                    <%
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ticketsystem", "root", "123456");
                            stmt = conn.createStatement();
                            String sql = "SELECT * FROM events";
                            rs = stmt.executeQuery(sql);
                            while (rs.next()) {
                                String eventName = rs.getString("event_name");
                                String category = rs.getString("category");
                                int clicks = rs.getInt("clicks");
                                Date eventDate = rs.getDate("event_date");
                                Time eventTime = rs.getTime("event_time");
                                String location = rs.getString("location");
                                String seatedPrice = rs.getString("seated_price");
                                String standingPrice = rs.getString("standing_price");
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
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
