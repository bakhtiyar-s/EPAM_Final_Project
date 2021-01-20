package service.customer;

import dao.AddressDAO;
import entity.Address;
import entity.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import service.Service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ShowPlaceOrderPageService implements Service {
    private static final Logger LOGGER = LogManager.getLogger(ShowPlaceOrderPageService.class.getName());
    private static final String USER = "user";
    private static final String ADDRESSES = "addresses";
    private final AddressDAO addressDAO = new AddressDAO();

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        User user = (User) req.getSession().getAttribute(USER);
        List<Address> addresses = null;
        try {
            addresses = addressDAO.findAddressById(user.getUserId());
            req.getSession().setAttribute(ADDRESSES, addresses);
            resp.sendRedirect("/jsp/customer/place_order.jsp");
        } catch (IOException | SQLException e) {
            LOGGER.error(e.getMessage(),e);
        }

    }
}
