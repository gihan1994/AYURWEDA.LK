 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
 

package Resources;

import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 *
 * @author Gihan
 */
public class UserCounts implements HttpSessionListener,HttpSessionAttributeListener{

    private static int logUserCount=0;
   private static int viewUserCount=0;
    
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        
        System.out.println("session haduna");
      viewUserCount+=1;
        
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        viewUserCount-=1;
        
        
//        System.out.println( se.getSession().getAttribute("username"));
         
    }

    @Override
    public void attributeAdded(HttpSessionBindingEvent event) {
        System.out.println("attribute if eliye");
    if(event.getSession()!=null){
    if(event.getSession().getAttribute("username")!=null){
       
       
    logUserCount+=1;
   }
    }    
        
   
        
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent event) {
        System.out.println(event.getName()+"   "+event.getValue().toString());
//   if(event.getSession()!=null){
//    if(event.getSession().getAttribute("username")!=null){
//       
//      
  logUserCount-=1;
//   }
//    } 
        
        
    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent event) {
    }

    /**
     * @return the logUserCount
     */
    public int getLogUserCount() {
        if(logUserCount>0){
        return logUserCount;
        }else{
         return 0;
        }
        
       
    }

    /**
     * @return the viewUserCount
     */
    public int getViewUserCount() {
       if(viewUserCount>0){
        return viewUserCount;
        }else{
         return 0;
        }
    }
    
    
    
    
    
}
