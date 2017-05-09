package BitChess.Services;

import org.springframework.stereotype.Service;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 09-May-17.
 */
@Service
public class ConcreteDatabaseService implements DatabaseService {

    public int test() {
        try {
            ResultSet resultSet = DatabaseConnection.getConnection().createStatement().executeQuery("select count(*) from users");
            resultSet.next();
            return resultSet.getInt(1);
        } catch (Exception ex) {
            System.err.println("Error at test query: " + ex.getMessage());
        }
        return -1;
    }

    public int checkUserExists(String nickname) throws SQLException {
        String plsql = "BEGIN ? := PACKAGE_USERS.EXISTS_USER(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(2, nickname);
        statement.registerOutParameter(1, Types.NUMERIC);
        statement.execute();
        return statement.getInt(1);
    }

    public String getPassword(String nickname) throws SQLException {
        String plsql = "BEGIN ? := PACKAGE_USERS.GET_PASSWORD(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(2, nickname);
        statement.registerOutParameter(1, Types.VARCHAR);
        statement.execute();
        return statement.getString(1);
    }


    public void register(String username, String password, String email) throws SQLException
    {
        String plsql = "BEGIN PACKAGE_USERS.INSERT_NEW_USER(?, ?, ?, ?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(1, username);
        statement.setString(2, email);
        statement.setString(3, username);
        statement.setString(4, password);
        statement.execute();
    }
}
