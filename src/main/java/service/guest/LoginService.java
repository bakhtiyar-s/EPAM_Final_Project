package service.guest;

import dao.AddressDAO;
import dao.UserDAO;
import entity.Address;
import entity.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import service.Service;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class LoginService implements Service {
    private static final Logger LOGGER = LogManager.getLogger(LoginService.class.getName());

    private static final String PARAM_EMAIL = "email";
    private static final String PARAM_PASSWORD = "password";
    private static final String LOGIN_FAILED = "loginFailed";
    private static final String ADDRESSES = "addresses";
    private static final String USER = "user";
    private static final String IS_LOGIN = "isLogin";
    private static final String USER_CATEGORY = "userCategory";

    private final UserDAO userDAO = new UserDAO();
    private final AddressDAO addressDAO = new AddressDAO();

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        String email = req.getParameter(PARAM_EMAIL).toLowerCase();
        String password = req.getParameter(PARAM_PASSWORD);
        User user = null;
        try {
            user = userDAO.findUserByEmailAndPass(email,password);
        } catch (SQLException e) {
            LOGGER.error(e.getMessage(),e);
        }
        if (user == null) {
            req.setAttribute(LOGIN_FAILED, true);
            try {
                req.getRequestDispatcher("/jsp/guest/login.jsp").forward(req, resp);
            } catch (ServletException | IOException e) {
                LOGGER.error(e.getMessage(),e);
            }
        } else {
            List<Address> addresses = null;
            try {
                addresses = addressDAO.findAddressById(user.getUserId());
            } catch (SQLException e) {
                LOGGER.error(e.getMessage(),e);
            }
            req.getSession().setAttribute(ADDRESSES, addresses);
            req.getSession().setAttribute(USER, user);
            req.getSession().setAttribute(IS_LOGIN, true);
            req.getSession().setAttribute(USER_CATEGORY, user.getUserCategory().toString().toLowerCase());
            try {
                resp.sendRedirect("/jsp/main.jsp");
            } catch (IOException e) {
                LOGGER.error(e.getMessage(),e);
            }
        }
    }
}
