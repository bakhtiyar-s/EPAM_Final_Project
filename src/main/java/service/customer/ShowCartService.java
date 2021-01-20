package service.customer;

import entity.MenuItem;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import service.Service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Map;

public class ShowCartService implements Service {
    private static final Logger LOGGER = LogManager.getLogger(ShowCartService.class.getName());
    private static final String CART = "cart";
    private static final String CART_PRICE = "cartPrice";
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        Map<MenuItem, Integer> cart = (Map<MenuItem, Integer>) req.getSession().getAttribute(CART);
        if (cart != null) {
            BigDecimal cartPrice = new BigDecimal(0);
            for (Map.Entry<MenuItem, Integer> entry : cart.entrySet()) {
                BigDecimal price = entry.getKey().getPrice();
                BigDecimal qty = new BigDecimal(entry.getValue());
                cartPrice = cartPrice.add(price.multiply(qty));
            }
            req.getSession().setAttribute(CART_PRICE, cartPrice);
        }

        try {
            resp.sendRedirect("/jsp/customer/cart.jsp");
        } catch (IOException e) {
            LOGGER.error(e.getMessage(),e);
        }
    }
}
