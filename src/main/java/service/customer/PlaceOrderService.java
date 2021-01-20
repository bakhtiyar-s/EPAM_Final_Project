package service.customer;

import dao.AddressDAO;
import dao.OrderDAO;
import entity.Address;
import entity.MenuItem;
import entity.Order;
import entity.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import service.Service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;

public class PlaceOrderService implements Service {
    private static final Logger LOGGER = LogManager.getLogger(PlaceOrderService.class.getName());
    OrderDAO orderDAO = new OrderDAO();
    AddressDAO addressDAO = new AddressDAO();
    private static final String ORDER_STATUS = "PENDING";
    private static final String USER = "user";
    private static final String ADDRESS_ID = "addressId";
    private static final String DELIVERY_TIME = "deliveryTime";
    private static final String PAYMENT_TYPE = "paymentType";
    private static final String CART_PRICE = "cartPrice";
    private static final String COMMENTS = "comments";
    private static final String ORDER_CONFIRMED = "orderConfirmed";
    private static final String LAST_ORDER = "lastOrder";
    private static final String CART = "cart";
    private static final String NEW_ADDRESS = "newAddress";
    private static final String ADDRESS_LINE_1 = "addressLine1";
    private static final String ADDRESS_LINE_2 = "addressLine2";
    private static final String COMMENT = "comment";

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        User user = (User) req.getSession().getAttribute(USER);
        int addressId = 0;
        int userId = user.getUserId();
        String addressIdString = req.getParameter(ADDRESS_ID);
        if (addressIdString.equals(NEW_ADDRESS)) {
            String addressLine1 = req.getParameter(ADDRESS_LINE_1);
            String addressLine2 = req.getParameter(ADDRESS_LINE_2);
            String comment = req.getParameter(COMMENT);
            Address address = new Address(addressLine1, addressLine2, comment, user.getUserId());
            try {
                addressDAO.create(address);
            } catch (SQLException e) {
                LOGGER.error(e.getMessage(),e);
            }
            addressId =address.getAddressId();
        } else {
            addressId = Integer.parseInt(addressIdString);
        }
        LocalDateTime orderTime = LocalDateTime.now();
        LocalTime deliveryByTime = LocalTime.parse(req.getParameter(DELIVERY_TIME));
        String paymentType = req.getParameter(PAYMENT_TYPE);
        BigDecimal totalPrice = (BigDecimal) req.getSession().getAttribute(CART_PRICE);
        String comment = req.getParameter(COMMENTS);

        Order order = new Order(userId,addressId,orderTime,deliveryByTime, Order.Status.valueOf(ORDER_STATUS), Order.PaymentType.valueOf(paymentType.toUpperCase()), totalPrice,comment);
        Map<MenuItem, Integer> cart = (Map<MenuItem, Integer>) req.getSession().getAttribute(CART);
        try {
            orderDAO.create(order, cart);
            req.getSession().setAttribute(ORDER_CONFIRMED, true);
            req.getSession().setAttribute(LAST_ORDER, order);
            cart.clear();
            resp.sendRedirect("/jsp/customer/confirmed_order.jsp");
        } catch (SQLException | IOException e) {
            LOGGER.error(e.getMessage(),e);
        }
    }
}
