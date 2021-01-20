package entity;

public enum UserCategory {
    ADMINISTRATOR(1), REGISTERED_USER(2) ;
    private final int categoryId;

    UserCategory(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getCategoryId() {
        return categoryId;
    }
}
