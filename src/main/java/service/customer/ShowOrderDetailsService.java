package service.customer;

import dao.MenuItemDAO;
import entity.MenuItem;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import service.Service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

public class ShowOrderDetailsService implements Service {
    private static final Logger LOGGER = LogManager.getLogger(ShowOrderDetailsService.class.getName());
    private static final String ORDER_ID = "orderId";
    private static final String ORDER_DETAILS = "orderDetails";
    MenuItemDAO menuItemDAO = new MenuItemDAO();

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        int orderId = Integer.parseInt(req.getParameter(ORDER_ID)) ;
        Map<MenuItem, Integer> orderDetails = null;
        try {
            orderDetails = menuItemDAO.findMenuItemsByOrderId(orderId);
            req.getSession().setAttribute(ORDER_DETAILS, orderDetails);
            resp.sendRedirect("/jsp/customer/order_details.jsp");
        } catch (SQLException | IOException e) {
            LOGGER.error(e.getMessage(),e);
        }

    }
}
