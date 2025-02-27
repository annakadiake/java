<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, org.apache.commons.codec.digest.DigestUtils" %>
<%@ include file="db_connect.jsp" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Inscription Administrateur</title>

    <!-- Bootstrap 5 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        :root {
            --primary: #1a365d;
            --secondary: #4a90e2;
            --light: #f8f9fa;
            --shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }

        body {
            background-color: var(--primary);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container-box {
            background: white;
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: var(--shadow);
            text-align: center;
            width: 100%;
            max-width: 400px;
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        h2 {
            color: var(--primary);
            margin-bottom: 1rem;
        }

        .form-group {
            text-align: left;
            margin-bottom: 1rem;
        }

        label {
            font-weight: bold;
        }

        .form-control {
            border: 1px solid var(--secondary);
            border-radius: 5px;
        }

        .btn-custom {
            width: 100%;
            background-color: var(--primary);
            color: white;
            border-radius: 5px;
            padding: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            background-color: var(--secondary);
            transform: scale(1.05);
        }

        .message {
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }

        .message.error {
            color: red;
        }

        .message.success {
            color: green;
        }
    </style>
</head>
<body>
<div class="container-box">
    <h2>Créer un compte Administrateur</h2>

    <% 
        String message = (String) session.getAttribute("message");
        if (message != null) {
            String messageType = message.startsWith("Erreur") ? "error" : "success";
    %>
        <p class="message <%= messageType %>"><%= message %></p>
    <% 
            session.removeAttribute("message");
        }
    %>

    <form action="inscription.jsp" method="post">
        <div class="form-group">
            <label>Nom d'utilisateur :</label>
            <input type="text" name="username" class="form-control" required>
        </div>

        <div class="form-group">
            <label>Mot de passe :</label>
            <input type="password" name="userPassword" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-custom" name="action" value="inscrire">
            <i class="fas fa-user-plus"></i> S'inscrire
        </button>
    </form>
</div>

<%
if ("POST".equalsIgnoreCase(request.getMethod()) && "inscrire".equals(request.getParameter("action"))) {
    String username = request.getParameter("username").trim();
    String userPassword = request.getParameter("userPassword").trim();
    String hashedPassword = DigestUtils.md5Hex(userPassword);

    try {
        // Vérifier si l'utilisateur existe déjà
        String checkQuery = "SELECT COUNT(*) FROM admin WHERE username = ?";
        PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
        checkStmt.setString(1, username);
        ResultSet rs = checkStmt.executeQuery();
        rs.next();
        int count = rs.getInt(1);

        if (count > 0) {
            session.setAttribute("message", "Erreur : Cet utilisateur existe déjà.");
            response.sendRedirect("inscription.jsp");
        } else {
            String insertQuery = "INSERT INTO admin (username, password) VALUES (?, ?)";
            PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
            insertStmt.setString(1, username);
            insertStmt.setString(2, hashedPassword);

            int rowsInserted = insertStmt.executeUpdate();
            if (rowsInserted > 0) {
                session.setAttribute("message", "Succès : Inscription réussie !");
                response.sendRedirect("login.jsp");
            }
        }
    } catch (Exception e) {
        session.setAttribute("message", "Erreur SQL : Inscription impossible.");
        response.sendRedirect("inscription.jsp");
    }
}
%>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
