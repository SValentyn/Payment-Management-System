package com.system.entity;

import java.io.Serializable;
import java.math.BigDecimal;

public class Payment implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer paymentId;
    private Integer accountId;
    private Boolean isOutgoing;
    private String senderNumber;
    private BigDecimal senderAmount;
    private String senderCurrency;
    private String recipientNumber;
    private BigDecimal recipientAmount;
    private String recipientCurrency;
    private BigDecimal exchangeRate;
    private BigDecimal newBalance;
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

    public Boolean getIsOutgoing() {
        return isOutgoing;
    }

    public void setIsOutgoing(Boolean isOutgoing) {
        this.isOutgoing = isOutgoing;
    }

    public String getSenderNumber() {
        return senderNumber;
    }

    public void setSenderNumber(String senderNumber) {
        this.senderNumber = senderNumber;
    }

    public BigDecimal getSenderAmount() {
        return senderAmount;
    }

    public void setSenderAmount(BigDecimal senderAmount) {
        this.senderAmount = senderAmount;
    }

    public String getSenderCurrency() {
        return senderCurrency;
    }

    public void setSenderCurrency(String senderCurrency) {
        this.senderCurrency = senderCurrency;
    }

    public String getRecipientNumber() {
        return recipientNumber;
    }

    public void setRecipientNumber(String recipientNumber) {
        this.recipientNumber = recipientNumber;
    }

    public BigDecimal getRecipientAmount() {
        return recipientAmount;
    }

    public void setRecipientAmount(BigDecimal recipientAmount) {
        this.recipientAmount = recipientAmount;
    }

    public String getRecipientCurrency() {
        return recipientCurrency;
    }

    public void setRecipientCurrency(String recipientCurrency) {
        this.recipientCurrency = recipientCurrency;
    }

    public BigDecimal getExchangeRate() {
        return exchangeRate;
    }

    public void setExchangeRate(BigDecimal exchangeRate) {
        this.exchangeRate = exchangeRate;
    }

    public BigDecimal getNewBalance() {
        return newBalance;
    }

    public void setNewBalance(BigDecimal newBalance) {
        this.newBalance = newBalance;
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
        result = prime * result + ((isOutgoing == null) ? 0 : isOutgoing.hashCode());
        result = prime * result + ((senderNumber == null) ? 0 : senderNumber.hashCode());
        result = prime * result + ((senderAmount == null) ? 0 : senderAmount.hashCode());
        result = prime * result + ((senderCurrency == null) ? 0 : senderCurrency.hashCode());
        result = prime * result + ((recipientNumber == null) ? 0 : recipientNumber.hashCode());
        result = prime * result + ((recipientAmount == null) ? 0 : recipientAmount.hashCode());
        result = prime * result + ((recipientCurrency == null) ? 0 : recipientCurrency.hashCode());
        result = prime * result + ((exchangeRate == null) ? 0 : exchangeRate.hashCode());
        result = prime * result + ((newBalance == null) ? 0 : newBalance.hashCode());
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

        if (isOutgoing == null) {
            if (other.isOutgoing != null)
                return false;
        } else if (!isOutgoing.equals(other.isOutgoing))
            return false;

        if (senderNumber == null) {
            if (other.senderNumber != null)
                return false;
        } else if (!senderNumber.equals(other.senderNumber))
            return false;

        if (senderAmount == null) {
            if (other.senderAmount != null)
                return false;
        } else if (!senderAmount.equals(other.senderAmount))
            return false;

        if (senderCurrency == null) {
            if (other.senderCurrency != null)
                return false;
        } else if (!senderCurrency.equals(other.senderCurrency))
            return false;

        if (recipientNumber == null) {
            if (other.recipientNumber != null)
                return false;
        } else if (!recipientNumber.equals(other.recipientNumber))
            return false;

        if (recipientAmount == null) {
            if (other.recipientAmount != null)
                return false;
        } else if (!recipientAmount.equals(other.recipientAmount))
            return false;

        if (recipientCurrency == null) {
            if (other.recipientCurrency != null)
                return false;
        } else if (!recipientCurrency.equals(other.recipientCurrency))
            return false;

        if (exchangeRate == null) {
            if (other.exchangeRate != null)
                return false;
        } else if (!exchangeRate.equals(other.exchangeRate))
            return false;

        if (newBalance == null) {
            if (other.newBalance != null)
                return false;
        } else if (!newBalance.equals(other.newBalance))
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
        return "Payment [paymentId=" + paymentId + ", " +
                "accountId=" + accountId + ", " +
                "is_outgoing=" + isOutgoing + ", " +
                "senderNumber=" + senderNumber + ", " +
                "senderAmount=" + senderAmount + ", " +
                "senderCurrency=" + senderCurrency + ", " +
                "recipientNumber=" + recipientNumber + ", " +
                "recipientAmount=" + recipientAmount + ", " +
                "recipientCurrency=" + recipientCurrency + ", " +
                "exchangeRate=" + exchangeRate + ", " +
                "newBalance=" + newBalance + ", " +
                "appointment=" + appointment + ", " +
                "date=" + date + ", " +
                "condition=" + condition + "]";
    }

}
