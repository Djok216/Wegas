package BitChess.Models.Stats;

/**
 * Created by CristinaU on 28/05/2017.
 */
public class OneCategoryStats {
    private String catName;
    private Integer nr_threads;

    public OneCategoryStats(String name, Integer nr) {
        catName = name;
        nr_threads = nr;
    }
    public Integer getNr_threads() {
        return nr_threads;
    }

    public String getCatName() {
        return catName;
    }

    public void setCatName(String catName) {
        this.catName = catName;
    }

    public void setNr_threads(Integer nr_threads) {
        this.nr_threads = nr_threads;
    }
}
