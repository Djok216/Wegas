package BitChess.Models.Clubs;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.*;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 20-May-17.
 */
public class ClubStatisticsModel extends Vector {
    private List<SimpleStatisticModel> stats;

    public ClubStatisticsModel() {
        stats = new Vector<>();
    }

    public ClubStatisticsModel(List<SimpleStatisticModel> stats) {
        this.stats = stats;
    }

    public List<SimpleStatisticModel> getStats() {
        return stats;
    }

    public void setStats(List<SimpleStatisticModel> stats) {
        this.stats = stats;
    }

    @JsonIgnore
    public Boolean isValid() {
        return !(getStats()==null);
    }
}
