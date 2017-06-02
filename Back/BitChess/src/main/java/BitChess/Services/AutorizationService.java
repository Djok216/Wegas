package BitChess.Services;

import org.springframework.stereotype.Service;

import java.sql.SQLException;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 02-Jun-17.
 */
@Service
public class AutorizationService {
    public AutorizationService() {
    }

    public Boolean checkCredentials(ConcreteDatabaseService databaseService, String token) {
        try {
            Integer res = databaseService.checkToken(token);
            if (res == -1 || res == 0)
                return false;
            return true;
        } catch (SQLException sqlEx) {
            return false;
        }
    }
}
