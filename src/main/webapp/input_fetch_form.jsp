<!DOCTYPE html>
<html>
<head>
    <title>Insert and Fetch Carton Details</title>
</head>
<body>
    <h2>Insert and Fetch Carton Details</h2>
    
    <h3>Insert Carton Details</h3>
    <form action="process_insert.jsp" method="post">
        <label for="mprno">MPR No:</label>
        <input type="text" id="mprno" name="mprno"><br><br>
        
        <label for="cartontype">Carton Type:</label>
        <input type="text" id="cartontype" name="cartontype"><br><br>
        
        <!-- Add input fields for other columns in the opb_carton_calc table -->
        <label for="orderid">Order Number:</label>
        <input type="text" id="orderid" name="orderid"><br><br>
        
        <label for="overs">Overs:</label>
        <input type="text" id="overs" name="overs"><br><br>
        
        <label for="spine">Spine:</label>
        <input type="text" id="spine" name="spine"><br><br>
        
        <label for="bookspercarton">Books per Carton:</label>
        <input type="text" id="bookspercarton" name="bookspercarton"><br><br>
        
        <label for="ply">Ply:</label>
        <input type="text" id="ply" name="ply"><br><br>
        
        <label for="length">Length:</label>
        <input type="text" id="length" name="length"><br><br>
        
        <label for="width">Width:</label>
        <input type="text" id="width" name="width"><br><br>
        
        <label for="height">Height:</label>
        <input type="text" id="height" name="height"><br><br>
        
        <label for="cartonqty">Carton Quantity:</label>
        <input type="text" id="cartonqty" name="cartonqty"><br><br>
        
        <label for="temp1">Temp 1:</label>
        <input type="text" id="temp1" name="temp1"><br><br>
        
        <label for="temp2">Temp 2:</label>
        <input type="text" id="temp2" name="temp2"><br><br>
        
        <label for="temp3">Temp 3:</label>
        <input type="text" id="temp3" name="temp3"><br><br>
        
        <label for="temp4">Temp 4:</label>
        <input type="text" id="temp4" name="temp4"><br><br>
        
        <input type="submit" value="Insert">
    </form>
    
    <hr>
    
    <h3>Fetch Carton Details</h3>
    <form action="process_fetch.jsp" method="post">
        <label for="orderno">Enter Order No:</label>
        <input type="text" id="orderid" name="orderid">
        <input type="submit" value="Fetch">
    </form>
</body>
</html>
