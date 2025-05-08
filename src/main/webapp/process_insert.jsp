<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    // Retrieve form data
    String mprno = request.getParameter("mprno");
    String cartontype = request.getParameter("cartontype");
    String orderid = request.getParameter("orderid");
    String overs = request.getParameter("overs");
    String spine = request.getParameter("spine");
    String bookspercarton = request.getParameter("bookspercarton");
    String ply = request.getParameter("ply");
    String length = request.getParameter("length");
    String width = request.getParameter("width");
    String height = request.getParameter("height");
    String cartonqty = request.getParameter("cartonqty");
    String temp1 = request.getParameter("temp1");
    String temp2 = request.getParameter("temp2");
    String temp3 = request.getParameter("temp3");
    String temp4 = request.getParameter("temp4");

    // Establish connection to the database
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/optest", "root", "123456");

        // Prepare SQL statement to insert record into database
        String sql = "INSERT INTO opb_carton_calc (mprno, cartontype, orderid, overs, spine, bookspercarton, ply, length, width, height, cartonqty, temp1, temp2, temp3, temp4) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, mprno);
        pstmt.setString(2, cartontype);
        pstmt.setString(3, orderid);
        pstmt.setString(4, overs);
        pstmt.setString(5, spine);
        pstmt.setString(6, bookspercarton);
        pstmt.setString(7, ply);
        pstmt.setString(8, length);
        pstmt.setString(9, width);
        pstmt.setString(10, height);
        pstmt.setString(11, cartonqty);
        pstmt.setString(12, temp1);
        pstmt.setString(13, temp2);
        pstmt.setString(14, temp3);
        pstmt.setString(15, temp4);

        // Execute the SQL statement
        pstmt.executeUpdate();

        // Close resources
        pstmt.close();
        conn.close();

        // Redirect to a confirmation page
        response.sendRedirect("insert_success.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        // Handle any errors that occur
        // Redirect to an error page or display error message
    } finally {
        // Close resources in finally block if necessary
        if (pstmt != null) {
            pstmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
%>
