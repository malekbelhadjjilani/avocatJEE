package mvcController;

import mvcModel.ChatService;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ChatbotServlet", urlPatterns = {"/chatbot"})
public class ChatbotServlet extends HttpServlet {
    
    @EJB
    private ChatService chatService;
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/plain; charset=UTF-8");

        try {
            String message = req.getParameter("message");
            System.out.println("Message reçu: " + message);
            
            if (chatService == null) {
                System.out.println("Injection EJB échouée, instanciation manuelle de ChatService");
                chatService = new mvcModel.ChatService();
            }
            
            String reponse = chatService.repondre(message != null ? message : "");
            System.out.println("Réponse envoyée: " + reponse);
            
            resp.getWriter().write(reponse);
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("Erreur interne du serveur : " + e.getMessage());
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/plain; charset=UTF-8");
        resp.getWriter().write("Chatbot OK - Utilisez POST avec 'message'");
    }
}