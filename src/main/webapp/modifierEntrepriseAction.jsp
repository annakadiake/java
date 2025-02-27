<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="db_connect.jsp" %>

<%
    // Récupération des paramètres envoyés par le formulaire
    int id = Integer.parseInt(request.getParameter("id"));
    String nomEntreprise = request.getParameter("nomEntreprise");
    String adresseEntreprise = request.getParameter("adresseEntreprise");
    double chiffreAffaire = Double.parseDouble(request.getParameter("chiffreAffaire"));

    // Mise à jour des informations de l'entreprise
    PreparedStatement updateStmt = conn.prepareStatement(
        "UPDATE entreprise SET nomEntreprise = ?, adresseEntreprise = ?, chiffreAffaire = ? WHERE id = ?"
    );
    updateStmt.setString(1, nomEntreprise);
    updateStmt.setString(2, adresseEntreprise);
    updateStmt.setDouble(3, chiffreAffaire);
    updateStmt.setInt(4, id);
    updateStmt.executeUpdate();

    // Redirection vers la liste des entreprises après mise à jour
    response.sendRedirect("listeEntreprises.jsp");
%>
