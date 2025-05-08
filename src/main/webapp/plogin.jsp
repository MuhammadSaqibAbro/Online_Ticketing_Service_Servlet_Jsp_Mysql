<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            background-color: #102031;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            color: white;
            text-align: center;
            padding: 20px;
        }
        .login {
            background-color: #204060;
            padding: 20px;
            border-radius: 10px;
            display: inline-block;
            text-align: left;
        }
        button {
            padding: 10px 20px;
            background-color: #204060;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 20px;
        }
        button:hover {
            background-color: #1a2e40;
        }
    </style>
</head>
<body>
    <div class="login">
        <h2>Login</h2>
        <form method="post" action="login_action.jsp">
            <label for="username">Username:</label><br>
            <input type="text" id="username" name="username" required><br><br>
            <label for="password">Password:</label><br>
            <input type="password" id="password" name="password" required><br><br>
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>
