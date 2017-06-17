/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Resources;

import Connection.NewHibernateUtil;
import DB.Login;
import DB.Logintimes;
import DB.User;
import DB.Usertype;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.json.JSONObject;

/**
 *
 * @author Gihan
 */
public class UserManagement extends HttpServlet {

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

            if (request.getParameter("formType") != null && request.getParameter("formType").equalsIgnoreCase("userregi")) {

                try {
                    User u = (User) s.createCriteria(DB.User.class).
                            add(Restrictions.eq("email", request.getParameter("uemail"))).uniqueResult();

                    Login l = (Login) s.createCriteria(DB.Login.class).
                            add(Restrictions.eq("username", request.getParameter("uruname"))).uniqueResult();

                    if (u == null && l == null) {//is check user name or email already exist

                        u = new User();
                        u.setFname(request.getParameter("ufname"));
                        u.setLname(request.getParameter("ulname"));
                        u.setEmail(request.getParameter("uemail"));
                        u.setTel(request.getParameter("utel"));

                        System.out.println(request.getParameter("utype"));
                        Usertype ut = (Usertype) s.createCriteria(DB.Usertype.class)
                                .add(Restrictions.eq("idUserType", new Integer(request.getParameter("utype")))).uniqueResult();

                        u.setUsertype(ut);
                        u.setSignDate(new Date());
                        u.setStatus("1");

                        s.save(u);
                        s.flush();
                        s.beginTransaction().commit();

                        l = new Login();

                        l.setUsername(request.getParameter("uruname"));
                        l.setPassword(request.getParameter("upw"));
                        l.setUser(u);
                        l.setStatus("1");
                        s.save(l);
                        s.flush();
                        s.beginTransaction().commit();

                        Logintimes lt = new Logintimes();
                        lt.setLogdate(new Date());
                        lt.setIntime(new Date());
                        lt.setLogin(l);
                        lt.setStatus("1");
                        s.save(lt);
                        s.flush();
                        s.beginTransaction().commit();

                        request.getSession().setAttribute("username", request.getParameter("uruname"));

                        if (request.getSession().getAttribute("uscart") != null) {// session cart available

                            response.sendRedirect("CartConverter?username=" + request.getSession().getAttribute("username"));

                        } else {

                            response.sendRedirect("Home.jsp");
                        }

                    } else {
                        response.sendRedirect("Login_UserRegistration.jsp?msg=Email or User Name Already Exist Try Again!!!");
                        out.write("Email or User Name Already Exist Try Again");

                    }

                } catch (Exception ex) {
                    System.out.println(ex);
                }

            }

        //Check User Name password when request comes from login form    
            if (request.getParameter("formType") != null && request.getParameter("formType").equalsIgnoreCase("userlogin")) {

                if (request.getParameter("luname") != null && request.getParameter("lpw") != null) {

                    Login cl = (Login) s.createCriteria(DB.Login.class).
                            add(Restrictions.and(Restrictions.eq("username", request.getParameter("luname")),
                                            Restrictions.eq("password", request.getParameter("lpw")))).uniqueResult();

                    if (cl != null) {

                        User checkuser = (User) s.createCriteria(DB.User.class).add(Restrictions.and(Restrictions.eq("idUser", cl.getUser().getIdUser()),
                                Restrictions.eq("status", "1"))).uniqueResult();

                        if (checkuser != null) {//check user is active user

                            Logintimes ltlot = (Logintimes) s.createCriteria(DB.Logintimes.class)
                                    .add(Restrictions.and(Restrictions.eq("login", cl), Restrictions.eq("status", "1"))).uniqueResult();

                            if (ltlot != null) {//check user login before

                                ltlot.setOuttime(new Date());
                                ltlot.setStatus("0");
                                s.update(ltlot);
                                s.flush();
                                s.beginTransaction().commit();
                              
                            }

                            cl.setStatus("1");
                            s.update(cl);
                            s.flush();
                            s.beginTransaction().commit();

                            Logintimes lt = new Logintimes();
                            lt.setLogdate(new Date());
                            lt.setIntime(new Date());
                            lt.setLogin(cl);
                            lt.setStatus("1");
                            s.save(lt);
                            s.flush();
                            s.beginTransaction().commit();

                            request.getSession().setAttribute("username", request.getParameter("luname"));

                            if (request.getSession().getAttribute("uscart") != null) {// session cart available

                                System.out.println("call cartconveter");

                                response.sendRedirect("CartConverter?username=" + request.getSession().getAttribute("username"));

                            } else {

                                response.sendRedirect("Home.jsp");
                            }

                        } else {

                            response.sendRedirect("Login_UserRegistration.jsp?msg=Your Account has been baned");
                        }

                    } else {

                        response.sendRedirect("Login_UserRegistration.jsp?msg=Error Login Try Again!!!!!");

                    }

                }

            }

            //for logout user
            if (request.getParameter("lstatus") != null && request.getParameter("lstatus").equalsIgnoreCase("logout")) {

                Login lotl = (Login) s.createCriteria(DB.Login.class).add(Restrictions.eq("username", request.getSession().getAttribute("username"))).uniqueResult();

                if (lotl != null) {

                    Logintimes ltlot = (Logintimes) s.createCriteria(DB.Logintimes.class)
                            .add(Restrictions.and(Restrictions.eq("login", lotl), Restrictions.eq("status", "1"))).uniqueResult();

                    ltlot.setOuttime(new Date());
                    ltlot.setStatus("0");
                    s.update(ltlot);
                    s.flush();
                    s.beginTransaction().commit();
                    lotl.setStatus("0");
                    s.update(lotl);
                    s.flush();
                    s.beginTransaction().commit();
                    request.getSession().removeAttribute("username");
                    request.getSession().invalidate();

                    response.sendRedirect("Home.jsp");

                } else {
                    response.sendRedirect("Home.jsp");
                }

            }

        // user status change
            if (request.getParameter("changeUserStatus") != null && request.getParameter("changeUserStatusId") != null) {
                String msg = "";
                String color = "";

                User chu = (User) s.createCriteria(DB.User.class).add(Restrictions.eq("idUser", new Integer(request.getParameter("changeUserStatusId")))).uniqueResult();

                if (request.getParameter("changeUserStatus").equalsIgnoreCase("1")) {

                    chu.setStatus(request.getParameter("changeUserStatus"));
                    msg = "User Activated";
                    color = "#009900";

                }
                if (request.getParameter("changeUserStatus").equalsIgnoreCase("0")) {

                    chu.setStatus(request.getParameter("changeUserStatus"));
                    msg = "User De-activated";
                    color = "red";
                }

                s.update(chu);
                s.flush();
                s.beginTransaction().commit();

                out.write("<div class=\"modal fade\" id=\"myModal\" role=\"dialog\">");
                out.write("<div class=\"modal-dialog  modal-open\">");
                out.write("<div class=\"modal-content\">");
                out.write("<div class=\"modal-header\">");
                out.write("<h4 class=\"modal-title\"> &nbsp;Message &nbsp; </h4><span  class=\"glyphicon glyphicon-envelope\" aria-hidden=\"true\"></span>");
                out.write("</div>");
                out.write("<div class=\"modal-body\">");
                out.write("<span style=\"color: " + color + "\" class=\"glyphicon glyphicon-ok\" aria-hidden=\"true\"></span><strong><p style=\"color: " + color + "\">" + msg + "</p></strong>");
                out.write("</div>");
                out.write("<div class=\"modal-footer\">");
                out.write("</div>");
                out.write("</div>");
                out.write(" </div>");
                out.write("</div>");

            }

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

}
