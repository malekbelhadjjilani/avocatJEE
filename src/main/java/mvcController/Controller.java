package mvcController;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import mvcModel.AvocatService;
import mvcModel.ClientService;
import entites.Avocat;
import entites.Client;

import java.io.IOException;
import java.util.List;

@WebServlet("/Controller")
public class Controller extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @EJB
    private AvocatService avocatService;

    @EJB
    private ClientService clientService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String actionValue = request.getParameter("action");
        
        if (actionValue == null || actionValue.trim().isEmpty()) {
            response.sendRedirect("Controller?action=login");
            return;
        }

        switch (actionValue) {
            case "login" -> {
                // ✅ CORRIGÉ : login.jsp (hors WEB-INF)
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            case "logout" -> {
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                response.sendRedirect("Controller?action=login");
            }
            case "listAvocats" -> {
                List<Avocat> avocats = avocatService.getAllAvocats();
                request.setAttribute("avocats", avocats);
                // ✅ CORRIGÉ : home.jsp (hors WEB-INF)
                request.getRequestDispatcher("home.jsp").forward(request, response);
            }
            case "listClients" -> {
                List<Client> clients = clientService.getAllClients();
                request.setAttribute("clients", clients);
                request.getRequestDispatcher("home.jsp").forward(request, response);
            }
            case "all" -> {
                request.setAttribute("avocats", avocatService.getAllAvocats());
                request.setAttribute("clients", clientService.getAllClients());
                request.getRequestDispatcher("home.jsp").forward(request, response);
            }
            case "findById" -> {
                String id = request.getParameter("id");
                String type = request.getParameter("type");

                if (id == null || id.trim().isEmpty()) {
                    request.setAttribute("error", "ID requis");
                } else if ("avocat".equals(type)) {
                    Avocat a = avocatService.findById(id);
                    if (a != null) {
                        request.setAttribute("result", a);
                    } else {
                        request.setAttribute("error", "Avocat non trouvé: " + id);
                    }
                } else {
                    Client c = clientService.findById(id);
                    if (c != null) {
                        request.setAttribute("result", c);
                    } else {
                        request.setAttribute("error", "Client non trouvé: " + id);
                    }
                }
                request.getRequestDispatcher("home.jsp").forward(request, response);
            }
            default -> {
                response.sendRedirect("Controller?action=login");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String actionValue = request.getParameter("action");

        switch (actionValue) {
            case "login" -> {
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String role = request.getParameter("role");

                if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
                    request.setAttribute("error", "Email et mot de passe requis");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }

                HttpSession session = request.getSession();

                if ("avocat".equals(role)) {
                    Avocat avocat = avocatService.findByEmailAndPassword(email, password);
                    if (avocat != null) {
                        session.setAttribute("user", avocat);
                        session.setAttribute("userRole", "avocat");
                        response.sendRedirect("Controller?action=all");
                    } else {
                        request.setAttribute("error", "Email ou mot de passe incorrect");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                } else {
                    Client client = clientService.findByEmailAndPassword(email, password);
                    if (client != null) {
                        session.setAttribute("user", client);
                        session.setAttribute("userRole", "client");
                        response.sendRedirect("Controller?action=all");
                    } else {
                        request.setAttribute("error", "Email ou mot de passe incorrect");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                }
            }
            case "add" -> {
                String nom = request.getParameter("nom");
                String prenom = request.getParameter("prenom");
                String email = request.getParameter("email");
                String telephone = request.getParameter("telephone");
                String type = request.getParameter("type");

                if ("avocat".equals(type)) {
                    Avocat avocat = new Avocat();
                    avocat.setId(generateId("a"));
                    avocat.setNom(nom);
                    avocat.setPrenom(prenom);
                    avocat.setEmail(email);
                    avocat.setTelephone(telephone);
                    avocat.setRole("avocat");
                    avocat.setStatut("disponible");
                    avocat.setPassword("");
                    avocatService.addAvocat(avocat);
                } else if ("client".equals(type)) {
                    Client client = new Client();
                    client.setId(generateId("c"));
                    client.setNom(nom);
                    client.setPrenom(prenom);
                    client.setEmail(email);
                    client.setTelephone(telephone);
                    client.setRole("client");
                    client.setStatut("actif");
                    client.setPassword("");
                    clientService.addClient(client);
                }

                response.sendRedirect("Controller?action=all");
            }
            default -> {
                response.sendRedirect("Controller?action=login");
            }
        }
    }

    private String generateId(String prefix) {
        return prefix + System.currentTimeMillis();
    }
}