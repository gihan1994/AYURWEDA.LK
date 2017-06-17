/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Resources;

import Connection.NewHibernateUtil;
import DB.Login;
import DB.LoginActivity;
import DB.Logintimes;
import DB.LogintimesHasPage;
import DB.UsertypeHasPage;
import java.util.Date;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Gihan
 */
public class PrevilageCheck {
    
   
    
    
    public  boolean checkManager(String username,String url,String btn_text){
    
        boolean status=false;
        Session pres=NewHibernateUtil.getSessionFactory().openSession();
       
        Login l=(Login) pres.createCriteria(DB.Login.class).add(Restrictions.eq("username", username)).uniqueResult();
        
        String[] page=url.split("/");
        
        if(l!=null){
        
            if(l.getUser().getStatus().equalsIgnoreCase("1")){
           
            
            List<UsertypeHasPage> uthpl=pres.createCriteria(DB.UsertypeHasPage.class).add(Restrictions.eq("usertype", l.getUser().getUsertype())).list();
            
            for (UsertypeHasPage uthp : uthpl) {
                
                if(uthp.getPage().getUrl().equals(page[page.length-1])){
                //status validation method 
                    
                    //set login time page
                    Logintimes lt=(Logintimes) pres.createCriteria(DB.Logintimes.class)
                            .add(Restrictions.and(Restrictions.eq("login", l), Restrictions.eq("status", "1"))).uniqueResult();
                    if(lt!=null){
                        System.out.println("logtimes");
                        LogintimesHasPage lthp=(LogintimesHasPage) pres.createCriteria(DB.LogintimesHasPage.class)
                                .add(Restrictions.and(Restrictions.eq("logintimes", lt), Restrictions.eq("page", uthp.getPage()))).uniqueResult();
                        
                        if(lthp!=null){
                        System.out.println("logtimes has page");
                            lthp.setAccCount(lthp.getAccCount()+1);
                            pres.update(lthp);
                              pres.flush();
                           
                            pres.beginTransaction().commit();
                            
                        }else{
                            System.out.println("add new logintime has page");
                         LogintimesHasPage lthpn=new LogintimesHasPage();
                        lthpn.setLogintimes(lt);
                        lthpn.setPage(uthp.getPage());
                        lthpn.setStatus("1");
                        lthpn.setAccCount(1);
                        lthpn.setViewTime(new Date());
                        pres.save(lthpn);
                         pres.flush();
                        
                        pres.beginTransaction().commit();
                        }
                       
                        
                        
                        
                        LoginActivity la=(LoginActivity) pres.createCriteria(DB.LoginActivity.class)
                                .add(Restrictions.eq("logintimes",lt )).uniqueResult();
                        if(la!=null&&btn_text!=null){
                        
                            
                            la.setDescription(la.getDescription()+"/"+btn_text);
                            pres.update(la);
                             pres.flush();
                             
                            pres.beginTransaction().commit();
                        
                        }
                        else{
                        LoginActivity lan=new LoginActivity();
                        lan.setDescription(btn_text);
                        lan.setLogintimes(lt);
                        lan.setStatus("0");
                        
                        pres.save(lan);
                         pres.flush();
                         
                        pres.beginTransaction().commit();
                        
                        }
                        
                        
                        
                        
                       
                    }
                    
                    
                status=true;
                }
                
            }
            
            }
            
        
        }
        
      
        pres.close();
    
        return status;
    }
    
}
