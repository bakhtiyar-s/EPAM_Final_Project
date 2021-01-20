package service.menu;

import dao.MenuItemDAO;
import entity.MenuItem;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import service.Service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ShowMenuService implements Service {
    private static final Logger LOGGER = LogManager.getLogger(ShowMenuService.class.getName());
    private static final String STARTER="starters";
    private static final String HOT_MEAL="hotMeals";
    private static final String SOUP="soups";
    private static final String DESSERT="desserts";
    private static final String DRINK="drinks";
    private static final String MENU="menu";
    private static final String CATEGORIES="menuItemCategories";

    MenuItemDAO menuItemDAO = new MenuItemDAO();
    List<MenuItem> starters = null;
    List<MenuItem> hotMeals= null;
    List<MenuItem> soups = null;
    List<MenuItem> desserts = null;
    List<MenuItem> drinks = null;
    List<MenuItem> menuItemList = null;
    List<String> menuItemCategories = null;

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        try {
            starters = menuItemDAO.findAllMenuItemsByCategory(1);
            hotMeals= menuItemDAO.findAllMenuItemsByCategory(2);
            soups = menuItemDAO.findAllMenuItemsByCategory(3);
            desserts = menuItemDAO.findAllMenuItemsByCategory(4);
            drinks = menuItemDAO.findAllMenuItemsByCategory(5);
            menuItemList = menuItemDAO.findAll();
            menuItemCategories = menuItemDAO.findAllMenuItemCategory();
        } catch (SQLException e) {
            LOGGER.error(e.getMessage(),e);
        }
        req.getSession().setAttribute(CATEGORIES, menuItemCategories);
        req.getSession().setAttribute(STARTER, starters);
        req.getSession().setAttribute(HOT_MEAL, hotMeals);
        req.getSession().setAttribute(SOUP, soups);
        req.getSession().setAttribute(DESSERT, desserts);
        req.getSession().setAttribute(DRINK, drinks);
        req.getSession().setAttribute(MENU, menuItemList);

        try {
            resp.sendRedirect("/jsp/menu.jsp");
        } catch (IOException e) {
            LOGGER.error(e.getMessage(),e);
        }
    }
}
