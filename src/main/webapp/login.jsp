<%@ page import="java.sql.*, org.apache.commons.codec.digest.DigestUtils"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="db_connect.jsp"%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Connexion Administrateur</title>

    <!-- Bootstrap 5 & FontAwesome -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        :root {
            --primary: #1a365d;
            --secondary: #4a90e2;
            --light: #f8f9fa;
        }

        body {
            background-color: var(--light);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            max-width: 400px;
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }

        h2 {
            color: var(--primary);
            text-align: center;
            margin-bottom: 20px;
        }

        .form-control {
            border: 2px solid var(--secondary);
            border-radius: 5px;
            padding: 10px;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 5px rgba(26, 54, 93, 0.5);
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 10px;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
        }

        .btn-primary:hover {
            background-color: var(--secondary);
        }

        .error-message {
            color: red;
            font-size: 0.9rem;
            margin-top: 10px;
            display: none;
        }
    </style>
</head>
<body>

<div class="container">
    <h2><i class="fas fa-user-shield"></i> Connexion Admin</h2>

    <form action="login.jsp" method="post">
        <div class="mb-3">
            <label class="form-label">Nom d'utilisateur :</label>
            <input type="text" name="username" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Mot de passe :</label>
            <input type="password" name="password" class="form-control" required>
        </div>

        <button type="submit" class="btn-primary">Se connecter</button>
    </form>

    <p class="error-message" id="error-message"></p>
</div>

<%
    // Vérification du formulaire
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username").trim();
        String enteredPassword = request.getParameter("password").trim();

        if (username.isEmpty() || enteredPassword.isEmpty()) {
%>
        <script>
            document.getElementById("error-message").innerText = "Erreur : Tous les champs sont obligatoires.";
            document.getElementById("error-message").style.display = "block";
        </script>
<%
        } else {
            try {
                String hashedEnteredPassword = DigestUtils.md5Hex(enteredPassword);

                // Vérifier si l'utilisateur existe
                String query = "SELECT * FROM admin WHERE username = ? AND password = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, username);
                stmt.setString(2, hashedEnteredPassword);

                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    // Stocker les informations de session
                    session.setAttribute("user_id", rs.getInt("id"));
                    session.setAttribute("user_name", rs.getString("username"));
                    session.setAttribute("user_type", "admin");

                    response.sendRedirect("dashboard_admin.jsp");
                } else {
%>
        <script>
            document.getElementById("error-message").innerText = "Nom d’utilisateur ou mot de passe incorrect.";
            document.getElementById("error-message").style.display = "block";
        </script>
<%
                }
                rs.close();
                stmt.close();
            } catch (Exception e) {
%>
        <script>
            document.getElementById("error-message").innerText = "Erreur SQL, veuillez réessayer.";
            document.getElementById("error-message").style.display = "block";
        </script>
<%
            }
        }
    }
%>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
