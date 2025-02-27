<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="db_connect.jsp" %>

<%
    String message = "";
    String alertType = "danger"; // Par défaut, message d'erreur

    try {
        // Récupération des paramètres du formulaire
        String matriculeParam = request.getParameter("matricule");
        String nom = request.getParameter("nomEmploye");
        String prenom = request.getParameter("prenomEmp");
        String fonction = request.getParameter("fonctionEmp");
        String service = request.getParameter("serviceEmp");
        String dateEmbauche = request.getParameter("dateEmbauche");
        String sexe = request.getParameter("sexeEmp");
        String salaireParam = request.getParameter("salaireBase");

        // Vérification des champs obligatoires
        if (matriculeParam == null || matriculeParam.trim().isEmpty() ||
            nom == null || nom.trim().isEmpty() ||
            prenom == null || prenom.trim().isEmpty() ||
            fonction == null || fonction.trim().isEmpty() ||
            service == null || service.trim().isEmpty() ||
            dateEmbauche == null || dateEmbauche.trim().isEmpty() ||
            sexe == null || sexe.trim().isEmpty() ||
            salaireParam == null || salaireParam.trim().isEmpty()) {
            
            message = "Erreur : Tous les champs sont obligatoires.";
        } else {
            int matricule = Integer.parseInt(matriculeParam);
            double salaire = Double.parseDouble(salaireParam);

            // Mise à jour des informations de l'employé
            PreparedStatement stmt = conn.prepareStatement(
                "UPDATE employe SET nomEmploye = ?, prenomEmp = ?, fonctionEmp = ?, serviceEmp = ?, dateEmbauche = ?, sexeEmp = ?, salaireBase = ? WHERE matricule = ?"
            );
            stmt.setString(1, nom);
            stmt.setString(2, prenom);
            stmt.setString(3, fonction);
            stmt.setString(4, service);
            stmt.setString(5, dateEmbauche);
            stmt.setString(6, sexe);
            stmt.setDouble(7, salaire);
            stmt.setInt(8, matricule);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                message = "Employé modifié avec succès.";
                alertType = "success";
            } else {
                message = "Erreur : Échec de la modification.";
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
    <title>Modification Employé</title>

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
    <h2>Modification Employé</h2>
    <div class="alert alert-<%= alertType %>">
        <%= message %>
    </div>
    <a href="listeEmployes.jsp" class="btn-back">Retour à la liste des employés</a>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
