package com.evaluation.model;

import java.util.Date;

public class Employe {
    private int matricule;
    private String nomEmploye;
    private String prenomEmp;
    private String fonctionEmp;
    private String serviceEmp;
    private Date dateEmbauche;
    private String sexeEmp;
    private double salaireBase;
    private Entreprise entreprise;

    public Employe() {}

    public int getMatricule() {
        return matricule;
    }

    public void setMatricule(int matricule) {
        this.matricule = matricule;
    }

    public String getNomEmploye() {
        return nomEmploye;
    }

    public void setNomEmploye(String nomEmploye) {
        this.nomEmploye = nomEmploye;
    }

    public String getPrenomEmp() {
        return prenomEmp;
    }

    public void setPrenomEmp(String prenomEmp) {
        this.prenomEmp = prenomEmp;
    }

    public String getFonctionEmp() {
        return fonctionEmp;
    }

    public void setFonctionEmp(String fonctionEmp) {
        this.fonctionEmp = fonctionEmp;
    }

    public String getServiceEmp() {
        return serviceEmp;
    }

    public void setServiceEmp(String serviceEmp) {
        this.serviceEmp = serviceEmp;
    }

    public Date getDateEmbauche() {
        return dateEmbauche;
    }

    public void setDateEmbauche(Date dateEmbauche) {
        this.dateEmbauche = dateEmbauche;
    }

    public String getSexeEmp() {
        return sexeEmp;
    }

    public void setSexeEmp(String sexeEmp) {
        this.sexeEmp = sexeEmp;
    }

    public double getSalaireBase() {
        return salaireBase;
    }

    public void setSalaireBase(double salaireBase) {
        this.salaireBase = salaireBase;
    }

    public Entreprise getEntreprise() {
        return entreprise;
    }

    public void setEntreprise(Entreprise entreprise) {
        this.entreprise = entreprise;
    }
}
