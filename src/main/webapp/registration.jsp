<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Page</title>
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
        .signup-container {
            background-color: #204060;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            width: 400px;
            text-align: center;
        }
        .signup-container h2 {
            margin-bottom: 20px;
        }
        .signup-container input {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
        }
        .signup-container button {
            background-color: #102031;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
        .signup-container button:hover {
            background-color: #1a1a2e;
        }
        .login-link {
            margin-top: 10px;
            font-size: 14px;
        }
        .login-link a {
            color: white;
            text-decoration: none;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
        .error {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
    <script>
        function validateForm() {
            const dob = document.getElementById("dob").value;
            const phone = document.getElementById("phone").value;
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmPassword").value;
            
            const dobRegex = /^(\d{2})\/(\d{2})\/(\d{4})$/;
            if (!dobRegex.test(dob)) {
                alert("Date of Birth must be in the format DD/MM/YYYY.");
                return false;
            }

            const phoneRegex = /^[0-9]{10}$/;
            if (!phoneRegex.test(phone)) {
                alert("Mobile Phone must be a 10-digit number.");
                return false;
            }

            const passwordRegex = /^(?=.*[!@#$%^&*])(?=.*\d{2})[A-Za-z\d!@#$%^&*]{9}$/;
            if (!passwordRegex.test(password)) {
                alert("Password must be 9 characters long, contain one special character, and two digits.");
                return false;
            }

            if (password !== confirmPassword) {
                alert("Passwords do not match.");
                return false;
            }

            const dobParts = dob.split('/');
            const birthDate = new Date(dobParts[2], dobParts[1] - 1, dobParts[0]);
            const ageDiffMs = Date.now() - birthDate.getTime();
            const ageDate = new Date(ageDiffMs);
            const age = Math.abs(ageDate.getUTCFullYear() - 1970);

            if (age < 18) {
                alert("You must be at least 18 years old to sign up.");
                return false;
            }

            return true;
        }

        function resetForm() {
            document.getElementById("signupForm").reset();
        }
    </script>
</head>
<body>
    <div class="signup-container">
        <h2>Signup</h2>
        <form method="post" onsubmit="return validateForm()" id="signupForm">
            <input type="text" id="onBehalf" name="username" placeholder="Name" required><br>
            <input type="text" id="surname" name="surname" placeholder="Surname" required><br>
            <input type="text" id="dob" name="dob" placeholder="Date of Birth (DD/MM/YYYY)" required><br>
            <input type="email" id="email" name="email" placeholder="Email" required><br>
            <input type="tel" id="phone" name="phone" placeholder="Mobile Phone (10 digits)" required><br>
            <input type="password" id="password" name="password" placeholder="Password" required><br>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required><br>
            <button type="submit">Signup</button>
            <button type="button" onclick="resetForm()">Reset</button>
        </form>
        <div class="login-link">
            <a href="login.jsp">Go to Login</a>
        </div>
        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String url = "jdbc:mysql://localhost:3306/ticketsystem";
                String user = "root";
                String password = "123456";

                String username = request.getParameter("username");
                String surname = request.getParameter("surname");
                String dob = request.getParameter("dob");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String userPassword = request.getParameter("password");

                // Convert DOB to YYYY-MM-DD format for MySQL
                String[] dobParts = dob.split("/");
                String formattedDob = dobParts[2] + "-" + dobParts[1] + "-" + dobParts[0];

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, password);

                    String checkUserSql = "SELECT * FROM users WHERE username = ?";
                    pstmt = conn.prepareStatement(checkUserSql);
                    pstmt.setString(1, username);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        out.println("<h3 class='error'>Username already exists. Please choose another one.</h3>");
                    } else {
                        String insertSql = "INSERT INTO users (username, surname, dob, email, phone, password) VALUES (?, ?, ?, ?, ?, ?)";
                        pstmt = conn.prepareStatement(insertSql);
                        pstmt.setString(1, username);
                        pstmt.setString(2, surname);
                        pstmt.setString(3, formattedDob);
                        pstmt.setString(4, email);
                        pstmt.setString(5, phone);
                        pstmt.setString(6, userPassword);

                        int row = pstmt.executeUpdate();
                        if (row > 0) {
                            out.println("<h3>Registration successful!</h3>");
                        } else {
                            out.println("<h3>Signup failed, please try again.</h3>");
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<h3>Error: " + e.getMessage() + "</h3>");
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
