package BitChess.Models.Forum;

/**
 * Created by Tamara on 28.05.2017.
 */
public class OnePost {
    private Integer id, userId, statusId, threadId;
    private String content, created_at, userName;

    public OnePost(Integer id, String content, Integer userId, Integer statusId, Integer threadId, String created_at) {
        this.id = id;
        this.userId = userId;
        this.statusId = statusId;
        this.threadId = threadId;
        this.content = content;
        this.created_at = created_at;
    }

    public OnePost(){
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserName() {
        return userName;
    }

    public Integer getId(){ return id; }
    public String getContent(){ return content; }
    public Integer getUserId(){ return userId; }
    public Integer getStatusId() { return statusId; }
    public Integer getThreadId() { return  threadId; }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setThreadId(Integer threadId) { this.threadId = threadId; }

    public void setStatusId(Integer statusId) { this.statusId = statusId; }

    public void setUserId(Integer userId) { this.userId = userId; }

    public void setContent(String content) {
        this.content = content;
    }
}
