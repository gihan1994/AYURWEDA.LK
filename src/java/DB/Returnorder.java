package DB;
// Generated May 1, 2017 3:38:53 PM by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * Returnorder generated by hbm2java
 */
public class Returnorder  implements java.io.Serializable {


     private Integer idReturnOrder;
     private Dispatchorders dispatchorders;
     private String reson;
     private Date returndate;

    public Returnorder() {
    }

	
    public Returnorder(Dispatchorders dispatchorders) {
        this.dispatchorders = dispatchorders;
    }
    public Returnorder(Dispatchorders dispatchorders, String reson, Date returndate) {
       this.dispatchorders = dispatchorders;
       this.reson = reson;
       this.returndate = returndate;
    }
   
    public Integer getIdReturnOrder() {
        return this.idReturnOrder;
    }
    
    public void setIdReturnOrder(Integer idReturnOrder) {
        this.idReturnOrder = idReturnOrder;
    }
    public Dispatchorders getDispatchorders() {
        return this.dispatchorders;
    }
    
    public void setDispatchorders(Dispatchorders dispatchorders) {
        this.dispatchorders = dispatchorders;
    }
    public String getReson() {
        return this.reson;
    }
    
    public void setReson(String reson) {
        this.reson = reson;
    }
    public Date getReturndate() {
        return this.returndate;
    }
    
    public void setReturndate(Date returndate) {
        this.returndate = returndate;
    }




}


