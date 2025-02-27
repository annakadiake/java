<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/evaluation";
    String user = "root";
    String password = ""; // Mets ton mot de passe MySQL si nécessaire

    Connection conn = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
    } catch (Exception e) {
        out.println("Erreur de connexion : " + e.getMessage());
    }
%>
