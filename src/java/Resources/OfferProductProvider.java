/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Resources;

import Connection.NewHibernateUtil;
import DB.Productoffers;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;

/**
 *
 * @author Gihan
 */
public class OfferProductProvider {

  

    public void checkDateAvailable() {
        Session offerProvidersestion = NewHibernateUtil.getSessionFactory().openSession();
    Date td = new Date();  
        List<Productoffers> pol = offerProvidersestion.createCriteria(DB.Productoffers.class).list();
        for (Productoffers po : pol) {
            try {
                if (new SimpleDateFormat("yyyy-MM-dd").parse(new SimpleDateFormat("yyyy-MM-dd").format(po.getDateofview())).before(td)
                        &&!(td.equals(po.getDateofview()))) {
                    po.setDatestatus("0");
                    offerProvidersestion.update(po);
                    offerProvidersestion.flush();
                    offerProvidersestion.beginTransaction().commit();
                    
                }
            } catch (ParseException ex) {
                System.out.println(ex);
            }

        }

    }

    public static void main(String[] args) {
     
    }

}
