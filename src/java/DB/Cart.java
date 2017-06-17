package DB;
// Generated May 1, 2017 3:38:53 PM by Hibernate Tools 4.3.1


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Cart generated by hbm2java
 */
public class Cart  implements java.io.Serializable {


     private Integer idCart;
     private User user;
     private Date date;
     private Double total;
     private Integer paystatus;
     private Set<CartHasPCatergory> cartHasPCatergories = new HashSet<CartHasPCatergory>(0);
     private Set<CartHasProducts> cartHasProductses = new HashSet<CartHasProducts>(0);

    public Cart() {
    }

	
    public Cart(User user) {
        this.user = user;
    }
    public Cart(User user, Date date, Double total, Integer paystatus, Set<CartHasPCatergory> cartHasPCatergories, Set<CartHasProducts> cartHasProductses) {
       this.user = user;
       this.date = date;
       this.total = total;
       this.paystatus = paystatus;
       this.cartHasPCatergories = cartHasPCatergories;
       this.cartHasProductses = cartHasProductses;
    }
   
    public Integer getIdCart() {
        return this.idCart;
    }
    
    public void setIdCart(Integer idCart) {
        this.idCart = idCart;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public Date getDate() {
        return this.date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }
    public Double getTotal() {
        return this.total;
    }
    
    public void setTotal(Double total) {
        this.total = total;
    }
    public Integer getPaystatus() {
        return this.paystatus;
    }
    
    public void setPaystatus(Integer paystatus) {
        this.paystatus = paystatus;
    }
    public Set<CartHasPCatergory> getCartHasPCatergories() {
        return this.cartHasPCatergories;
    }
    
    public void setCartHasPCatergories(Set<CartHasPCatergory> cartHasPCatergories) {
        this.cartHasPCatergories = cartHasPCatergories;
    }
    public Set<CartHasProducts> getCartHasProductses() {
        return this.cartHasProductses;
    }
    
    public void setCartHasProductses(Set<CartHasProducts> cartHasProductses) {
        this.cartHasProductses = cartHasProductses;
    }




}

