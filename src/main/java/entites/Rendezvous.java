package entites;

import jakarta.persistence.*;
import java.io.Serializable;
import java.sql.Time;
import java.util.Date;

@Entity
@Table(name = "rendezvous")
public class Rendezvous implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", length = 10, nullable = false)
    private String id;  // ← String, pas Long

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "clientId", referencedColumnName = "id")
    private Client client;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "avocatId", referencedColumnName = "id")
    private Avocat avocat;

    @Column(name = "date")
    @Temporal(TemporalType.DATE)
    private Date date;

    @Column(name = "heure")
    private Time heure;

    @Column(name = "duree")
    private Integer duree;

    @Column(name = "motif", columnDefinition = "TEXT")
    private String motif;

    @Column(name = "statut", length = 20)
    private String statut;

    @Column(name = "dateCreation")
    @Temporal(TemporalType.DATE)
    private Date dateCreation;

    // Getters et Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public Client getClient() { return client; }
    public void setClient(Client client) { this.client = client; }

    public Avocat getAvocat() { return avocat; }
    public void setAvocat(Avocat avocat) { this.avocat = avocat; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }

    public Time getHeure() { return heure; }
    public void setHeure(Time heure) { this.heure = heure; }

    public Integer getDuree() { return duree; }
    public void setDuree(Integer duree) { this.duree = duree; }

    public String getMotif() { return motif; }
    public void setMotif(String motif) { this.motif = motif; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public Date getDateCreation() { return dateCreation; }
    public void setDateCreation(Date dateCreation) { this.dateCreation = dateCreation; }
}