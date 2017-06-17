/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MobileResources;

import Connection.NewHibernateUtil;
import DB.GrnHasProducts;
import DB.Productoffers;
import DB.Products;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author gihanmunasinghe
 */
public class ProductListProvider {

     public  static ArrayList<UniqCustomProduct> getProductList(String searchval,String sortcatid,String sortbrandid) {
            Session listProviderses=NewHibernateUtil.getSessionFactory().openSession();
             String idcat = "idp_catergory Like '%'";
                String idbrand = "idBrands Like '%'";
                String pqty = "grn_has_products.qty>0";
                String searchvalue = "";

                // change page types ========================

                //sorted conditions===============================
                if (searchval!= null) {
                    searchvalue = "AND ProductName='" + searchval+ "' OR brandname='" +searchval + "'";
                }

                if (sortcatid!= null) {

                    idcat = "idp_catergory LIKE'" + sortcatid+ "'";

                }
                if (sortbrandid!= null) {

                    idbrand = "idBrands LIKE'" + sortbrandid+ "'";
                }
          String sql = "SELECT\n"
                        + "`grn_has_products`.`IdGRNhasProduct`\n"
                        + " , `products`.`idProducts`\n"
                        + " , `products`.`ProductName`\n"
                        + " , `grn_has_products`.`sellprice`\n"
                        + " , `products`.`img`\n"
                        + " , `brands`.`brandname`\n"
                        + " , `p_catergory`.`cat_name`\n"
                        + " , `products`.`description`\n"
                        + "FROM\n"
                        + "    `products_has_brands`\n"
                        + "    INNER JOIN `products` \n"
                        + "        ON (`products_has_brands`.`Products_idProducts` = `products`.`idProducts`)\n"
                        + "    INNER JOIN `brands` \n"
                        + "        ON (`products_has_brands`.`Brands_idBrands` = `brands`.`idBrands`)\n"
                        + "    INNER JOIN `p_catergory` \n"
                        + "        ON (`products`.`P_Catergory_idP_Catergory` = `p_catergory`.`idP_Catergory`)\n"
                        + "    INNER JOIN `grn_has_products` \n"
                        + "        ON (`grn_has_products`.`Products_idProducts` = `products`.`idProducts`)\n"
                        + " WHERE GRNPstatus='1'\n"
                        + "         AND qtystatus='1'  AND `products`.`status`='1' AND grn_has_products.`qty`>0 " + searchvalue + " AND " + idcat + " AND " + idbrand;

                SQLQuery quary = listProviderses.createSQLQuery(sql);     
        List l = quary.list();

                int count = 0;
                if (l.size() > 0) {
                    ArrayList<UniqCustomProduct> ucpal=new ArrayList<>();
                    
                    for (Object o : l) {
                            UniqCustomProduct ucp=new UniqCustomProduct();
                        Object[] oa = (Object[]) o;
                        Products pp=(Products) listProviderses.load(DB.Products.class, new Integer(oa[1].toString()));
                        ucp.product=pp;
                        ucp.price=new Double( oa[3].toString());
                        ucp.stockid=new Integer(oa[0].toString());
                             
                            GrnHasProducts ghp = (GrnHasProducts) listProviderses.load(DB.GrnHasProducts.class, new Integer(oa[0].toString()));
                            if (ghp != null) {
                                ucp.tolStock=ghp.getQty();
                               
                            }
                    
                    ucpal.add(ucp);
                    }
               
                  return ucpal;
                }else{
                  return null;// for if the stock has been empty
                }
        
      
    }

}
