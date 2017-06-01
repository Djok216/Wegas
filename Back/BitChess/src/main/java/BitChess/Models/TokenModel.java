package BitChess.Models;

/**
 * Created by Tamara on 01.06.2017.
 */
public class TokenModel
{
    private String token;
    public TokenModel(String token){
        this.token=token;
    }

    public void setToken(String token){ this.token = token; }
    public String getToken() { return token; }
}
