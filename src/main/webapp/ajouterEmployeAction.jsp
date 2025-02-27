<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="db_connect.jsp" %>

<%
    try {
        // Récupération des paramètres
        String matricule = request.getParameter("matricule");
        String nomEmploye = request.getParameter("nomEmploye");
        String prenomEmp = request.getParameter("prenomEmp");
        String fonctionEmp = request.getParameter("fonctionEmp");
        String serviceEmp = request.getParameter("serviceEmp");
        String dateEmbauche = request.getParameter("dateEmbauche");
        String sexe = request.getParameter("sexeEmp"); 
        String salaireBaseStr = request.getParameter("salaireBase");

        // Vérification des champs obligatoires
        if (matricule == null || nomEmploye == null || prenomEmp == null || fonctionEmp == null ||
            serviceEmp == null || dateEmbauche == null || sexe == null || salaireBaseStr == null ||
            matricule.trim().isEmpty() || nomEmploye.trim().isEmpty() || prenomEmp.trim().isEmpty() ||
            fonctionEmp.trim().isEmpty() || serviceEmp.trim().isEmpty() || dateEmbauche.trim().isEmpty() ||
            sexe.trim().isEmpty() || salaireBaseStr.trim().isEmpty()) {
            
            response.sendRedirect("ajouterEmploye.jsp?error=Tous les champs sont obligatoires.");
            return;
        }

        // Vérification du sexe (évite les erreurs SQL)
        if (!sexe.equals("M") && !sexe.equals("F")) {
            response.sendRedirect("ajouterEmploye.jsp?error=Valeur de sexe invalide");
            return;
        }

        // Vérification du salaire
        double salaireBase;
        try {
            salaireBase = Double.parseDouble(salaireBaseStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("ajouterEmploye.jsp?error=Format du salaire incorrect.");
            return;
        }

        // Vérification si le matricule existe déjà
        String checkSql = "SELECT COUNT(*) FROM employe WHERE matricule = ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, matricule);
            try (ResultSet rs = checkStmt.executeQuery()) {
                rs.next();
                if (rs.getInt(1) > 0) {
                    response.sendRedirect("ajouterEmploye.jsp?error=Matricule déjà existant !");
                    return;
                }
            }
        }

        // Insertion de l'employé
        String sql = "INSERT INTO employe (matricule, nomEmploye, prenomEmp, fonctionEmp, serviceEmp, dateEmbauche, sexeEmp, salaireBase) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, matricule);
            stmt.setString(2, nomEmploye);
            stmt.setString(3, prenomEmp);
            stmt.setString(4, fonctionEmp);
            stmt.setString(5, serviceEmp);
            stmt.setString(6, dateEmbauche);
            stmt.setString(7, sexe);
            stmt.setDouble(8, salaireBase);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("ajouterEmploye.jsp?success=Employé ajouté avec succès !");
            } else {
                response.sendRedirect("ajouterEmploye.jsp?error=Erreur lors de l'ajout de l'employé.");
            }
        }
    } catch (SQLException e) {
        response.sendRedirect("ajouterEmploye.jsp?error=Erreur SQL : " + e.getMessage());
    }
%>
