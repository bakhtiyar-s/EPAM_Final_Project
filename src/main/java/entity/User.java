package entity;

import java.util.Objects;

public class User {
    private int userId;
    private UserCategory userCategory = UserCategory.REGISTERED_USER;
    private String firstName;
    private String lastName;
    private String phoneNumber;
    private String password;
    private String email;

    public User() {
    }

    public User(String firstName, String lastName, String phoneNumber, String password, String email) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.email = email;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public UserCategory getUserCategory() {
        return userCategory;
    }

    public void setUserCategory(int categoryId) {
        switch (categoryId) {
            case 1:
                this.userCategory = UserCategory.ADMINISTRATOR;
                break;
            case 2:
                this.userCategory = UserCategory.REGISTERED_USER;
                break;
        }
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() { return lastName; }

    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return userId == user.userId &&
                userCategory == user.userCategory &&
                firstName.equals(user.firstName) &&
                lastName.equals(user.lastName) &&
                phoneNumber.equals(user.phoneNumber) &&
                password.equals(user.password) &&
                Objects.equals(email, user.email);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, userCategory, firstName, lastName, phoneNumber, password, email);
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", userCategory=" + userCategory +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}
