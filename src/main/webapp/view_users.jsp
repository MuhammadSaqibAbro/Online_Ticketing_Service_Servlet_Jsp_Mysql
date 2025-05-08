<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Registered Users</title>
    <style>
        body {
            background-color: #102031;
            font-family: Arial, sans-serif;
            color: white;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: #1a1a2e;
            color: white;
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
    </style>
</head>
<body>
    <h2>Registered Users</h2>
    <table>
        <thead>
            <tr>
                <th>Username</th>
                <th>Surname</th>
                <th>Date of Birth</th>
                <th>Email</th>
                <th>Mobile Phone</th>
                <th>Password</th>
            </tr>
        </thead>
        <tbody>
            <% 
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ticketsystem", "root", "123456");
                    stmt = conn.createStatement();
                    String sql = "SELECT username, surname, dob, email, phone, password FROM users";
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        String username = rs.getString("username");
                        String surname = rs.getString("surname");
                        Date dob = rs.getDate("dob");
                        String email = rs.getString("email");
                        String phone = rs.getString("phone");
                        String password = rs.getString("password");
            %>
            <tr>
                <td><%= username %></td>
                <td><%= surname %></td>
                <td><%= dob %></td>
                <td><%= email %></td>
                <td><%= phone %></td>
                <td><%= password %></td>
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
</body>
</html>
