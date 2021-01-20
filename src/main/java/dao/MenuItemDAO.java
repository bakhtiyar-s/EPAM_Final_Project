package dao;

import connectionpool.ConnectionPool;
import connectionpool.ProxyConnection;
import entity.MenuItem;
import entity.MenuItemCategory;
import entity.User;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MenuItemDAO extends BaseDAO {
    private static final String SQL_INSERT_NEW_MENU_ITEM =
            "INSERT INTO FoodStore.MenuItem (itemname, price, categoryid, description, stoploss, imghref) VALUES (?, ?, ?, ?, ?, ?);";

    private static final String SQL_SELECT_ALL_MENU_ITEMS =
            "SELECT * FROM FoodStore.MenuItem;";

    private static final String SQL_SELECT_ALL_MENU_ITEMS_BY_CATEGORY =
            "SELECT * FROM FoodStore.MenuItem WHERE categoryID = ?;";

    private static final String SQL_SELECT_ALL_MENU_ITEMS_CATEGORY =
            "SELECT * FROM FoodStore.MenuCategory;";

    private static final String SQL_SELECT_MENU_ITEMS_BY_ORDER_ID =
            "SELECT menuItem.id, categoryid, itemName, description, price, stoploss, imghref, quantity FROM Foodstore.menuItem INNER JOIN Foodstore.orderDetail on menuitem.id = menuItemId WHERE orderId = ?;";

    private static final String SQL_SELECT_MENU_ITEM_BY_ID =
            "SELECT * FROM FoodStore.MenuItem WHERE id = ?;";

    private static final String SQL_UPDATE_MENU_ITEM =
            "UPDATE FoodStore.MenuItem SET itemname = ?, price = ?, description = ?, stoploss = ? WHERE id = ?;";

    public void create(MenuItem menuItem) throws SQLException {
        ProxyConnection connection = ConnectionPool.getInstance().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(SQL_INSERT_NEW_MENU_ITEM, Statement.RETURN_GENERATED_KEYS);
        preparedStatement.setString(1, menuItem.getName());
        preparedStatement.setBigDecimal(2, menuItem.getPrice());
        preparedStatement.setInt(3, menuItem.getCategory().getCategoryId());
        preparedStatement.setString(4,menuItem.getDescription());
        preparedStatement.setBoolean(5,menuItem.getStoploss());
        preparedStatement.setString(6, menuItem.getImageLocation());
        preparedStatement.executeUpdate();
        ResultSet rs = preparedStatement.getGeneratedKeys();
        menuItem.setId(rs.getInt(1));
        releaseConnection(connection);
    }

    public List<MenuItem> findAll() throws SQLException {
        List<MenuItem> menuItems = new ArrayList<>();
        ProxyConnection connection = ConnectionPool.getInstance().getConnection();
        Statement statement = connection.createStatement();
        ResultSet rs = statement.executeQuery(SQL_SELECT_ALL_MENU_ITEMS);
        while (rs.next()) {
            MenuItem menuItem = buildMenuItem(rs);
            menuItems.add(menuItem);
        }
        releaseConnection(connection);
        return menuItems;
    }

    public MenuItem findMenuItemById(int menuItemId) throws SQLException {
        MenuItem menuItem = null;
        ProxyConnection connection = ConnectionPool.getInstance().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(SQL_SELECT_MENU_ITEM_BY_ID);
        preparedStatement.setInt(1, menuItemId);
        ResultSet rs = preparedStatement.executeQuery();
        if (rs.next()) {
            menuItem = buildMenuItem(rs);
        }
        releaseConnection(connection);
        return menuItem;
    }

    public List<MenuItem> findAllMenuItemsByCategory(int categoryId) throws SQLException {
        List<MenuItem> menuItems = new ArrayList<>();
        ProxyConnection connection = ConnectionPool.getInstance().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(SQL_SELECT_ALL_MENU_ITEMS_BY_CATEGORY);
        preparedStatement.setInt(1, categoryId);
        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()) {
            MenuItem menuItem = buildMenuItem(rs);
            menuItems.add(menuItem);
        }
        releaseConnection(connection);
        return menuItems;
    }

    public List<String> findAllMenuItemCategory() throws SQLException {
        List<String> menuItemCategories = new ArrayList<>();
        ProxyConnection connection = ConnectionPool.getInstance().getConnection();
        Statement statement = connection.createStatement();
        ResultSet rs = statement.executeQuery(SQL_SELECT_ALL_MENU_ITEMS_CATEGORY);
        while (rs.next()) {
            menuItemCategories.add(rs.getString("categoryName"));
        }
        releaseConnection(connection);
        return menuItemCategories;
    }

    public Map<MenuItem, Integer> findMenuItemsByOrderId(int orderId) throws SQLException {
        Map<MenuItem, Integer> orderDetails = new HashMap<>();
        ProxyConnection connection = ConnectionPool.getInstance().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(SQL_SELECT_MENU_ITEMS_BY_ORDER_ID);
        preparedStatement.setInt(1, orderId);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            MenuItem menuItem = buildMenuItem(resultSet);
            orderDetails.put(menuItem, resultSet.getInt("quantity"));
        }
        releaseConnection(connection);
        return orderDetails;
    }

    public void editMenuItem(String name, BigDecimal price, String description, Boolean stopLoss, int id) throws SQLException {
        ProxyConnection connection = ConnectionPool.getInstance().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(SQL_UPDATE_MENU_ITEM);
        preparedStatement.setString(1, name);
        preparedStatement.setBigDecimal(2, price);
        preparedStatement.setString(3, description);
        preparedStatement.setBoolean(4, stopLoss);
        preparedStatement.setInt(5, id);
        preparedStatement.executeUpdate();
        releaseConnection(connection);
    }

    private MenuItem buildMenuItem(ResultSet rs) throws SQLException {

        MenuItem menuItem = new MenuItem();
        menuItem.setId(rs.getInt("id"));
        menuItem.setCategory(rs.getInt("categoryId"));
        menuItem.setName(rs.getString("itemName"));
        menuItem.setDescription(rs.getString("description"));
        menuItem.setPrice(rs.getBigDecimal("price"));
        menuItem.setStoploss(rs.getBoolean("stopLoss"));
        menuItem.setImageLocation(rs.getString("imgHref"));

        return menuItem;
    }
}
