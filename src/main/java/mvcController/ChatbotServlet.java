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
        
        System.out.println("=== ChatbotServlet doPost appelé ==="); // LOG de debug
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/plain; charset=UTF-8");
        
        String message = req.getParameter("message");
        System.out.println("Message reçu: " + message); // LOG de debug
        
        String reponse = chatService.repondre(message != null ? message : "");
        System.out.println("Réponse: " + reponse); // LOG de debug
        
        resp.getWriter().write(reponse);
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/plain; charset=UTF-8");
        resp.getWriter().write("Chatbot OK - Utilisez POST avec 'message'");
    }
}