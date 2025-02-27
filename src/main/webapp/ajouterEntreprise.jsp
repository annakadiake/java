<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="db_connect.jsp" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Ajouter une Entreprise</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-lg p-4">
        <h2 class="text-center text-primary">Ajouter une Entreprise</h2>

        <!-- Gestion des messages d'erreur ou de succès -->
        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");

            if (success != null) {
        %>
            <div class="alert alert-success" role="alert"><%= success %></div>
        <% } else if (error != null) { %>
            <div class="alert alert-danger" role="alert"><%= error %></div>
        <% } %>

        <form action="ajouterEntrepriseAction.jsp" method="post">
            <div class="mb-3">
                <label class="form-label">Nom de l'Entreprise</label>
                <input type="text" name="nomEntreprise" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Adresse</label>
                <input type="text" name="adresseEntreprise" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Chiffre d'Affaire (€)</label>
                <input type="number" name="chiffreAffaire" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Date de Création</label>
                <input type="date" name="dateCreation" class="form-control" required>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-primary">Ajouter</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
