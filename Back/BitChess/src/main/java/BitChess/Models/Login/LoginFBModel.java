package BitChess.Models.Login;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 10-Jun-17.
 */
public class LoginFBModel {
    String facebookId, email, name;

    public LoginFBModel() {}

    public LoginFBModel(String facebookId, String email, String name) {
        this.facebookId = facebookId;
        this.email = email;
        this.name = name;
    }

    public String getFacebookId() {
        return facebookId;
    }

    public void setFacebookId(String facebookId) {
        this.facebookId = facebookId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @JsonIgnore
    public Boolean isValid() {
        return !(
                getFacebookId() == null || getEmail() == null || getName() == null ||
                        getFacebookId().isEmpty() || getEmail().isEmpty() || getName().isEmpty()
        );
    }
}
