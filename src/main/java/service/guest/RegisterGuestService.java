package service.guest;

import dao.UserDAO;
import entity.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import service.Service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class RegisterGuestService implements Service {
    private static final Logger LOGGER = LogManager.getLogger(RegisterGuestService.class.getName());

    private static final String PARAM_FIRST_NAME = "first_name";
    private static final String PARAM_LAST_NAME = "last_name";
    private static final String PARAM_PHONE = "phoneNumber";
    private static final String PARAM_PASSWORD = "password";
    private static final String PARAM_PASSWORD_REPEAT = "psw-repeat";
    private static final String PARAM_EMAIL = "email";
    private static final String REGISTRATION_SUCCESS = "registrationSuccess";
    private static final String PASSWORDS_DO_NOT_MATCH = "passwordsDoNotMatch";
    private static final String CURRENT_PAGE ="currentPage";
    private final UserDAO userDAO = new UserDAO();

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        String firstName = req.getParameter(PARAM_FIRST_NAME);
        String lastName = req.getParameter(PARAM_LAST_NAME);
        String phoneNumber = req.getParameter(PARAM_PHONE);
        String password = req.getParameter(PARAM_PASSWORD);
        String repeatPassword = req.getParameter(PARAM_PASSWORD_REPEAT);
        String email = req.getParameter(PARAM_EMAIL).toLowerCase();

        if (!password.equals(repeatPassword)) {
            req.getSession().setAttribute(PASSWORDS_DO_NOT_MATCH, true);
            try {
                resp.sendRedirect(req.getSession().getAttribute(CURRENT_PAGE).toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            User user = new User(firstName, lastName, phoneNumber, password, email);
            try {
                userDAO.create(user);
                req.getSession().setAttribute(REGISTRATION_SUCCESS, true);
                resp.sendRedirect("/jsp/guest/login.jsp");
            } catch (SQLException | IOException e) {
                LOGGER.error(e.getMessage(), e);
            }
        }
    }
}
