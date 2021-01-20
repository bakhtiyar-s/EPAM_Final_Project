package service;

import service.administrator.CompleteOrderService;
import service.administrator.EditMenuItemService;
import service.administrator.ShowAllOrdersService;
import service.administrator.ShowEditMenuItemPageService;
import service.customer.*;
import service.general.ChangeLocaleService;
import service.guest.LoginService;
import service.guest.RegisterGuestService;
import service.menu.ShowMenuService;

public enum ServiceType {
    REGISTER_CLIENT(new RegisterGuestService()),
    LOGIN(new LoginService()),
    LOGOUT(new LogoutService()),
    SHOW_MENU(new ShowMenuService()),
    CHANGE_LOCALE(new ChangeLocaleService()),
    ADD_TO_CART(new AddToCartService()),
    REMOVE_FROM_CART(new RemoveFromCartService()),
    SHOW_CART(new ShowCartService()),
    SHOW_PLACE_ORDER_PAGE(new ShowPlaceOrderPageService()),
    PLACE_ORDER(new PlaceOrderService()),
    SHOW_ORDERS(new ShowOrderHistoryService()),
    CANCEL_ORDER(new CancelOrderService()),
    ORDER_DETAILS(new ShowOrderDetailsService()),
    CHANGE_PASSWORD(new ChangePasswordService()),
    ADD_NEW_ADDRESS(new AddNewAddressService()),
    EDIT_MENU_ITEM_PAGE(new ShowEditMenuItemPageService()),
    EDIT_MENU_ITEM(new EditMenuItemService()),
    SHOW_ALL_ORDERS(new ShowAllOrdersService()),
    COMPLETE_ORDER(new CompleteOrderService());
    private final Service service;

    ServiceType(Service service) {
        this.service = service;
    }

    public Service getService() {
        return service;
    }
}
