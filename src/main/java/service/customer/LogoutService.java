package service.customer;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import service.Service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LogoutService implements Service {
    private static final Logger LOGGER = LogManager.getLogger(LogoutService.class.getName());
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        req.getSession().invalidate();
        try {
            resp.sendRedirect("/jsp/main.jsp");
        } catch (IOException e) {
            LOGGER.error(e.getMessage(),e);
        }
    }
}
