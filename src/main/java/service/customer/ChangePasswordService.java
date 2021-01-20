package service.customer;

import dao.UserDAO;
import entity.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import service.Service;
import service.general.ChangeLocaleService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class ChangePasswordService implements Service {
    private static final Logger LOGGER = LogManager.getLogger(ChangePasswordService.class.getName());
    private static final String USER = "user";
    private static final String NEW_PASSWORD = "newPassword";
    private static final String REPEAT_PASSWORD = "repeatPassword";
    private static final String PASSWORD_CHANGED = "passwordChanged";
    private static final String PASSWORDS_DO_NOT_MATCH = "passwordsDoNotMatch";
    UserDAO userDAO = new UserDAO();

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        User user = (User) req.getSession().getAttribute(USER);
        String newPassword = req.getParameter(NEW_PASSWORD);
        String repeatPassword = req.getParameter(REPEAT_PASSWORD);
        if (newPassword.equals(repeatPassword)) {
            try {
                userDAO.updatePassword(user.getUserId(), newPassword);
                req.getSession().setAttribute(PASSWORD_CHANGED, true);
            } catch (SQLException e) {
                LOGGER.error(e.getMessage(),e);
            }
        } else {
            req.getSession().setAttribute(PASSWORDS_DO_NOT_MATCH, true);
        }
        try {
            resp.sendRedirect("/jsp/customer/profile.jsp");
        } catch (IOException e) {
            LOGGER.error(e.getMessage(),e);
        }
    }
}
