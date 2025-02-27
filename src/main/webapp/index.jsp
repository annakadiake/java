<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Accueil</title>

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
            align-items: center;
            justify-content: center;
            height: 100vh;
            background-color: var(--light);
            font-family: 'Arial', sans-serif;
        }

        .container-box {
            background: white;
            padding: 3rem;
            border-radius: 12px;
            box-shadow: var(--shadow);
            text-align: center;
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        h1 {
            color: var(--primary);
            font-size: 2rem;
            margin-bottom: 15px;
        }

        p {
            color: #333;
            font-size: 1.1rem;
        }

        .btn-custom {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            padding: 12px 20px;
            border-radius: 8px;
            text-decoration: none;
            color: white;
            font-weight: bold;
            background-color: var(--secondary);
            transition: all 0.3s ease;
            font-size: 1.1rem;
        }

        .btn-custom:hover {
            background-color: var(--primary);
            transform: scale(1.05);
        }
    </style>
</head>
<body>

<div class="container-box">
    <h1>Bienvenue sur le Système de Gestion</h1>
    <p>Veuillez vous connecter pour accéder à l'application.</p>
    <a href="login.jsp" class="btn btn-custom mt-3">
        <i class="fas fa-sign-in-alt"></i> Connexion
    </a>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
