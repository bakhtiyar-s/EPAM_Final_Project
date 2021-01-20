package dao;

import connectionpool.ConnectionPool;
import connectionpool.ProxyConnection;
import entity.User;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends BaseDAO {
    private static final String SQL_INSERT_NEW_USER =
            "INSERT INTO FoodStore.User  (categoryId, firstName, lastName, phoneNum, password, email) VALUES (?, ?, ?, ?, MD5(?), ?);";

    private static final String SQL_SELECT_ALL_USERS =
            "SELECT * FROM FoodStore.User;";

    private static final String SQL_SELECT_USER_BY_EMAIL_AND_PASS =
            "SELECT * FROM FoodStore.User WHERE email = ? AND password = MD5(?);";

    private static final String SQL_CHANGE_USER_PASSWORD =
            "UPDATE Foodstore.User SET password=MD5(?) WHERE id=?;";

    public void create(User user) throws SQLException {
        ProxyConnection connection = ConnectionPool.getInstance().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(SQL_INSERT_NEW_USER, Statement.RETURN_GENERATED_KEYS);
        preparedStatement.setInt(1, user.getUserCategory().getCategoryId());
        preparedStatement.setString(2, user.getFirstName());
        preparedStatement.setString(3, user.getLastName());
        preparedStatement.setString(4, user.getPhoneNumber());
        preparedStatement.setString(5, user.getPassword());
        preparedStatement.setString(6, user.getEmail());
        preparedStatement.executeUpdate();
        ResultSet rs =preparedStatement.getGeneratedKeys();
        if (rs.next()) {
            user.setUserId(rs.getInt(1));
        }
        releaseConnection(connection);
    }

    public List<User> findAll() throws SQLException {
        List<User> users = new ArrayList<>();
        ProxyConnection connection = ConnectionPool.getInstance().getConnection();
        Statement statement = connection.createStatement();
        ResultSet rs = statement.executeQuery(SQL_SELECT_ALL_USERS);
        while (rs.next()) {
            User user = buildUser(rs);
            users.add(user);
        }
        releaseConnection(connection);
        return users;
    }

    public User findUserByEmailAndPass(String email, String password) throws SQLException {

        User user = null;
        ProxyConnection connection = ConnectionPool.getInstance().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(SQL_SELECT_USER_BY_EMAIL_AND_PASS);
        preparedStatement.setString(1, email);
        preparedStatement.setString(2, password);
        ResultSet rs = preparedStatement.executeQuery();
        if (rs.next()) {
            user = buildUser(rs);
        }
        releaseConnection(connection);
        return user;
    }

    public void updatePassword(int userId, String password) throws SQLException {
        ProxyConnection connection = ConnectionPool.getInstance().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(SQL_CHANGE_USER_PASSWORD);
        preparedStatement.setString(1, password);
        preparedStatement.setInt(2, userId);
        preparedStatement.executeUpdate();
        releaseConnection(connection);
    }

    private User buildUser(ResultSet rs) throws SQLException {

        User user = new User();
        user.setUserId(rs.getInt("id"));
        user.setUserCategory(rs.getInt("categoryId"));
        user.setFirstName(rs.getString("firstName"));
        user.setLastName(rs.getString("lastName"));
        user.setPhoneNumber(rs.getString("phoneNum"));
        user.setPassword(rs.getString("password"));
        user.setEmail(rs.getString("email"));

        return user;
    }
}
