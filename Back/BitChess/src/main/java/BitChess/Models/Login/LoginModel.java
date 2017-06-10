package BitChess.Models.Login;

import com.fasterxml.jackson.annotation.JsonIgnore;

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

    @JsonIgnore
    public Boolean isValid() {
        return !(getUsername() == null || getPassword() == null ||
                getPassword().isEmpty() || getUsername().isEmpty());
    }
}
