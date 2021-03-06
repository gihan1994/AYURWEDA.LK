package DB;
// Generated May 1, 2017 3:38:53 PM by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * Ratings generated by hbm2java
 */
public class Ratings  implements java.io.Serializable {


     private Integer idRatings;
     private Products products;
     private User user;
     private String status;
     private Date rateDate;
     private Double rate;

    public Ratings() {
    }

	
    public Ratings(Products products, User user) {
        this.products = products;
        this.user = user;
    }
    public Ratings(Products products, User user, String status, Date rateDate, Double rate) {
       this.products = products;
       this.user = user;
       this.status = status;
       this.rateDate = rateDate;
       this.rate = rate;
    }
   
    public Integer getIdRatings() {
        return this.idRatings;
    }
    
    public void setIdRatings(Integer idRatings) {
        this.idRatings = idRatings;
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
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    public Date getRateDate() {
        return this.rateDate;
    }
    
    public void setRateDate(Date rateDate) {
        this.rateDate = rateDate;
    }
    public Double getRate() {
        return this.rate;
    }
    
    public void setRate(Double rate) {
        this.rate = rate;
    }




}


