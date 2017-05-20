package BitChess.Models.Clubs;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 20-May-17.
 */
public class ClubModel {
    private String clubName;

    public ClubModel() {
        clubName = "";
    }

    public ClubModel(String clubName) {
        this.clubName = clubName;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }
}
