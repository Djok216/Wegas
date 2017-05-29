package BitChess.Models.Stats;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by CristinaU on 29/05/2017.
 */
public class CategoriesSModel {
    ArrayList<OneCategoryStats> lista;

    public CategoriesSModel() {
        lista = new ArrayList<OneCategoryStats>();
    }

    public ArrayList<OneCategoryStats> getLista() {
        return lista;
    }

    public void addCategoryStats(String cName, Integer nr) {
        OneCategoryStats t = new OneCategoryStats(cName, nr);
        lista.add(t);
    }

    public void emptyList() {
        lista.clear();
    }
}
