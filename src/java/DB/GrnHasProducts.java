package DB;
// Generated May 1, 2017 3:38:53 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * GrnHasProducts generated by hbm2java
 */
public class GrnHasProducts  implements java.io.Serializable {


     private Integer idGrnhasProduct;
     private Grn grn;
     private Products products;
     private Integer qty;
     private Double sellprice;
     private Double buyprice;
     private String grnpstatus;
     private String qtystatus;
     private Integer addqty;
     private Set<InvoiceHasGrnHasProducts> invoiceHasGrnHasProductses = new HashSet<InvoiceHasGrnHasProducts>(0);
     private Set<WishlistHasGrnHasProducts> wishlistHasGrnHasProductses = new HashSet<WishlistHasGrnHasProducts>(0);
     private Set<Productoffers> productofferses = new HashSet<Productoffers>(0);

    public GrnHasProducts() {
    }

	
    public GrnHasProducts(Grn grn, Products products) {
        this.grn = grn;
        this.products = products;
    }
    public GrnHasProducts(Grn grn, Products products, Integer qty, Double sellprice, Double buyprice, String grnpstatus, String qtystatus, Integer addqty, Set<InvoiceHasGrnHasProducts> invoiceHasGrnHasProductses, Set<WishlistHasGrnHasProducts> wishlistHasGrnHasProductses, Set<Productoffers> productofferses) {
       this.grn = grn;
       this.products = products;
       this.qty = qty;
       this.sellprice = sellprice;
       this.buyprice = buyprice;
       this.grnpstatus = grnpstatus;
       this.qtystatus = qtystatus;
       this.addqty = addqty;
       this.invoiceHasGrnHasProductses = invoiceHasGrnHasProductses;
       this.wishlistHasGrnHasProductses = wishlistHasGrnHasProductses;
       this.productofferses = productofferses;
    }
   
    public Integer getIdGrnhasProduct() {
        return this.idGrnhasProduct;
    }
    
    public void setIdGrnhasProduct(Integer idGrnhasProduct) {
        this.idGrnhasProduct = idGrnhasProduct;
    }
    public Grn getGrn() {
        return this.grn;
    }
    
    public void setGrn(Grn grn) {
        this.grn = grn;
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
    public Double getSellprice() {
        return this.sellprice;
    }
    
    public void setSellprice(Double sellprice) {
        this.sellprice = sellprice;
    }
    public Double getBuyprice() {
        return this.buyprice;
    }
    
    public void setBuyprice(Double buyprice) {
        this.buyprice = buyprice;
    }
    public String getGrnpstatus() {
        return this.grnpstatus;
    }
    
    public void setGrnpstatus(String grnpstatus) {
        this.grnpstatus = grnpstatus;
    }
    public String getQtystatus() {
        return this.qtystatus;
    }
    
    public void setQtystatus(String qtystatus) {
        this.qtystatus = qtystatus;
    }
    public Integer getAddqty() {
        return this.addqty;
    }
    
    public void setAddqty(Integer addqty) {
        this.addqty = addqty;
    }
    public Set<InvoiceHasGrnHasProducts> getInvoiceHasGrnHasProductses() {
        return this.invoiceHasGrnHasProductses;
    }
    
    public void setInvoiceHasGrnHasProductses(Set<InvoiceHasGrnHasProducts> invoiceHasGrnHasProductses) {
        this.invoiceHasGrnHasProductses = invoiceHasGrnHasProductses;
    }
    public Set<WishlistHasGrnHasProducts> getWishlistHasGrnHasProductses() {
        return this.wishlistHasGrnHasProductses;
    }
    
    public void setWishlistHasGrnHasProductses(Set<WishlistHasGrnHasProducts> wishlistHasGrnHasProductses) {
        this.wishlistHasGrnHasProductses = wishlistHasGrnHasProductses;
    }
    public Set<Productoffers> getProductofferses() {
        return this.productofferses;
    }
    
    public void setProductofferses(Set<Productoffers> productofferses) {
        this.productofferses = productofferses;
    }




}

