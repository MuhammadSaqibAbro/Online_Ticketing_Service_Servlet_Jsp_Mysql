<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Purchase Event</title>
</head>
<body>
    <%
        HttpSession Ssession = request.getSession(false);
        String username = (Ssession != null) ? (String) Ssession.getAttribute("username") : null;

        if (username == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        String url = "jdbc:mysql://localhost:3306/ticketsystem";
        String user = "root";
        String password = "123456";

        Connection conn = null;
        PreparedStatement selectStmt = null;
        PreparedStatement insertStmt = null;
        ResultSet rs = null;

        String eventId = request.getParameter("event_id");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            String selectSQL = "SELECT id, event_name, category, event_date, event_time, location, seated_price, standing_price FROM events WHERE id=?";
            selectStmt = conn.prepareStatement(selectSQL);
            selectStmt.setInt(1, Integer.parseInt(eventId));
            rs = selectStmt.executeQuery();

            if (rs.next()) {
                String insertSQL = "INSERT INTO purchases (username, event_id, price) VALUES (?, ?, ?)";
                insertStmt = conn.prepareStatement(insertSQL);

                insertStmt.setString(1, username);
                insertStmt.setInt(2, rs.getInt("id"));
                insertStmt.setBigDecimal(3, rs.getBigDecimal("seated_price")); // Assuming seated_price is the price for the purchase

                int rowsInserted = insertStmt.executeUpdate();

                if (rowsInserted > 0) {
                    out.println("<h2>Event purchased successfully!</h2>");
                } else {
                    out.println("<h2>Failed to purchase event.</h2>");
                }
            } else {
                out.println("<h2>No such event found.</h2>");
            }
        } catch (Exception e) {
            out.println("<h2>Error: " + e.getMessage() + "</h2>");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (selectStmt != null) selectStmt.close();
                if (insertStmt != null) insertStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("<h2>Error closing resources: " + e.getMessage() + "</h2>");
                e.printStackTrace();
            }
        }
    %>
    <button onclick="window.location.href='all_events.jsp'">Back to Events</button>
</body>
</html>
