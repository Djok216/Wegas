package BitChess.Models;

import java.io.Serializable;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 09-May-17.
 */

public class NicknameModel implements Serializable {
    private String nickname;

    public String getNickname() {
        return nickname;}

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
}
