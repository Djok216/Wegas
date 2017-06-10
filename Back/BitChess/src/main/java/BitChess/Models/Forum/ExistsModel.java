package BitChess.Models.Forum;

/**
 * Created by Tamara on 17.05.2017.
 */
public class ExistsModel
{
    private Integer exists;

    public Integer getExists() {
        return exists;
    }
    public ExistsModel(){

    }

    public ExistsModel(int x){
        this.setExists(x);
    }

    public void setExists(Integer exists) {
        this.exists = exists;
    }
}
