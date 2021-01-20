package service.administrator;

import dao.OrderDAO;
import entity.Order;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import service.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ShowAllOrdersService implements Service {
    private static final Logger LOGGER = LogManager.getLogger(ShowAllOrdersService.class.getName());
    OrderDAO orderDAO = new OrderDAO();

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        try {
            List<Order> orders = orderDAO.findAllOrders();
            req.getSession().setAttribute("orders", orders);
            resp.sendRedirect("/jsp/administrator/orders.jsp");
        } catch (IOException | SQLException e) {
            LOGGER.error(e.getMessage(),e);
        }
    }
}
