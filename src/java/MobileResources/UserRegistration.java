/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MobileResources;

import Connection.NewHibernateUtil;
import DB.Login;
import DB.Logintimes;
import DB.User;
import DB.Usertype;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author gihanmunasinghe
 */
public class UserRegistration {

    public String registerUser(JSONObject jo) {
        Session regiuserses = NewHibernateUtil.getSessionFactory().openSession();

        String msgcode = ganerateMsgCode();
        User u = new User();
        try {
            u.setFname(jo.getString("fname"));
            u.setLname(jo.getString("lname"));
            u.setEmail(jo.getString("email"));
            u.setTel(jo.getString("mobi"));
        } catch (JSONException ex) {
            System.out.println(ex);
        }

        Usertype ut = (Usertype) regiuserses.load(Usertype.class, 2);

        u.setUsertype(ut);
        u.setSignDate(new Date());
        u.setStatus("0");

        regiuserses.save(u);
        regiuserses.flush();
        regiuserses.beginTransaction().commit();

        Login l = new Login();

        try {
           l.setUsername(jo.getString("uname"));
           l.setPassword(jo.getString("pw"));
            
        } catch (Exception e) {
            System.out.println(e);
        }
        
        l.setUser(u);
        l.setStatus("0");
        regiuserses.save(l);
        regiuserses.flush();
        regiuserses.beginTransaction().commit();

        Logintimes lt = new Logintimes();
        lt.setLogdate(new Date());
        lt.setIntime(new Date());
        lt.setLogin(l);
        lt.setStatus("1");
        regiuserses.save(lt);
        regiuserses.flush();
        regiuserses.beginTransaction().commit();
regiuserses.close();
        return msgcode;
    }
    
    private String ganerateMsgCode(){
      
           String f=Math.random()+"";
           
 String code=f.substring(2, 6);
          
       
     return code;
    
    }
    
    public void userConfirmation(String username){
        Session cofiruserses=NewHibernateUtil.getSessionFactory().openSession();
        Login l=(Login) cofiruserses.createCriteria(DB.Login.class).add(Restrictions.eq("username", username)).uniqueResult();
        if(l!=null){
            User user = l.getUser();
            user.setStatus("1");
            cofiruserses.update(user);
            cofiruserses.flush();
            cofiruserses.beginTransaction().commit();
            
              l.setStatus("1");
            cofiruserses.update(l);
            cofiruserses.flush();
            cofiruserses.beginTransaction().commit();
            cofiruserses.close();
        }
        
    
    }
   
}
