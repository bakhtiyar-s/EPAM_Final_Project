package service.administrator;

import dao.OrderDAO;
import entity.Order;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import service.Service;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class CompleteOrderService implements Service {
    private static final Logger LOGGER = LogManager.getLogger(CompleteOrderService.class.getName());
    OrderDAO orderDAO = new OrderDAO();
    private static final String ORDER_STATUS = "COMPLETED";
    private static final String ORDER_ID = "orderId";
    private static final String ORDER_COMPLETED = "orderCompleted";

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        int orderId = Integer.parseInt(req.getParameter(ORDER_ID));
        try {
            orderDAO.updateOrderStatus(orderId, Order.Status.valueOf(ORDER_STATUS));
            req.getSession().setAttribute(ORDER_COMPLETED, true);
            RequestDispatcher dispatcher = req.getRequestDispatcher("/CafeServlet?service=SHOW_ALL_ORDERS");
            dispatcher.forward(req,resp);
        } catch (SQLException | IOException | ServletException e) {
            LOGGER.error(e.getMessage(),e);
        }
    }
}
