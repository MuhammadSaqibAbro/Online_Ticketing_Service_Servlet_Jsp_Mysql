# **🎟️ Online Ticketing Service Web Application**

## 🚀 **Overview**
Welcome to the **Online Ticketing Service Web Application**! This application provides a seamless way for admins to manage events, including creating, updating, and deleting events, as well as users booking tickets for various events. The system is designed using **Java Servlets**, **JSP**, and **MySQL** for database management. 

The admin has full control to add events, upload event images, and view event statistics in a graphical format. Users can browse events, book tickets, and receive a downloadable ticket receipt.

## 🌐 **Technologies Used**
- **Frontend**: HTML, CSS, JSP
- **Backend**: Java (Servlets)
- **Database**: MySQL
- **Libraries**: 
  - **Chart.js** for event data visualization (Bar Graphs)
  - **JDBC** for MySQL connectivity
  - **Apache Tomcat** for servlet container

## 🖥️ **Features**

### **Admin Panel**
- **CRUD Operations on Events**: Admin can Create, Read, Update, and Delete events.
- **Event Management**: Admin can add event details such as:
  - 🏷️ **Event Name**
  - 📅 **Event Date & Time**
  - 📍 **Event Location**
  - 💸 **Ticket Prices** (Seated and Standing)
  - 🖼️ **Event Image** (supports images for event promotion)
  - 🎭 **Event Category** (e.g., Concert, Theater, Sports)
- **Event Statistics**: Admin can view a bar graph to represent event data, such as ticket sales and revenue generated.
  
### **User Panel**
- **Event Booking**: Users can browse events, view details, and select the number of tickets they want to book.
- **Ticket Receipt Generation**: Upon successful booking, users will receive a **ticket receipt** with event details and payment information.
  
### **Admin Operations**
- **Event Reporting**: View graphical representations of ticket sales, available tickets, and revenue generation.
- **Event Deletion**: Admin can delete events that are no longer relevant or sold out.

## 📊 **Data Visualization (Bar Graph)**
The application uses **Chart.js** to visualize event data, such as ticket sales and revenue. A **bar graph** is displayed on the admin panel to represent:
- 🎫 **Number of tickets sold**
- 📉 **Available vs. booked tickets**
- 💵 **Revenue generation by event**

### Screens:
![Screenshot 2025-05-08 172655](https://github.com/user-attachments/assets/d8dd0515-5a6d-49a9-8860-a3ab14b631a4)
![Screenshot 2025-05-08 172737](https://github.com/user-attachments/assets/2b3d36ea-68b6-4604-88b4-8016619a88c0)
![Screenshot 2025-05-08 172805](https://github.com/user-attachments/assets/4908a4a2-4838-4c51-bda9-d94d4cc9f0b5)
![Screenshot 2025-05-08 172829](https://github.com/user-attachments/assets/c3387a19-4d2a-43c6-bfd0-fc63a61c2cd9)
![Screenshot 2025-05-08 172948](https://github.com/user-attachments/assets/3ec150ba-6585-42ec-969c-9118a9f95f44)
![bar](https://github.com/user-attachments/assets/0622d143-6383-48ed-b6b7-2257c64a8ce8)
![Screenshot 2025-05-08 173120](https://github.com/user-attachments/assets/e3a51e1e-4046-4a2d-b768-90d48ff8c406)
![Screenshot 2025-05-08 173043](https://github.com/user-attachments/assets/4cba74d2-908d-4a20-830d-6904a38e5f03)
![Screenshot 2025-05-08 173120](https://github.com/user-attachments/assets/e843b55e-fd26-4cd5-bb2d-e74f99fbabfd)
![Screenshot 2025-05-08 173217](https://github.com/user-attachments/assets/f4c591a2-5e1b-4bb3-bf72-afcbccca26f1)
![Uploading Screenshot 2025-05-08 173250.png…]()


## 🛠️ **Installation Guide**

### 1. **Clone the Repository**
```bash
git clone https://github.com/MuhammadSaqibAbro/Online_Ticketing_Service_Servlet_Jsp_Mysql.git
