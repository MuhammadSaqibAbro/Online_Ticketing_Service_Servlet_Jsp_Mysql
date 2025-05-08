<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #102031;
            color: white;
            text-align: center;
            padding-top: 50px;
        }
        .login-box {
            background-color: #204060;
            width: 300px;
            margin: auto;
            padding: 20px;
            border-radius: 10px;
        }
        .form-input {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
        }
        .form-submit {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }
        .form-submit:hover {
            background-color: #45a049;
        }
        .error-message {
            color: red;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>Admin Login</h2>
        <form method="post" action="admin_login.jsp">
            <input type="text" name="username" placeholder="Username" class="form-input" required><br>
            <input type="password" name="password" placeholder="Password" class="form-input" required><br>
            <input type="submit" value="Login" class="form-submit">
        </form>
        <% 
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            if ("admin".equals(username) && "Admin@123".equals(password)) {
                response.sendRedirect("admin_menu.jsp");
            } else if (username != null && password != null) {
                out.println("<p class=\"error-message\">Incorrect username or password. Please try again.</p>");
            }
        %>
    </div>
</body>
</html>
