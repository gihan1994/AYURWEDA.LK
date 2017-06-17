/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DBCON;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author gihanmunasinghe
 */
public class Db_Connection {
    
    private static SessionFactory factory;
      static {
            factory = new Configuration().configure().buildSessionFactory();
      }

      public Session getSession() {
            return factory.openSession();
      }

      public void doWork() {
           Session session = getSession();
           // do work.
           session.close();
      }

     // Call this during shutdown
     public static void close() {
          factory.close();
     }
    
}
