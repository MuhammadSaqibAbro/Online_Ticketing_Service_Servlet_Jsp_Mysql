<%@ page import="java.sql.*, java.util.*, java.sql.Date, java.sql.Time" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #1a1a2e;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            padding: 20px;
            text-align: center;
            max-width: 600px;
            width: 100%;
        }
        h2 {
            font-size: 24px;
            margin-bottom: 10px;
            border-bottom: 2px solid #204060;
            padding-bottom: 5px;
        }
        p {
            font-size: 18px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <%!
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
        %>
        <%@ page import="java.sql.*, java.util.*, java.sql.Date, java.sql.Time" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ page language="java" %>

        <%
            try {
                // Establishing database connection
                String url = "jdbc:mysql://localhost:3306/ticketsystem";
                String user = "root";
                String password = "123456";
                Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL JDBC driver
                conn = DriverManager.getConnection(url, user, password);

                // Retrieve event ID from request parameter
                int eventId = Integer.parseInt(request.getParameter("event_id"));

                // Fetch event details for the selected event
                String sql = "SELECT * FROM events WHERE id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, eventId);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    // Extract event details
                    int eventIdFromDB = rs.getInt("id");
                    String eventName = rs.getString("name");
                    Date eventDate = rs.getDate("date"); // Use java.sql.Date explicitly
                    Time eventTime = rs.getTime("time"); // Use java.sql.Time explicitly
                    String eventLocation = rs.getString("location");
                    double seatedPrice = rs.getDouble("seated_price");
                    double standingPrice = rs.getDouble("standing_price");

                    // Calculate total price (example logic, adjust as per your business rules)
                    double totalPrice = seatedPrice; // Example: Assuming only seated price for simplicity

                    // Insert booking details into the bill table
                    sql = "INSERT INTO bill (event_id, event_name, event_date, event_time, event_location, total_price) " +
                          "VALUES (?, ?, ?, ?, ?, ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, eventIdFromDB);
                    pstmt.setString(2, eventName);
                    pstmt.setDate(3, eventDate);
                    pstmt.setTime(4, eventTime);
                    pstmt.setString(5, eventLocation);
                    pstmt.setDouble(6, totalPrice);
                    int rowsAffected = pstmt.executeUpdate();

                    if (rowsAffected > 0) {
                        // Booking successful, show confirmation message
        %>
                        <h2>Booking Successful!</h2>
                        <p>Event: <%= eventName %></p>
                        <p>Date: <%= eventDate %></p>
                        <p>Time: <%= eventTime %></p>
                        <p>Location: <%= eventLocation %></p>
                        <p>Total Price: $<%= totalPrice %></p>
        <%          
                    } else {
                        // Booking failed
        %>
                        <h2>Booking Failed!</h2>
                        <p>Please try again later.</p>
        <%                  
                    }
                } else {
                    // Event not found
        %>
                    <h2>Event not found!</h2>
                    <p>Please select a valid event to book.</p>
        <%          
                }

            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            } finally {
                // Closing resources in finally block
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>
</body>
</html>
