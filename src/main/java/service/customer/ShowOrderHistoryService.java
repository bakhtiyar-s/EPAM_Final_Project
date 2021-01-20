package service.customer;

import dao.OrderDAO;
import entity.Order;
import entity.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import service.Service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ShowOrderHistoryService implements Service {
    private static final Logger LOGGER = LogManager.getLogger(ShowOrderHistoryService.class.getName());
    private static final String USER = "user";
    private static final String ORDER_HISTORY = "orderHistory";
    OrderDAO orderDAO = new OrderDAO();

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        User user = (User) req.getSession().getAttribute(USER);
        int userId = user.getUserId();
        try {
            List<Order> orderHistory = orderDAO.findOrdersByUserId(userId);
            req.getSession().setAttribute(ORDER_HISTORY, orderHistory);
            resp.sendRedirect("/jsp/customer/order_history.jsp");
        } catch (IOException | SQLException e) {
            LOGGER.error(e.getMessage(),e);
        }
    }
}
