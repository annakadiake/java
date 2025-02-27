<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="db_connect.jsp" %>

<%
    String message = "";
    String alertType = "danger"; // Par défaut, message d'erreur

    try {
        // Récupération des paramètres du formulaire
        String nom = request.getParameter("nomEntreprise");
        String adresse = request.getParameter("adresseEntreprise");
        String chiffreAffaireParam = request.getParameter("chiffreAffaire");
        String dateCreation = request.getParameter("dateCreation");

        // Vérification des champs obligatoires
        if (nom == null || nom.trim().isEmpty() ||
            adresse == null || adresse.trim().isEmpty() ||
            chiffreAffaireParam == null || chiffreAffaireParam.trim().isEmpty() ||
            dateCreation == null || dateCreation.trim().isEmpty()) {
            
            message = "Erreur : Tous les champs sont obligatoires.";
        } else {
            double chiffreAffaire = Double.parseDouble(chiffreAffaireParam);

            // Insertion des informations de l'entreprise
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO entreprise (nomEntreprise, adresseEntreprise, chiffreAffaire, dateCreation) VALUES (?, ?, ?, ?)"
            );
            stmt.setString(1, nom);
            stmt.setString(2, adresse);
            stmt.setDouble(3, chiffreAffaire);
            stmt.setString(4, dateCreation);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                message = "Entreprise ajoutée avec succès.";
                alertType = "success";
            } else {
                message = "Erreur : Échec de l'ajout.";
            }
        }
    } catch (NumberFormatException e) {
        message = "Erreur : Valeurs invalides.";
    } catch (SQLException e) {
        message = "Erreur SQL : " + e.getMessage();
        e.printStackTrace();
    } finally {
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Ajout Entreprise</title>

    <!-- Bootstrap 5 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
        }

        .container {
            max-width: 500px;
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }

        .btn-back {
            display: inline-block;
            margin-top: 1rem;
            text-decoration: none;
            color: white;
            background-color: #1a365d;
            padding: 10px 20px;
            border-radius: 5px;
        }

        .btn-back:hover {
            background-color: #4a90e2;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Ajout d'une Entreprise</h2>
    <div class="alert alert-<%= alertType %>">
        <%= message %>
    </div>
    <a href="listeEntreprises.jsp" class="btn-back">Retour à la liste des entreprises</a>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
