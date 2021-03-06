package DB;
// Generated May 1, 2017 3:38:53 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Wishlist generated by hbm2java
 */
public class Wishlist  implements java.io.Serializable {


     private Integer idWishList;
     private User user;
     private Integer itemCount;
     private String status;
     private Set<WishlistHasGrnHasProducts> wishlistHasGrnHasProductses = new HashSet<WishlistHasGrnHasProducts>(0);

    public Wishlist() {
    }

	
    public Wishlist(User user) {
        this.user = user;
    }
    public Wishlist(User user, Integer itemCount, String status, Set<WishlistHasGrnHasProducts> wishlistHasGrnHasProductses) {
       this.user = user;
       this.itemCount = itemCount;
       this.status = status;
       this.wishlistHasGrnHasProductses = wishlistHasGrnHasProductses;
    }
   
    public Integer getIdWishList() {
        return this.idWishList;
    }
    
    public void setIdWishList(Integer idWishList) {
        this.idWishList = idWishList;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public Integer getItemCount() {
        return this.itemCount;
    }
    
    public void setItemCount(Integer itemCount) {
        this.itemCount = itemCount;
    }
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    public Set<WishlistHasGrnHasProducts> getWishlistHasGrnHasProductses() {
        return this.wishlistHasGrnHasProductses;
    }
    
    public void setWishlistHasGrnHasProductses(Set<WishlistHasGrnHasProducts> wishlistHasGrnHasProductses) {
        this.wishlistHasGrnHasProductses = wishlistHasGrnHasProductses;
    }




}


