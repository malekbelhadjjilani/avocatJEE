<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cabinet d'Avocats - Gestion</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --brand-navy: #1a2b4a;
            --brand-turquoise: #00b4b4;
            --brand-gold: #d4a574;
            --bg-light: #f8f9fa;
        }
        
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e9ecef 100%);
            min-height: 100vh;
        }
        
        .navbar-brand {
            font-weight: 700;
            color: var(--brand-navy) !important;
        }
        
        .nav-link {
            font-weight: 500;
            color: #6c757d;
            transition: all 0.3s ease;
        }
        
        .nav-link:hover, .nav-link.active {
            color: var(--brand-turquoise);
        }
        
        .card-avocat {
            border: none;
            border-radius: 16px;
            background: white;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            overflow: hidden;
        }
        
        .card-avocat:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(0,0,0,0.15);
        }
        
        .card-banner {
            height: 80px;
            background: linear-gradient(135deg, var(--brand-navy) 0%, var(--brand-turquoise) 100%);
        }
        
        .avatar-container {
            margin-top: -40px;
            position: relative;
            display: inline-block;
        }
        
        .avatar {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border: 4px solid white;
            border-radius: 50%;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .avatar-placeholder {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--brand-navy) 0%, var(--brand-turquoise) 100%);
            border: 4px solid white;
            border-radius: 50%;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 28px;
            font-weight: 700;
        }
        
        .status-badge {
            position: absolute;
            bottom: 5px;
            right: -10px;
            font-size: 10px;
            padding: 4px 10px;
            border-radius: 20px;
            font-weight: 500;
        }
        
        .status-valide {
            background: #d1fae5;
            color: #065f46;
        }
        
        .status-attente {
            background: #fef3c7;
            color: #92400e;
        }
        
        .speciality-badge {
            background: rgba(0, 180, 180, 0.1);
            color: var(--brand-turquoise);
            font-size: 12px;
            padding: 6px 12px;
            border-radius: 20px;
        }
        
        .btn-primary-custom {
            background: var(--brand-navy);
            border: none;
            border-radius: 10px;
            padding: 10px 20px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-primary-custom:hover {
            background: var(--brand-turquoise);
            transform: translateY(-2px);
        }
        
        .btn-outline-custom {
            border: 2px solid var(--brand-turquoise);
            color: var(--brand-turquoise);
            border-radius: 10px;
            padding: 8px 18px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-outline-custom:hover {
            background: var(--brand-turquoise);
            color: white;
        }
        
        .search-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }
        
        .form-control-custom {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 12px 16px;
            transition: all 0.3s ease;
        }
        
        .form-control-custom:focus {
            border-color: var(--brand-turquoise);
            box-shadow: 0 0 0 4px rgba(0, 180, 180, 0.1);
        }
        
        .stat-value {
            font-size: 18px;
            font-weight: 700;
            color: var(--brand-navy);
        }
        
        .stat-label {
            font-size: 11px;
            color: #6c757d;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }
        
        .empty-state i {
            font-size: 64px;
            color: #dee2e6;
            margin-bottom: 20px;
        }
        
        .alert-custom {
            border-radius: 12px;
            border: none;
        }
        
        .text-brand-navy {
            color: var(--brand-navy);
        }
        
        .text-brand-turquoise {
            color: var(--brand-turquoise);
        }

        /* ==================== CHATBOT CSS ==================== */
        #chatbot-widget {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 350px;
            font-family: 'Inter', sans-serif;
            z-index: 9999;
            box-shadow: 0 8px 32px rgba(0,0,0,0.2);
            border-radius: 16px;
            overflow: hidden;
        }

        #chatbot-header {
            background: linear-gradient(135deg, #1a2b4a 0%, #00b4b4 100%);
            color: white;
            padding: 16px 20px;
            cursor: pointer;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 15px;
        }

        #chatbot-header i.bi-robot {
            font-size: 22px;
        }

        #chatbot-header i.bi-chevron-up,
        #chatbot-header i.bi-chevron-down {
            margin-left: auto;
            font-size: 14px;
        }

        #chatbot-body {
            display: none;
            background: white;
            height: 400px;
            flex-direction: column;
        }

        #chatbot-body.active {
            display: flex;
        }

        #chat-messages {
            flex: 1;
            overflow-y: auto;
            padding: 15px;
            background: #f8f9fa;
            display: flex;
            flex-direction: column;
        }

        .chat-welcome {
            text-align: center;
            padding: 15px 10px;
            color: #6c757d;
            font-size: 12px;
            border-bottom: 1px solid #e9ecef;
            margin-bottom: 10px;
        }

        .chat-welcome i {
            font-size: 32px;
            color: #00b4b4;
            margin-bottom: 8px;
        }

        .msg {
            margin-bottom: 12px;
            padding: 12px 16px;
            border-radius: 18px;
            max-width: 85%;
            line-height: 1.5;
            font-size: 14px;
            animation: fadeIn 0.3s ease;
            word-wrap: break-word;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .msg.bot {
            background: #e3f2fd;
            color: #1565c0;
            align-self: flex-start;
            border-bottom-left-radius: 4px;
        }

        .msg.user {
            background: #1a2b4a;
            color: white;
            align-self: flex-end;
            margin-left: auto;
            border-bottom-right-radius: 4px;
        }

        .typing {
            font-style: italic;
            color: #6c757d;
            font-size: 13px;
            padding: 8px 12px;
            background: #e3f2fd;
            border-radius: 18px;
            border-bottom-left-radius: 4px;
            align-self: flex-start;
        }

        #chat-input {
            display: flex;
            padding: 12px 15px;
            border-top: 1px solid #e0e0e0;
            background: white;
            gap: 10px;
        }

        #chat-input input {
            flex: 1;
            border: 2px solid #e9ecef;
            border-radius: 25px;
            padding: 10px 18px;
            outline: none;
            font-size: 14px;
            transition: all 0.3s;
        }

        #chat-input input:focus {
            border-color: #00b4b4;
            box-shadow: 0 0 0 3px rgba(0, 180, 180, 0.1);
        }

        #chat-input button {
            background: linear-gradient(135deg, #1a2b4a 0%, #00b4b4 100%);
            color: white;
            border: none;
            border-radius: 50%;
            width: 44px;
            height: 44px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
            flex-shrink: 0;
        }

        #chat-input button:hover {
            transform: scale(1.1);
            box-shadow: 0 4px 12px rgba(0, 180, 180, 0.3);
        }

        #chat-input button i {
            font-size: 16px;
        }
    </style>
</head>
<body>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="Controller?action=all">
            <i class="bi bi-briefcase-fill text-brand-turquoise me-2"></i>
            <span>AvocaTN</span>
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link ${empty param.action || param.action == 'all' ? 'active' : ''}" href="Controller?action=all">
                        <i class="bi bi-grid me-1"></i>Tous
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${param.action == 'listAvocats' ? 'active' : ''}" href="Controller?action=listAvocats">
                        <i class="bi bi-briefcase me-1"></i>Avocats
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${param.action == 'listClients' ? 'active' : ''}" href="Controller?action=listClients">
                        <i class="bi bi-people me-1"></i>Clients
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container py-4">

    <!-- Messages d'erreur -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-custom mb-4" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
        </div>
    </c:if>

    <!-- Recherche -->
    <div class="search-card p-4 mb-4">
        <h5 class="mb-3 text-brand-navy">
            <i class="bi bi-search me-2"></i>Rechercher
        </h5>
        <form action="Controller" method="get" class="row g-3">
            <div class="col-md-4">
                <input type="text" name="id" class="form-control form-control-custom" 
                       placeholder="ID (ex: a1, c2...)" required>
            </div>
            <div class="col-md-3">
                <select name="type" class="form-select form-control-custom">
                    <option value="avocat">Avocat</option>
                    <option value="client">Client</option>
                </select>
            </div>
            <div class="col-md-2">
                <input type="hidden" name="action" value="findById">
                <button type="submit" class="btn btn-primary-custom w-100 text-white">
                    <i class="bi bi-search me-1"></i>Chercher
                </button>
            </div>
        </form>
    </div>

    <!-- Résultat de recherche -->
    <c:if test="${not empty result}">
        <div class="mb-4">
            <h5 class="mb-3 text-brand-navy">Résultat de la recherche</h5>
            <div class="row">
                <div class="col-md-6 col-lg-4">
                    <div class="card-avocat">
                        <div class="card-banner"></div>
                        <div class="text-center px-3 pb-3">
                            <div class="avatar-container">
                                <c:choose>
                                    <c:when test="${not empty result.avatar}">
                                        <img src="${result.avatar}" alt="${result.prenom}" class="avatar">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="avatar-placeholder">
                                            ${result.prenom.charAt(0)}${result.nom.charAt(0)}
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${not empty result.statut}">
                                    <span class="status-badge ${result.statut == 'valide' || result.statut == 'disponible' || result.statut == 'actif' ? 'status-valide' : 'status-attente'}">
                                        ${result.statut == 'valide' || result.statut == 'disponible' || result.statut == 'actif' ? 'Actif' : 'En attente'}
                                    </span>
                                </c:if>
                            </div>
                            <h5 class="mt-3 mb-1 fw-bold text-brand-navy">
                                ${result.prenom} ${result.nom}
                            </h5>
                            <p class="text-muted mb-2">
                                <i class="bi bi-envelope me-1"></i>${result.email}
                            </p>
                            <c:if test="${not empty result.specialite}">
                                <span class="speciality-badge d-inline-block mb-2">
                                    <i class="bi bi-briefcase me-1"></i>${result.specialite}
                                </span>
                            </c:if>
                            <div class="d-flex justify-content-center gap-3 mt-3 pt-3 border-top">
                                <c:if test="${not empty result.noteMoyenne}">
                                    <div class="text-center">
                                        <div class="stat-value">
                                            <i class="bi bi-star-fill text-warning" style="font-size: 14px;"></i>
                                            <fmt:formatNumber value="${result.noteMoyenne}" pattern="#0.0"/>
                                        </div>
                                        <div class="stat-label">Note</div>
                                    </div>
                                </c:if>
                                <c:if test="${not empty result.prixHeure}">
                                    <div class="text-center">
                                        <div class="stat-value">${result.prixHeure}</div>
                                        <div class="stat-label">DT/heure</div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Section Avocats -->
    <c:if test="${not empty avocats}">
        <div class="mb-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="text-brand-navy mb-0">
                    <i class="bi bi-briefcase me-2"></i>Avocats
                    <span class="badge bg-secondary ms-2">${avocats.size()}</span>
                </h4>
            </div>
            
            <div class="row g-4">
                <c:forEach var="a" items="${avocats}">
                    <div class="col-md-6 col-lg-4 col-xl-3">
                        <div class="card-avocat h-100">
                            <div class="card-banner"></div>
                            <div class="text-center px-3 pb-3">
                                <div class="avatar-container">
                                    <c:choose>
                                        <c:when test="${not empty a.avatar}">
                                            <img src="${a.avatar}" alt="${a.prenom}" class="avatar">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="avatar-placeholder">
                                                ${a.prenom.charAt(0)}${a.nom.charAt(0)}
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="status-badge ${a.statut == 'valide' || a.statut == 'disponible' ? 'status-valide' : 'status-attente'}">
                                        ${a.statut == 'valide' || a.statut == 'disponible' ? 'Validé' : 'En attente'}
                                    </span>
                                </div>
                                
                                <h6 class="mt-3 mb-1 fw-bold text-brand-navy">
                                    Maître ${a.prenom} ${a.nom}
                                </h6>
                                
                                <div class="d-flex justify-content-center gap-2 flex-wrap mb-2">
                                    <c:if test="${not empty a.specialite}">
                                        <span class="speciality-badge">
                                            <i class="bi bi-briefcase me-1"></i>${a.specialite}
                                        </span>
                                    </c:if>
                                </div>
                                
                                <p class="text-muted small mb-2">
                                    <i class="bi bi-geo-alt me-1 text-brand-turquoise"></i>
                                    ${empty a.region ? 'Non spécifié' : a.region}
                                </p>
                                
                                <div class="d-flex justify-content-around align-items-center py-2 my-2 border-top border-bottom">
                                    <div class="text-center">
                                        <div class="stat-value">
                                            <i class="bi bi-star-fill text-warning" style="font-size: 12px;"></i>
                                            <fmt:formatNumber value="${empty a.noteMoyenne ? 0 : a.noteMoyenne}" pattern="#0.0"/>
                                        </div>
                                        <div class="stat-label">${empty a.nombreAvis ? 0 : a.nombreAvis} avis</div>
                                    </div>
                                    <div class="vr"></div>
                                    <div class="text-center">
                                        <div class="stat-value">${empty a.prixHeure ? '-' : a.prixHeure}</div>
                                        <div class="stat-label">DT/h</div>
                                    </div>
                                    <div class="vr"></div>
                                    <div class="text-center">
                                        <div class="stat-value">${empty a.anneesExperience ? '-' : a.anneesExperience}</div>
                                        <div class="stat-label">ans</div>
                                    </div>
                                </div>
                                
                                <div class="d-grid gap-2">
                                    <a href="Controller?action=findById&id=${a.id}&type=avocat" 
                                       class="btn btn-primary-custom text-white btn-sm">
                                        Voir profil <i class="bi bi-chevron-right ms-1"></i>
                                    </a>
                                    <button class="btn btn-outline-custom btn-sm">
                                        <i class="bi bi-calendar-check me-1"></i>Prendre RDV
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>

    <!-- Section Clients -->
    <c:if test="${not empty clients}">
        <div class="mb-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="text-brand-navy mb-0">
                    <i class="bi bi-people me-2"></i>Clients
                    <span class="badge bg-secondary ms-2">${clients.size()}</span>
                </h4>
            </div>
            
            <div class="row g-4">
                <c:forEach var="c" items="${clients}">
                    <div class="col-md-6 col-lg-4 col-xl-3">
                        <div class="card-avocat h-100">
                            <div class="card-banner" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);"></div>
                            <div class="text-center px-3 pb-3">
                                <div class="avatar-container">
                                    <c:choose>
                                        <c:when test="${not empty c.avatar}">
                                            <img src="${c.avatar}" alt="${c.prenom}" class="avatar">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="avatar-placeholder" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                                                ${c.prenom.charAt(0)}${c.nom.charAt(0)}
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="status-badge status-valide">Actif</span>
                                </div>
                                
                                <h6 class="mt-3 mb-1 fw-bold text-brand-navy">
                                    ${c.prenom} ${c.nom}
                                </h6>
                                
                                <p class="text-muted small mb-2">
                                    <i class="bi bi-envelope me-1"></i>${c.email}
                                </p>
                                
                                <c:if test="${not empty c.telephone}">
                                    <p class="text-muted small mb-2">
                                        <i class="bi bi-telephone me-1 text-brand-turquoise"></i>${c.telephone}
                                    </p>
                                </c:if>
                                
                                <div class="d-grid gap-2 mt-3">
                                    <a href="Controller?action=findById&id=${c.id}&type=client" 
                                       class="btn btn-primary-custom text-white btn-sm">
                                        Voir détails <i class="bi bi-chevron-right ms-1"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>

    <!-- État vide -->
    <c:if test="${empty avocats && empty clients && empty result}">
        <div class="empty-state">
            <i class="bi bi-inbox"></i>
            <h4 class="text-muted">Aucun résultat</h4>
            <p class="text-muted">Utilisez la recherche ou naviguez entre les sections</p>
            <a href="Controller?action=all" class="btn btn-primary-custom text-white">
                <i class="bi bi-arrow-clockwise me-2"></i>Afficher tout
            </a>
        </div>
    </c:if>

</div>

<!-- ==================== CHATBOT WIDGET ==================== -->
<div id="chatbot-widget">
    <div id="chatbot-header" onclick="toggleChat()">
        <i class="bi bi-robot"></i>
        <span>Assistant Juridique</span>
        <i class="bi bi-chevron-up" id="chat-icon-toggle"></i>
    </div>
    <div id="chatbot-body">
        <div id="chat-messages">
            <div class="chat-welcome">
                <i class="bi bi-shield-check"></i>
                <p class="mb-0">Posez vos questions sur les procédures juridiques</p>
            </div>
            <div class="msg bot">Bonjour ! Je suis l'assistant virtuel du cabinet. Comment puis-je vous aider aujourd'hui ?</div>
        </div>
        <div id="chat-input">
            <input type="text" id="user-message" placeholder="Écrivez votre question..." 
                   onkeypress="if(event.key==='Enter') sendMessage()">
            <button onclick="sendMessage()">
                <i class="bi bi-send-fill"></i>
            </button>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- ==================== CHATBOT JAVASCRIPT ==================== -->
<!-- ==================== CHATBOT JAVASCRIPT ==================== -->
<script>
    // ==================== FONCTIONS UTILITAIRES (définies d'abord) ====================
    
    // Scroll automatique vers le bas
    function scrollToBottom() {
        const container = document.getElementById('chat-messages');
        if (container) {
            container.scrollTop = container.scrollHeight;
        }
    }

    // Ajouter un message dans le chat
    function addMessage(text, sender) {
        const container = document.getElementById('chat-messages');
        if (!container) return;
        
        const div = document.createElement('div');
        div.className = 'msg ' + sender;
        div.textContent = text;
        container.appendChild(div);
        scrollToBottom();
    }

    // Toggle ouverture/fermeture du chat
    function toggleChat() {
        const body = document.getElementById('chatbot-body');
        const icon = document.getElementById('chat-icon-toggle');
        
        if (!body || !icon) {
            console.error('Elements chatbot non trouvés');
            return;
        }
        
        body.classList.toggle('active');
        
        if (body.classList.contains('active')) {
            icon.classList.remove('bi-chevron-up');
            icon.classList.add('bi-chevron-down');
            setTimeout(() => {
                const input = document.getElementById('user-message');
                if (input) input.focus();
            }, 100);
        } else {
            icon.classList.remove('bi-chevron-down');
            icon.classList.add('bi-chevron-up');
        }
    }

    // ==================== ENVOI MESSAGE (utilise les fonctions ci-dessus) ====================
    
    // Envoyer un message
    async function sendMessage() {
        const input = document.getElementById('user-message');
        if (!input) return;
        
        const message = input.value.trim();
        if (!message) return;
        
        // Affiche message utilisateur
        addMessage(message, 'user');
        input.value = '';
        
        // Indicateur "en train d'écrire"
        const container = document.getElementById('chat-messages');
        if (!container) return;
        
        const typing = document.createElement('div');
        typing.className = 'typing';
        typing.id = 'typing-indicator';
        typing.innerHTML = '<i class="bi bi-three-dots"></i> En train d\'écrire...';
        container.appendChild(typing);
        scrollToBottom();
        
        // Appel API via ChatbotServlet
        try {
        	const response = await fetch('chatbot', {  // ← OK, appelle ChatbotServlet
        	    method: 'POST',
        	    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        	    body: 'message=' + encodeURIComponent(message)
        	});
            
            // Vérifie si c'est du texte ou du HTML
            const rawText = await response.text();
            console.log("Raw response:", rawText.substring(0, 100));
            
            // Supprime indicateur
            const indicator = document.getElementById('typing-indicator');
            if (indicator) indicator.remove();
            
            // Si c'est du HTML (erreur), affiche message d'erreur
            if (rawText.trim().startsWith('<') || rawText.trim().startsWith('<!DOCTYPE')) {
                addMessage('Erreur serveur: ChatbotServlet non trouvé ou erreur de déploiement.', 'bot');
                return;
            }
            
            // Affiche réponse texte
            addMessage(rawText, 'bot');
            
        } catch (error) {
            console.error('Erreur chatbot:', error);
            const indicator = document.getElementById('typing-indicator');
            if (indicator) indicator.remove();
            addMessage('Désolé, le service est temporairement indisponible.', 'bot');
        }
    }
</script>

</body>
</html>