package BitChess.Services;

import org.springframework.stereotype.Service;

import java.sql.SQLException;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 09-May-17.
 */
public interface DatabaseService {
    int test();
    int checkUserExists(String nickname) throws SQLException;
    String getPassword(String nickname) throws SQLException;
    void register(String username, String password, String email) throws SQLException;
}
