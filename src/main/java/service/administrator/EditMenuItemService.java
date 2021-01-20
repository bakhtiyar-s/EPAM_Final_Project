package service.administrator;

import dao.MenuItemDAO;
import entity.MenuItem;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import service.Service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

public class EditMenuItemService implements Service {
    private static final Logger LOGGER = LogManager.getLogger(EditMenuItemService.class.getName());
    private static final String MENU_ITEM = "menuItem";
    private static final String NAME = "name";
    private static final String DESCRIPTION = "description";
    private static final String PRICE = "price";
    private static final String STOP_LOSS = "stopLoss";
    private static final String MENU_ITEM_CHANGED = "menuItemChanged";
    private static final String CURRENT_PAGE = "currentPage";
    MenuItemDAO menuItemDAO = new MenuItemDAO();

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        MenuItem menuItem = (MenuItem) req.getSession().getAttribute(MENU_ITEM);
        String name = req.getParameter(NAME);
        String description = req.getParameter(DESCRIPTION);
        String price = req.getParameter(PRICE);
        String stopLoss = req.getParameter(STOP_LOSS);

        try {
            menuItemDAO.editMenuItem(name, new BigDecimal(price), description, Boolean.valueOf(stopLoss), menuItem.getId());
            menuItem = menuItemDAO.findMenuItemById(menuItem.getId());
            req.getSession().setAttribute(MENU_ITEM, menuItem);
            req.getSession().setAttribute(MENU_ITEM_CHANGED, true);
            resp.sendRedirect(req.getSession().getAttribute(CURRENT_PAGE).toString());
        } catch (SQLException | IOException e) {
            LOGGER.error(e.getMessage(),e);
        }
    }
}
