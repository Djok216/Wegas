package BitChess.Models.Clubs;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 20-May-17.
 */
public class ClubModel {
    private String clubName;

    public ClubModel() {
        clubName = null;
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

    @JsonIgnore
    public Boolean isValid() {
        return !(getClubName() == null);
    }
}
