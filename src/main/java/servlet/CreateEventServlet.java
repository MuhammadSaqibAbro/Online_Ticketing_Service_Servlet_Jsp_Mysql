package servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/CreateEventServlet")
@MultipartConfig
public class CreateEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String eventName = request.getParameter("event_name");
        String category = request.getParameter("category");
        int clicks = Integer.parseInt(request.getParameter("clicks"));
        String eventDate = request.getParameter("event_date");
        String eventTime = request.getParameter("event_time");
        String location = request.getParameter("location");
        String seatedPrice = request.getParameter("seated_price");
        String standingPrice = request.getParameter("standing_price");
        
        // Process file upload
        Part filePart = request.getPart("image");
        String fileName = filePart.getSubmittedFileName();
        String savePath = getServletContext().getRealPath("/") + "uploads" + File.separator + fileName;
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }
        filePart.write(savePath + File.separator);

        // Database connection parameters
        String dbURL = "jdbc:mysql://localhost:3306/ticketsystem";
        String dbUser = "root";
        String dbPassword = "123456";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            String sql = "INSERT INTO events (event_name, category, clicks, event_date, event_time, location, seated_price, standing_price, image_path) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, eventName);
            preparedStatement.setString(2, category);
            preparedStatement.setInt(3, clicks);
            preparedStatement.setString(4, eventDate);
            preparedStatement.setString(5, eventTime);
            preparedStatement.setString(6, location);
            preparedStatement.setString(7, seatedPrice);
            preparedStatement.setString(8, standingPrice);
            preparedStatement.setString(9, "uploads/" + fileName);

            int rows = preparedStatement.executeUpdate();
            if (rows > 0) {
                response.getWriter().println("Event created successfully.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error creating event: " + e.getMessage());
        } finally {
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
