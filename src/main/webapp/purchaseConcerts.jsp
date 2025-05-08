<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Purchase Confirmation</title>
    <style>
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
    </style>
</head>
<body>
    <div class="container">
        <div class="section">
            <h2>Purchase Confirmation</h2>
            <%
                String concert = request.getParameter("concert");
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                double pricePerTicket = 50.0; // Example ticket price
                double totalAmount = quantity * pricePerTicket;

                // Database connection and insertion logic
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ticketing", "root", "password");
                    String query = "INSERT INTO bills (event, quantity, totalAmount) VALUES (?, ?, ?)";
                    PreparedStatement ps = con.prepareStatement(query);
                    ps.setString(1, concert);
                    ps.setInt(2, quantity);
                    ps.setDouble(3, totalAmount);
                    int result = ps.executeUpdate();
                    if (result > 0) {
                        out.println("<p>Thank you for your purchase!</p>");
                        out.println("<p>Concert: " + concert + "</p>");
                        out.println("<p>Quantity: " + quantity + "</p>");
                        out.println("<p>Total Amount: $" + totalAmount + "</p>");
                    } else {
                        out.println("<p>There was an error processing your purchase. Please try again.</p>");
                    }
                    ps.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>There was an error processing your purchase. Please try again.</p>");
                }
            %>
        </div>
    </div>
</body>
</html>
