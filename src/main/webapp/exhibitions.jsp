<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" %>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Establishing database connection
        String url = "jdbc:mysql://localhost:3306/ticketsystem";
        String user = "root";
        String password = "123456";
        Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL JDBC driver
        conn = DriverManager.getConnection(url, user, password);

        String sql = "SELECT * FROM events WHERE name LIKE 'exhibition%' OR name LIKE 'Exhibition%'";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        List<Map<String, Object>> events = new ArrayList<>();
        while (rs.next()) {
            Map<String, Object> event = new HashMap<>();
            event.put("id", rs.getInt("id"));
            event.put("name", rs.getString("name"));
            event.put("date", rs.getDate("date"));
            event.put("time", rs.getTime("time"));
            event.put("location", rs.getString("location"));
            event.put("seated_price", rs.getDouble("seated_price"));
            event.put("standing_price", rs.getDouble("standing_price"));
            events.add(event);
        }

        request.setAttribute("events", events); // Storing events list in request attribute

    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    } finally {
        // Closing resources in finally block
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Exhibitions</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            background-color: #102031; 
            color: white; 
            margin: 0;
            padding: 0;
        }
        .container { 
            max-width: 800px; 
            margin: 20px auto; 
            padding: 20px; 
            background-color: #1a1a2e;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 20px;
        }
        th, td { 
            padding: 10px; 
            border: 1px solid #ccc; 
            text-align: left;
        }
        th { 
            background-color: #204060; 
            color: white; 
        }
        td { 
            color: white; 
        }
        .btn { 
            padding: 10px 20px; 
            background-color: #204060; 
            color: white; 
            border: none; 
            cursor: pointer; 
            text-decoration: none;
            display: inline-block;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .btn:hover { 
            background-color: #1a1a2e; 
        }
        .btn:focus {
            outline: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Available Exhibitions</h1>
        <table>
            <tr>
                <th>Name</th>
                <th>Date</th>
                <th>Time</th>
                <th>Location</th>
                <th>Seated Price</th>
                <th>Standing Price</th>
                <th>Action</th>
            </tr>
            <% 
            List<Map<String, Object>> events = (List<Map<String, Object>>) request.getAttribute("events");
            if (events != null && !events.isEmpty()) {
                for (Map<String, Object> event : events) {
            %>
                <tr>
                    <td><%= event.get("name") %></td>
                    <td><%= event.get("date") %></td>
                    <td><%= event.get("time") %></td>
                    <td><%= event.get("location") %></td>
                    <td>$ <%= event.get("seated_price") %></td>
                    <td>$ <%= event.get("standing_price") %></td>
                    <td>
                        <form method="post" action="generateBill.jsp">
                            <input type="hidden" name="event_id" value="<%= event.get("id") %>">
                            <button type="submit" class="btn">Book & Print Bill</button>
                        </form>
                    </td>
                </tr>
            <% 
                }
            } else {
            %>
                <tr>
                    <td colspan="7">No exhibitions available.</td>
                </tr>
            <% 
            }
            %>
        </table>
    </div>
</body>
</html>
