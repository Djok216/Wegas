package BitChess.Models.Stats;

/**
 * Created by CristinaU on 28/05/2017.
 */
public class OneUserThread {
    private String user_name;
    private Integer nr;

    public OneUserThread(String name, Integer nr1) {
        user_name = name;
        nr = nr1;
    }
    public String getUser_name() {
        return user_name;
    }

    public Integer getNr() {
        return nr;
    }

    public void setNr(Integer nr) {
        this.nr = nr;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }
}
