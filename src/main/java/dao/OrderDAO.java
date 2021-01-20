package dao;

import connectionpool.ConnectionPool;
import connectionpool.ProxyConnection;
import entity.MenuItem;
import entity.Order;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class OrderDAO extends BaseDAO {
    private static final String SQL_INSERT_NEW_ORDER =
            "INSERT INTO FoodStore.Order  (customerid, addressid, ordertime, deliverbytime, paymentType, orderstatus, totalprice, comment) VALUES (?, ?, ?, ?, ?::PAYMENT_TYPE, ?::ORDER_STATUS, ?, ?);";
    private static final String SQL_INSERT_NEW_ORDER_DETAIL =
            "INSERT INTO FoodStore.orderDetail  (orderId, menuItemId, quantity, extendedPrice) VALUES (?, ?, ?, ?);";
    private static final String SQL_SELECT_ORDERS_BY_USER_ID =
            "SELECT Id, customerid, addressid, ordertime, deliverbytime, paymenttype, orderstatus, totalprice, comment FROM Foodstore.Order WHERE customerId=? ORDER BY orderTime DESC;";
    private static final String SQL_UPDATE_ORDER_STATUS =
            "UPDATE Foodstore.Order SET orderStatus=?::ORDER_STATUS WHERE id=?";
    private static final String SQL_SELECT_All_ORDERS =
            "SELECT * FROM Foodstore.Order ORDER BY ordertime DESC;";

    public void create(Order order, Map<MenuItem, Integer> cart) throws SQLException {
        ProxyConnection connection = ConnectionPool.getInstance().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(SQL_INSERT_NEW_ORDER, Statement.RETURN_GENERATED_KEYS);
        preparedStatement.setInt(1, order.getUserId());
        preparedStatement.setInt(2, order.getAddressId());
        preparedStatement.setTimestamp(3, Timestamp.valueOf(order.getOrderTime()));
        preparedStatement.setTime(4, Time.valueOf(order.getDeliverByTime()));
        preparedStatement.setString(5, order.getPaymentType().name());
        preparedStatement.setString(6, order.getOrderStatus().name());
        preparedStatement.setBigDecimal(7, order.getTotalPrice());
        preparedStatement.setString(8, order.getComment());
        preparedStatement.executeUpdate();
        ResultSet rs =preparedStatement.getGeneratedKeys();
        if (rs.next()) {
            order.setOrderId(rs.getInt(1));
        }
        releaseConnection(connection);

        for (Map.Entry<MenuItem, Integer> entry : cart.entrySet()) {
            BigDecimal price = entry.getKey().getPrice();
            int qty = entry.getValue();
            BigDecimal extendedPrice = price.multiply(BigDecimal.valueOf(qty));
            connection = ConnectionPool.getInstance().getConnection();
            preparedStatement = connection.prepareStatement(SQL_INSERT_NEW_ORDER_DETAIL);
            preparedStatement.setInt(1, order.getOrderId());
            preparedStatement.setInt(2, entry.getKey().getId());
            preparedStatement.setInt(3, qty);
            preparedStatement.setBigDecimal(4,extendedPrice);
            preparedStatement.executeUpdate();
            releaseConnection(connection);
        }
    }

    public List<Order> findAllOrders() throws SQLException {
        List<Order> orders = new LinkedList<>();
        ProxyConnection connection = ConnectionPool.getInstance().getConnection();
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(SQL_SELECT_All_ORDERS);
        while (resultSet.next()) {
            Order order = buildOrder(resultSet);
            orders.add(order);
        }
        releaseConnection(connection);
        return orders;
    }

    public void updateOrderStatus(int orderId, Order.Status orderStatus) throws SQLException {

        ProxyConnection connection = ConnectionPool.getInstance().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(SQL_UPDATE_ORDER_STATUS);
        preparedStatement.setString(1, orderStatus.name());
        preparedStatement.setInt(2, orderId);
        preparedStatement.executeUpdate();
        releaseConnection(connection);
    }

    public List<Order> findOrdersByUserId(int userId) throws SQLException {

        List<Order> orders = new ArrayList<>();
        ProxyConnection connection = ConnectionPool.getInstance().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(SQL_SELECT_ORDERS_BY_USER_ID);
        preparedStatement.setInt(1, userId);
        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()) {
            Order order = buildOrder(rs);
            orders.add(order);
        }
        releaseConnection(connection);
        return orders;
    }

    private Order buildOrder (ResultSet rs) throws SQLException {

        Order order = new Order();
        order.setOrderId(rs.getInt("id"));
        order.setUserId(rs.getInt("customerId"));
        order.setAddressId(rs.getInt("addressId"));
        order.setOrderTime(LocalDateTime.parse(rs.getTimestamp("orderTime").toString(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSSSSS")));
        order.setDeliverByTime(LocalTime.parse(rs.getTime("deliverByTime").toString()));
        order.setPaymentType(Order.PaymentType.valueOf(rs.getString("paymentType")));
        order.setOrderStatus(Order.Status.valueOf(rs.getString("orderStatus")));
        order.setTotalPrice(rs.getBigDecimal("totalPrice"));
        order.setComment(rs.getString("comment"));

        return order;
    }
}
