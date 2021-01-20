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

public class AddNewAddressService implements Service {
    private static final Logger LOGGER = LogManager.getLogger(AddNewAddressService.class.getName());
    AddressDAO addressDAO = new AddressDAO();
    private static final String ADDRESS_LINE_1 = "addressLine1";
    private static final String ADDRESS_LINE_2 = "addressLine2";
    private static final String COMMENT = "comment";
    private static final String USER = "user";
    private static final String USER_ADDRESSES = "addresses";

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        String addressLine1 = req.getParameter(ADDRESS_LINE_1);
        String addressLine2 = req.getParameter(ADDRESS_LINE_2);
        String comment = req.getParameter(COMMENT);
        User user = (User) req.getSession().getAttribute(USER);
        int userId = user.getUserId();

        Address address = new Address(addressLine1, addressLine2, comment, userId);
        try {
            addressDAO.create(address);
            List<Address> addresses = addressDAO.findAddressById(userId);
            req.getSession().setAttribute(USER_ADDRESSES, addresses);
            resp.sendRedirect("/jsp/customer/address.jsp");
        } catch (SQLException | IOException e) {
            LOGGER.error(e.getMessage(),e);
        }

    }
}
