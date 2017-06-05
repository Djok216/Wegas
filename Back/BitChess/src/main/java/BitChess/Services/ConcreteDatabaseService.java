package BitChess.Services;

import BitChess.Models.Clubs.ClubStatisticsModel;
import BitChess.Models.Clubs.SimpleStatisticModel;
import BitChess.Models.Forum.OneCategory;
import BitChess.Models.Forum.OnePost;
import BitChess.Models.Forum.OneThread;
import BitChess.Models.Friends.FriendshipModel;
import BitChess.Models.Games.GameEndedModel;
import BitChess.Models.Games.GameStartedModel;
import BitChess.Models.Stats.CategoriesSModel;
import BitChess.Models.Stats.TopActiveUsersModel;
import BitChess.Models.Stats.TopThreadsModel;
import BitChess.Models.UserModel;
import oracle.jdbc.OracleTypes;
import org.springframework.stereotype.Service;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Vector;

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
    //authentification region begins
    public Vector<String> findUsers(String stringMatch) throws SQLException {
        Vector<String> users = new Vector<>();
        String plsql = "BEGIN ? := PACKAGE_USERS.GET_USERS_MATCH(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(2, stringMatch);
        statement.registerOutParameter(1, OracleTypes.CURSOR);
        statement.execute();

        ResultSet resultSet = (ResultSet) statement.getObject(1);
        while (resultSet.next())
            users.add(resultSet.getString(1));
        resultSet.close();
        statement.close();
        return users;
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

    public Boolean existsUser(String nickname) throws SQLException {
        Integer result;
        String plsql = "BEGIN ? := PACKAGE_USERS.EXISTS_USER(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(2, nickname);
        statement.registerOutParameter(1, Types.NUMERIC);
        statement.execute();
        result = statement.getInt(1);
        statement.close();
        return result == 1;
    }

    public Boolean existsUser(Integer id) throws SQLException {
        int result;
        String plsql = "BEGIN ? := PACKAGE_USERS.EXISTS_USER(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setInt(2, id);
        statement.registerOutParameter(1, Types.NUMERIC);
        statement.execute();
        result = statement.getInt(1);
        statement.close();
        return result==1;
    }

    public UserModel setUserByNickname(String nickname) throws SQLException {
        String plsql = "BEGIN ? := PACKAGE_USERS.SET_USER_BY_NICKNAME(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        UserModel user = new UserModel();
        statement.setString(2, nickname);
        statement.registerOutParameter(1, OracleTypes.CURSOR);
        statement.execute();
        ResultSet resultSet = (ResultSet) statement.getObject(1);
        while (resultSet.next()) {
            user = new UserModel(resultSet.getInt(1), resultSet.getString(2),
                    resultSet.getString(3), resultSet.getString(4), resultSet.getString(5),
                    resultSet.getString(6), resultSet.getInt(7), resultSet.getInt(8),
                    resultSet.getInt(9),
                    resultSet.getString(10), resultSet.getInt(11), resultSet.getInt(12),
                    resultSet.getString(13));
        }
        resultSet.close();
        statement.close();
        return user;
    }
    public String getNicknameById(int id) throws SQLException {
        String plsql = "BEGIN ? := PACKAGE_USERS.GET_NICKNAME_BY_ID(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setInt(2, id);
        statement.registerOutParameter(1, Types.VARCHAR);
        statement.execute();
        String result = statement.getString(1);
        statement.close();
        return result;
    }

    public void setToken(String nickname, String token) throws SQLException {
        String plsql = "BEGIN PACKAGE_USERS.SET_TOKEN_BY_NICKNAME(?, ?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(1, nickname);
        statement.setString(2, token);
        statement.execute();
        statement.close();
    }

    public Integer logOutUser(String token) throws  SQLException{
        String plsql = " BEGIN  ? := PACKAGE_USERS.LOG_OUT(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(2, token);
        statement.registerOutParameter(1, Types.INTEGER);
        statement.execute();
        Integer result = statement.getInt(1);
        statement.close();
        System.out.println(result);
        return result;
    }
    public Integer checkToken(String token) throws  SQLException{
        String plsql = " BEGIN  ? := PACKAGE_USERS.CHECK_TOKEN(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(2, token);
        statement.registerOutParameter(1, Types.INTEGER);
        statement.execute();
        Integer result = statement.getInt(1);
        statement.close();
        return result;
    }

    //authentifiaction region ends

    //forum region begins
    public int checkCategoryExits(Integer id) throws SQLException { //false if 0
        Integer result;
        String plsql = "BEGIN ? := PACKAGE_CATEGORY.checkCategoryExists(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setInt(2, id);
        statement.registerOutParameter(1, Types.NUMERIC);
        statement.execute();
        result = statement.getInt(1);
        statement.close();
        return result;
    }

    public int checkThreadExits(Integer id) throws SQLException { //false if 0
        Integer result;
        String plsql = "BEGIN ? := PACKAGE_forum.checkThreadExists(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setInt(2, id);
        statement.registerOutParameter(1, Types.NUMERIC);
        statement.execute();
        result = statement.getInt(1);
        statement.close();
        return result;
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

    public Vector<OneThread> getAllThreads() throws SQLException {
        Vector<OneThread> threads = new Vector<>();
        String plsql = "BEGIN ? := PACKAGE_FORUM.GET_THREADS; END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.registerOutParameter(1, OracleTypes.CURSOR);
        statement.execute();
        ResultSet resultSet = (ResultSet) statement.getObject(1);
        while (resultSet.next()) {
            threads.add(new OneThread(resultSet.getInt(1), resultSet.getInt(2),
                    resultSet.getInt(3), resultSet.getInt(4),
                    resultSet.getString(5), resultSet.getString(6), resultSet.getString(7)));
        }
        resultSet.close();
        statement.close();
        return threads;
    }

    public Vector<OneThread> getThreadsByCategory(int category) throws SQLException {
        Vector<OneThread> threads = new Vector<>();
        String plsql = "BEGIN ? := PACKAGE_FORUM.GET_THREADS_BY_Category(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setInt(2, category);
        statement.registerOutParameter(1, OracleTypes.CURSOR);
        statement.execute();
        ResultSet resultSet = (ResultSet) statement.getObject(1);
        while (resultSet.next()) {
            threads.add(new OneThread(resultSet.getInt(1), resultSet.getInt(2),
                    resultSet.getInt(3), resultSet.getInt(4),
                    resultSet.getString(5), resultSet.getString(6), resultSet.getString(7)));
        }
        resultSet.close();
        statement.close();
        return threads;
    }

    public Vector<OneThread> getThreadsByUser(String nickname) throws SQLException {
        Vector<OneThread> threads = new Vector<>();
        String plsql = "BEGIN ? := PACKAGE_FORUM.GET_THREADS_BY_USER(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(2, nickname);
        statement.registerOutParameter(1, OracleTypes.CURSOR);
        statement.execute();
        ResultSet resultSet = (ResultSet) statement.getObject(1);
        while (resultSet.next()) {
            threads.add(new OneThread(resultSet.getInt(1), resultSet.getInt(2),
                    resultSet.getInt(3), resultSet.getInt(4),
                    resultSet.getString(5), resultSet.getString(6), resultSet.getString(7)));
        }
        resultSet.close();
        statement.close();
        return threads;
    }
    public void addThread(OneThread thread) throws SQLException {
        String plsql = "BEGIN PACKAGE_FORUM.INSERT_THREAD(?, ?, ?, ?, ?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(1, thread.getName());
        statement.setString(2, thread.getDescription());
        statement.setInt(3, thread.getUserId());
        statement.setInt(4, thread.getStatusId());
        statement.setInt(5, thread.getCategoryId());
        statement.execute();
        statement.close();
    }
    public void addPost(OnePost post) throws SQLException {
        post.setStatusId(1);
        String plsql = "BEGIN PACKAGE_FORUM.INSERT_POST(?, ?, ?, ?); END;";
        System.out.println("wtf");
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        System.out.println(post.getContent());
        System.out.println(post.getStatusId());
        System.out.println(post.getThreadId());
        System.out.println(post.getUserId());
        statement.setString(1, post.getContent());
        statement.setInt(2, post.getStatusId());
        statement.setInt(3, post.getThreadId());
        statement.setInt(4, post.getUserId());
        statement.execute();
        statement.close();
    }
    public Vector<OnePost> getPostsByThread(int thread) throws SQLException {
        Vector<OnePost> posts = new Vector<>();
        String plsql = "BEGIN ? := PACKAGE_FORUM.GET_POSTS_BY_THREADS(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setInt(2, thread);
        statement.registerOutParameter(1, OracleTypes.CURSOR);
        statement.execute();
        ResultSet resultSet = (ResultSet) statement.getObject(1);
        while (resultSet.next()) {
            posts.add(new OnePost(resultSet.getInt(1), resultSet.getString(2),
                    resultSet.getInt(3), resultSet.getInt(4),
                    resultSet.getInt(5), resultSet.getString(6)));
        }
        resultSet.close();
        statement.close();
        return posts;
    }


    //forum region ends

    //region clubs methods
    public void insertNewClub(String clubName) throws SQLException {
        String plsql = "BEGIN PACKAGE_CLUBS.INSERT_NEW_CLUB(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(1, clubName);
        statement.execute();
        statement.close();
    }

    public void deleteClub(String clubName) throws SQLException {
        String plsql = "BEGIN PACKAGE_CLUBS.DELETE_CLUB(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(1, clubName);
        statement.execute();
        statement.close();
    }

    public boolean existsClub(String clubName) throws SQLException {
        String plsql = "BEGIN ? := PACKAGE_CLUBS.EXISTS_CLUB(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(2, clubName);
        statement.registerOutParameter(1, Types.NUMERIC);
        statement.execute();
        Integer result = statement.getInt(1);
        statement.close();
        if (result == 1) return true;
        return false;
    }

    public boolean isClubMember(String clubName, String userName) throws SQLException {
        String plsql = "BEGIN ? := PACKAGE_CLUBS.IS_MEMBER(?,?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(2, clubName);
        statement.setString(3, userName);
        statement.registerOutParameter(1, Types.NUMERIC);
        statement.execute();
        Integer result = statement.getInt(1);
        statement.close();
        if (result == 1) return true;
        return false;
    }

    public void addClubMember(String clubName, String userName) throws SQLException {
        String plsql = "BEGIN PACKAGE_CLUBS.ADD_MEMBER(?,?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(1, clubName);
        statement.setString(2, userName);
        statement.execute();
        statement.close();
    }

    public void deleteClubMember(String userName) throws SQLException {
        String plsql = "BEGIN PACKAGE_CLUBS.DELETE_MEMBER(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(1, userName);
        statement.execute();
        statement.close();
    }

    public ClubStatisticsModel getGeneralStatistic() throws SQLException {
        ClubStatisticsModel clubStatisticsModel = new ClubStatisticsModel();
        String plsql = "BEGIN ? := PACKAGE_CLUBS.GET_GENERAL_STATISTICS; END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.registerOutParameter(1, OracleTypes.CURSOR);
        statement.execute();

        ResultSet resultSet = (ResultSet) statement.getObject(1);
        while (resultSet.next()) {
            clubStatisticsModel.add(new SimpleStatisticModel(resultSet.getString(1), resultSet.getInt(2)));
        }
        resultSet.close();
        statement.close();
        return clubStatisticsModel;
    }

    public Vector<String> getClubMembers(String clubName) throws SQLException {
        Vector<String> members = new Vector<>();
        String plsql = "BEGIN ? := PACKAGE_CLUBS.GET_CLUB_MEMBERS(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setString(2, clubName);
        statement.registerOutParameter(1, OracleTypes.CURSOR);
        statement.execute();

        ResultSet resultSet = (ResultSet) statement.getObject(1);
        while (resultSet.next()) {
            members.add(resultSet.getString(1));
        }
        resultSet.close();
        statement.close();
        return members;
    }

    public ClubStatisticsModel getClubsByPopularity(Integer topX) throws SQLException {
        ClubStatisticsModel clubStatisticsModel = new ClubStatisticsModel();
        String plsql = "BEGIN ? := PACKAGE_CLUBS.GET_CLUBS_BY_POPULARITY(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setInt(2, topX);
        statement.registerOutParameter(1, OracleTypes.CURSOR);
        statement.execute();

        ResultSet resultSet = (ResultSet) statement.getObject(1);
        while (resultSet.next()) {
            clubStatisticsModel.add(new SimpleStatisticModel(resultSet.getString(1), resultSet.getInt(2)));
        }
        resultSet.close();
        statement.close();
        return clubStatisticsModel;
    }

    public ClubStatisticsModel getClubsByRating(Integer topX) throws SQLException {
        ClubStatisticsModel clubRatingModel = new ClubStatisticsModel();
        String plsql = "BEGIN ? := PACKAGE_CLUBS.GET_CLUBS_BY_RATING(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setInt(2, topX);
        statement.registerOutParameter(1, OracleTypes.CURSOR);
        statement.execute();

        ResultSet resultSet = (ResultSet) statement.getObject(1);
        while (resultSet.next())
            clubRatingModel.add(new SimpleStatisticModel(resultSet.getString(1), resultSet.getInt(2)));
        resultSet.close();
        statement.close();
        return clubRatingModel;
    }
    //endregion


    //region package games
    public Integer addGameStarted(GameStartedModel gameStartedModel) throws SQLException {
        Integer gameId;
        String plsql = "BEGIN ? := PACKAGE_GAMES.ADD_GAME_STARTED(?,?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setInt(2,gameStartedModel.getFirstPlayerId());
        statement.setInt(3, gameStartedModel.getSecondPlayerId());
        statement.registerOutParameter(1, Types.NUMERIC);
        statement.execute();

        gameId = statement.getInt(1);
        statement.close();
        return gameId;
    }

    public void addGameEnded(GameEndedModel gameEndedModel) throws SQLException {
        String plsql = "BEGIN PACKAGE_GAMES.ADD_GAME_ENDED(?,?,?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setInt(1,gameEndedModel.getGameId());
        statement.setString(2,gameEndedModel.getMovements());
        statement.setInt(3,gameEndedModel.getGameResult());
        statement.execute();
        statement.close();
    }

    public Boolean existsGame(Integer id) throws SQLException {
        Integer result;
        String plsql = "BEGIN ? := PACKAGE_GAMES.EXISTS_GAME(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setInt(2, id);
        statement.registerOutParameter(1, Types.NUMERIC);
        statement.execute();
        result = statement.getInt(1);
        statement.close();
        return result==1;
    }
    //endregion

    // region package friends
    public boolean existsFriendship(FriendshipModel friendshipModel) throws SQLException {
        Integer result;
        String plsql = "BEGIN ? := PACKAGE_FRIENDS.CHECH_FRIENDSHIP_EXISTS(?,?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setInt(2, friendshipModel.getFirstPlayerId());
        statement.setInt(3, friendshipModel.getSecondPlayerId());
        statement.registerOutParameter(1, Types.NUMERIC);
        statement.execute();
        result = statement.getInt(1);
        statement.close();
        return result==1;
    }
    public void addFriends(FriendshipModel friendshipModel) throws SQLException {
        Integer result;
        String plsql = "BEGIN PACKAGE_FRIENDS.ADD_FRIENDS(?,?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setInt(1, friendshipModel.getFirstPlayerId());
        statement.setInt(2, friendshipModel.getSecondPlayerId());
        statement.execute();
        statement.close();
    }
    // endregion

    //statistics
    public Integer getNumberOfUsers() throws SQLException {
        Integer result;
        String plsql = "BEGIN ? := PACKAGE_stats_functions.nr_of_users(); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.registerOutParameter(1, Types.NUMERIC);
        statement.execute();
        result = statement.getInt(1);
        statement.close();
        return result;
    }

    public Integer getNumberOfLatestGames(Integer nr_of_days) throws SQLException {
        Integer result;
        String plsql = "BEGIN ? := PACKAGE_stats_functions.nr_of_latest_games(?); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.setInt(2, nr_of_days);
        statement.registerOutParameter(1, Types.NUMERIC);
        statement.execute();
        result = statement.getInt(1);
        statement.close();
        return result;
    }

    public TopThreadsModel getTopDiscussedThreads() throws SQLException {
        TopThreadsModel vector = new TopThreadsModel();
        String plsql = "BEGIN ? := PACKAGE_stats_functions.top_discussed_threads(); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.registerOutParameter(1, OracleTypes.CURSOR);
        statement.execute();

        ResultSet resultSet = (ResultSet) statement.getObject(1);
        while (resultSet.next())
            vector.addTopThread(resultSet.getString(1), resultSet.getInt(2));
        resultSet.close();
        statement.close();

        return vector;
    }

    public TopActiveUsersModel getTopActiveUsers() throws SQLException {
        TopActiveUsersModel vector = new TopActiveUsersModel();
        String plsql = "BEGIN ? := PACKAGE_stats_functions.top_active_users(); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.registerOutParameter(1, OracleTypes.CURSOR);
        statement.execute();

        ResultSet resultSet = (ResultSet) statement.getObject(1);
        while (resultSet.next())
            vector.addTopUser(resultSet.getString(1), resultSet.getInt(2));
        resultSet.close();
        statement.close();

        return vector;
    }

    public CategoriesSModel getThreadsbyCategory() throws SQLException {
        CategoriesSModel vector = new CategoriesSModel();
        String plsql = "BEGIN ? := PACKAGE_stats_functions.nr_posts_by_category(); END;";
        CallableStatement statement = DatabaseConnection.getConnection().prepareCall(plsql);
        statement.registerOutParameter(1, OracleTypes.CURSOR);
        statement.execute();

        ResultSet resultSet = (ResultSet) statement.getObject(1);
        while (resultSet.next())
            vector.addCategoryStats(resultSet.getString(1), resultSet.getInt(2));
        resultSet.close();
        statement.close();

        return vector;
    }

    //end statistics
}
