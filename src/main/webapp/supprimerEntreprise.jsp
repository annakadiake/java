<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="db_connect.jsp" %>

<%
    // Récupération sécurisée de l'ID de l'entreprise
    String idParam = request.getParameter("id");
    String message = "";
    String alertType = "danger"; // Par défaut, message d'erreur

    if (idParam == null || idParam.trim().isEmpty()) {
        message = "Erreur : ID de l'entreprise non fourni.";
    } else {
        try {
            int id = Integer.parseInt(idParam);

            // Vérifier si l'entreprise existe
            PreparedStatement checkStmt = conn.prepareStatement("SELECT * FROM entreprise WHERE id = ?");
            checkStmt.setInt(1, id);
            ResultSet rs = checkStmt.executeQuery();

            if (!rs.next()) {
                message = "Erreur : Aucune entreprise trouvée avec cet ID.";
            } else {
                // Suppression de l'entreprise
                PreparedStatement deleteStmt = conn.prepareStatement("DELETE FROM entreprise WHERE id = ?");
                deleteStmt.setInt(1, id);
                int rowsAffected = deleteStmt.executeUpdate();

                if (rowsAffected > 0) {
                    message = "Entreprise supprimée avec succès.";
                    alertType = "success";
                } else {
                    message = "Erreur lors de la suppression.";
                }
            }

            rs.close();
            checkStmt.close();
        } catch (NumberFormatException e) {
            message = "Erreur : ID invalide.";
        } catch (SQLException e) {
            message = "Erreur SQL : " + e.getMessage();
            e.printStackTrace();
        } finally {
            if (conn != null) conn.close();
        }
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Suppression Entreprise</title>

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
    <h2>Suppression Entreprise</h2>
    <div class="alert alert-<%= alertType %>">
        <%= message %>
    </div>
    <a href="listeEntreprises.jsp" class="btn-back">Retour à la liste des entreprises</a>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
