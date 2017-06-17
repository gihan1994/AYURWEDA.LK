/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebServices;

import Connection.NewHibernateUtil;
import DB.Brands;
import DB.Cart;
import DB.CartHasProducts;
import DB.GrnHasProducts;
import DB.Invoice;
import DB.InvoiceHasGrnHasProducts;
import DB.Login;
import DB.Logintimes;
import DB.Messages;
import DB.Notifications;
import DB.PCatergory;
import DB.Products;
import DB.ProductsHasBrands;
import DB.Shippingorder;
import DB.User;
import MobileResources.CartController;
import MobileResources.ProductListProvider;
import MobileResources.UniqCustomProduct;
import MobileResources.UserRegistration;
import Resources.ProductRatingProvider;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author gihanmunasinghe
 */
@WebService(serviceName = "AurwedaWebServices")
public class AurwedaWebServices {

    /**
     * This is a sample web service operation
     * @param txt
     * @return 
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "parameter") String txt) {
        return "Hello " + txt + " !";
    }
    @WebMethod(operationName = "LoginUser")
    public String LoginUser(@WebParam(name = "parameter") String txt) {
        
        String req_username="";
        String req_password="";
        
        try {
            
           JSONArray ja=new JSONArray(txt);
            
            JSONObject jo=ja.getJSONObject(0);
             JSONObject jo1=ja.getJSONObject(1);
            req_username=(String)jo.get("username");
             req_password=(String)jo1.get("password");
            
        } catch (Exception ex) {
            Logger.getLogger(AurwedaWebServices.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        Session s=NewHibernateUtil.getSessionFactory().openSession();
        Login l=(Login) s.createCriteria(DB.Login.class).add(Restrictions.and
        (Restrictions.eq("username",req_username), Restrictions.eq("password", req_password))).uniqueResult();
        
        if(l!=null){
        l.setStatus("1");
        s.update(l);
        s.flush();s.beginTransaction().commit();
        s.close();
        return "1";
        }
        else{
        
         return "0";
        }
       
    }
    @WebMethod(operationName = "RegisterUser")
    public String RegisterUser(@WebParam(name = "parameter") String txt) {
        String msgcode="";
        try {
            JSONObject registerData=new JSONObject(txt);
        msgcode=new UserRegistration().registerUser(registerData);
            
        } catch (Exception ex) {
            System.out.println(ex);
        }
        
        
        
        return msgcode;
    }
     @WebMethod(operationName = "ProductsList")
    public String ProductsList(@WebParam(name = "parameter") String txt) {
         JSONArray ja=new JSONArray();
         try {
             
             ArrayList<UniqCustomProduct> alucp=ProductListProvider.getProductList(null, null, null);
             
             
             
             for (UniqCustomProduct ucp : alucp) {
                 
           
             JSONObject jo=new JSONObject();
             
                String stockid=ucp.stockid+"";
             
             jo.put("stockid", stockid);
             jo.put("pname", ucp.product.getProductName());
             jo.put("pcat", ucp.product.getPCatergory().getCatName());
             for(ProductsHasBrands pb:ucp.product.getProductsHasBrandses()){jo.put("pbrand", pb.getBrands().getBrandname());}
             jo.put("pprice", ucp.price);
             Double pdis=0.0;
             if(ucp.discount!=null){
                pdis=ucp.discount; 
             }
             jo.put("pdiscount", pdis);
          
         jo.put("pimg", ucp.product.getImg());
             
           
             
             
             ja.put(jo);
         }
         
       
         } catch (Exception e) {
             System.out.println(e);}
        
        
        return ja.toString();
    }

    /**
     * Web service operation
     * @param txt
     * @return 
     */
    @WebMethod(operationName = "AddToCart")
    public String AddToCart(@WebParam(name = "parameter") String txt) {
      
        String username=" ";
        String itemid=" ";
        
        try {
            
           JSONArray ja=new JSONArray(txt);
            
            JSONObject jo=ja.getJSONObject(0);
             JSONObject jo1=ja.getJSONObject(1);
          username=(String)jo.get("username");
          itemid=(String)jo1.get("itemid"); 
          
          new CartController().addToCart(new Integer(itemid), username);
            
        } catch (Exception e) {
            System.out.println(e);}
        
           
        
        
//        new CartController().addToCart(0, txt)
        return "Adding is ok";
    }
    
     @WebMethod(operationName = "getCatList")
    public String getCatList(@WebParam(name = "parameter") String txt) {
        
         JSONArray ja=new JSONArray();
          try {
         for(PCatergory pc:(List<PCatergory>)NewHibernateUtil.getSessionFactory().openSession().createCriteria(DB.PCatergory.class).list()){
        JSONObject jo=new JSONObject();
            
             jo.put("catname",pc.getCatName());
             ja.put(jo);
            
        }
        
              
        } catch (Exception e) {
              System.out.println(e);}
        
        return ja.toString();
    }
    
     @WebMethod(operationName = "getBrandList")
    public String getBrandList(@WebParam(name = "parameter") String txt) {
        
          JSONArray ja=new JSONArray();
          try {
         for(Brands pb:(List<Brands>)NewHibernateUtil.getSessionFactory().openSession().createCriteria(DB.Brands.class).list()){
        JSONObject jo=new JSONObject();
            
             jo.put("brandname",pb.getBrandname());
             ja.put(jo);
            
        }
        
              
        } catch (Exception e) {
              System.out.println(e);}
        
        return ja.toString();
    }
    
        @WebMethod(operationName = "cartUpload")
    public String cartUpload (@WebParam(name = "parameter") String txt) {
      
        try {
            JSONArray ja=new JSONArray(txt);
           
            String user= (String)ja.getJSONObject(0).get("username");
            JSONArray productlist=ja.getJSONArray(1);
            for (int i = 0; i < productlist.length(); i++) {
                JSONObject product=productlist.getJSONObject(i);
                String itemid=(String) product.get("itemid");
                int qty=new Integer((String)product.get("qty"));
                
                for (int j = 0; j < qty; j++) {
                    
                    new CartController().addToCart(new Integer(itemid), user);
                    
                }
                
                
            }
           
           
        } catch (JSONException ex) {
            Logger.getLogger(AurwedaWebServices.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "Upload Ok";
    }
    
     @WebMethod(operationName = "cleanCart")
    public String cleanCart(@WebParam(name = "parameter") String txt) {
         Session cleancartses=NewHibernateUtil.getSessionFactory().openSession();
               try {
             JSONObject jun=new JSONObject(txt);
            String username=(String)jun.get("username");
            if(username!=null){
                Login l=(Login)cleancartses.createCriteria(DB.Login.class).add(Restrictions.eq("username", username)).uniqueResult();
            if(l!=null){
                 Cart c=(Cart) cleancartses.createCriteria(DB.Cart.class).add(Restrictions.eq("user", l.getUser())).uniqueResult();
                  List<CartHasProducts> chs = cleancartses.createCriteria(DB.CartHasProducts.class).add(Restrictions.eq("cart", c)).list();

                    for (CartHasProducts cchp : chs) {

                        cleancartses.delete(cchp);
                       cleancartses.flush();
                 cleancartses.beginTransaction().commit();
                    }
                    cleancartses.delete(c);
                    cleancartses.flush();
                 cleancartses.beginTransaction().commit();
               cleancartses.close();
                }
                
            }
            
            
             
         } catch (Exception e) {
             System.out.println(e);
         }
       cleancartses.close();
        return "clean Cart";
    }
       @WebMethod(operationName = "removeCart")
    public String removeCart(@WebParam(name = "parameter") String txt) {
      String username="";
      String itemid="";
           try {
               JSONObject jo=new JSONObject(txt);
               username=(String)jo.get("username");
               itemid=(String)jo.get("itemid");
               
           } catch (Exception e) {
               System.out.println(e);
           }
        
        
        
        return new CartController().removeItem(itemid, username);
    }
       @WebMethod(operationName = "viewCart")
    public String viewCart(@WebParam(name = "parameter") String txt) {
          Session viewcartses=NewHibernateUtil.getSessionFactory().openSession();
          JSONArray ja=new JSONArray();
        try {
            JSONObject jun=new JSONObject(txt);
            String username=(String)jun.get("username");
            if(username!=null){
                Login l=(Login) viewcartses.createCriteria(DB.Login.class).add(Restrictions.eq("username", username)).uniqueResult();
            if(l!=null){
                 Cart c=(Cart) viewcartses.createCriteria(DB.Cart.class).add(Restrictions.eq("user", l.getUser())).uniqueResult();
                 if(c!=null){
                    Set<CartHasProducts> cartHasProductses = c.getCartHasProductses();
                    if(cartHasProductses!=null){
                      for (CartHasProducts chp: cartHasProductses) {
                     JSONObject jo=new JSONObject();
                     Set<GrnHasProducts> grnHasProductses = chp.getProducts().getGrnHasProductses();
                     for (GrnHasProducts grnhp : grnHasProductses) {
                         jo.put("itemid", grnhp.getIdGrnhasProduct()); 
                         jo.put("qty",chp.getQty());
                     }
                    
                   
                      ja.put(jo);
                }
                    }
               
                 }
                
            }
            
            }
            
                    
                    
                    } catch (JSONException ex) {
            Logger.getLogger(AurwedaWebServices.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        viewcartses.close();
        return ja.toString();
    }
    
    @WebMethod(operationName = "getBillingData")
    public String getBillingData(@WebParam(name = "parameter") String txt) {
        
        Session billdatases=NewHibernateUtil.getSessionFactory().openSession();
        JSONObject billdata=new JSONObject();
        
       String username=" ";
             
        try {
          JSONObject jo=new JSONObject(txt);
          username=(String)jo.get("username");
          
          if(username!=null){
             Login l=(Login)billdatases.createCriteria(DB.Login.class).add(Restrictions.eq("username", username)).uniqueResult();
            if(l!=null){
                
                
                billdata.put("email", l.getUser().getEmail());
                billdata.put("mobino", l.getUser().getTel());
                
                 Set<Shippingorder> shippingorders = l.getUser().getShippingorders();
                 if(shippingorders!=null&&shippingorders.size()>0){
                  for (Shippingorder so : shippingorders) {
                   billdata.put("Name",so.getRecieverName());
                   billdata.put("street1", so.getStreet1());
                   billdata.put("street2", so.getStreet2());
                   billdata.put("city", so.getCity());
                   billdata.put("pcode", so.getPostalcode());
                }
                 }
               
                 
                 
            }  
                    }
                  
       
            
        } catch (Exception e) {
            System.out.println(e);}
        billdatases.close();
        
        return billdata.toString();
    }
    
     @WebMethod(operationName = "checkout")
    public String checkout(@WebParam(name = "parameter") String txt) {
        String invoid="";
       Session checkoutses=NewHibernateUtil.getSessionFactory().openSession();
        String username="";
         try {
            JSONArray ja=new JSONArray(txt);
            JSONObject jo=ja.getJSONObject(0);
            username=(String)jo.get("username");
            
            JSONObject billdata=ja.getJSONObject(1);
            
             if(username!=null){
             Login l=(Login) checkoutses.createCriteria(DB.Login.class).add(Restrictions.eq("username", username)).uniqueResult();
            if(l!=null){
            
                //save billing address
                
             Shippingorder so=(Shippingorder) checkoutses.createCriteria(DB.Shippingorder.class)
                     .add(Restrictions.eq("user", l.getUser())).uniqueResult();
                     if(so!=null){
                     
                         
                         so.setUser(l.getUser());
                         so.setRecieverName((String)billdata.get("Name"));
                         so.setStreet1((String)billdata.get("st1"));
                         so.setStreet2((String)billdata.get("st2"));
                         so.setCity((String)billdata.get("city"));
                         so.setPostalcode((String)billdata.get("pcode"));
                         
                         checkoutses.update(so);
                        checkoutses.flush();
                         checkoutses.beginTransaction().commit();
                         
                         
                     }
                     else{
                         so=new Shippingorder();
                            so.setUser(l.getUser());
                         so.setRecieverName((String)billdata.get("Name"));
                         so.setStreet1((String)billdata.get("st1"));
                         so.setStreet2((String)billdata.get("st2"));
                         so.setCity((String)billdata.get("city"));
                         so.setPostalcode((String)billdata.get("pcode"));
                         
                        checkoutses.save(so);
                         checkoutses.flush();
                         checkoutses.beginTransaction().commit();
                     }
                     
//               pass user name for checkout and get the oderid and invoice id
                 HashMap<String, Integer> checkOut = new CartController().checkOut(username);
            
             
                  invoid=checkOut.get("invoid")+"";
            }}
          
         } catch (Exception e) {
             System.out.println(e);}
                
        checkoutses.close();
        
        return invoid;
    }
    
    
    @WebMethod(operationName = "NotificationListener")
    public String NotificationListener(@WebParam(name = "parameter") String txt) {
        Session notises=NewHibernateUtil.getSessionFactory().openSession();
        String username="";
       JSONArray noti=new JSONArray();
        try {
            JSONObject jo=new JSONObject(txt);
            username=(String)jo.get("username");
          
            if(username!=null){
             Login l=(Login) notises.createCriteria(DB.Login.class).add(Restrictions.eq("username", username)).uniqueResult();
            if(l!=null){
            
                List<Notifications> msgl=notises.createCriteria(DB.Notifications.class).add(Restrictions.and(Restrictions.eq("user", l.getUser()),
                        Restrictions.eq("status", "1"))).list();
                
                for (Notifications msg: msgl) {
                    JSONObject mbody=new JSONObject();
         mbody.put("title", msg.getTitle());
       
         noti.put(mbody);
         
           System.out.println("looper");
         
                    msg.setStatus("0");
                    notises.update(msg);
                    notises.flush();notises.beginTransaction().commit();
                    
                }
            
            }} 
            
            
            
        } catch (Exception e) {
            System.out.println(e);}
        
        
        notises.close();
        return noti.toString();
    }
    
     @WebMethod(operationName = "getTopRateProduct")
    public String getTopRateProduct(@WebParam(name = "parameter") String txt) {
         Session toprateses=NewHibernateUtil.getSessionFactory().openSession();
        JSONObject jo=new JSONObject();
        int pid =new ProductRatingProvider().getTopRateProduct();
        GrnHasProducts ghp=(GrnHasProducts) toprateses.load(DB.GrnHasProducts.class, pid);
         if(ghp!=null){
             try {
                 jo.put("stockid", ghp.getIdGrnhasProduct());
                 jo.put("pname", ghp.getProducts().getProductName());
                 jo.put("pimg", ghp.getProducts().getImg());
                 jo.put("pdescrip", ghp.getProducts().getDescription());
                 jo.put("pprice", ghp.getSellprice());
                 jo.put("pcat", ghp.getProducts().getPCatergory().getCatName());
                 
                 for (ProductsHasBrands phb : ghp.getProducts().getProductsHasBrandses()) {
                     jo.put("pbrand", phb.getBrands().getBrandname());
                 }
                 
             } catch (Exception e) {
                 System.out.println(e);}
   
         
         }
        
       toprateses.close();
        return jo.toString();
    }
    
        @WebMethod(operationName = "getNotifications")
    public String getNotifications(@WebParam(name = "parameter") String txt) {
       Session notilistses=NewHibernateUtil.getSessionFactory().openSession();
        String username="";
       JSONArray noti=new JSONArray();
        try {
            JSONObject jo=new JSONObject(txt);
            username=(String)jo.get("username");
            if(username!=null){
             Login l=(Login) notilistses.createCriteria(DB.Login.class).add(Restrictions.eq("username", username)).uniqueResult();
            if(l!=null){
            
                List<Messages> msgl=notilistses.createCriteria(DB.Messages.class).add(Restrictions.eq("user", l.getUser())).list();
                
                for (Messages msg: msgl) {
                    JSONObject mbody=new JSONObject();
         mbody.put("head", msg.getHeding());
         mbody.put("mbody", msg.getMbody());
         mbody.put("date",new SimpleDateFormat("yyyy-MM-dd").format(msg.getMdate()));
         noti.put(mbody);
         
                    System.out.println(msg.getHeding());   
                }
            
            }} 
            
            
            
        } catch (Exception e) {
            System.out.println(e);}
        
        
        notilistses.close();
        return noti.toString();
    }
    
     
    @WebMethod(operationName = "checkUserNameForRegister")
    public String checkUserNameForRegister(@WebParam(name = "parameter") String txt) {
       //if available return 1
        Session regiuserchekses=NewHibernateUtil.getSessionFactory().openSession();
       String status="0";
        try {
          String username=(String) new JSONObject(txt).get("username");
          if(username!=null){
                
           if(regiuserchekses.createCriteria(DB.Login.class).add(Restrictions.eq("username", username)).uniqueResult()!=null){
           status="1";
           }   
          
          }
            
            
        } catch (Exception e) {
            System.out.println(e);
        }
        regiuserchekses.close();
        return status;
    }
    
    @WebMethod(operationName = "checkUserEmailForRegister")
    public String checkUserEmailForRegister(@WebParam(name = "parameter") String txt) {
       //if available return 1
        Session regiuserchekses=NewHibernateUtil.getSessionFactory().openSession();
       String status="0";
        try {
          String email=(String) new JSONObject(txt).get("email");
          if(email!=null){
                
           if(regiuserchekses.createCriteria(DB.User.class).add(Restrictions.eq("email", email)).uniqueResult()!=null){
           status="1";
           }   
          
          }
            
            
        } catch (Exception e) {
            System.out.println(e);
        }
        regiuserchekses.close();
        return status;
    }
    
    @WebMethod(operationName = "checkUserMobileForRegister")
    public String checkUserMobileForRegister(@WebParam(name = "parameter") String txt) {
       //if available return 1
        Session regiuserchekses=NewHibernateUtil.getSessionFactory().openSession();
       String status="0";
        try {
          String mobile=(String) new JSONObject(txt).get("mobile");
          if(mobile!=null){
                
           if(regiuserchekses.createCriteria(DB.User.class).add(Restrictions.eq("tel", mobile)).uniqueResult()!=null){
           status="1";
           }   
          
          }
            
            
        } catch (Exception e) {
            System.out.println(e);
        }
        regiuserchekses.close();
        return status;
    }
    
     @WebMethod(operationName = "logOutUser")
    public String logOutUser(@WebParam(name = "parameter") String txt) {
       //if available return 1
        Session regiuserchekses=NewHibernateUtil.getSessionFactory().openSession();
      String status="";
        try {
          String username=(String) new JSONObject(txt).get("username");
          
          if(username!=null){
          Login lotl = (Login) regiuserchekses.createCriteria(DB.Login.class).add(Restrictions.eq("username", username)).uniqueResult();

                if (lotl != null) {

                    Logintimes ltlot = (Logintimes) regiuserchekses.createCriteria(DB.Logintimes.class)
                            .add(Restrictions.and(Restrictions.eq("login", lotl), Restrictions.eq("status", "1"))).uniqueResult();

                    if(ltlot!=null){
                            ltlot.setOuttime(new Date());
                    ltlot.setStatus("0");
                    regiuserchekses.update(ltlot);
                    regiuserchekses.flush();
                    regiuserchekses.beginTransaction().commit();
                    lotl.setStatus("0");
                    regiuserchekses.update(lotl);
                    regiuserchekses.flush();
                    regiuserchekses.beginTransaction().commit();
                    }
            
                  
                status="You has been Logout";

                } else {
               status="You have not login yet";
                }
          
          }else{System.out.println("user name Null");}
           
          
          
          
            
            
        } catch (Exception e) {
            System.out.println(e);
        }
        regiuserchekses.close();
        return status;
    }
    
     @WebMethod(operationName = "setRegisterConfirmation")
    public String setRegisterConfirmation(@WebParam(name = "parameter") String txt) {
         try {
             new UserRegistration().userConfirmation(new JSONObject(txt).getString("username"));
             
         } catch (Exception e) {
             System.out.println(e);}
        
        return "confirmation ok";
    }
    
    @WebMethod(operationName = "getInvoices")
    public String getInvoices(@WebParam(name = "parameter") String txt) {
        Session getinvoiceses=NewHibernateUtil.getSessionFactory().openSession();
         JSONArray involist=new JSONArray();
        try {
            String username=new JSONObject(txt).getString("username");
            Login l=(Login) getinvoiceses.createCriteria(DB.Login.class).add(Restrictions.eq("username", username)).uniqueResult();
           
            if(l!=null){
                Set<Invoice> invoices = l.getUser().getInvoices();
                for (Invoice invoice : invoices) {
                   JSONObject ijo=new JSONObject();
                   
                   ijo.put("invoid", invoice.getIdInvoice());
                     ijo.put("total", invoice.getTotal());
                      ijo.put("issuedate", new SimpleDateFormat("yyyy-MM-dd").format(invoice.getDate())); 
                     involist.put(ijo);
                      
                    
                }
            
            }
            
            
        } catch (Exception ex) {
            System.out.println(ex);
        }
        
        
        
        
        
        getinvoiceses.close();
        return involist.toString();
    }
   
    @WebMethod(operationName = "viewInvoice")
    public String viewInvoice(@WebParam(name = "parameter") String txt) {
        Session viewinvoses=NewHibernateUtil.getSessionFactory().openSession();
        JSONArray list=new JSONArray();
        
        try {
            String invoid=new JSONObject(txt).getString("invoid");
            Invoice i=(Invoice) viewinvoses.load(DB.Invoice.class, new Integer(invoid));
            if(i!=null){
                Set<InvoiceHasGrnHasProducts> ihpl = i.getInvoiceHasGrnHasProductses();
                for (InvoiceHasGrnHasProducts ihp : ihpl) {
                   JSONObject jo=new JSONObject();
                   jo.put("pid", ihp.getGrnHasProducts().getIdGrnhasProduct());
                   jo.put("product",ihp.getGrnHasProducts().getProducts().getProductName()+
                           "- Rs."+ihp.getGrnHasProducts().getSellprice());
                   jo.put("qty",ihp.getInvoqty());
                   jo.put("amount", ihp.getTotal());
                   
                   
                   list.put(jo);
                    
                }
                
            }
            
            
            
            
        } catch (Exception e) {
            System.out.println(e);}
        
        
        viewinvoses.close();
        
        return list.toString();
    }  
}
