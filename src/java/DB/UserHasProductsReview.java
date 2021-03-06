package DB;
// Generated May 1, 2017 3:38:53 PM by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * UserHasProductsReview generated by hbm2java
 */
public class UserHasProductsReview  implements java.io.Serializable {


     private Integer idReview;
     private Products products;
     private User user;
     private Date rdate;
     private String message;
     private String status;

    public UserHasProductsReview() {
    }

	
    public UserHasProductsReview(Products products, User user) {
        this.products = products;
        this.user = user;
    }
    public UserHasProductsReview(Products products, User user, Date rdate, String message, String status) {
       this.products = products;
       this.user = user;
       this.rdate = rdate;
       this.message = message;
       this.status = status;
    }
   
    public Integer getIdReview() {
        return this.idReview;
    }
    
    public void setIdReview(Integer idReview) {
        this.idReview = idReview;
    }
    public Products getProducts() {
        return this.products;
    }
    
    public void setProducts(Products products) {
        this.products = products;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public Date getRdate() {
        return this.rdate;
    }
    
    public void setRdate(Date rdate) {
        this.rdate = rdate;
    }
    public String getMessage() {
        return this.message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }




}


