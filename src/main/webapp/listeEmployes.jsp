<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="db_connect.jsp" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Liste des Employés</title>

    <!-- Bootstrap 5 -->
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
            font-family: Arial, sans-serif;
        }

        .container {
            margin-top: 50px;
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

        .table {
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }

        .btn {
            border-radius: 5px;
            padding: 5px 10px;
        }

        .btn-modifier {
            background-color: var(--secondary);
            color: white;
        }

        .btn-modifier:hover {
            background-color: var(--primary);
        }

        .btn-supprimer {
            background-color: #dc3545;
            color: white;
        }

        .btn-supprimer:hover {
            background-color: #b02a37;
        }
    </style>

    <script>
        function confirmerSuppression(matricule) {
            return confirm("Voulez-vous vraiment supprimer l'employé avec le matricule " + matricule + " ?");
        }
    </script>
</head>
<body>
<div class="container">
    <h2>Liste des Employés</h2>
    
    <table class="table table-striped table-hover">
        <thead class="table-dark">
        <tr>
            <th>Matricule</th>
            <th>Nom</th>
            <th>Prénom</th>
            <th>Fonction</th>
            <th>Service</th>
            <th>Date d'Embauche</th>
            <th>Sexe</th>
            <th>Salaire</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            Statement stmt = null;
            ResultSet rs = null;
            try {
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT * FROM employe");

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("matricule") %></td>
            <td><%= rs.getString("nomEmploye") %></td>
            <td><%= rs.getString("prenomEmp") %></td>
            <td><%= rs.getString("fonctionEmp") %></td>
            <td><%= rs.getString("serviceEmp") %></td>
            <td><%= rs.getDate("dateEmbauche") %></td>
            <td><%= rs.getString("sexeEmp") %></td>
            <td><%= rs.getDouble("salaireBase") %> €</td>
            <td>
                <a href="modifierEmploye.jsp?matricule=<%= rs.getInt("matricule") %>" class="btn btn-modifier btn-sm">
                    <i class="fas fa-edit"></i> Modifier
                </a>
                <a href="supprimerEmploye.jsp?matricule=<%= rs.getInt("matricule") %>" 
                   class="btn btn-supprimer btn-sm"
                   onclick="return confirmerSuppression(<%= rs.getInt("matricule") %>);">
                    <i class="fas fa-trash-alt"></i> Supprimer
                </a>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='9' class='text-danger'>Erreur lors du chargement des employés : " + e.getMessage() + "</td></tr>");
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
