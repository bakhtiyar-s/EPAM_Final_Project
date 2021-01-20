package service.customer;

import dao.OrderDAO;
import entity.Order;
import entity.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import service.Service;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class CancelOrderService implements Service {
    private static final Logger LOGGER = LogManager.getLogger(CancelOrderService.class.getName());
    OrderDAO orderDAO = new OrderDAO();
    private static final String USER = "user";
    private static final String REGISTERED_USER = "REGISTERED_USER";
    private static final String ORDER_STATUS = "CANCELLED";
    private static final String LAST_ORDER = "lastOrder";
    private static final String ORDER_ID = "orderId";
    private static final String ORDER_CANCELLED = "orderCancelled";
    private static final String ORDER_CONFIRMED = "orderConfirmed";

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        User user = (User) req.getSession().getAttribute(USER);

        if (user.getUserCategory().toString().equals(REGISTERED_USER))  {
            Order lastOrder = (Order) req.getSession().getAttribute(LAST_ORDER);
            try {
                orderDAO.updateOrderStatus(lastOrder.getOrderId(), Order.Status.valueOf(ORDER_STATUS));
                lastOrder.setOrderStatus(Order.Status.valueOf(ORDER_STATUS));
                req.getSession().setAttribute(LAST_ORDER, lastOrder);
                req.getSession().setAttribute(ORDER_CANCELLED, true);
                req.getSession().setAttribute(ORDER_CONFIRMED, false);
                resp.sendRedirect("/jsp/customer/confirmed_order.jsp");
            } catch (SQLException | IOException e) {
                LOGGER.error(e.getMessage(),e);
            }
        } else {
            int orderId = Integer.parseInt(req.getParameter(ORDER_ID));
            try {
                orderDAO.updateOrderStatus(orderId, Order.Status.valueOf(ORDER_STATUS));
                req.getSession().setAttribute(ORDER_CANCELLED, true);
                RequestDispatcher dispatcher = req.getRequestDispatcher("/CafeServlet?service=SHOW_ALL_ORDERS");
                dispatcher.forward(req,resp);
            } catch (SQLException | IOException | ServletException e) {
                LOGGER.error(e.getMessage(),e);
            }
        }


    }
}
