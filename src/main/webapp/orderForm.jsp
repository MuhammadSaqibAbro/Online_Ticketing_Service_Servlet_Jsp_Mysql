<!DOCTYPE html>
<html>
<head>
    <title>Order Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }

        h2 {
            color: #333;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        form input[type="text"],
        form input[type="number"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        form input[type="submit"] {
            background-color: #007BFF;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: auto;
            font-size: 14px;
        }

        form input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .fetch-btn {
            background-color: #28a745;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: auto;
            font-size: 14px;
            margin-left: 10px;
        }

        .fetch-btn:hover {
            background-color: #218838;
        }

        .order-number-container {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        hr {
            border: 1px solid #ccc;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h2>Order Form</h2>
    <form id="orderForm" action="OrderServlet" method="post">
        <input type="hidden" name="action" value="insert">
        MPR: <input type="text" name="mpr" value="${mpr}" required><br>
        <div class="order-number-container">
            Dims Order Number: <input type="text" name="dims_order_number" id="dims_order_number" value="${dims_order_number}" required>
            <button type="button" class="fetch-btn" onclick="fetchOrderDetails()">Fetch</button>
        </div>
        Dims Order Name: <input type="text" name="dims_order_name" value="${dims_order_name}" required><br>
        Customer: <input type="text" name="customer" value="${customer}" required><br>
        Customer Name: <input type="text" name="customer_name" value="${customer_name}" required><br>
        Carton Type: <input type="text" name="carton_type" value="${carton_type}" required><br>
        Books Style: <input type="text" name="book_style" value="${book_style}" required><br>
        Order Quantity: <input type="number" name="order_quantity" value="${order_quantity}" required><br>
        Overs: <input type="number" name="overs" value="${overs}" required><br>
        Book Size: <input type="text" name="book_size" value="${book_size}" required><br>
        TPS: <input type="text" name="tps" value="${tps}" required><br>
        Spine: <input type="text" name="spine" value="${spine}" required><br>
        Books Per Carton: <input type="number" name="books_per_carton" value="${books_per_carton}" required><br>
        Carton Length: <input type="number" name="carton_length" value="${carton_length}" required><br>
        Carton Width: <input type="number" name="carton_width" value="${carton_width}" required><br>
        Carton Height: <input type="number" name="carton_height" value="${carton_height}" required><br>
        Cartons Quantity: <input type="number" name="cartons_quantity" value="${cartons_quantity}" required><br>
        <input type="submit" value="Submit">
    </form>

    <script>
        function fetchOrderDetails() {
            var orderNumber = document.getElementById('dims_order_number').value;
            if (orderNumber) {
                var fetchForm = document.createElement('form');
                fetchForm.method = 'post';
                fetchForm.action = 'OrderServlet';

                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'fetch';
                fetchForm.appendChild(actionInput);

                var orderNumberInput = document.createElement('input');
                orderNumberInput.type = 'hidden';
                orderNumberInput.name = 'dims_order_number_to_fetch';
                orderNumberInput.value = orderNumber;
                fetchForm.appendChild(orderNumberInput);

                document.body.appendChild(fetchForm);
                fetchForm.submit();
            }
        }
    </script>
</body>
</html>
