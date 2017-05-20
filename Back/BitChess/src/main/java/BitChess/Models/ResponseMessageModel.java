package BitChess.Models;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 09-May-17.
 */
public class ResponseMessageModel {
    private String responseMessage;

    public ResponseMessageModel(String responseMessage) {
        this.responseMessage = responseMessage;
    }

    public String getResponseMessage() {
        return responseMessage;
    }

    public void setResponseMessage(String responseMessage) {
        this.responseMessage = responseMessage;
    }

    @JsonIgnore
    public Boolean isValid() {
        if(getResponseMessage() == null) return false;
        return true;
    }
}
