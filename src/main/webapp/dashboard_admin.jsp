<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="db_connect.jsp" %>

<%
    if (session.getAttribute("user_id") == null || !"admin".equals(session.getAttribute("user_type"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    int totalEntreprises = 0;
    int totalEmployes = 0;
    try {
        String countEntreprisesQuery = "SELECT COUNT(*) FROM entreprise";
        PreparedStatement countEntreprisesStmt = conn.prepareStatement(countEntreprisesQuery);
        ResultSet countEntreprisesRs = countEntreprisesStmt.executeQuery();
        if (countEntreprisesRs.next()) {
            totalEntreprises = countEntreprisesRs.getInt(1);
        }

        String countEmployesQuery = "SELECT COUNT(*) FROM employe";
        PreparedStatement countEmployesStmt = conn.prepareStatement(countEmployesQuery);
        ResultSet countEmployesRs = countEmployesStmt.executeQuery();
        if (countEmployesRs.next()) {
            totalEmployes = countEmployesRs.getInt(1);
        }
    } catch (Exception e) {
        out.println("<p class='alert alert-danger'>Erreur : " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Administrateur</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
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
            display: flex;
            height: 100vh;
            background-color: var(--light);
            font-family: Arial, sans-serif;
        }

        .sidebar {
            width: 260px;
            background-color: var(--primary);
            color: white;
            padding: 1.5rem;
            height: 100vh;
            position: fixed;
        }

        .sidebar a {
            text-decoration: none;
            color: white;
            display: block;
            padding: 12px;
            border-radius: 5px;
            transition: background 0.3s ease;
        }

        .sidebar a:hover {
            background-color: var(--secondary);
        }

        .main-content {
            margin-left: 280px;
            padding: 2rem;
            width: 100%;
        }

        .header {
            background-color: white;
            padding: 1rem;
            border-radius: 10px;
            box-shadow: var(--shadow);
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .stats-container {
            display: flex;
            gap: 1.5rem;
            flex-wrap: wrap;
            justify-content: center;
        }

        .stat-box {
            flex: 1;
            min-width: 250px;
            background-color: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: var(--shadow);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .stat-box:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
        }

        .stat-box i {
            font-size: 2.5rem;
            color: var(--primary);
        }

        .btn-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            margin-top: 20px;
        }

        .btn-custom {
            padding: 12px 20px;
            border-radius: 5px;
            text-decoration: none;
            color: white;
            font-weight: bold;
            background-color: var(--secondary);
            display: flex;
            align-items: center;
            gap: 10px;
            transition: background 0.3s ease, transform 0.3s ease;
        }

        .btn-custom:hover {
            background-color: var(--primary);
            transform: translateY(-3px);
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }
            .main-content {
                margin-left: 0;
                padding: 1rem;
            }
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h3>Navigation</h3>
    <a href="dashboard_admin.jsp"><i class="fas fa-home"></i> Accueil</a>
    <a href="listeEntreprises.jsp"><i class="fas fa-building"></i> Entreprises</a>
    <a href="listeEmployes.jsp"><i class="fas fa-users"></i> Employés</a>
    <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Déconnexion</a>
</div>

<!-- Contenu Principal -->
<div class="main-content">
    <div class="header">
        <h2>Dashboard Administrateur</h2>
    </div>

    <!-- Statistiques -->
    <div class="stats-container">
        <div class="stat-box">
            <i class="fas fa-building"></i>
            <h3><%= totalEntreprises %></h3>
            <p>Total Entreprises</p>
        </div>
        <div class="stat-box">
            <i class="fas fa-users"></i>
            <h3><%= totalEmployes %></h3>
            <p>Total Employés</p>
        </div>
    </div>

    <!-- Boutons de Gestion -->
    <div class="btn-container">
        <a href="ajouterEntreprise.jsp" class="btn btn-custom"><i class="fas fa-plus"></i> Ajouter Entreprise</a>
        <a href="ajouterEmploye.jsp" class="btn btn-custom"><i class="fas fa-user-plus"></i> Ajouter Employé</a>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
