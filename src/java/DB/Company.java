package DB;
// Generated May 1, 2017 3:38:53 PM by Hibernate Tools 4.3.1


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Company generated by hbm2java
 */
public class Company  implements java.io.Serializable {


     private Integer idCompany;
     private String name;
     private String regiNo;
     private Date regiDate;
     private String description;
     private String startDate;
     private String awared;
     private Set<Supplier> suppliers = new HashSet<Supplier>(0);

    public Company() {
    }

    public Company(String name, String regiNo, Date regiDate, String description, String startDate, String awared, Set<Supplier> suppliers) {
       this.name = name;
       this.regiNo = regiNo;
       this.regiDate = regiDate;
       this.description = description;
       this.startDate = startDate;
       this.awared = awared;
       this.suppliers = suppliers;
    }
   
    public Integer getIdCompany() {
        return this.idCompany;
    }
    
    public void setIdCompany(Integer idCompany) {
        this.idCompany = idCompany;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public String getRegiNo() {
        return this.regiNo;
    }
    
    public void setRegiNo(String regiNo) {
        this.regiNo = regiNo;
    }
    public Date getRegiDate() {
        return this.regiDate;
    }
    
    public void setRegiDate(Date regiDate) {
        this.regiDate = regiDate;
    }
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    public String getStartDate() {
        return this.startDate;
    }
    
    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }
    public String getAwared() {
        return this.awared;
    }
    
    public void setAwared(String awared) {
        this.awared = awared;
    }
    public Set<Supplier> getSuppliers() {
        return this.suppliers;
    }
    
    public void setSuppliers(Set<Supplier> suppliers) {
        this.suppliers = suppliers;
    }




}


