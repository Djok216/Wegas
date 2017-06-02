package BitChess.Models;

/**
 * Created by Tamara on 01.06.2017.
 */
public class TokenModel
{
    private String token;
    private boolean valid;

    public TokenModel(){
        this.valid=true;
    }

    public TokenModel(String token){
        this.token=token;
        this.valid=true;
    }

    public void setToken(String token){ this.token = token; this.valid=true; }
    public String getToken() { return token; }
    public void  setValid(Boolean valid) { this.valid = valid; }
    public boolean getValid() { return this.valid; }
}
