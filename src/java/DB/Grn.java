package DB;
// Generated May 1, 2017 3:38:53 PM by Hibernate Tools 4.3.1


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Grn generated by hbm2java
 */
public class Grn  implements java.io.Serializable {


     private Integer idGrn;
     private Supplier supplier;
     private Date date;
     private Integer PCount;
     private Double total;
     private Integer totalqty;
     private Integer existqty;
     private String grnstatus;
     private String addstatus;
     private Set<GrnHasProducts> grnHasProductses = new HashSet<GrnHasProducts>(0);

    public Grn() {
    }

	
    public Grn(Supplier supplier) {
        this.supplier = supplier;
    }
    public Grn(Supplier supplier, Date date, Integer PCount, Double total, Integer totalqty, Integer existqty, String grnstatus, String addstatus, Set<GrnHasProducts> grnHasProductses) {
       this.supplier = supplier;
       this.date = date;
       this.PCount = PCount;
       this.total = total;
       this.totalqty = totalqty;
       this.existqty = existqty;
       this.grnstatus = grnstatus;
       this.addstatus = addstatus;
       this.grnHasProductses = grnHasProductses;
    }
   
    public Integer getIdGrn() {
        return this.idGrn;
    }
    
    public void setIdGrn(Integer idGrn) {
        this.idGrn = idGrn;
    }
    public Supplier getSupplier() {
        return this.supplier;
    }
    
    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }
    public Date getDate() {
        return this.date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }
    public Integer getPCount() {
        return this.PCount;
    }
    
    public void setPCount(Integer PCount) {
        this.PCount = PCount;
    }
    public Double getTotal() {
        return this.total;
    }
    
    public void setTotal(Double total) {
        this.total = total;
    }
    public Integer getTotalqty() {
        return this.totalqty;
    }
    
    public void setTotalqty(Integer totalqty) {
        this.totalqty = totalqty;
    }
    public Integer getExistqty() {
        return this.existqty;
    }
    
    public void setExistqty(Integer existqty) {
        this.existqty = existqty;
    }
    public String getGrnstatus() {
        return this.grnstatus;
    }
    
    public void setGrnstatus(String grnstatus) {
        this.grnstatus = grnstatus;
    }
    public String getAddstatus() {
        return this.addstatus;
    }
    
    public void setAddstatus(String addstatus) {
        this.addstatus = addstatus;
    }
    public Set<GrnHasProducts> getGrnHasProductses() {
        return this.grnHasProductses;
    }
    
    public void setGrnHasProductses(Set<GrnHasProducts> grnHasProductses) {
        this.grnHasProductses = grnHasProductses;
    }




}

