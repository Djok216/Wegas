package BitChess.Services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 09-May-17.
 */

public class DatabaseConnection {
    private static Connection connection;

    private DatabaseConnection() {
    }

    public static Connection getConnection() {
        if (connection == null) {
            createConnection();
        }
        return connection;
    }

    private static void createConnection() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "user_chess", "user_chess");

            System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
            System.out.println("  CONNECTED TO ORACLE DATABASE  ");
            System.out.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
        } catch (ClassNotFoundException e) {
            System.err.println("FATAL ERROR: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("DATABASE ERROR: " + e.getMessage());
        }
    }

    public static void resetConnection() {
        connection = null;
    }
}
