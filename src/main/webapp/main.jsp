<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to My Application</title>
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
            text-align: center;
        }
        .container {
            max-width: 600px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            background-color: #1a1a2e;
        }
        h1 {
            font-size: 28px;
            margin-bottom: 20px;
        }
        .button-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }
        .button {
            padding: 15px 30px;
            background-color: #204060;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            font-size: 18px;
        }
        .button:hover {
            background-color: #406080;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to My Application</h1>
        <div class="button-container">
            <a href="admin_login.jsp" class="button">Admin Panel</a>
            <a href="login.jsp" class="button">User Panel</a>
        </div>
    </div>
</body>
</html>
