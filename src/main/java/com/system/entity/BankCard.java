package com.system.entity;

import java.io.Serializable;

public class BankCard implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer cardId;
    private Integer accountId;
    private String number;
    private String CVV;
    private String validity;
    private Boolean isActive;

    public BankCard() {
    }

    public Integer getCardId() {
        return cardId;
    }

    public void setCardId(Integer cardId) {
        this.cardId = cardId;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getCVV() {
        return CVV;
    }

    public void setCVV(String CVV) {
        this.CVV = CVV;
    }

    public String getValidity() {
        return validity;
    }

    public void setValidity(String validity) {
        this.validity = validity;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((cardId == null) ? 0 : cardId.hashCode());
        result = prime * result + ((accountId == null) ? 0 : accountId.hashCode());
        result = prime * result + ((number == null) ? 0 : number.hashCode());
        result = prime * result + ((CVV == null) ? 0 : CVV.hashCode());
        result = prime * result + ((validity == null) ? 0 : validity.hashCode());
        result = prime * result + ((isActive == null) ? 0 : isActive.hashCode());
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

        BankCard other = (BankCard) obj;

        if (cardId == null) {
            if (other.cardId != null)
                return false;
        } else if (!cardId.equals(other.cardId))
            return false;

        if (accountId == null) {
            if (other.accountId != null)
                return false;
        } else if (!accountId.equals(other.accountId))
            return false;

        if (number == null) {
            if (other.number != null)
                return false;
        } else if (!number.equals(other.number))
            return false;

        if (CVV == null) {
            if (other.CVV != null)
                return false;
        } else if (!CVV.equals(other.CVV))
            return false;

        if (validity == null) {
            if (other.validity != null)
                return false;
        } else if (!validity.equals(other.validity))
            return false;

        if (isActive == null) {
            return other.isActive == null;
        } else return isActive.equals(other.isActive);

    }

    @Override
    public String toString() {
        return "CreditCard [cardId=" + cardId +
                ", accountId=" + accountId +
                ", number=" + number +
                ", CVV=" + CVV +
                ", validity=" + validity +
                ", isActive=" + isActive + "]";
    }

}
