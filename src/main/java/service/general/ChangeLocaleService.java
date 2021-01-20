package service.general;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import service.Service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ChangeLocaleService implements Service {
    private static final Logger LOGGER = LogManager.getLogger(ChangeLocaleService.class.getName());
    private static final String LANGUAGE = "language";
    private static final String LOCALE = "lang";
    private static final String CURRENT_PAGE = "currentPage";

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        String locale = req.getParameter(LANGUAGE);
        req.getSession().setAttribute(LOCALE, locale);

        try {
            resp.sendRedirect(req.getSession().getAttribute(CURRENT_PAGE).toString());
        } catch (IOException e) {
            LOGGER.error(e.getMessage(),e);
        }
    }
}
