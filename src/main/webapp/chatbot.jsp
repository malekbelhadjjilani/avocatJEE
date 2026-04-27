<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- CSS du chatbot -->
<style>
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
        transition: transform 0.3s;
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

<!-- Widget Chatbot -->
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

<!-- JavaScript du chatbot -->
<script>
    // Toggle ouverture/fermeture du chat
    function toggleChat() {
        const body = document.getElementById('chatbot-body');
        const icon = document.getElementById('chat-icon-toggle');
        body.classList.toggle('active');
        
        if (body.classList.contains('active')) {
            icon.classList.remove('bi-chevron-up');
            icon.classList.add('bi-chevron-down');
            setTimeout(() => document.getElementById('user-message').focus(), 100);
        } else {
            icon.classList.remove('bi-chevron-down');
            icon.classList.add('bi-chevron-up');
        }
    }

    // Envoyer un message
    async function sendMessage() {
        const input = document.getElementById('user-message');
        const message = input.value.trim();
        if (!message) return;
        
        // Affiche message utilisateur
        addMessage(message, 'user');
        input.value = '';
        
        // Indicateur "en train d'écrire"
        const typing = document.createElement('div');
        typing.className = 'typing';
        typing.id = 'typing-indicator';
        typing.innerHTML = '<i class="bi bi-three-dots"></i> En train d\'écrire...';
        document.getElementById('chat-messages').appendChild(typing);
        scrollToBottom();
        
        // Appel API
        try {
            const response = await fetch('api/chat', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'message=' + encodeURIComponent(message)
            });
            
            const reponse = await response.text();
            
            // Supprime indicateur et affiche réponse
            document.getElementById('typing-indicator').remove();
            addMessage(reponse, 'bot');
            
        } catch (error) {
            document.getElementById('typing-indicator').remove();
            addMessage('Désolé, une erreur est survenue. Veuillez réessayer plus tard.', 'bot');
        }
    }

    // Ajouter un message dans le chat
    function addMessage(text, sender) {
        const div = document.createElement('div');
        div.className = 'msg ' + sender;
        div.textContent = text;
        document.getElementById('chat-messages').appendChild(div);
        scrollToBottom();
    }

    // Scroll automatique vers le bas
    function scrollToBottom() {
        const container = document.getElementById('chat-messages');
        container.scrollTop = container.scrollHeight;
    }
</script>