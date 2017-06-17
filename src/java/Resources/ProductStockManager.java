/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Resources;

import Connection.NewHibernateUtil;
import DB.Grn;
import DB.GrnHasProducts;
import DB.Products;
import DB.ProductsHasBrands;
import DB.Supplier;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Gihan
 */
public class ProductStockManager extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    static HashMap pidm = new HashMap();
    static Double stotal = 0.0;
    static int sitemscount = 0;
    static String supid = null;

    @SuppressWarnings("empty-statement")
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            Session s = NewHibernateUtil.getSessionFactory().openSession();

            //for view stockgeta
            if (request.getParameter("stockData") != null) {

                //add option forview
                if (request.getParameter("stockData").equalsIgnoreCase("OptionData")
                        && request.getParameter("optiontype") != null && request.getParameter("gnid") != null) {
                    //active status
                    if (request.getParameter("optiontype").equalsIgnoreCase("1")) {
                        //set exist product stock deactive
                        GrnHasProducts ghp = (GrnHasProducts) s.load(DB.GrnHasProducts.class, new Integer(request.getParameter("gnid")));
                        if (ghp != null) {
                            List<GrnHasProducts> ghpl = s.createCriteria(DB.GrnHasProducts.class).add(Restrictions
                                    .and(Restrictions.eq("products", ghp.getProducts()), Restrictions.eq("grnpstatus", "1"))).list();
                            if (ghpl.size() > 0) {
                                for (GrnHasProducts ghpu : ghpl) {

                                    ghpu.setGrnpstatus("0");
                                    s.update(ghpu);
                                    s.flush();
                                    s.beginTransaction().commit();
                                }
                            }
                            //new product stock active
                            ghp.setGrnpstatus("1");
                            s.update(ghp);
                            s.flush();
                            s.beginTransaction().commit();

                        }

                    }
                    //deactive status
                    if (request.getParameter("optiontype").equalsIgnoreCase("0")) {
                        GrnHasProducts ghp = (GrnHasProducts) s.load(DB.GrnHasProducts.class, new Integer(request.getParameter("gnid")));
                        if (ghp != null) {

                            //new product stock deactive
                            Criteria cghp = s.createCriteria(DB.GrnHasProducts.class).add(Restrictions
                                    .and(Restrictions.eq("products", ghp.getProducts()), Restrictions.eq("qtystatus", "1")));
                            cghp.addOrder(Order.desc("idGrnhasProduct"));
                            cghp.setMaxResults(2);
                            List<GrnHasProducts> ghpl = cghp.list();
                            if (ghpl.size() > 0) {
                                for (GrnHasProducts ghpu : ghpl) {

                                    if (ghp.equals(ghpu)) {
                                        ghp.setGrnpstatus("0");
                                        s.update(ghp);
                                        s.flush();
                                        s.beginTransaction().commit();
                                    } else {
                                        ghpu.setGrnpstatus("1");
                                        s.update(ghpu);
                                        s.flush();
                                        s.beginTransaction().commit();
                                    }

                                }
                            }

                        }
                    }

                }

                if (request.getParameter("stockpid") != null && !(request.getParameter("stockpid").equalsIgnoreCase("All"))) {
                    Products p = (Products) s.load(DB.Products.class, new Integer(request.getParameter("stockpid")));;
                    if (p != null) {
                        List<GrnHasProducts> ghpl = s.createCriteria(DB.GrnHasProducts.class).add(Restrictions.eq("products", p)).list();

                        if (ghpl.size() > 0) {
                            out.print("<table class=\"table table-bordered \" style=\"font-size:12px;table-layout: fixed \">");
                            out.print("<th width=\"5%\">GRN No</th>");
                            out.print("<th width=\"10%\">Supplier</th>");
                            out.print("<th width=\"10%\">Date</th>");
                            out.print("<th width=\"15%\" style=\"text-align: left\" >Products</th>");
                            out.print(" <th width=\"10%\">Add Stock</th>");
                            out.print("<th width=\"10%\">Exist Stock</th>");
                            out.print("<th width=\"10%\">buy price(LKR)</th>");
                            out.print("<th width=\"10%\">sellprice price(LKR)</th>");
                            out.print(" <th width=\"10%\">Current status</th>");
                            out.print(" <th>Option</th>");
                            for (GrnHasProducts ghp : ghpl) {
                                out.print("  <tr style=\"text-align: center\">");
                                out.print(" <td >" + ghp.getGrn().getIdGrn() + "</td>");
                                out.print("<td>" + ghp.getGrn().getSupplier().getFullName() + "</td>");
                                out.print("<td>" + new SimpleDateFormat("yyyy-MM-dd").format(ghp.getGrn().getDate()) + "</td>");
                                out.print(" <td >");
                                out.print("<ul >");
                                out.print(" <li>" + ghp.getProducts().getProductName() + "</li>");
                                out.print("</ul >");
                                out.print("  </td>");
                                out.print("<td>" + ghp.getAddqty() + "</td>");
                                out.print("<td>" + ghp.getQty() + "</td>");
                                out.print("  <td>" + ghp.getBuyprice() + "</td>");
                                out.print("  <td>" + ghp.getSellprice() + "</td>");

                                if (ghp.getGrnpstatus().equals("1")) {
                                    out.print("<td style=\"color:#00b534;font-weight: bold \">Active</td>");
                                } else {
                                    out.print("<td style=\"color:red;font-weight: bold \">De-active</td>");
                                }

                                if (ghp.getQtystatus().equals("1")) {
                                    out.print("<td>");
                                    if (ghp.getGrnpstatus().equals("1")) {
                                        out.print("<button class=\"btn  btn-danger btn-xs  \" type=\"button\" onclick=\"stockOptionChange('0'," + ghp.getIdGrnhasProduct() + ")\" style=\"font-size:10px\">De-active </button>");
                                    }
                                    if (ghp.getGrnpstatus().equals("0")) {
                                        out.print("<button class=\"btn  btn-success btn-xs  \" type=\"button\" onclick=\"stockOptionChange('1'," + ghp.getIdGrnhasProduct() + ")\" style=\"font-size:10px\">Active </button>");
                                    }
                                    out.print(" <button class=\"btn btn-default btn-xs \" type=\"button\" onclick=\"GRNModelView(" + ghp.getGrn().getIdGrn() + ")\" style=\"font-size:10px\">view GRN</button>");
                                    out.print("</td>");
                                } else {
                                    out.print("<td>");
                                    out.print(" <button class=\"btn btn-default btn-sm \" type=\"button\" onclick=\"GRNModelView(" + ghp.getGrn().getIdGrn() + ")\">view GRN</button>");
                                    out.print("</td>");
                                }

                                out.print("</tr>");

                            }
                            out.print("   </table>");
                        } else {
                            out.print("<h4 style=\"color:red\">Sorry any Grn has not been added </h4>");
                        }

                    }
                } //get all data ===============================================
                else {
                    List<Grn> grnl = s.createCriteria(DB.Grn.class).list();
                    if (request.getParameter("supid") != null) {
                        Supplier sup = (Supplier) s.load(DB.Supplier.class, new Integer(request.getParameter("supid")));
                        if (sup != null) {
                            grnl = s.createCriteria(DB.Grn.class).add(Restrictions.eq("supplier", sup)).list();
                        }
                    }

                    if (grnl.size() > 0) {

                        out.print("<table class=\"table table-bordered \" style=\"font-size:12px;table-layout: fixed \">");
                        out.print("<th width=\"10%\">GRN No</th>");
                        out.print("<th width=\"10%\">Supplier</th>");
                        out.print("<th width=\"10%\">Date</th>");
                        out.print("<th width=\"20%\" style=\"text-align: left\" >Products</th>");
                        out.print(" <th width=\"10%\">Add Stock</th>");
                        out.print("<th width=\"10%\">Exist Stock</th>");
                        out.print("<th width=\"10%\">Paid cost(LKR)</th>");
                        out.print(" <th width=\"10%\">Current status</th>");
                        out.print(" <th>Option</th>");
                        for (Grn grn : grnl) {

                            out.print("  <tr style=\"text-align: center\">");
                            out.print(" <td >" + grn.getIdGrn() + "</td>");
                            out.print("<td>" + grn.getSupplier().getFullName() + "</td>");
                            out.print("<td>" + new SimpleDateFormat("yyyy-MM-dd").format(grn.getDate()) + "</td>");
                            out.print(" <td >");
                            out.print("<ul >");

                            Set<GrnHasProducts> grnHasProductses = grn.getGrnHasProductses();
                            for (GrnHasProducts ghp : grnHasProductses) {
                                out.print(" <li>" + ghp.getProducts().getProductName() + "</li>");
                            }

                            out.print(" </ul>");
                            out.print("  </td>");
                            out.print("<td>" + grn.getTotalqty() + "</td>");
                            out.print("<td>" + grn.getExistqty() + "</td>");
                            out.print("  <td>" + grn.getTotal() + "</td>");

                            if (grn.getGrnstatus().equals("1")) {
                                out.print("<td style=\"color:#00b534;font-weight: bold \">Active</td>");
                            } else {
                                out.print("<td style=\"color:red;font-weight: bold \">De-active</td>");
                            }

                            out.print("<td>");
                            out.print(" <button class=\"btn btn-default btn-sm \" type=\"button\" onclick=\"GRNModelView(" + grn.getIdGrn() + ")\">view GRN</button>");
                            out.print("</td>");

                            out.print("</tr>");

                        }
                        out.print("   </table>");
                    } else {
                        out.print("<div style=\"margin-top:50px;display: inline-block \">");
                        out.print("<h4 style=\"color:red\">Sorry any Grn has not been added this Supplier </h4>");
                        out.print("</div>");
                    }
                }

            }

            //get grn nxt id
            if (request.getParameter("GetData") != null && request.getParameter("GetData").equals("GrnId")) {

                Criteria gg = s.createCriteria(DB.Grn.class);
               
                ArrayList<Integer> idal=new ArrayList<>();
                for(Grn gi:(List<Grn>)gg.list()){
                idal.add(gi.getIdGrn());
                }

                int grnid=Collections.max(idal);
                if(grnid==0){
                out.write("0");
                }else{
                out.write((++grnid)+"");
                }
                        
             }

            if (request.getParameter("pmodel") != null) {
                String chek = request.getParameter("pmodel").toString();
                JSONObject j = new JSONObject();
                Products p = new Products();

                if (isNumeric(chek)) {
                    p = (Products) s.createCriteria(DB.Products.class).add(Restrictions.and(Restrictions.eq("idProducts", new Integer(request.getParameter("pmodel"))),
                            Restrictions.eq("status", new Integer("1")))).uniqueResult();

                } else {
                    p = (Products) s.createCriteria(DB.Products.class).add(Restrictions.and(Restrictions.eq("productName", request.getParameter("pmodel")), 
                            Restrictions.eq("status", new Integer("1")))).uniqueResult();

                }

//========================== check product is available ======================================
                if (p != null) {
                    List<GrnHasProducts> ghpl = s.createCriteria(DB.GrnHasProducts.class)
                            .add(Restrictions.and(Restrictions.eq("products", p), Restrictions.eq("qtystatus", "1"))).list();

                    int tolqty = 0;
                    //check qty availble 
                    if (ghpl.size() > 0) {
                        for (GrnHasProducts ghp : ghpl) {
                            tolqty += ghp.getQty();
                        }
                    }

                    List<ProductsHasBrands> phb = s.createCriteria(DB.ProductsHasBrands.class)
                            .add(Restrictions.eq("products", p)).list();

                    ArrayList<String> phbl = new ArrayList<>();

                    for (ProductsHasBrands bl : phb) {

                        phbl.add(bl.getBrands().getBrandname());

                    }

                    for (String string : phbl) {
                        System.out.println(phbl);
                    }

                    JSONArray list = new JSONArray(phbl);

                    j.put("pid", p.getIdProducts());
                    j.put("pname", p.getProductName());
                    j.put("pbrand", list);
                    j.put("qqty", tolqty);

                    out.print(j);
                    System.out.println(j);

                } //no product available 
                else {
                    out.write("0");
                }

            }

            // ======= stock adding and remove ==========================================================
            if (request.getParameter("status") != null && request.getParameter("pid") != null
                    && request.getParameter("supid") != null) {

                Products pp = (Products) s.load(DB.Products.class, new Integer(request.getParameter("pid")));
                Supplier sup = (Supplier) s.load(DB.Supplier.class, new Integer(request.getParameter("supid")));
                Grn forview = new Grn();
                boolean grnstatus = false;//grn not exist
                if (pp != null) {
                    //check status
                    if (request.getParameter("status").equalsIgnoreCase("stockadd")) {// status is item adding
                        if (request.getParameter("nqty") != null
                                && request.getParameter("buyprice") != null
                                && request.getParameter("sellprice") != null) {

                            Grn supgrn = (Grn) s.createCriteria(DB.Grn.class).add(Restrictions
                                    .and(Restrictions.eq("supplier", sup), Restrictions.eq("addstatus", "0"))).uniqueResult();
                            //grn exist   
                            if (supgrn != null) {
                                forview = supgrn;
                                grnstatus = true;
                                GrnHasProducts ghp = (GrnHasProducts) s.createCriteria(DB.GrnHasProducts.class)
                                        .add(Restrictions.and(Restrictions.eq("grn", supgrn), Restrictions.eq("products", pp))).uniqueResult();
//                     product exsit in grn
                                if (ghp != null) {
                                    ghp.setAddqty(ghp.getAddqty() + new Integer(request.getParameter("nqty")));
                                    ghp.setQty(ghp.getAddqty() + new Integer(request.getParameter("nqty")));
                                    ghp.setBuyprice(new Double(request.getParameter("buyprice")));
                                    ghp.setSellprice(new Double(request.getParameter("sellprice")));
                                    s.update(ghp);
                                    s.flush();
                                    s.beginTransaction().commit();

                                } else {
                                    ghp = new GrnHasProducts();
                                    ghp.setAddqty(new Integer(request.getParameter("nqty")));
                                    ghp.setQty(new Integer(request.getParameter("nqty")));
                                    ghp.setBuyprice(new Double(request.getParameter("buyprice")));
                                    ghp.setSellprice(new Double(request.getParameter("sellprice")));
                                    ghp.setGrn(supgrn);
                                    ghp.setProducts(pp);
                                    //check product availabillty
                                    //not availble
                                    if (new StockChangeManager().checkProductQty(pp.getIdProducts())) {
                                        ghp.setGrnpstatus("1");
                                    } //availble
                                    else {
                                        ghp.setGrnpstatus("0");
                                    }
                                    ghp.setQtystatus("1");
                                    s.save(ghp);
                                    s.flush();
                                    s.beginTransaction().commit();
                                }

                            } //add new Grn
                            else {
                                supgrn = new Grn();
                                supgrn.setAddstatus("0");
                                supgrn.setDate(new Date());
                                supgrn.setExistqty(0);
                                supgrn.setGrnstatus("1");
                                supgrn.setPCount(0);
                                supgrn.setSupplier(sup);
                                supgrn.setTotal(0.0);
                                supgrn.setTotalqty(0);
                                forview = supgrn;//change grn variable for method loacal type
                                s.save(forview);
                                s.flush();
                                s.beginTransaction().commit();
                                GrnHasProducts ghp = new GrnHasProducts();
                                ghp.setAddqty(new Integer(request.getParameter("nqty")));
                                ghp.setQty( new Integer(request.getParameter("nqty")));
                                ghp.setBuyprice(new Double(request.getParameter("buyprice")));
                                ghp.setSellprice(new Double(request.getParameter("sellprice")));
                                ghp.setGrn(supgrn);
                                ghp.setProducts(pp);
                                //check product availabillty
                                //not availble
                                if (new StockChangeManager().checkProductQty(pp.getIdProducts())) {
                                    ghp.setGrnpstatus("1");
                                } //availble
                                else {
                                    ghp.setGrnpstatus("0");
                                }
                                ghp.setQtystatus("1");
                                s.save(ghp);
                                s.flush();
                                s.beginTransaction().commit();
                            }
                        }
                    }
                    if (request.getParameter("status").equalsIgnoreCase("stockremove") ) {// status is item remove
                        forview= (Grn) s.createCriteria(DB.Grn.class).add(Restrictions
                                    .and(Restrictions.eq("supplier", sup), Restrictions.eq("addstatus", "0"))).uniqueResult();
                       grnstatus=true;
                                 GrnHasProducts ghp = (GrnHasProducts) s.createCriteria(DB.GrnHasProducts.class)
                                        .add(Restrictions.and(Restrictions.eq("grn", forview), Restrictions.eq("products", pp))).uniqueResult();
                                 if(ghp!=null){
                                 s.delete(ghp);
                                 s.flush();
                                 s.beginTransaction().commit();
                                 }
                    }
                }

                //set table view and 
                List<GrnHasProducts> ghpl = s.createCriteria(DB.GrnHasProducts.class).add(Restrictions.eq("grn", forview)).list();
                Double grntotal =0.0;
                    int grntolqty = 0;
                    int productCount = 0;
                if (ghpl.size() > 0) {
                   
                    out.write("<div style=\"display: inline-block;width:100%\">");

                    out.write("<table class='table table-responsive table-bordered' id='itemstable'>");

                    out.write("<th>product id</th>");
                    out.write("<th>Name</th>");
                    out.write("<th>Buy Price</th>");
                    out.write("<th>Sell Price</th>");
                    out.write("<th>Added Qty</th>");
                    out.write("<th>Amount</th>");
                    out.write("<th>Option</th>");

                    for (GrnHasProducts ghp : ghpl) {
                        out.write("<tr>");
                        out.write("<td>" + ghp.getProducts().getIdProducts() + "</td>");
                        out.write("<td>" + ghp.getProducts().getProductName() + "</td>");
                        out.write("<td>" + ghp.getBuyprice() + "</td>");
                        out.write("<td>" + ghp.getSellprice() + "</td>");
                        out.write("<td>" + ghp.getAddqty() + "</td>");

                        grntolqty += ghp.getAddqty();
                        Double amount = ghp.getAddqty() * ghp.getBuyprice();
                        grntotal += amount;
                        productCount++;
                        out.write("<td>" + amount + "</td>");
                        out.write("<td><button class='btn btn-sm btn-danger' type='button' onclick=\"removeItem('" + ghp.getProducts().getIdProducts() + "');\">X</button></td>");
                        out.write("</tr>");

                    }
                        out.write("</table>");
                  
                        
                     out.write("<div class='col-md-10'>");
                    out.write("<h4 style='font-weight: bold;text-align:right;color: #ff3300'>Total Amount:<span style=\"font-weight: bold;color: #990099\">" + grntotal + "LKR</span></h4>");
                    out.write("</div>");
                    out.write("<div class='col-md-2'></div>");
                    out.write("</div>");
                    out.write("<div style=\"display: inline-block\">");
                    out.write(" <br>");
                    out.write("<div class='col-md-8'></div>");
                    out.write("<div class='col-md-4'>");
                    out.write("<div class='btn-group-sm'>");
                    out.write("<button class='btn btn-sm btn-warning' type='button' onclick=\"removeGRN();\">Clear</button>");
                    out.write(" &nbsp;  &nbsp; &nbsp; &nbsp;");
                    out.write("<button class='btn btn-sm btn-success' type='button' onclick=\"printGrn();\">Print GRN</button>");
                    out.write("</div>");
                    out.write(" </div>");
                    out.write("</div>");

                } else {
                    out.print("Iwaraiiiii");
                    out.print("<h6 style='font-weight: bold;>---- No Details Add yet -----</h6>");
                    System.out.println("grn product over");
                }
//                update GRN
                    forview.setTotal(grntotal);
                    forview.setTotalqty(grntolqty);
                    forview.setExistqty(grntolqty);
                    forview.setPCount(productCount);
                    if (grnstatus) {
                        s.update(forview);
                        s.flush();
                        s.beginTransaction().commit();
                    } else {
                        s.save(forview);
                        s.flush();
                        s.beginTransaction().commit();
                    }
            
            
            
            } else {

                System.out.println("stok empty");
            }
            //clear add GRN data Before Save
            if(request.getParameter("cleargrn")!=null&& request.getParameter("supid") != null){
                 Supplier sup = (Supplier) s.load(DB.Supplier.class, new Integer(request.getParameter("supid")));
                 if(sup!=null){
                    Grn supgrn = (Grn) s.createCriteria(DB.Grn.class).add(Restrictions
                                    .and(Restrictions.eq("supplier", sup), Restrictions.eq("addstatus", "0"))).uniqueResult();
                    if(supgrn!=null){
                         List<GrnHasProducts> ghpl = s.createCriteria(DB.GrnHasProducts.class).add(Restrictions.eq("grn", supgrn)).list();
                        for (GrnHasProducts ghp : ghpl) {
                            s.delete(ghp);
                            s.flush();s.beginTransaction();
                            
                        }
                       s.delete(supgrn);
                       s.flush();
                       s.beginTransaction().commit();
                    }
                 }
               
            }else{
              System.out.println("can not grn remove ");
            }
            
            // =============== GRN Saving and Print view ==================================
            if (request.getParameter("getgrn") != null&& request.getParameter("supid") != null ) {
                 Supplier sup = (Supplier) s.load(DB.Supplier.class, new Integer(request.getParameter("supid")));
                 if(sup!=null){
                    Grn supgrn = (Grn) s.createCriteria(DB.Grn.class).add(Restrictions
                                    .and(Restrictions.eq("supplier", sup), Restrictions.eq("addstatus", "0"))).uniqueResult();
                    if(supgrn!=null){
                      supgrn.setAddstatus("1");
                      supgrn.setDate(new Date());
                      s.update(supgrn);
                      s.flush();
                      s.beginTransaction().commit();
                      out.print(supgrn.getIdGrn()+"");
                    }
                 }

            }

        } catch (Exception ex) {
            System.out.println(ex);
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

    public static boolean isNumeric(String str) {
        try {
            double d = Double.parseDouble(str);
        } catch (NumberFormatException nfe) {
            return false;
        }
        return true;
    }

}
