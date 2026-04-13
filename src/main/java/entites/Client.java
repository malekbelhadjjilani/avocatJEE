package entites;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the clients database table.
 * 
 */
@Entity
@Table(name="clients")
@NamedQuery(name="Client.findAll", query="SELECT c FROM Client c")
public class Client implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;

	private String adresse;

	@Lob
	private String avatar;

	private String cin;

	@Temporal(TemporalType.DATE)
	private Date dateInscription;

	@Temporal(TemporalType.DATE)
	private Date dateNaissance;

	private String email;

	private String nom;

	private String password;

	private String prenom;

	private String role;

	private String statut;

	private String telephone;


	//bi-directional many-to-one association to Rendezvous
	@OneToMany(mappedBy="client", fetch=FetchType.EAGER)
	private List<Rendezvous> rendezvouses;

	public Client() {
	}

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAdresse() {
		return this.adresse;
	}

	public void setAdresse(String adresse) {
		this.adresse = adresse;
	}

	public String getAvatar() {
		return this.avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getCin() {
		return this.cin;
	}

	public void setCin(String cin) {
		this.cin = cin;
	}

	public Date getDateInscription() {
		return this.dateInscription;
	}

	public void setDateInscription(Date dateInscription) {
		this.dateInscription = dateInscription;
	}

	public Date getDateNaissance() {
		return this.dateNaissance;
	}

	public void setDateNaissance(Date dateNaissance) {
		this.dateNaissance = dateNaissance;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNom() {
		return this.nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPrenom() {
		return this.prenom;
	}

	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}

	public String getRole() {
		return this.role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getStatut() {
		return this.statut;
	}

	public void setStatut(String statut) {
		this.statut = statut;
	}

	public String getTelephone() {
		return this.telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}


	public List<Rendezvous> getRendezvouses() {
		return this.rendezvouses;
	}

	public void setRendezvouses(List<Rendezvous> rendezvouses) {
		this.rendezvouses = rendezvouses;
	}

	public Rendezvous addRendezvous(Rendezvous rendezvous) {
		getRendezvouses().add(rendezvous);
		rendezvous.setClient(this);

		return rendezvous;
	}

	public Rendezvous removeRendezvous(Rendezvous rendezvous) {
		getRendezvouses().remove(rendezvous);
		rendezvous.setClient(null);

		return rendezvous;
	}

}