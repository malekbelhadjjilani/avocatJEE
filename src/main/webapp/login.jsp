<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - AvocaTN</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --brand-navy: #1a2b4a;
            --brand-turquoise: #00b4b4;
        }
        
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #1a2b4a 0%, #2d4a6f 50%, #00b4b4 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .login-card {
            background: white;
            border-radius: 24px;
            box-shadow: 0 25px 80px rgba(0,0,0,0.3);
            padding: 50px 40px;
            width: 100%;
            max-width: 440px;
        }
        
        .logo-section {
            text-align: center;
            margin-bottom: 35px;
        }
        
        .logo-icon {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, var(--brand-navy), var(--brand-turquoise));
            border-radius: 20px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 32px;
            margin-bottom: 15px;
        }
        
        .logo-title {
            font-size: 26px;
            font-weight: 700;
            color: var(--brand-navy);
            margin: 0;
        }
        
        .form-control-custom {
            width: 100%;
            padding: 14px 16px 14px 50px;
            border: 2px solid #e9ecef;
            border-radius: 14px;
            font-size: 15px;
            transition: all 0.3s ease;
            background: #fafbfc;
            margin-bottom: 15px;
        }
        
        .form-control-custom:focus {
            border-color: var(--brand-turquoise);
            box-shadow: 0 0 0 4px rgba(0, 180, 180, 0.1);
            outline: none;
        }
        
        .input-group {
            position: relative;
        }
        
        .input-group i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #adb5bd;
            font-size: 18px;
            z-index: 10;
        }
        
        .btn-login {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, var(--brand-navy), var(--brand-turquoise));
            border: none;
            border-radius: 14px;
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(0,180,180,0.3);
        }
        
        .alert-custom {
            border-radius: 12px;
            border: none;
            padding: 14px 18px;
            margin-bottom: 20px;
        }
        
        .guest-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #e9ecef;
        }
        
        .guest-link a {
            color: var(--brand-turquoise);
            font-weight: 600;
            text-decoration: none;
        }
        
        .role-selector {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .role-option {
            flex: 1;
            padding: 14px;
            border: 2px solid #e9ecef;
            border-radius: 14px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            background: #fafbfc;
        }
        
        .role-option:hover, .role-option.active {
            border-color: var(--brand-turquoise);
            background: rgba(0,180,180,0.05);
        }
        
        .role-option i {
            font-size: 24px;
            color: var(--brand-navy);
            display: block;
            margin-bottom: 5px;
        }
        
        .role-option input[type="radio"] {
            display: none;
        }
    </style>
</head>
<body>

    <div class="login-card">
        <div class="logo-section">
            <div class="logo-icon">
                <i class="bi bi-briefcase-fill"></i>
            </div>
            <h1 class="logo-title">AvocaTN</h1>
            <p class="text-muted">Cabinet d'Avocats - Gestion</p>
        </div>
        
        <!-- ✅ Alerte d'erreur - ne s'affiche QUE si error est présent et non vide -->
        <c:if test="${error != null && not empty error}">
            <div class="alert alert-danger alert-custom" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
            </div>
        </c:if>
        
        <!-- Formulaire POST vers Controller -->
        <form action="Controller" method="post">
            <input type="hidden" name="action" value="login">
            
            <!-- Sélection du rôle -->
            <div class="role-selector">
                <label class="role-option active" onclick="selectRole(this)">
                    <input type="radio" name="role" value="avocat" checked>
                    <i class="bi bi-briefcase"></i>
                    <span>Avocat</span>
                </label>
                <label class="role-option" onclick="selectRole(this)">
                    <input type="radio" name="role" value="client">
                    <i class="bi bi-person"></i>
                    <span>Client</span>
                </label>
            </div>
            
            <!-- Email -->
            <div class="input-group">
                <i class="bi bi-envelope"></i>
                <input type="email" name="email" class="form-control-custom" 
                       placeholder="Email" required>
            </div>
            
            <!-- Mot de passe -->
            <div class="input-group">
                <i class="bi bi-lock"></i>
                <input type="password" name="password" class="form-control-custom" 
                       placeholder="Mot de passe" required>
            </div>
            
            <button type="submit" class="btn-login">
                <i class="bi bi-box-arrow-in-right me-2"></i>Se connecter
            </button>
        </form>
        
        <div class="text-center mt-3">
            <a href="#" style="color: var(--brand-turquoise); text-decoration: none; font-weight: 500;">
                Mot de passe oublié ?
            </a>
        </div>
        
        <div class="guest-link">
            <p class="text-muted mb-0">
                <a href="Controller?action=all">
                    <i class="bi bi-arrow-right-circle me-1"></i>Continuer en invité
                </a>
            </p>
        </div>
    </div>

    <script>
        function selectRole(element) {
            document.querySelectorAll('.role-option').forEach(opt => opt.classList.remove('active'));
            element.classList.add('active');
            element.querySelector('input').checked = true;
        }
    </script>
</body>
</html>