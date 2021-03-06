package BitChess.Models.Forum;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 13-May-17.
 */
public class OneCategory {
    private Integer id, nrThreads;
    private String name, description;

    public OneCategory(Integer id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }
    public OneCategory(Integer id){
        this.id=id;
    }
    public OneCategory(){
    }

    public Integer getId(){return id;}
    public String getName(){return name;}
    public String getDescription(){return description;}

    public void setNrThreads(Integer nrThreads) {
        this.nrThreads = nrThreads;
    }

    public Integer getNrThreads() {
        return nrThreads;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setName(String name) {
        this.name = name;
    }
}