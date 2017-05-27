package BitChess.Models.Games;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 27-May-17.
 */
public class GameIdModel {
    Integer gameId;

    public GameIdModel() {
    }

    public GameIdModel(Integer gameId) {
        this.gameId = gameId;
    }

    public Integer getGameId() {
        return gameId;
    }

    public void setGameId(Integer gameId) {
        this.gameId = gameId;
    }

    @JsonIgnore
    Boolean isValid() {
        return !(getGameId()==null);
    }
}
