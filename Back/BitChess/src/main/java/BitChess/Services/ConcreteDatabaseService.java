package BitChess.Services;

import BitChess.Models.OneCategory;
import javafx.util.Pair;
import org.springframework.stereotype.Service;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Vector;

import oracle.jdbc.OracleTypes;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 09-May-17.
 */
@Service
public class ConcreteDatabaseService {

    public int test() {
        try {
            ResultSet resultSet = DatabaseConnection.getConnection().createStatement().executeQuery("SELECT count(*) FROM users");
            resultSet.next();
            return resultSet.getInt(1);
        } catch (Exception ex) {
            System.err.println("Error at test query: " + ex.getMessage());
        }
        return -1;
    }

    public int checkUserExists(String nickname) throws SQLException {
        Integer result;
        String plsql = "BEGIN ? := PACKAGE_USERS.EXISTS_USER(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(2, nickname);
        statement.registerOutParameter(1, Types.NUMERIC);
        statement.execute();
        result = statement.getInt(1);
        statement.close();
        return result;
    }

    public String getPassword(String nickname) throws SQLException {
        String result;
        String plsql = "BEGIN ? := PACKAGE_USERS.GET_PASSWORD(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(2, nickname);
        statement.registerOutParameter(1, Types.VARCHAR);
        statement.execute();
        result = statement.getString(1);
        statement.close();
        return result;
    }

    public void register(String username, String password, String email) throws SQLException {
        String plsql = "BEGIN PACKAGE_USERS.INSERT_NEW_REGULAR_USER(?, ?, ?, ?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(1, username);
        statement.setString(2, email);
        statement.setString(3, username);
        statement.setString(4, password);
        statement.execute();
        statement.close();
    }

    public Vector<OneCategory> getAllCategories() throws SQLException {
        Vector<OneCategory> categories = new Vector<>();
        String plsql = "BEGIN ? := PACKAGE_CATEGORY.GET_CATEGORIES; END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.registerOutParameter(1, OracleTypes.CURSOR);
        statement.execute();
        ResultSet resultSet = (ResultSet) statement.getObject(1);
        while (resultSet.next()) {
            categories.add(new OneCategory(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3)));
        }
        resultSet.close();
        statement.close();
        return categories;
    }
}
