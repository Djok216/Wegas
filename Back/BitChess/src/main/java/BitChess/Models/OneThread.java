package BitChess.Models;

/**
 * Created by Tamara on 18.05.2017.
 */
public class OneThread {
    private Integer id, userId, statusId, categoryId;
    private String name, description, created_at;

    public OneThread(Integer id, Integer userId, Integer statusId, Integer categoryId, String name, String description, String created_at) {
        this.id = id;
        this.userId = userId;
        this.statusId = statusId;
        this.categoryId = categoryId;
        this.name = name;
        this.description = description;
        this.created_at = created_at;
    }

    public OneThread(){
    }

    public Integer getId(){ return id; }
    public String getName(){ return name; }
    public Integer getUserId(){ return userId; }
    public Integer getStatusId() { return statusId; }
    public Integer getCategoryId() { return  categoryId; }
    public String getDescription(){ return description; }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setCategoryId(Integer categoryId) { this.categoryId = categoryId; }

    public void setStatusId(Integer statusId) { this.statusId = statusId; }

    public void setUserId(Integer userId) { this.userId = userId; }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setName(String name) {
        this.name = name;
    }
}
