package DB;
// Generated May 1, 2017 3:38:53 PM by Hibernate Tools 4.3.1



/**
 * CartHasPCatergoryId generated by hbm2java
 */
public class CartHasPCatergoryId  implements java.io.Serializable {


     private int cartIdCart;
     private int PCatergoryIdPCatergory;

    public CartHasPCatergoryId() {
    }

    public CartHasPCatergoryId(int cartIdCart, int PCatergoryIdPCatergory) {
       this.cartIdCart = cartIdCart;
       this.PCatergoryIdPCatergory = PCatergoryIdPCatergory;
    }
   
    public int getCartIdCart() {
        return this.cartIdCart;
    }
    
    public void setCartIdCart(int cartIdCart) {
        this.cartIdCart = cartIdCart;
    }
    public int getPCatergoryIdPCatergory() {
        return this.PCatergoryIdPCatergory;
    }
    
    public void setPCatergoryIdPCatergory(int PCatergoryIdPCatergory) {
        this.PCatergoryIdPCatergory = PCatergoryIdPCatergory;
    }


   public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof CartHasPCatergoryId) ) return false;
		 CartHasPCatergoryId castOther = ( CartHasPCatergoryId ) other; 
         
		 return (this.getCartIdCart()==castOther.getCartIdCart())
 && (this.getPCatergoryIdPCatergory()==castOther.getPCatergoryIdPCatergory());
   }
   
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + this.getCartIdCart();
         result = 37 * result + this.getPCatergoryIdPCatergory();
         return result;
   }   


}


