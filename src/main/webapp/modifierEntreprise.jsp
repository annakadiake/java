<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="db_connect.jsp" %>

<%
    int id = 0;
    try {
        id = Integer.parseInt(request.getParameter("id"));
    } catch (NumberFormatException e) {
        out.println("<h3 class='text-danger text-center'>Erreur : ID invalide.</h3>");
        return;
    }

    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM entreprise WHERE id = ?");
    stmt.setInt(1, id);
    ResultSet rs = stmt.executeQuery();

    if (!rs.next()) {
        out.println("<h3 class='text-danger text-center'>Erreur : Aucune entreprise trouvée.</h3>");
        return;
    }

    // Formattage correct de la date pour l'affichage dans un champ date
    Date dateCreation = rs.getDate("dateCreation");
    String dateCreationFormatted = (dateCreation != null) ? dateCreation.toString() : "";
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Modifier Entreprise</title>

    <!-- Bootstrap 5 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            max-width: 500px;
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }

        h2 {
            text-align: center;
            color: #1a365d;
        }

        .btn-primary {
            background-color: #1a365d;
            border: none;
            width: 100%;
            padding: 10px;
            font-size: 1rem;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-primary:hover {
            background-color: #4a90e2;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Modifier Entreprise</h2>
    <form action="modifierEntrepriseAction.jsp" method="post">
        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">

        <div class="mb-3">
            <label class="form-label">Nom :</label>
            <input type="text" name="nomEntreprise" value="<%= rs.getString("nomEntreprise") %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Adresse :</label>
            <input type="text" name="adresseEntreprise" value="<%= rs.getString("adresseEntreprise") %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Chiffre d'Affaire :</label>
            <input type="number" step="0.01" min="0" name="chiffreAffaire" value="<%= rs.getDouble("chiffreAffaire") %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Date de Création :</label>
            <input type="date" name="dateCreation" value="<%= dateCreationFormatted %>" class="form-control" required>
        </div>

        <button type="submit" class="btn-primary">Modifier</button>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

<%
    rs.close();
    stmt.close();
%>
