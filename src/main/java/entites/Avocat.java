package entites;

import jakarta.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "avocats")
@NamedQueries({
    @NamedQuery(name="Avocat.findAll", query="SELECT a FROM Avocat a"),
    @NamedQuery(name="Avocat.findBySpecialite", query="SELECT a FROM Avocat a WHERE a.specialite = :specialite"),
    @NamedQuery(name="Avocat.findByRegion", query="SELECT a FROM Avocat a WHERE a.region = :region")
})
public class Avocat implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", length = 10, nullable = false)
    private String id;  // ← CHANGÉ : String au lieu de Long

    @Column(name = "email", length = 100, nullable = false)
    private String email;

    @Column(name = "nom", length = 100, nullable = false)
    private String nom;

    @Column(name = "prenom", length = 100, nullable = false)
    private String prenom;

    @Column(name = "role", length = 20)
    private String role = "avocat";

    @Column(name = "telephone", length = 20)
    private String telephone;

    @Column(name = "dateNaissance")
    @Temporal(TemporalType.DATE)
    private Date dateNaissance;

    @Column(name = "cin", length = 20)
    private String cin;

    @Column(name = "avatar", columnDefinition = "TEXT")
    private String avatar;

    @Column(name = "specialite", length = 50)
    private String specialite;

    @Column(name = "region", length = 50)
    private String region;

    @Column(name = "prixHeure", precision = 10, scale = 2)
    private BigDecimal prixHeure;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "anneesExperience")
    private Integer anneesExperience;

    @Column(name = "statut", length = 20)
    private String statut;

    @Column(name = "numeroBarreau", length = 50)
    private String numeroBarreau;

    @Column(name = "adresse", columnDefinition = "TEXT")
    private String adresse;

    @Column(name = "noteMoyenne", precision = 4, scale = 2)
    private BigDecimal noteMoyenne;

    @Column(name = "nombreAvis")
    private Integer nombreAvis;

    @Column(name = "password", length = 255, nullable = false)
    private String password;

    // Relation vers Rendez-vous
    @OneToMany(mappedBy = "avocat", fetch = FetchType.LAZY)
    private List<Rendezvous> rendezvousList;

    // Getters et Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getTelephone() { return telephone; }
    public void setTelephone(String telephone) { this.telephone = telephone; }

    public Date getDateNaissance() { return dateNaissance; }
    public void setDateNaissance(Date dateNaissance) { this.dateNaissance = dateNaissance; }

    public String getCin() { return cin; }
    public void setCin(String cin) { this.cin = cin; }

    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }

    public String getSpecialite() { return specialite; }
    public void setSpecialite(String specialite) { this.specialite = specialite; }

    public String getRegion() { return region; }
    public void setRegion(String region) { this.region = region; }

    public BigDecimal getPrixHeure() { return prixHeure; }
    public void setPrixHeure(BigDecimal prixHeure) { this.prixHeure = prixHeure; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Integer getAnneesExperience() { return anneesExperience; }
    public void setAnneesExperience(Integer anneesExperience) { this.anneesExperience = anneesExperience; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public String getNumeroBarreau() { return numeroBarreau; }
    public void setNumeroBarreau(String numeroBarreau) { this.numeroBarreau = numeroBarreau; }

    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }

    public BigDecimal getNoteMoyenne() { return noteMoyenne; }
    public void setNoteMoyenne(BigDecimal noteMoyenne) { this.noteMoyenne = noteMoyenne; }

    public Integer getNombreAvis() { return nombreAvis; }
    public void setNombreAvis(Integer nombreAvis) { this.nombreAvis = nombreAvis; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public List<Rendezvous> getRendezvousList() { return rendezvousList; }
    public void setRendezvousList(List<Rendezvous> rendezvousList) { this.rendezvousList = rendezvousList; }
}