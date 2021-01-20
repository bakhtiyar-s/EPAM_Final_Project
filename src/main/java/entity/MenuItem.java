package entity;

import java.math.BigDecimal;
import java.util.Objects;

public class MenuItem {
    private int id;
    private String name;
    private BigDecimal price;
    private MenuItemCategory category;
    private String description;
    private Boolean stoploss;
    private String imageLocation;

    public MenuItem() {
    }

    public MenuItem(int id, String name, BigDecimal price, MenuItemCategory category, String description, Boolean stoploss, String imageLocation) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.category = category;
        this.description = description;
        this.stoploss = stoploss;
        this.imageLocation = imageLocation;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public MenuItemCategory getCategory() {
        return category;
    }

    public void setCategory(int categoryId) {
        switch (categoryId) {
            case 1:
                this.category = MenuItemCategory.STARTER;
                break;
            case 2:
                this.category = MenuItemCategory.HOT_MEAL;
                break;
            case 3:
                this.category = MenuItemCategory.SOUP;
                break;
            case 4:
                this.category = MenuItemCategory.DESSERT;
                break;
            case 5:
                this.category = MenuItemCategory.DRINK;
                break;
        }
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean getStoploss() {
        return stoploss;
    }

    public void setStoploss(Boolean stoploss) {
        this.stoploss = stoploss;
    }

    public String getImageLocation() {
        return imageLocation;
    }

    public void setImageLocation(String imageLocation) {
        this.imageLocation = imageLocation;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MenuItem menuItem = (MenuItem) o;
        return id == menuItem.id &&
                name.equals(menuItem.name) &&
                price.equals(menuItem.price);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, price);
    }

    @Override
    public String toString() {
        return "MenuItem{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", category=" + category +
                ", description='" + description + '\'' +
                ", stoploss=" + stoploss +
                ", imageLocation='" + imageLocation + '\'' +
                '}';
    }
}
