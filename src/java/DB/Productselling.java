package DB;
// Generated May 1, 2017 3:38:53 PM by Hibernate Tools 4.3.1



/**
 * Productselling generated by hbm2java
 */
public class Productselling  implements java.io.Serializable {


     private Integer idProductSelling;
     private Products products;
     private Integer sellQty;
     private String status;

    public Productselling() {
    }

	
    public Productselling(Products products) {
        this.products = products;
    }
    public Productselling(Products products, Integer sellQty, String status) {
       this.products = products;
       this.sellQty = sellQty;
       this.status = status;
    }
   
    public Integer getIdProductSelling() {
        return this.idProductSelling;
    }
    
    public void setIdProductSelling(Integer idProductSelling) {
        this.idProductSelling = idProductSelling;
    }
    public Products getProducts() {
        return this.products;
    }
    
    public void setProducts(Products products) {
        this.products = products;
    }
    public Integer getSellQty() {
        return this.sellQty;
    }
    
    public void setSellQty(Integer sellQty) {
        this.sellQty = sellQty;
    }
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }




}

