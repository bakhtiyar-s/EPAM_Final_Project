package dao;

import connectionpool.ConnectionPool;
import connectionpool.ProxyConnection;
import entity.Address;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class AddressDAO extends BaseDAO {
    private static final String SQL_SELECT_ALL_ADDRESSES_BY_USER_ID =
            "SELECT * FROM FoodStore.Address WHERE userid = ?;";

    private static final String SQL_INSERT_NEW_ADDRESS =
            "INSERT INTO FoodStore.Address (addressline1, addressline2, comment, userid) VALUES (?, ?, ?, ?);";

    public void create(Address address) throws SQLException {
        ProxyConnection connection = ConnectionPool.getInstance().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(SQL_INSERT_NEW_ADDRESS, Statement.RETURN_GENERATED_KEYS);
        preparedStatement.setString(1, address.getAddressLine1());
        preparedStatement.setString(2, address.getAddressLine2());
        preparedStatement.setString(3, address.getComment());
        preparedStatement.setInt(4,address.getUserId());
        preparedStatement.executeUpdate();
        ResultSet rs = preparedStatement.getGeneratedKeys();
        if (rs.next()) {
            address.setAddressId(rs.getInt(1));
        }
        releaseConnection(connection);
    }

    public List<Address> findAddressById(int userId) throws SQLException {
        List<Address> addresses = new ArrayList<>();
        ProxyConnection connection = ConnectionPool.getInstance().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(SQL_SELECT_ALL_ADDRESSES_BY_USER_ID);
        preparedStatement.setInt(1, userId);
        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()) {
            Address address = buildAddress(rs);
            addresses.add(address);
        }
        releaseConnection(connection);
        return addresses;
    }

    private Address buildAddress(ResultSet rs) throws SQLException {

        Address address = new Address();
        address.setAddressId(rs.getInt("id"));
        address.setAddressLine1(rs.getString("addressline1"));
        address.setAddressLine2(rs.getString("addressline2"));
        address.setComment(rs.getString("comment"));
        address.setUserId(rs.getInt("userid"));

        return address;
    }

}
