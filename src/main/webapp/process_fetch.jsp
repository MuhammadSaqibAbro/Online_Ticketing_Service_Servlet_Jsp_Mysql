<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Anton&display=swap">
    <link rel="stylesheet" href="styles.css">

</head>

<body>

<header class="bg-primary text-white">
    <div class="container">
        <div class="row align-items-center py-2">
            <div class="col-12 col-md-8 d-flex align-items-center">
                <div class="logo">
                    <img src="logo.png" alt="ByteDolomite Ticketing" class="img-fluid logo-img">
                </div>
                <div class="logo-text ml-2">
                    <h1>ByteDolomite Ticketing</h1>
                </div>
            </div>
        </div>
    </div>
</header>

<div class="container">
    <div id="login-form" class="mt-5">
        <h2>Login</h2>
        <form id="login-form1">
            <label for="username">Email:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <button type="button" id="submitButton">Login</button>

            <p>
                <a href="regstrazione.html" id="first-access-link">Registrati</a><br>
            </p>
        </form>
        <div id="message_container"></div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
<script src="logi.js"></script>

</body>

</html>
