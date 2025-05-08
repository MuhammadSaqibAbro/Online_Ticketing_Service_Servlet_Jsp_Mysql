<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.util.Arrays" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <style>
        body {
            background-color: #102031;
            font-family: Arial, sans-serif;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: #204060;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            width: 300px;
            text-align: center;
        }
        .login-container h2 {
            margin-bottom: 20px;
        }
        .login-container input {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
        }
        .login-container button {
            background-color: #102031;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
        }
        .login-container button:hover {
            background-color: #1a1a2e;
        }
        .register-link {
            margin-top: 10px;
            font-size: 14px;
        }
        .register-link a {
            color: white;
            text-decoration: none;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
        .error {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <form method="post">
            <input type="text" name="username" placeholder="Username" value="<%= request.getCookies() != null ? Arrays.stream(request.getCookies()).filter(c -> c.getName().equals("username")).findFirst().map(Cookie::getValue).orElse("") : "" %>" required>
            <br>
            <input type="password" name="password" placeholder="Password" required>
            <br>
            <button type="submit">Login</button>
        </form>
        <div class="register-link">
            <a href="registration.jsp">Go to Registration</a>
        </div>
        <% 
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String url = "jdbc:mysql://localhost:3306/ticketsystem";
                String user = "root";
                String password = "123456";

                String username = request.getParameter("username");
                String userPassword = request.getParameter("password");

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, password);

                    String sql = "SELECT * FROM users WHERE username = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, username);

                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        // Check password
                        String storedPassword = rs.getString("password");
                        if (storedPassword.equals(userPassword)) {
                            // Login successful, set cookie and redirect to menu.jsp
                            Cookie usernameCookie = new Cookie("username", username);
                            usernameCookie.setMaxAge(60 * 60 * 24 * 30); // 30 days
                            response.addCookie(usernameCookie);
                            response.sendRedirect("menu.jsp");
                        } else {
                            out.println("<h2>Login failed, incorrect password.</h2>");
                        }
                    } else {
                        out.println("<h2>Login failed, user not found.</h2>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<h2>Error: " + e.getMessage() + "</h2>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
    </div>
</body>
</html>
