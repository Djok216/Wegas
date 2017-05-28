package BitChess.Models.Friends;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 28-May-17.
 */
public class FriendshipModel {
    private Integer firstPlayerId, secondPlayerId;

    public FriendshipModel() {
    }

    public FriendshipModel(Integer firstPlayerId, Integer secondPlayerId) {
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
        return !(getSecondPlayerId()==null || getSecondPlayerId()==null);
    }
}
