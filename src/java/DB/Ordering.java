package DB;
// Generated May 1, 2017 3:38:53 PM by Hibernate Tools 4.3.1


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Ordering generated by hbm2java
 */
public class Ordering  implements java.io.Serializable {


     private Integer idOrder;
     private Invoice invoice;
     private User user;
     private Date orderdate;
     private String status;
     private String resName;
     private String tel;
     private String street1;
     private String street2;
     private String city;
     private String pcode;
     private Set<Dispatchorders> dispatchorderses = new HashSet<Dispatchorders>(0);

    public Ordering() {
    }

	
    public Ordering(Invoice invoice, User user) {
        this.invoice = invoice;
        this.user = user;
    }
    public Ordering(Invoice invoice, User user, Date orderdate, String status, String resName, String tel, String street1, String street2, String city, String pcode, Set<Dispatchorders> dispatchorderses) {
       this.invoice = invoice;
       this.user = user;
       this.orderdate = orderdate;
       this.status = status;
       this.resName = resName;
       this.tel = tel;
       this.street1 = street1;
       this.street2 = street2;
       this.city = city;
       this.pcode = pcode;
       this.dispatchorderses = dispatchorderses;
    }
   
    public Integer getIdOrder() {
        return this.idOrder;
    }
    
    public void setIdOrder(Integer idOrder) {
        this.idOrder = idOrder;
    }
    public Invoice getInvoice() {
        return this.invoice;
    }
    
    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public Date getOrderdate() {
        return this.orderdate;
    }
    
    public void setOrderdate(Date orderdate) {
        this.orderdate = orderdate;
    }
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    public String getResName() {
        return this.resName;
    }
    
    public void setResName(String resName) {
        this.resName = resName;
    }
    public String getTel() {
        return this.tel;
    }
    
    public void setTel(String tel) {
        this.tel = tel;
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
    public String getPcode() {
        return this.pcode;
    }
    
    public void setPcode(String pcode) {
        this.pcode = pcode;
    }
    public Set<Dispatchorders> getDispatchorderses() {
        return this.dispatchorderses;
    }
    
    public void setDispatchorderses(Set<Dispatchorders> dispatchorderses) {
        this.dispatchorderses = dispatchorderses;
    }




}


