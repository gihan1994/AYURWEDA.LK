package DB;
// Generated May 1, 2017 3:38:53 PM by Hibernate Tools 4.3.1



/**
 * Aboutus generated by hbm2java
 */
public class Aboutus  implements java.io.Serializable {


     private int idAboutus;
     private String description;
     private String location;

    public Aboutus() {
    }

	
    public Aboutus(int idAboutus) {
        this.idAboutus = idAboutus;
    }
    public Aboutus(int idAboutus, String description, String location) {
       this.idAboutus = idAboutus;
       this.description = description;
       this.location = location;
    }
   
    public int getIdAboutus() {
        return this.idAboutus;
    }
    
    public void setIdAboutus(int idAboutus) {
        this.idAboutus = idAboutus;
    }
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    public String getLocation() {
        return this.location;
    }
    
    public void setLocation(String location) {
        this.location = location;
    }




}


