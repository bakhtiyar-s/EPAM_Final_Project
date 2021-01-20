package service.administrator;

import dao.MenuItemDAO;
import entity.MenuItem;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import service.Service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class ShowEditMenuItemPageService implements Service {
    private static final Logger LOGGER = LogManager.getLogger(ShowEditMenuItemPageService.class.getName());
    private static final String MENU_ITEM_ID = "menuItemId";
    private static final String MENU_ITEM = "menuItem";
    MenuItemDAO menuItemDAO = new MenuItemDAO();

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        int menuItemId = Integer.parseInt(req.getParameter(MENU_ITEM_ID));
        MenuItem menuItem = null;
        try {
            menuItem = menuItemDAO.findMenuItemById(menuItemId);
            req.getSession().setAttribute(MENU_ITEM, menuItem);
            resp.sendRedirect("/jsp/administrator/edit_menu_item.jsp");
        } catch (SQLException | IOException e) {
            LOGGER.error(e.getMessage(),e);
        }

    }
}
