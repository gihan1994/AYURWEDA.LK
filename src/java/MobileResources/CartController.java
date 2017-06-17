/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MobileResources;

import Connection.NewHibernateUtil;
import DB.Cart;
import DB.CartHasProducts;
import DB.CartHasProductsId;
import DB.GrnHasProducts;
import DB.Invoice;
import DB.InvoiceHasGrnHasProducts;
import DB.Login;
import DB.Notifications;
import DB.Ordering;
import DB.Productoffers;
import DB.Products;
import DB.Productselling;
import DB.Shippingorder;
import Resources.StockChangeManager;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author gihanmunasinghe
 */
public class CartController {
    
    public String addToCart(int itemid,String uname){//add to cart item and return cart item total
        int tolitem=0;
           Session s=NewHibernateUtil.getSessionFactory().openSession();
GrnHasProducts itemghp=(GrnHasProducts)s.load(DB.GrnHasProducts.class, itemid);
if(itemghp!=null){
   Login l = (Login) s.createCriteria(DB.Login.class).add(Restrictions.eq("username", uname)).uniqueResult();

                    Products p = (Products) s.createCriteria(DB.Products.class).
                            add(Restrictions.eq("idProducts",itemghp.getProducts().getIdProducts())).uniqueResult();

                    
                    if (l != null && p != null) {
                        GrnHasProducts ghp=(GrnHasProducts)s.createCriteria(DB.GrnHasProducts.class)
                                .add(Restrictions.and(Restrictions.eq("products",p),
                                        Restrictions
                                        .and(Restrictions.eq("grnpstatus", "1"), Restrictions.eq("qtystatus", "1")))).uniqueResult();
                                 Double uniqprice=0.0;
                                 if(ghp!=null){
                                 uniqprice=ghp.getSellprice();
                                 
                           int poffer=0; 
                                       Productoffers poff=(Productoffers)s.createCriteria(DB.Productoffers.class)
                                        .add(Restrictions.and(Restrictions.eq("grnHasProducts", ghp),
                                                Restrictions.eq("dateofview", new Date()))).uniqueResult();
                              
                                if(poff!=null&&poff.getOfferstatus().equalsIgnoreCase("1")){
                                    poffer=poff.getPresentage();
                                    }
                       

                        Criteria criteriaCart = s.createCriteria(DB.Cart.class);
                        criteriaCart.add(Restrictions.eq("user", l.getUser()));

                        Cart c = (Cart) criteriaCart.uniqueResult();

                        //check request user has already unpayble cart 
                        if (c != null) { // already Exsit cart

                           

                        
                            CartHasProducts chpex = (CartHasProducts) s.createCriteria(DB.CartHasProducts.class).
                                    add(Restrictions.and(Restrictions.eq("cart", c), Restrictions.eq("products", p))).uniqueResult();

                            if (chpex != null) { // request product has existed in cart already

                              

                                int i = chpex.getQty() + 1;
                                double ptol=i * uniqprice;
                                if(poffer!=0){ptol=(uniqprice-(uniqprice*poffer/100))*i;}
                                chpex.setQty(i);
                                chpex.setPtotal(ptol);
                                s.update(chpex);
                                s.flush();
                 s.beginTransaction().commit(); 

                            } else { //not exist cart add to cart as a newone

                                CartHasProductsId chpi = new CartHasProductsId();
                                chpi.setCartIdCart(c.getIdCart());
                                chpi.setProductsIdProducts(p.getIdProducts());

                                chpex = new CartHasProducts();

                                chpex.setCart(c);
                                chpex.setProducts(p);
                                chpex.setQty(1);
                                double ptol=uniqprice;
                                if(poffer!=0){ptol=(uniqprice-(uniqprice*poffer/100));}
                                chpex.setPtotal(ptol);
                                chpex.setId(chpi);

                                s.save(chpex);
                                s.flush();
                 s.beginTransaction().commit();

                            }
                            Criteria criteriaCHP = s.createCriteria(DB.CartHasProducts.class);
                            criteriaCHP.add(Restrictions.eq("cart", c));
                            criteriaCHP.setProjection(Projections.sum("ptotal"));

                            Double total = Double.parseDouble(criteriaCHP.uniqueResult().toString());
                            c.setTotal(total);
                            s.update(c);

                          s.flush();
                 s.beginTransaction().commit();

                        } else {//not already exsit add new cart

                            Cart c1 = new Cart();
                            c1.setDate(new Date());
                            c1.setTotal(0.0);
                            c1.setUser(l.getUser());
                            c1.setPaystatus(0);

                            s.save(c1);
                           s.flush();
                 s.beginTransaction().commit();

                            CartHasProductsId chpi = new CartHasProductsId();
                            chpi.setCartIdCart(c1.getIdCart());
                            chpi.setProductsIdProducts(p.getIdProducts());

                            CartHasProducts chp = new CartHasProducts();
                            chp.setCart(c1);
                            chp.setProducts(p);
                            chp.setQty(1);
                               double ptol=uniqprice;
                                if(poffer!=0){ptol=(uniqprice-(uniqprice*poffer/100));}
                            chp.setPtotal(ptol);
                            chp.setId(chpi);

                            s.save(chp);
                          s.flush();
                 s.beginTransaction().commit();
                            //set cart total for new cart
                            List<CartHasProducts> carttol = s.createCriteria(DB.CartHasProducts.class).add(Restrictions.eq("cart", c1)).list();

                            Double total = 0.0;
                            for (CartHasProducts chpfortol : carttol) {
                                    tolitem+=chpfortol.getQty();
                                total += chpfortol.getPtotal();

                            }
                            System.out.println(c1.getIdCart());
                            System.out.println(total);
                            c1.setTotal(total);
                            s.update(c1);
                           s.flush();
                 s.beginTransaction().commit();
//                            s.close();

                        }
                    } } else {
                        System.out.println("else 3");
                        System.out.println("user or product null");
                    }
        
}
           
    return tolitem+"";
    } 
    
    
    public String removeItem(String itemid,String User){
    Session rs = NewHibernateUtil.getSessionFactory().openSession();
    Double total = 0.0;
               if(itemid!=null&&User!=null){}
                    Login l = (Login) rs.createCriteria(DB.Login.class).add(Restrictions.eq("username", User)).uniqueResult();
if(l!=null){}
                    
                    Cart c = (Cart) rs.createCriteria(DB.Cart.class).add(Restrictions.eq("user", l.getUser())).uniqueResult();
if(c!=null){}
        GrnHasProducts ghp=(GrnHasProducts) rs.load(DB.GrnHasProducts.class, new Integer(itemid));
        
                   

                    if (c != null && ghp != null) {

                        CartHasProducts rchp = (CartHasProducts) rs.createCriteria(DB.CartHasProducts.class).
                                add(Restrictions.and(Restrictions.eq("cart", c), Restrictions.eq("products",ghp.getProducts()))).uniqueResult();

                        if (rchp != null) {
                            
                            
                            rs.delete(rchp);
                             rs.flush();
                 rs.beginTransaction().commit();
                            System.out.println("in delete item");
                        }

//                    //check cart item is available
                       List<CartHasProducts> dcl = rs.createCriteria(DB.CartHasProducts.class).add(Restrictions.eq("cart", c)).list();
                        System.out.println(dcl.size()+"cart items");
                       if (dcl.size()==0) {
                            rs.delete(c);
                            rs.flush();
                 rs.beginTransaction().commit();
                           
                        }
                       //cart total update
                       else{
                         
                            for (CartHasProducts chpfortol : dcl) {

                                total += chpfortol.getPtotal();

                            }
                            c.setTotal(total);
                            rs.update(c);
                         rs.flush();
                 rs.beginTransaction().commit();
                       
                       
                       }

                      

                    }

              

          return total+"";
    
    }
    
    
    public HashMap<String,Integer> checkOut(String User){
        HashMap<String,Integer> OidIid=new HashMap<>();
        
    
                 Session cs = NewHibernateUtil.getSessionFactory().openSession();
          
            
                boolean checkqty=true;
                String msg="";
             
                     if (User!= null) {

                Login l = (Login) cs.createCriteria(DB.Login.class).add(Restrictions.eq("username", User)).uniqueResult();
                
               if(l!=null){
               
                Cart ccart = (Cart)cs.createCriteria(DB.Cart.class).add(Restrictions.eq("user",l.getUser() )).uniqueResult();
                if(ccart!=null){
                  Invoice invo = new Invoice();
                
                invo.setDate(new Date());
                invo.setTotal(new Double(ccart.getTotal().toString()));
                invo.setUser(l.getUser());
                invo.setTotal(ccart.getTotal());
                cs.save(invo);
                 cs.flush();
                 cs.beginTransaction().commit();

                    Ordering odr=new Ordering();
                    odr.setStatus("0");
                    odr.setOrderdate(new Date());
                    odr.setInvoice(invo);
                    odr.setUser(l.getUser());
                    
                    //set order address
                    Shippingorder orso=(Shippingorder) cs.createCriteria(DB.Shippingorder.class).add(Restrictions.eq("user", l.getUser())).uniqueResult();
                    if(orso!=null){
                    odr.setResName(orso.getRecieverName());
                    odr.setTel(orso.getUser().getTel());
                    odr.setStreet1(orso.getStreet1());
                    odr.setStreet2(orso.getStreet2());
                    odr.setCity(orso.getCity());
                    odr.setPcode(orso.getPostalcode());
                    }
                    cs.save(odr);
                    
                    cs.flush();
                 cs.beginTransaction().commit();
                
                 //pass oderid and invoid set==================================
                 
                 OidIid.put("invoid", invo.getIdInvoice());
                 OidIid.put("orderid", odr.getIdOrder());
                 
                 //===========================================================
                 

                List<CartHasProducts> chpforinvo = cs.createCriteria(DB.CartHasProducts.class).add(Restrictions.eq("cart", ccart)).list();

                for (CartHasProducts chpl : chpforinvo) {
                    
                     Products dp=(Products) cs.createCriteria(DB.Products.class)
                            .add(Restrictions.eq("idProducts", new Integer(chpl.getProducts().getIdProducts()))).uniqueResult();
                    
                    if(dp!=null){
                                  GrnHasProducts ghp=(GrnHasProducts)cs.createCriteria(DB.GrnHasProducts.class)
                                .add(Restrictions.and(Restrictions.eq("products",dp),
                                        Restrictions
                                        .and(Restrictions.eq("grnpstatus", "1"), Restrictions.eq("qtystatus", "1")))).uniqueResult();
                     
                     if(ghp!=null&&ghp.getQty()>=chpl.getQty()){
                      
                         
                   
                         InvoiceHasGrnHasProducts ihp = new InvoiceHasGrnHasProducts();

                     ihp.setGrnHasProducts(ghp);
                   ihp.setInvoice(invo);
                    ihp.setInvoqty(chpl.getQty());
                    ihp.setTotal(chpl.getPtotal());
                    cs.save(ihp);
                     cs.flush();
                 cs.beginTransaction().commit();
                    
                       
                  Notifications nn=new Notifications();
                                nn.setAdddate(new Date());
                                nn.setStatus("1");
                                nn.setTitle("Order has been processed");
                                nn.setUser(l.getUser());
                                cs.save(nn);
                                cs.flush();
                                cs.beginTransaction().commit();
                       
                    //update selling product count
                     Productselling ps=(Productselling) cs.createCriteria(DB.Productselling.class)
                            .add(Restrictions.eq("products", chpl.getProducts())).uniqueResult();
                    
                    if(ps!=null){
                            
                        ps.setSellQty(ps.getSellQty()+chpl.getQty());
                        cs.update(ps);
                         cs.flush();
                 cs.beginTransaction().commit();
                        
                    }else{
                    
                        ps=new Productselling();
                        
                        
                        ps.setProducts(chpl.getProducts());
                        ps.setStatus("1");
                        ps.setSellQty(chpl.getQty());
                        cs.save(ps);
                         cs.flush();
                 cs.beginTransaction().commit();
                        
                    }
                    
                    //update stock
                   
                    
                    dp.setTolQty(dp.getTolQty()-chpl.getQty());
                    cs.update(dp);
                     cs.flush();
                 cs.beginTransaction().commit();
                 
                 //GRN Stock Update
                 if(ghp.getQty()-chpl.getQty()==0){
                     //if set stock is Overed
                 ghp.setGrnpstatus("0");
                 ghp.setQtystatus("0");
                 }
                    ghp.setQty(ghp.getQty()-chpl.getQty());
                    cs.update(ghp);
                 cs.flush();
                 cs.beginTransaction().commit();
                 
                 //if product has been added offer update offerqty
                 
                 Productoffers poff = (Productoffers) cs.createCriteria(DB.Productoffers.class)
                                        .add(Restrictions.and(Restrictions.eq("grnHasProducts", ghp),
                                                        Restrictions.eq("dateofview", new Date()))).uniqueResult();
                 
                 if(poff!=null&&poff.getOfferstatus().equalsIgnoreCase("1")){
                     poff.setOfferqty(poff.getOfferqty()+chpl.getQty());
                     cs.update(poff);
                  cs.flush();
                 cs.beginTransaction().commit();
                 }
                    
                 //checked stock and changeed stock if current stock is empty
                 
                   new StockChangeManager().updateProductStock(chpl.getProducts().getIdProducts());
                 
                    cs.delete(chpl);
                cs.flush();
                 cs.beginTransaction().commit();
                     checkqty=true;
                     }
                     //out of stock
                     else{
                       msg=dp.getProductName()+" is "+"Out of Stock"+" Available Stock :"+dp.getTolQty();  
                         
                      checkqty=false;
                      break;
                     }
                }
                }
               
                if(checkqty){
                   List<Cart> dcl=cs.createCriteria(DB.Cart.class)
                           .add(Restrictions.eq("user", l.getUser())).list();
                    for (Cart cart : dcl) {
                        
                       cs.delete(cart);  
                       cs.flush();
                 cs.beginTransaction().commit();
                    }
                    
                 

                }else{

                
                }
                
             
                 
               
                System.out.println("okk invoice");
                }else{
                    System.out.println("invoice manager user haven't cart");
                }
              
               }else{
                   System.out.println("user not login or username error");
                  
               }
                  
                
            }else{
                   
                     }

           
       
    
    
   
    return OidIid;
    }
    
    
}
