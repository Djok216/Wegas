package BitChess.Models.Clubs;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 20-May-17.
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public class SimpleStatisticModel {
    private String clubName;
    private Integer statistic;

    public SimpleStatisticModel() {
        this.clubName = null;
        this.statistic = null;
    }

    public SimpleStatisticModel(String clubName, Integer statistic) {
        this.clubName = clubName;
        this.statistic = statistic;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public Integer getStatistic() {
        return statistic;
    }

    public void setStatistic(Integer statistic) {
        this.statistic = statistic;
    }

    @JsonIgnore
    public Boolean isValid() {
        if(clubName == null || statistic == null) return false;
        return true;
    }
}
