<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="db_connect.jsp" %>

<%
    // Récupération sécurisée du matricule
    String matriculeParam = request.getParameter("matricule");
    
    if (matriculeParam == null || matriculeParam.trim().isEmpty()) {
        out.println("<h3 class='text-danger text-center'>Erreur : Matricule non fourni.</h3>");
        return;
    }

    int matricule = 0;
    try {
        matricule = Integer.parseInt(matriculeParam);
    } catch (NumberFormatException e) {
        out.println("<h3 class='text-danger text-center'>Erreur : Matricule invalide.</h3>");
        return;
    }

    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Requête SQL pour récupérer les informations de l'employé
        stmt = conn.prepareStatement("SELECT * FROM employe WHERE matricule = ?");
        stmt.setInt(1, matricule);
        rs = stmt.executeQuery();

        if (!rs.next()) {
            out.println("<h3 class='text-danger text-center'>Erreur : Aucun employé trouvé avec ce matricule.</h3>");
            return;
        }

        // Conversion correcte de la date pour le champ HTML
        Date dateEmbauche = rs.getDate("dateEmbauche");
        String dateEmbaucheFormatted = (dateEmbauche != null) ? dateEmbauche.toString() : "";
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Modifier Employé</title>

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
    <h2>Modifier Employé</h2>
    <form action="modifierEmployeAction.jsp" method="post">
        <input type="hidden" name="matricule" value="<%= rs.getInt("matricule") %>">

        <div class="mb-3">
            <label class="form-label">Nom :</label>
            <input type="text" name="nomEmploye" value="<%= rs.getString("nomEmploye") %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Prénom :</label>
            <input type="text" name="prenomEmp" value="<%= rs.getString("prenomEmp") %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Fonction :</label>
            <input type="text" name="fonctionEmp" value="<%= rs.getString("fonctionEmp") %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Service :</label>
            <input type="text" name="serviceEmp" value="<%= rs.getString("serviceEmp") %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Date d'Embauche :</label>
            <input type="date" name="dateEmbauche" value="<%= dateEmbaucheFormatted %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Sexe :</label>
            <select name="sexeEmp" class="form-select" required>
                <option value="M" <%= rs.getString("sexeEmp").equals("M") ? "selected" : "" %>>Masculin</option>
                <option value="F" <%= rs.getString("sexeEmp").equals("F") ? "selected" : "" %>>Féminin</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Salaire :</label>
            <input type="number" step="0.01" name="salaireBase" value="<%= rs.getDouble("salaireBase") %>" class="form-control" required>
        </div>

        <button type="submit" class="btn-primary">Modifier</button>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

<%
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
    }
%>
