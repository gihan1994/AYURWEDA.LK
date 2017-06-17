/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Resources;

import Connection.NewHibernateUtil;
import DB.GrnHasProducts;
import DB.Messages;
import DB.Products;
import DB.User;
import DB.Usertype;
import java.util.Date;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Gihan
 */
public class StockChangeManager {
    Session s=NewHibernateUtil.getSessionFactory().openSession();
    public void updateProductStock(int pid){
        Products p=(Products)s.createCriteria(DB.Products.class).add(Restrictions.eq("idProducts", pid)).uniqueResult();
        
           GrnHasProducts ghp=(GrnHasProducts)s.createCriteria(DB.GrnHasProducts.class)
                                .add(Restrictions.and(Restrictions.eq("products",p),
                                        Restrictions
                                        .and(Restrictions.eq("grnpstatus", "1"), Restrictions.eq("qtystatus", "1")))).uniqueResult();
        //current stock is empty
           if(ghp==null){
            Criteria ghpupl=s.createCriteria(DB.GrnHasProducts.class)
                                .add(Restrictions.and(Restrictions.eq("qtystatus", "1"), Restrictions.eq("products", p)));
    
            //available stock and change that
            if(ghpupl!=null){
                
                ghpupl.addOrder(Order.asc("idGrnhasProduct"));
                ghpupl.setMaxResults(1);
                
                ghp=(GrnHasProducts)ghpupl.uniqueResult();
                ghp.setGrnpstatus("1");
                s.update(ghp);
                s.flush();
                s.beginTransaction().commit();
            
            }else{
                DB.Messages adm=new Messages();
                adm.setHeding("Stock Notification");
                adm.setMbody(p.getProductName()+" product's stock has been Overed ");
                
                adm.setMdate(new Date());
                adm.setMtime(new Date());
                Usertype ut=(Usertype) s.createCriteria(DB.Usertype.class).add(Restrictions.eq("typeName", "Admin")).uniqueResult();
                if(ut!=null){
                    User u=(User) s.createCriteria(DB.User.class).add(Restrictions.eq("usertype", ut)).uniqueResult();
                    if(u!=null){
                    adm.setUser(u);
                    adm.setStatus("1");
                    s.save(adm);
                    s.flush();
                    s.beginTransaction().commit();
                    }
                }
            
            }
        
        }else{
            System.out.println("Stock available");
        }
        
    
    }
    public boolean checkProductQty(int pid){
    boolean flag=false;
        Products p=(Products) s.load(DB.Products.class, pid);
        if(p!=null){
            GrnHasProducts ghp=(GrnHasProducts) s.createCriteria(DB.GrnHasProducts.class)
                    .add(Restrictions.and(Restrictions.eq("products", p), Restrictions
                            .and(Restrictions.eq("grnpstatus", "1"), Restrictions.eq("qtystatus", "1")))).uniqueResult();
            if(ghp==null){
            flag=true;
            
            }
        
        
        
        }
    return flag;
    }
    
    
  
    
}
