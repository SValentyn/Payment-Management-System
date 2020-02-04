package com.system.entity;

public class Letter {

    private static final long serialVersionUID = 1L;

    private Integer letterId;
    private Integer userId;
    private String typeQuestion;
    private String description;
    private String date;

    public Letter() {
    }

    public Integer getLetterId() {
        return letterId;
    }

    public void setLetterId(Integer letterId) {
        this.letterId = letterId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getTypeQuestion() {
        return typeQuestion;
    }

    public void setTypeQuestion(String typeQuestion) {
        this.typeQuestion = typeQuestion;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((letterId == null) ? 0 : letterId.hashCode());
        result = prime * result + ((userId == null) ? 0 : userId.hashCode());
        result = prime * result + ((typeQuestion == null) ? 0 : typeQuestion.hashCode());
        result = prime * result + ((description == null) ? 0 : description.hashCode());
        result = prime * result + ((date == null) ? 0 : date.hashCode());
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

        Letter other = (Letter) obj;

        if (letterId == null) {
            if (other.letterId != null)
                return false;
        } else if (!letterId.equals(other.letterId))
            return false;

        if (userId == null) {
            if (other.userId != null)
                return false;
        } else if (!userId.equals(other.userId))
            return false;

        if (typeQuestion == null) {
            if (other.typeQuestion != null)
                return false;
        } else if (!typeQuestion.equals(other.typeQuestion))
            return false;

        if (description == null) {
            if (other.description != null)
                return false;
        } else if (!description.equals(other.description))
            return false;

        if (date != null) {
            return date.equals(other.date);
        } else {
            return other.date == null;
        }
    }

    @Override
    public String toString() {
        return "Letter [letterId=" + letterId +
                ", userId=" + userId +
                ", typeQuestion=" + typeQuestion +
                ", description=" + description +
                ", date=" + date + "]";
    }

}
