// Toggle ouverture/fermeture du chat
function toggleChat() {
    document.getElementById('chatbot-body').classList.toggle('active');
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
    typing.className = 'msg bot typing';
    typing.id = 'typing-indicator';
    typing.textContent = 'En train d\'écrire...';
    document.getElementById('chat-messages').appendChild(typing);
    scrollToBottom();
    
    // Appel API - réponse en texte brut
    try {
        const response = await fetch('api/chat', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'message=' + encodeURIComponent(message)
        });
        
        const reponse = await response.text();  // ← .text() pas .json()
        
        // Supprime indicateur et affiche réponse
        document.getElementById('typing-indicator').remove();
        addMessage(reponse, 'bot');
        
    } catch (error) {
        document.getElementById('typing-indicator').remove();
        addMessage('Erreur de connexion. Réessayez plus tard.', 'bot');
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

// Ouvrir le chat au chargement (optionnel)
window.onload = function() {
    // toggleChat(); // Décommente pour ouvrir automatiquement
};