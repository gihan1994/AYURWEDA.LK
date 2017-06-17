package DB;
// Generated May 1, 2017 3:38:53 PM by Hibernate Tools 4.3.1



/**
 * CartHasProducts generated by hbm2java
 */
public class CartHasProducts  implements java.io.Serializable {


     private CartHasProductsId id;
     private Cart cart;
     private Products products;
     private Integer qty;
     private Double ptotal;

    public CartHasProducts() {
    }

	
    public CartHasProducts(CartHasProductsId id, Cart cart, Products products) {
        this.id = id;
        this.cart = cart;
        this.products = products;
    }
    public CartHasProducts(CartHasProductsId id, Cart cart, Products products, Integer qty, Double ptotal) {
       this.id = id;
       this.cart = cart;
       this.products = products;
       this.qty = qty;
       this.ptotal = ptotal;
    }
   
    public CartHasProductsId getId() {
        return this.id;
    }
    
    public void setId(CartHasProductsId id) {
        this.id = id;
    }
    public Cart getCart() {
        return this.cart;
    }
    
    public void setCart(Cart cart) {
        this.cart = cart;
    }
    public Products getProducts() {
        return this.products;
    }
    
    public void setProducts(Products products) {
        this.products = products;
    }
    public Integer getQty() {
        return this.qty;
    }
    
    public void setQty(Integer qty) {
        this.qty = qty;
    }
    public Double getPtotal() {
        return this.ptotal;
    }
    
    public void setPtotal(Double ptotal) {
        this.ptotal = ptotal;
    }




}

