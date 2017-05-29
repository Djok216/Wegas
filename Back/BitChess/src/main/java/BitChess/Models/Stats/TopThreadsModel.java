package BitChess.Models.Stats;


import java.util.ArrayList;
import java.util.List;

/**
 * Created by CristinaU on 28/05/2017.
 */
public class TopThreadsModel {
    ArrayList<OneThreadModel> lista;

    public TopThreadsModel() {
        lista = new ArrayList<OneThreadModel>();
    }

    public List<OneThreadModel> getLista() {
        return lista;
    }

    public void addTopThread(String threadName, Integer nr) {
        OneThreadModel t = new OneThreadModel(threadName, nr);
        lista.add(t);
    }

    public void emptyList() {
        lista.clear();
    }
}
