package BitChess.Models;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 09-May-17.
 */
public class RegisterModel {
    private String username, password, email;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @JsonIgnore
    public Boolean isValid() {
        return !(getUsername() == null || getPassword() == null || getEmail() == null ||
                getUsername().isEmpty() || getPassword().isEmpty() || getEmail().isEmpty());
    }
}
