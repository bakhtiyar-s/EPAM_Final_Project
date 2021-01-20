package entity;

import java.util.Objects;

public class Address {
    private int addressId;
    private String addressLine1;
    private String addressLine2;
    private String comment;
    private int userId;

    public Address(String addressLine1, String addressLine2, String comment, int userId) {
        this.addressLine1 = addressLine1;
        this.addressLine2 = addressLine2;
        this.comment = comment;
        this.userId = userId;
    }

    public Address() {

    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getAddressLine1() {
        return addressLine1;
    }

    public void setAddressLine1(String addressLine1) {
        this.addressLine1 = addressLine1;
    }

    public String getAddressLine2() {
        return addressLine2;
    }

    public void setAddressLine2(String addressLine2) {
        this.addressLine2 = addressLine2;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Address address = (Address) o;
        return addressId == address.addressId &&
                userId == address.userId &&
                addressLine1.equals(address.addressLine1) &&
                Objects.equals(addressLine2, address.addressLine2) &&
                Objects.equals(comment, address.comment);
    }

    @Override
    public int hashCode() {
        return Objects.hash(addressId, addressLine1, addressLine2, comment, userId);
    }

    @Override
    public String toString() {
        return "Address{" +
                "addressId=" + addressId +
                ", addressLine1='" + addressLine1 + '\'' +
                ", addressLine2='" + addressLine2 + '\'' +
                ", comment='" + comment + '\'' +
                ", userId=" + userId +
                '}';
    }
}
