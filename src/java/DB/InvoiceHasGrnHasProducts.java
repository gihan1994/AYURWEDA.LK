package DB;
// Generated May 1, 2017 3:38:53 PM by Hibernate Tools 4.3.1



/**
 * InvoiceHasGrnHasProducts generated by hbm2java
 */
public class InvoiceHasGrnHasProducts  implements java.io.Serializable {


     private Integer idinvohasGrnProducts;
     private GrnHasProducts grnHasProducts;
     private Invoice invoice;
     private Integer invoqty;
     private Double total;

    public InvoiceHasGrnHasProducts() {
    }

	
    public InvoiceHasGrnHasProducts(GrnHasProducts grnHasProducts, Invoice invoice) {
        this.grnHasProducts = grnHasProducts;
        this.invoice = invoice;
    }
    public InvoiceHasGrnHasProducts(GrnHasProducts grnHasProducts, Invoice invoice, Integer invoqty, Double total) {
       this.grnHasProducts = grnHasProducts;
       this.invoice = invoice;
       this.invoqty = invoqty;
       this.total = total;
    }
   
    public Integer getIdinvohasGrnProducts() {
        return this.idinvohasGrnProducts;
    }
    
    public void setIdinvohasGrnProducts(Integer idinvohasGrnProducts) {
        this.idinvohasGrnProducts = idinvohasGrnProducts;
    }
    public GrnHasProducts getGrnHasProducts() {
        return this.grnHasProducts;
    }
    
    public void setGrnHasProducts(GrnHasProducts grnHasProducts) {
        this.grnHasProducts = grnHasProducts;
    }
    public Invoice getInvoice() {
        return this.invoice;
    }
    
    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }
    public Integer getInvoqty() {
        return this.invoqty;
    }
    
    public void setInvoqty(Integer invoqty) {
        this.invoqty = invoqty;
    }
    public Double getTotal() {
        return this.total;
    }
    
    public void setTotal(Double total) {
        this.total = total;
    }




}


