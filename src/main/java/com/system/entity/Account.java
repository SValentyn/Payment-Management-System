package com.system.entity;

import java.io.Serializable;
import java.math.BigDecimal;

public class Account implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer accountId;
    private Integer userId;
    private String number;
    private BigDecimal balance;
    private Boolean isBlocked;

    public Account() {
    }

    public Integer getAccountId() {
        return accountId;
    }

    public void setAccountId(Integer accountId) {
        this.accountId = accountId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public BigDecimal getBalance() {
        return balance;
    }

    public void setBalance(BigDecimal balance) {
        this.balance = balance;
    }

    public Boolean getIsBlocked() {
        return isBlocked;
    }

    public void setIsBlocked(Boolean isBlocked) {
        this.isBlocked = isBlocked;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((accountId == null) ? 0 : accountId.hashCode());
        result = prime * result + ((userId == null) ? 0 : userId.hashCode());
        result = prime * result + ((number == null) ? 0 : number.hashCode());
        result = prime * result + ((balance == null) ? 0 : balance.hashCode());
        result = prime * result + ((isBlocked == null) ? 0 : isBlocked.hashCode());
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

        Account other = (Account) obj;
        if (accountId == null) {
            if (other.accountId != null)
                return false;
        } else if (!accountId.equals(other.accountId))
            return false;

        if (userId == null) {
            if (other.userId == null)
                return false;
        } else if (!userId.equals(other.userId))
            return false;

        if (number == null) {
            if (other.number != null)
                return false;
        } else if (!number.equals(other.number))
            return false;

        if (balance == null) {
            if (other.balance != null)
                return false;
        } else if (!balance.equals(other.balance))
            return false;

        if (isBlocked == null) {
            if (other.isBlocked != null)
                return false;
        } else if (!isBlocked.equals(other.isBlocked))
            return false;

        return true;
    }

    @Override
    public String toString() {
        return "Account [accountId=" + accountId +
                ", userId=" + userId +
                ", number=" + number +
                ", balance=" + balance +
                ", isBlocked=" + isBlocked + "]";
    }
}