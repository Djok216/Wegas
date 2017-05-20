package BitChess.Models.Clubs;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 20-May-17.
 */
public class SimpleStatisticModel {
    private String club_name;
    private Integer statistic;

    public SimpleStatisticModel() {
        this.club_name = "";
        this.statistic = 0;
    }

    public SimpleStatisticModel(String club_name, Integer statistic) {
        this.club_name = club_name;
        this.statistic = statistic;
    }

    public String getClub_name() {
        return club_name;
    }

    public void setClub_name(String club_name) {
        this.club_name = club_name;
    }

    public Integer getStatistic() {
        return statistic;
    }

    public void setStatistic(Integer statistic) {
        this.statistic = statistic;
    }
}
