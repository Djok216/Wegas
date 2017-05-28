package BitChess.Models.Games;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 27-May-17.
 */
public class GameEndedModel {
    private Integer gameId, gameResult;
    private String movements;

    public GameEndedModel() {
    }

    public GameEndedModel(Integer gameId, String movements, Integer gameResult) {
        this.gameId = gameId;
        this.movements = movements;
        this.gameResult = gameResult;
    }

    public Integer getGameId() {
        return gameId;
    }

    public void setGameId(Integer gameId) {
        this.gameId = gameId;
    }

    public String getMovements() {
        return movements;
    }

    public void setMovements(String movements) {
        this.movements = movements;
    }

    public Integer getGameResult() {
        return gameResult;
    }

    public void setGameResult(Integer gameResult) {
        this.gameResult = gameResult;
    }

    @JsonIgnore
    public Boolean isValid() {
        return !(getGameId() == null || getMovements() == null || getGameResult()==null);
    }
}
