package mvcModel;

import jakarta.ejb.Stateless;
import java.util.HashMap;
import java.util.Map;

@Stateless
public class ChatService {
    
    private static final Map<String, String> FAQ = new HashMap<>();
    
    static {
        FAQ.put("rendez-vous", "Pour prendre rendez-vous, connectez-vous et accédez à l'onglet 'Rendez-vous'. Vous pouvez choisir un créneau disponible.");
        FAQ.put("annuler", "Pour annuler un rendez-vous, allez dans 'Mes Rendez-vous' et cliquez sur 'Annuler'.");
        FAQ.put("prix", "Les honoraires sont fixés lors de la première consultation. Un devis détaillé vous sera fourni.");
        FAQ.put("délai", "Les délais varient selon la procédure. Un procès verbal prend 2-4 semaines, une affaire civile peut prendre plusieurs mois.");
        FAQ.put("documents", "Apportez votre pièce d'identité, les documents relatifs à votre affaire, et tout courrier reçu.");
        FAQ.put("consultation", "La première consultation dure environ 1h. L'avocat analysera votre situation et vous conseillera.");
        FAQ.put("contact", "Vous pouvez nous contacter par email ou par téléphone au 01 23 45 67 89.");
        FAQ.put("horaires", "Le cabinet est ouvert du lundi au vendredi, de 9h à 18h.");
        FAQ.put("aide", "Je peux répondre à vos questions sur : rendez-vous, prix, délais, documents, consultation, contact, horaires.");
        FAQ.put("bonjour", "Bonjour ! Comment puis-je vous aider aujourd'hui ?");
        FAQ.put("salut", "Salut ! Posez-moi vos questions sur les procédures juridiques.");
    }
    
    public String repondre(String question) {
        String questionLower = question.toLowerCase().trim();
        
        // Recherche exacte
        if (FAQ.containsKey(questionLower)) {
            return FAQ.get(questionLower);
        }
        
        // Recherche par mot-clé
        for (Map.Entry<String, String> entry : FAQ.entrySet()) {
            if (questionLower.contains(entry.getKey())) {
                return entry.getValue();
            }
        }
        
        return "Je n'ai pas trouvé de réponse précise. Essayez avec : rendez-vous, prix, délais, documents, consultation, contact, horaires. Ou contactez directement le cabinet.";
    }
}