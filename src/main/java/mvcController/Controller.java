package mvcController;

import mvcModel.ChatService;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "Controller", urlPatterns = {"/Controller"})  // ← Changé de /chatbot à /Controller
public class Controller extends HttpServlet {
    
    @EJB
    private ChatService chatService;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        String action = req.getParameter("action");
        
        if ("all".equals(action)) {
            // Votre logique pour afficher tous les avocats/clients
            req.getRequestDispatcher("/home.jsp").forward(req, resp);
        } else if ("listAvocats".equals(action)) {
            // Logique liste avocats
            req.getRequestDispatcher("/home.jsp").forward(req, resp);
        } else if ("listClients".equals(action)) {
            // Logique liste clients
            req.getRequestDispatcher("/home.jsp").forward(req, resp);
        } else if ("findById".equals(action)) {
            // Logique recherche par ID
            req.getRequestDispatcher("/home.jsp").forward(req, resp);
        } else {
            resp.setContentType("text/plain; charset=UTF-8");
            resp.getWriter().write("Controller actif. Utilisez action=all, listAvocats, listClients, findById");
        }
    }
    
    // Pas de doPost pour le chatbot ici !
}