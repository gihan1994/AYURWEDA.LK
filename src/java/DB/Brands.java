package DB;
// Generated May 1, 2017 3:38:53 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Brands generated by hbm2java
 */
public class Brands  implements java.io.Serializable {


     private Integer idBrands;
     private String brandname;
     private String country;
     private Set<ProductsHasBrands> productsHasBrandses = new HashSet<ProductsHasBrands>(0);

    public Brands() {
    }

	
    public Brands(String brandname) {
        this.brandname = brandname;
    }
    public Brands(String brandname, String country, Set<ProductsHasBrands> productsHasBrandses) {
       this.brandname = brandname;
       this.country = country;
       this.productsHasBrandses = productsHasBrandses;
    }
   
    public Integer getIdBrands() {
        return this.idBrands;
    }
    
    public void setIdBrands(Integer idBrands) {
        this.idBrands = idBrands;
    }
    public String getBrandname() {
        return this.brandname;
    }
    
    public void setBrandname(String brandname) {
        this.brandname = brandname;
    }
    public String getCountry() {
        return this.country;
    }
    
    public void setCountry(String country) {
        this.country = country;
    }
    public Set<ProductsHasBrands> getProductsHasBrandses() {
        return this.productsHasBrandses;
    }
    
    public void setProductsHasBrandses(Set<ProductsHasBrands> productsHasBrandses) {
        this.productsHasBrandses = productsHasBrandses;
    }




}


