package DB;
// Generated May 1, 2017 3:38:53 PM by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * LogintimesHasPage generated by hbm2java
 */
public class LogintimesHasPage  implements java.io.Serializable {


     private Integer idLogintimehasPage;
     private Logintimes logintimes;
     private Page page;
     private Date viewTime;
     private String status;
     private Integer accCount;

    public LogintimesHasPage() {
    }

	
    public LogintimesHasPage(Logintimes logintimes, Page page) {
        this.logintimes = logintimes;
        this.page = page;
    }
    public LogintimesHasPage(Logintimes logintimes, Page page, Date viewTime, String status, Integer accCount) {
       this.logintimes = logintimes;
       this.page = page;
       this.viewTime = viewTime;
       this.status = status;
       this.accCount = accCount;
    }
   
    public Integer getIdLogintimehasPage() {
        return this.idLogintimehasPage;
    }
    
    public void setIdLogintimehasPage(Integer idLogintimehasPage) {
        this.idLogintimehasPage = idLogintimehasPage;
    }
    public Logintimes getLogintimes() {
        return this.logintimes;
    }
    
    public void setLogintimes(Logintimes logintimes) {
        this.logintimes = logintimes;
    }
    public Page getPage() {
        return this.page;
    }
    
    public void setPage(Page page) {
        this.page = page;
    }
    public Date getViewTime() {
        return this.viewTime;
    }
    
    public void setViewTime(Date viewTime) {
        this.viewTime = viewTime;
    }
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    public Integer getAccCount() {
        return this.accCount;
    }
    
    public void setAccCount(Integer accCount) {
        this.accCount = accCount;
    }




}

