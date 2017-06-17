/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Resources;

import Connection.NewHibernateUtil;
import DB.GrnHasProducts;
import DB.Products;
import DB.Ratings;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
/**
 *
 * @author Gihan
 */
public class ProductRatingProvider {
    Session getratingsession=NewHibernateUtil.getSessionFactory().openSession();
    
    public Double getRateOfProduct(String pid){
        //for calculation all client rating of product
        Double calRate=0.0;
        ArrayList<Double> sprl = setProductRates(pid);
        
        if(!(sprl.isEmpty())){
        for (Double d : sprl) {
            
            calRate+=d;
            
        }
        calRate=calRate/sprl.size();
        }else{
          
        }
//        System.out.println(pid +" ="+calRate);
    getratingsession.beginTransaction().commit();
    getratingsession.close();
   
    
        return calRate;
    }
    
    private ArrayList<Double> setProductRates(String pid) {
        //get all client rating and add to array list
        ArrayList<Double> ral=new ArrayList<>();
        Products p=(Products) getratingsession.createCriteria(DB.Products.class)
                .add(Restrictions.eq("idProducts", new Integer(pid))).uniqueResult();
        
        if(p!=null){
            List<Ratings> rl=getratingsession.createCriteria(DB.Ratings.class)
                    .add(Restrictions.eq("products",p )).list();
            
            if(rl.size()>=0){
                for (Ratings ri : rl) {
                    
                    ral.add(ri.getRate());
                    
                }
               
                
            }else{
            
            
            }
            
        }    
      
    return ral;
    }
    
    public int getTopRateProduct(){
    int stockpid=0;
    
        HashMap<Integer,Double> m=new HashMap<>();
        
        Session topratesesion=NewHibernateUtil.getSessionFactory().openSession();
        List<Ratings> rl=topratesesion.createCriteria(DB.Ratings.class).list();
        
        if(rl.size()>0){
            for (Ratings ri : rl) {
                Products p=(Products) topratesesion.createCriteria(DB.Products.class)
                        .add(Restrictions.and(Restrictions.eq("idProducts", ri.getProducts().getIdProducts()),
                                Restrictions.eq("status", 1))).uniqueResult();
                if(p!=null){
                    
                        GrnHasProducts ghp=(GrnHasProducts)topratesesion.createCriteria(DB.GrnHasProducts.class)
                                .add(Restrictions.and(Restrictions.eq("products", p),
                                        Restrictions
                                        .and(Restrictions.eq("grnpstatus", "1"), Restrictions.eq("qtystatus", "1")))).uniqueResult();
                                if(ghp!=null){
                              m.put(ghp.getIdGrnhasProduct(), new ProductRatingProvider().getRateOfProduct(p.getIdProducts().toString()));    
                              }
                   
                
                
                }
                
                
            }
        
        if(!(m.isEmpty())){
            Double max = Collections.max(m.values());
            
             for (Map.Entry<Integer, Double> entry : m.entrySet()) {
            if (entry.getValue().equals(max)) {
                
                stockpid=entry.getKey();
            }
            }
                
                    
        }
            
            
        }

        topratesesion.close();
        return stockpid;
        
    }
    
    
}
