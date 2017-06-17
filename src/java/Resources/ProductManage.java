
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Resources;

import Connection.NewHibernateUtil;
import DB.Brands;
import DB.PCatergory;
import DB.Productreview;
import DB.Products;
import DB.ProductsHasBrands;
import DB.Shipping;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Gihan
 */
public class ProductManage extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            Session s = NewHibernateUtil.getSessionFactory().openSession();
           

    //category add management        
            if (request.getParameter("status") != null && request.getParameter("status").equalsIgnoreCase("onCatdata")) {

                //=======for category status change
                if (request.getParameter("change") != null
                        && request.getParameter("change").equalsIgnoreCase("ok")
                        && request.getParameter("catid") != null) {

                    PCatergory pc = (PCatergory) s.createCriteria(DB.PCatergory.class).
                            add(Restrictions.eq("idPCatergory", new Integer(request.getParameter("catid")))).uniqueResult();
                    if (pc != null) {
                        if (pc.getStatus().equalsIgnoreCase("0")) {
                            pc.setStatus("1");

                        } else {
                            pc.setStatus("0");

                        }

                        s.update(pc);
                       s.flush();
                 s.beginTransaction().commit();

                    }

                }

                //add categories 
                if (request.getParameter("adname") != null
                        && request.getParameter("catstatus") != null
                        && request.getParameter("vehitype") != null
                        && request.getParameter("scost") != null) {

                    PCatergory pcat = (PCatergory) s.createCriteria(DB.PCatergory.class)
                            .add(Restrictions.eq("catName", request.getParameter("adname"))).uniqueResult();

                    if (pcat != null) {//already available category
                        Shipping ns = new Shipping();
                        Shipping es = null;

                        if (isNumber(request.getParameter("vehitype"))) {

                            es = (Shipping) s.createCriteria(DB.Shipping.class)
                                    .add(Restrictions.eq("idShipping", new Integer(request.getParameter("vehitype")))).uniqueResult();
                        } else {
                            es = (Shipping) s.createCriteria(DB.Shipping.class)
                                    .add(Restrictions.eq("mthodName", request.getParameter("vehitype"))).uniqueResult();
                        }

                        if (es != null) {
                            ns = es;
                            es.setCost(request.getParameter("scost"));
                            es.setMthodName(es.getMthodName());
                            es.setVehicleType("Light");
                            s.update(es);
                              s.flush();
                 s.beginTransaction().commit();

                        } else {
                            ns.setCost(request.getParameter("scost"));
                            ns.setMthodName(request.getParameter("vehitype"));
                            ns.setVehicleType("Light");
                        }
                        if (es == null) {

                            s.save(ns);
                              s.flush();
                 s.beginTransaction().commit();
                        }

                        pcat.setStatus(request.getParameter("catstatus"));

                        s.update(pcat);
                          s.flush();
                 s.beginTransaction().commit();

                    } else {//add new category

                        Shipping ns = new Shipping();
                        Shipping es = null;

                        if (isNumber(request.getParameter("vehitype"))) {

                            es = (Shipping) s.createCriteria(DB.Shipping.class)
                                    .add(Restrictions.eq("idShipping", new Integer(request.getParameter("vehitype")))).uniqueResult();
                        } else {
                            es = (Shipping) s.createCriteria(DB.Shipping.class)
                                    .add(Restrictions.eq("mthodName", request.getParameter("vehitype"))).uniqueResult();
                        }

                        if (es != null) {
                            ns = es;
                        } else {
                            ns.setCost(request.getParameter("scost"));
                            ns.setMthodName(request.getParameter("vehitype"));
                            ns.setVehicleType("Light");
                        }
                        if (es == null) {
                            s.save(ns);
                              s.flush();
                 s.beginTransaction().commit();
                        }

                        PCatergory npcat = new PCatergory();

                        npcat.setCatName(request.getParameter("adname"));
                        npcat.setShipping(ns);
                        npcat.setStatus(request.getParameter("catstatus"));

                        s.save(npcat);
                          s.flush();
                 s.beginTransaction().commit();

                    }

                    
                }
                Criteria apcc = s.createCriteria(DB.PCatergory.class);
                List<PCatergory> apcl = apcc.list();

                if (apcl.size() > 0) {
                    out.write("<table  class=\"table table-bordered\" style=\"border-color: #333333\">");
                    out.write("<tr>");
                    out.write("<th> <h6 class=\"h6\"><strong>Product Category Name</strong></h6></th>");
                    out.write("<th><h6 class=\"h6\"><strong>Shipping Method</strong></h6></th>");
                    out.write("<th><h6 class=\"h6\"><strong>Shipping Cost</strong></h6></th>");
                    out.write("<th><h6 class=\"h6\"><strong>Status</strong></h6></th>");
                    out.write("<th><h6 class=\"h6\"><strong>Option</strong></h6></th>");
                    out.write("</tr>");

                    for (PCatergory pc : apcl) {

                        out.write("<tr align=\"center\">");
                        out.write("<td height=\"24\">");
                        out.write(pc.getCatName());
                        out.write("</td>");

                        out.write("<td>");
                        out.write(pc.getShipping().getMthodName());
                        out.write("</td>");

                        out.write("<td>");
                        out.write(pc.getShipping().getCost() + " Rs");
                        out.write("</td>");

                        out.write("<td>");
                        String status = "Active";
                        if (pc.getStatus().equalsIgnoreCase("0")) {
                            status = "De-active";
                        }
                        out.write(status);
                        out.write("</td>");

                        out.write("<td>");

                        if (pc.getStatus().equalsIgnoreCase("0")) {
                            out.write("<button class=\"btn btn-success\" type=\"button\" onclick=\"catstatusChange('" + pc.getIdPCatergory() + "')\">Active</button>");
                        }

                        if (pc.getStatus().equalsIgnoreCase("1")) {
                            out.write("<button class=\"btn btn-danger\" type=\"button\" onclick=\"catstatusChange('" + pc.getIdPCatergory() + "')\">De-active</button>");
                        }
                        out.write("</td>");

                        out.write("</tr>");
                    }
                    out.write("</table>");

                } else {

                    out.write("<h4>No Available Categories</h4>");

                }

            }

//===================  brand management  =====================================================
            
            if (request.getParameter("bstatus") != null && request.getParameter("bstatus").equalsIgnoreCase("onBradata")) {
                 Session ss=NewHibernateUtil.getSessionFactory().openSession();
                   
                if (request.getParameter("bname") != null
                        && request.getParameter("bcountry") != null) {
                    
                    System.out.println("inside if");
                  
                    
                    Brands b = (Brands) ss.createCriteria(DB.Brands.class)
                            .add(Restrictions.eq("brandname", request.getParameter("bname"))).uniqueResult();

                    if (b != null) {
                        b.setBrandname(b.getBrandname());
                        b.setCountry(request.getParameter("bcountry"));
                        ss.update(b);
                      ss.flush();
                 ss.beginTransaction().commit(); 
                    } else {
                        Brands nb = new Brands();
                        nb.setBrandname(request.getParameter("bname"));
                        nb.setCountry(request.getParameter("bcountry"));
                        
                        ss.save(nb);
                       ss.flush();
                 ss.beginTransaction().commit(); 
                    }
                     
                }

                System.out.println("out if");

                Criteria apccc = ss.createCriteria(DB.Brands.class);
                List<Brands> brand2 = apccc.list();
                if(brand2.size()>0){
                 for (Brands bb : brand2) {

                    String item= bb.getBrandname()+" : "+bb.getCountry();
                    out.write("  <a href='#' class='list-group-item'>" + item + "</a>");
                }
                }else{
                
                out.write("<h5 style=\"color:#660000;\">No Brand Available</h5>");
                
                }
                

            }
           
         // load the customize_Product======================
            
           if(request.getParameter("type")!=null&&
                   request.getParameter("type").equalsIgnoreCase("GetPdata")){
           
               out.write("Customize_Products.jsp");

           } 
         //end==============================  
           
            
        //Load All Product Data & status Change of Products===================
           
         if(request.getParameter("contype")!=null&&
                 request.getParameter("contype").equalsIgnoreCase("GetAll")){
         
             //for status change
             
             if(request.getParameter("changestatus")!=null&&
                     request.getParameter("pid")!=null){
                 System.out.println("inn staus chanege");
             Products cp=(Products) s.createCriteria(DB.Products.class)
                     .add(Restrictions.eq("idProducts", new Integer(request.getParameter("pid")))).uniqueResult();
             
             if(cp!=null){
                 cp.setStatus(new Integer(request.getParameter("changestatus")));
             
                 s.update(cp);
                 s.flush();
                 s.beginTransaction().commit(); 
             }
             
             }
             
             
             
             //check data needed type active or de-active
             
             String status="`products`.`status` LIKE'%'";
             
             if(request.getParameter("sertype")!=null){
              if(request.getParameter("sertype").equalsIgnoreCase("1")){
             status="`products`.`status`='"+request.getParameter("sertype")+"'";
                 System.out.println("ok active");
             }
              if(request.getParameter("sertype").equalsIgnoreCase("0")){
             
             status="`products`.`status`='"+request.getParameter("sertype")+"'";
               System.out.println("ok deactive");
             }
             
              
             }
            
             String searchval="";
          if (request.getParameter("searchval") != null) {
                    searchval = " AND ProductName='" + request.getParameter("searchval") + "' OR idProducts='" + request.getParameter("searchval") + "'";
                }

             
             
           String quary="SELECT\n" +
"    `idProducts`\n" +
"    , `ProductName`\n" +
"    , `img`\n" +
"    , `status`\n" +
"FROM\n" +
"    `products` WHERE"+status+searchval;  
              
            SQLQuery sql=s.createSQLQuery(quary);
             
              List cuspl=sql.list();
              
              if(cuspl.size()>0){
                  
                  out.write(" <table class=\"table table-bordered\" >");
                  out.write("<th>Product id</th>");
                  out.write("<th>Product pic</th> ");
                  out.write("<th>Product Name</th>");
                  out.write("<th>Ratings</th>");
                  out.write("<th>Reviews</th>");
                  out.write("<th>status</th> ");
                  out.write("<th>Options</th> ");
                  
               for(Object o:cuspl){
                  
                  Object[] oa=(Object[])o;
             
                  out.write(" <tr> ");
                  out.write("<td>"+oa[0].toString()+"</td> ");
                  out.write("<td><img src=\""+oa[2].toString()+"\" class=\" img-responsive\" height=\"30\" width=\"30\"></td> ");
                  out.write("<td>"+oa[1].toString()+"</td> ");
                  out.write("<td style=\"font-weight: bold\">"+new ProductRatingProvider().getRateOfProduct(oa[0].toString())+"</td> ");
                
                  out.write("<td> <button class=\"btn btn-default\" type=\"button\" onclick=\"productReviewModel('"+oa[0].toString()+"')\"> View Reviews</button></td> ");

                  
                  
                  if(oa[3].toString().equalsIgnoreCase("0")){
                  out.write("<td style=\"font-weight: bold;color:red\">De-active</td> ");
                  out.write("<td><button class=\"btn btn-success\" onclick=\"productStatusChange(1,'"+oa[0].toString()+"')\">Active</button></td>");
                  }
                  if(oa[3].toString().equalsIgnoreCase("1")){
                  out.write("<td style=\"font-weight: bold;color:green\">Active</td> ");
                  out.write("<td><button class=\"btn btn-danger\" onclick=\"productStatusChange(0,'"+oa[0].toString()+"')\">De-active</button></td>");
                  
                  }
                  
                   out.write("</tr>");
                 
             
              }
               
                 out.write("</table>");
              }else{
                   System.out.println("list giyena");
                  out.write("<h4>No Products Available</h4>");
              
              
              }
             
              
         
         }
           
          if(request.getParameter("reviewmodel")!=null&&request.getParameter("revpid")!=null){
                Products p=(Products) s.load(DB.Products.class, new Integer(request.getParameter("revpid")));
                if(p!=null){
                   out.print("<div class=\"modal-header\">");
              out.print("<div style=\"display: inline-block;width: 100%;margin-left:100px  \">");
              out.print("<h3 style=\"font-weight: bold;margin-left:50px \">Product Name : <span style=\"color: #cc6600\">"+p.getProductName()+"</span></h3>");
              out.print("</div>");
              out.print("<div style=\"display: inline-block;width: 100%\">");
              String brandname="";
              for(ProductsHasBrands phb:p.getProductsHasBrandses()){
              brandname=phb.getBrands().getBrandname();
              }
              
              out.print("<div class=\"col-md-6\">   <h4 style=\"font-weight: bold\">Brand Name : <span style=\"color: #990033\">"+brandname+"</span></h4></div>");
              out.print("<div class=\"col-md-6\"><h4 style=\"font-weight: bold\">Category : <span style=\"color: #0066cc\">"+p.getPCatergory().getCatName()+"</span></h4></div>");
              out.print("</div>");
              out.print(" </div>");
              out.print("<div class=\"modal-body\" style=\"max-height:400;overflow: auto \">");
              out.print(" <div style=\"margin-left:150px;margin-right:100px;margin-top:15px   \">");
              out.print("<img src=\""+p.getImg()+"\" class=\"img-responsive\">");
              out.print("</div>");
              out.print(" <div style=\"margin-top:10px \">");  
                    List<Productreview> prl=s.createCriteria(DB.Productreview.class).add(Restrictions.eq("products",p)).list();
                    if(prl.size()>0){
                      
              out.print(" <table class=\"table table-bordered\">");
              out.print(" <th></th>");
              out.print("<th>User</th>");
              out.print("<th>Review</th>");
              out.print("<th>Date</th>");
              out.print("<th>Option</th>");
                        for (Productreview pi : prl) {
                          
              out.print(" <tr>");
              out.print("<td><img src=\""+pi.getUser().getUimg()+"\" style=\"width:50px;height:50px  \"></td>");
              out.print(" <td>"+pi.getUser().getFname()+" "+pi.getUser().getLname()+"</td>");
              out.print(" <td>"+pi.getReview()+"</td>");
              out.print(" <td>"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+"</td>");
              out.print("<td><button class=\"btn btn-danger\">Delete</button></td>");
              out.print(" </tr>");  
                        }
                 out.print(" </table>");        
                    }else{
                    out.print("<h4>No Reviews for this Product</h4>");
                    }
                   out.print(" </table> </div> </div>");
              out.print(" <div class=\"modal-footer\"> </div>"); 
                }
          } 
           
           

        } catch (Exception e) {
            System.out.println(e);
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public static boolean isNumber(String str) {
        try {
            double d = Double.parseDouble(str);
        } catch (NumberFormatException nfe) {
            return false;
        }
        return true;
    }

}
