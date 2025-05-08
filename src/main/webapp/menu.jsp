<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Ticketing Service</title>
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
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
            background-color: #204060;
            border-bottom: 2px solid #1a1a2e;
        }
        header h1 {
            font-size: 24px;
            margin: 0;
        }
        nav {
            display: flex;
            gap: 15px;
        }
        nav a {
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        nav a:hover {
            background-color: #1a1a2e;
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
        .most-clicked-events p {
            font-size: 16px;
            cursor: pointer;
        }
        .discount-message p {
            font-size: 18px;
            font-weight: bold;
            animation: changeDiscount 15s infinite alternate;
        }
        .company-info p {
            font-size: 16px;
        }
        .footer {
            background-color: #204060;
            color: #ccc;
            padding: 10px 0;
            text-align: center;
            border-top: 2px solid #1a1a2e;
        }
        @keyframes changeDiscount {
            0% { opacity: 1; }
            100% { opacity: 0; }
        }
    </style>
    <script>
        function updateDiscountMessage() {
            var messages = [
                "Discount 10% on all concerts!",
                "Buy 2 tickets for the price of 1 for theater performances!",
                "Get 15% off on sports events this weekend!",
                "Save 20% on guided tours!",
                "Early bird discount for museum exhibitions!"
            ];
            var messageElement = document.getElementById("discountMessage");
            var currentMessage = messageElement.innerText;
            var newMessage;
            do {
                newMessage = messages[Math.floor(Math.random() * messages.length)];
            } while (newMessage === currentMessage);
            messageElement.innerText = newMessage;
        }
        setInterval(updateDiscountMessage, 15000);

        function trackClick(eventName) {
            var clicks = localStorage.getItem("clickedEvent_" + eventName);
            clicks = clicks ? parseInt(clicks) : 0;
            clicks++;
            localStorage.setItem("clickedEvent_" + eventName, clicks);
            window.location.href = eventName.toLowerCase() + ".jsp";
        }

        function loadClickCounts() {
            var events = ["Concerts", "Theater", "Sports", "Guided Tours", "Exhibitions"];
            events.forEach(function(event) {
                var clicks = localStorage.getItem("clickedEvent_" + event);
                clicks = clicks ? parseInt(clicks) : 0;
                document.getElementById("clickedEvent_" + event).innerText = event + " - " + clicks + " clicks";
            });
        }

        document.addEventListener("DOMContentLoaded", loadClickCounts);
    </script>
</head>
<body>
    <header class="container">
        <h1>Online Ticketing Service</h1>
        <nav id="publicNav">

            <a href="eventForUser.jsp">Purchase Ticket for Events</a>
        </nav>
        <nav id="privateNav" style="display: none;">
            <a href="javascript:void(0);" onclick="trackClick('Concerts')">Concerts</a>
            <a href="javascript:void(0);" onclick="trackClick('Theater')">Theater</a>
            <a href="javascript:void(0);" onclick="trackClick('Sports')">Sports</a>
            <a href="javascript:void(0);" onclick="trackClick('Guided Tours')">Guided Tours</a>
            <a href="javascript:void(0);" onclick="trackClick('Exhibitions')">Exhibitions</a>
            <a href="profile.jsp">Profile</a>
            <a href="eventForUser.jsp">Purchase Events</a>
            <a href="logout.jsp">Logout</a>
        </nav>
    </header>
    <div class="container">
        <div class="section most-clicked-events">
            <h2>Most Clicked Events</h2>
            <p id="clickedEvent_Concerts">Concerts - 0 clicks</p>
            <p id="clickedEvent_Theater">Theater - 0 clicks</p>
            <p id="clickedEvent_Sports">Sports - 0 clicks</p>
            
        </div>
        <div class="section discount-message">
            <h2>Current Discounts</h2>
            <p id="discountMessage">Discount 10% on all concerts!</p>
        </div>
        <div class="section company-info">
            <h2>Company Information</h2>
            <p>Legal Headquarters: 123 Main Street, Trento</p>
            <p>VAT Number: 123456789</p>
            <p>Contact: info@ticketingsystem.com | +39 123 456 7890</p>
        </div>
    </div>
    <footer class="footer">
        <p>&copy; 2024 Online Ticketing Service. All rights reserved.</p>
    </footer>
    <script>
        // Simulating login status check
        var isLoggedIn = false; // Change this based on actual login status
        if (isLoggedIn) {
            document.getElementById("publicNav").style.display = "none";
            document.getElementById("privateNav").style.display = "flex";
        } else {
            document.getElementById("publicNav").style.display = "flex";
            document.getElementById("privateNav").style.display = "none";
        }
    </script>
</body>
</html>
