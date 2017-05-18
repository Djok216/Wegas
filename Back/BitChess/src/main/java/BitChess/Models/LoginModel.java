package BitChess.Models;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 09-May-17.
 */
public class LoginModel {
    private String username, password;

    public String getUsername() {   return username;    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
