package BitChess.Models.Stats;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by CristinaU on 28/05/2017.
 */
public class TopActiveUsersModel {
    ArrayList<OneUserThread> lista;

    public TopActiveUsersModel() {
        lista = new ArrayList<OneUserThread>();
    }

    public List<OneUserThread> getLista() {
        return lista;
    }

    public void addTopUser(String userName, Integer nr) {
        OneUserThread t = new OneUserThread(userName, nr);
        lista.add(t);
    }

    public void emptyList() {
        lista.clear();
    }
}
