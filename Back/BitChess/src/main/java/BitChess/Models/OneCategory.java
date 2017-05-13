package BitChess.Models;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 13-May-17.
 */
public class OneCategory {
    public Integer id;
    public String name, description;

    public OneCategory(Integer id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }
}