package mvcModel;

import java.util.List;
import entites.Avocat;
import jakarta.ejb.LocalBean;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;

@Stateless
@LocalBean
public class AvocatService {

    @PersistenceContext(unitName = "avocatJEE")
    private EntityManager em;

    // 🔹 Get all
    public List<Avocat> getAllAvocats() {
        return em.createNamedQuery("Avocat.findAll", Avocat.class)
                 .getResultList();
    }

    // 🔹 Ajouter
    public void addAvocat(Avocat avocat) {
        em.persist(avocat);
    }

    // 🔹 Get by ID (FIX int)
    public Avocat findById(String id) {
        return em.find(Avocat.class, id);
    }

    // 🔹 Supprimer
    public void deleteAvocat(String id) {
        Avocat a = em.find(Avocat.class, id);
        if (a != null) {
            em.remove(a);
        }
    }
    public Avocat findByEmailAndPassword(String email, String password) {
        try {
            return em.createQuery("SELECT a FROM Avocat a WHERE a.email = :email AND a.password = :password", Avocat.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}