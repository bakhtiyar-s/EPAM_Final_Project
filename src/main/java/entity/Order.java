package entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Objects;

public class Order {
    private int orderId;
    private int userId;
    private int addressId;
    private LocalDateTime orderTime;
    private LocalTime deliverByTime;
    private Order.Status orderStatus;
    private Order.PaymentType paymentType;
    private BigDecimal totalPrice;
    private String comment;

    public Order() {
    }

    public Order(int userId, int addressId, LocalDateTime orderTime, LocalTime deliverByTime, Status orderStatus, PaymentType paymentType, BigDecimal totalPrice, String comment) {
        this.userId = userId;
        this.addressId = addressId;
        this.orderTime = orderTime;
        this.deliverByTime = deliverByTime;
        this.orderStatus = orderStatus;
        this.paymentType = paymentType;
        this.totalPrice = totalPrice;
        this.comment = comment;
    }

    public enum Status {
        PENDING, COMPLETED, CANCELLED
    }

    public enum PaymentType {
        CARD, CASH, BITCOIN
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public LocalDateTime getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(LocalDateTime orderTime) {
        this.orderTime = orderTime;
    }

    public LocalTime getDeliverByTime() {
        return deliverByTime;
    }

    public void setDeliverByTime(LocalTime deliverByTime) {
        this.deliverByTime = deliverByTime;
    }

    public Status getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(Status orderStatus) {
        this.orderStatus = orderStatus;
    }

    public PaymentType getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(PaymentType paymentType) {
        this.paymentType = paymentType;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Order order = (Order) o;
        return orderId == order.orderId &&
                userId == order.userId &&
                addressId == order.addressId &&
                orderTime.equals(order.orderTime) &&
                deliverByTime.equals(order.deliverByTime) &&
                orderStatus == order.orderStatus &&
                paymentType == order.paymentType &&
                totalPrice.equals(order.totalPrice) &&
                Objects.equals(comment, order.comment);
    }

    @Override
    public int hashCode() {
        return Objects.hash(orderId, userId, addressId, orderTime, deliverByTime, orderStatus, paymentType, totalPrice, comment);
    }
}
