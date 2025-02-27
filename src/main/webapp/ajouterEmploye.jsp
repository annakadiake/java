
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="db_connect.jsp" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un Employé</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 500px;
            background: white;
            padding: 20px;
            margin-top: 50px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .btn-primary {
            width: 100%;
            font-size: 18px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4">Ajouter un Employé</h2>
    
    <form action="ajouterEmployeAction.jsp" method="post">
        <div class="mb-3">
            <label class="form-label">Matricule</label>
            <input type="text" name="matricule" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Nom</label>
            <input type="text" name="nomEmploye" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Prénom</label>
            <input type="text" name="prenomEmp" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Fonction</label>
            <input type="text" name="fonctionEmp" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Service</label>
            <input type="text" name="serviceEmp" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Date d'Embauche</label>
            <input type="date" name="dateEmbauche" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Sexe :</label>
<select name="sexeEmp" required>
    <option value="">-- Sélectionner --</option>
    <option value="M">Masculin</option>
    <option value="F">Féminin</option>
</select>
            
        </div>

        <div class="mb-3">
            <label class="form-label">Salaire</label>
            <input type="number" name="salaireBase" step="0.01" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-primary">Ajouter</button>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
