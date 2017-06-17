package DB;
// Generated May 1, 2017 3:38:53 PM by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * Feedback generated by hbm2java
 */
public class Feedback  implements java.io.Serializable {


     private int idFeedBack;
     private User user;
     private String message;
     private String status;
     private Date date;

    public Feedback() {
    }

	
    public Feedback(int idFeedBack, User user) {
        this.idFeedBack = idFeedBack;
        this.user = user;
    }
    public Feedback(int idFeedBack, User user, String message, String status, Date date) {
       this.idFeedBack = idFeedBack;
       this.user = user;
       this.message = message;
       this.status = status;
       this.date = date;
    }
   
    public int getIdFeedBack() {
        return this.idFeedBack;
    }
    
    public void setIdFeedBack(int idFeedBack) {
        this.idFeedBack = idFeedBack;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public String getMessage() {
        return this.message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    public Date getDate() {
        return this.date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }




}

