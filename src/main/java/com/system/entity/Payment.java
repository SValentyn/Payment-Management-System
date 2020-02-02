package com.system.entity;

import java.io.Serializable;
import java.math.BigDecimal;

public class Payment implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer paymentId;
    private Integer accountId;
    private String cardNumber;
    private BigDecimal sum;
    private String appointment;
    private String date;
    private Boolean condition;

    public Payment() {
    }

    public Integer getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(Integer paymentId) {
        this.paymentId = paymentId;
    }

    public Integer getAccountId() {
        return accountId;
    }

    public void setAccountId(Integer accountId) {
        this.accountId = accountId;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public BigDecimal getSum() {
        return sum;
    }

    public void setSum(BigDecimal sum) {
        this.sum = sum;
    }

    public String getAppointment() {
        return appointment;
    }

    public void setAppointment(String appointment) {
        this.appointment = appointment;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public Boolean getCondition() {
        return condition;
    }

    public void setCondition(Boolean condition) {
        this.condition = condition;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((paymentId == null) ? 0 : paymentId.hashCode());
        result = prime * result + ((accountId == null) ? 0 : accountId.hashCode());
        result = prime * result + ((cardNumber == null) ? 0 : cardNumber.hashCode());
        result = prime * result + ((sum == null) ? 0 : sum.hashCode());
        result = prime * result + ((appointment == null) ? 0 : appointment.hashCode());
        result = prime * result + ((date == null) ? 0 : date.hashCode());
        result = prime * result + ((condition == null) ? 0 : condition.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;

        Payment other = (Payment) obj;
        if (paymentId == null) {
            if (other.paymentId != null)
                return false;
        } else if (!paymentId.equals(other.paymentId))
            return false;

        if (accountId == null) {
            if (other.accountId != null)
                return false;
        } else if (!accountId.equals(other.accountId))
            return false;

        if (cardNumber == null) {
            if (other.cardNumber != null)
                return false;
        } else if (!cardNumber.equals(other.cardNumber))
            return false;

        if (sum == null) {
            if (other.sum != null)
                return false;
        } else if (!sum.equals(other.sum))
            return false;

        if (appointment == null) {
            if (other.appointment != null)
                return false;
        } else if (!appointment.equals(other.appointment))
            return false;

        if (date == null) {
            if (other.date != null)
                return false;
        } else if (!date.equals(other.date))
            return false;

        if (condition == null) {
            return other.condition == null;
        } else return condition.equals(other.condition);

    }

    @Override
    public String toString() {
        return "Payment [paymentId=" + paymentId +
                ", accountId=" + accountId +
                ", cardNumber=" + cardNumber +
                ", sum=" + sum +
                ", appointment=" + appointment +
                ", date=" + date +
                ", condition=" + condition + "]";
    }

}
