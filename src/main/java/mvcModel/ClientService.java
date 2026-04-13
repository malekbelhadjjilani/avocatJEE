package mvcModel;

import jakarta.ejb.LocalBean;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;
import entites.Client;

@Stateless
@LocalBean
public class ClientService {

    @PersistenceContext(unitName = "avocatJEE")
    private EntityManager em;

    // 🔹 Get all
    public List<Client> getAllClients() {
        return em.createNamedQuery("Client.findAll", Client.class)
                 .getResultList();
    }

    // 🔹 Get by ID ()
    public Client findById(String id) {
        return em.find(Client.class, id);
    }

    // 🔹 Ajouter (NEW)
    public void addClient(Client c) {
        em.persist(c);
    }

    // 🔹 Supprimer
    public void deleteClient(String id) {
        Client c = em.find(Client.class, id);
        if (c != null) {
            em.remove(c);
        }
    }
}