package entity;

public enum MenuItemCategory {
    STARTER(1),
    HOT_MEAL(2),
    SOUP(3),
    DESSERT(4),
    DRINK(5);

    private final int categoryId;

    MenuItemCategory(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getCategoryId() {
        return categoryId;
    }
}
