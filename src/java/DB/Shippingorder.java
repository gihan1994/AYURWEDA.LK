package DB;
// Generated May 1, 2017 3:38:53 PM by Hibernate Tools 4.3.1



/**
 * Shippingorder generated by hbm2java
 */
public class Shippingorder  implements java.io.Serializable {


     private Integer idShippingOrder;
     private User user;
     private String recieverName;
     private String street1;
     private String street2;
     private String city;
     private String postalcode;

    public Shippingorder() {
    }

	
    public Shippingorder(User user) {
        this.user = user;
    }
    public Shippingorder(User user, String recieverName, String street1, String street2, String city, String postalcode) {
       this.user = user;
       this.recieverName = recieverName;
       this.street1 = street1;
       this.street2 = street2;
       this.city = city;
       this.postalcode = postalcode;
    }
   
    public Integer getIdShippingOrder() {
        return this.idShippingOrder;
    }
    
    public void setIdShippingOrder(Integer idShippingOrder) {
        this.idShippingOrder = idShippingOrder;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public String getRecieverName() {
        return this.recieverName;
    }
    
    public void setRecieverName(String recieverName) {
        this.recieverName = recieverName;
    }
    public String getStreet1() {
        return this.street1;
    }
    
    public void setStreet1(String street1) {
        this.street1 = street1;
    }
    public String getStreet2() {
        return this.street2;
    }
    
    public void setStreet2(String street2) {
        this.street2 = street2;
    }
    public String getCity() {
        return this.city;
    }
    
    public void setCity(String city) {
        this.city = city;
    }
    public String getPostalcode() {
        return this.postalcode;
    }
    
    public void setPostalcode(String postalcode) {
        this.postalcode = postalcode;
    }




}


