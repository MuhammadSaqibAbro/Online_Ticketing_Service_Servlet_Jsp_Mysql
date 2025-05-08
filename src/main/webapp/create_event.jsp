<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Event</title>
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
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #1a1a2e;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        }
        h2 {
            font-size: 24px;
            margin-bottom: 20px;
            text-align: center;
            border-bottom: 2px solid #204060;
            padding-bottom: 10px;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            font-size: 16px;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="number"], input[type="date"], input[type="time"], input[type="file"] {
            padding: 10px;
            margin-bottom: 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
        }
        input[type="submit"] {
            background-color: #204060;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #1a1a2e;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Create Event</h2>
        <form action="CreateEventServlet" method="post" enctype="multipart/form-data">
            <label for="event_name">Event Name:</label>
            <input type="text" id="event_name" name="event_name" required>

            <label for="category">Category:</label>
            <input type="text" id="category" name="category" required>

            <label for="clicks">Clicks:</label>
            <input type="number" id="clicks" name="clicks" required>

            <label for="event_date">Event Date:</label>
            <input type="date" id="event_date" name="event_date" required>

            <label for="event_time">Event Time:</label>
            <input type="time" id="event_time" name="event_time" required>

            <label for="location">Location:</label>
            <input type="text" id="location" name="location" required>

            <label for="seated_price">Seated Price:</label>
            <input type="text" id="seated_price" name="seated_price" required>

            <label for="standing_price">Standing Price:</label>
            <input type="text" id="standing_price" name="standing_price" required>

            <label for="image">Event Image:</label>
            <input type="file" id="image" name="image" required>

            <input type="submit" value="Create Event">
        </form>
    </div>
</body>
</html>
