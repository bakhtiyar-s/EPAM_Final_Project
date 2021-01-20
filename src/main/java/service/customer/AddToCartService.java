package service.customer;

import entity.MenuItem;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import service.Service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AddToCartService implements Service {
    private static final Logger LOGGER = LogManager.getLogger(AddToCartService.class.getName());
    private static final String MENU_ITEM_ID = "menuItemId";
    private static final String QUANTITY = "quantity";
    private static final String ITEM_ADDED = "ItemAddedToCart";
    private static final String CART = "cart";

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        Map<MenuItem, Integer> cart = (Map<MenuItem, Integer>) req.getSession().getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }
        List<MenuItem> menu = (List<MenuItem>) req.getSession().getAttribute("menu");
        int menuItemId = Integer.parseInt(req.getParameter(MENU_ITEM_ID));
        int quantity = Integer.parseInt(req.getParameter(QUANTITY));
        MenuItem menuItemToAdd = menu.stream().filter(menuItem -> menuItemId == menuItem.getId()).findAny().orElse(null);
        if (!cart.containsKey(menuItemToAdd)) {
            cart.put(menuItemToAdd, quantity);
        } else {
            int prevQuantity = cart.get(menuItemToAdd);
            cart.put(menuItemToAdd, prevQuantity + quantity);
        }
        req.getSession().setAttribute(ITEM_ADDED, true);
        req.getSession().setAttribute(CART, cart);
        try {
            resp.sendRedirect("/jsp/menu.jsp");
        } catch (IOException e) {
            LOGGER.error(e.getMessage(),e);
        }
    }
}
