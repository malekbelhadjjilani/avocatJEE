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
import java.util.UUID;

@WebServlet("/Controller")
public class Controller extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @EJB
    private AvocatService avocatService;

    @EJB
    private ClientService clientService;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String actionValue = request.getParameter("action");

        if (actionValue == null) {
            actionValue = "all";
        }

        // 🔹 Afficher les avocats
        if (actionValue.equals("listAvocats")) {
            List<Avocat> avocats = avocatService.getAllAvocats();
            request.setAttribute("avocats", avocats);
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }

        // 🔹 Afficher les clients
        else if (actionValue.equals("listClients")) {
            List<Client> clients = clientService.getAllClients();
            request.setAttribute("clients", clients);
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }

        // 🔹 Afficher tout
        else if (actionValue.equals("all")) {
            request.setAttribute("avocats", avocatService.getAllAvocats());
            request.setAttribute("clients", clientService.getAllClients());
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }

        // 🔹 🔍 Recherche par ID
        else if ("findById".equals(actionValue)) {
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
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String actionValue = request.getParameter("action");

        // 🔹 ➕ Ajouter
        if (actionValue != null && actionValue.equals("add")) {
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
        } else {
            doGet(request, response);
        }
    }

    // Méthode utilitaire pour générer des IDs uniques
    private String generateId(String prefix) {
        return prefix + UUID.randomUUID().toString().substring(0, 8);
    }
}