package BitChess.Models.Games;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 27-May-17.
 */
public class GameStartedModel {
    private Integer firstPlayerId, secondPlayerId;

    public GameStartedModel() {
    }

    public GameStartedModel(Integer firstPlayerId, Integer secondPlayerId) {
        this.firstPlayerId = firstPlayerId;
        this.secondPlayerId = secondPlayerId;
    }

    public Integer getFirstPlayerId() {
        return firstPlayerId;
    }

    public void setFirstPlayerId(Integer firstPlayerId) {
        this.firstPlayerId = firstPlayerId;
    }

    public Integer getSecondPlayerId() {
        return secondPlayerId;
    }

    public void setSecondPlayerId(Integer secondPlayerId) {
        this.secondPlayerId = secondPlayerId;
    }

    @JsonIgnore
    public Boolean isValid() {
        return !(getFirstPlayerId() == null || getSecondPlayerId() == null);
    }
}
