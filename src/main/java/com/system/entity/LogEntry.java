package com.system.entity;

import java.io.Serializable;

public class LogEntry implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer logEntryId;
    private Integer userId;
    private String description;
    private String date;

    public LogEntry() {
    }

    public Integer getLogEntryId() {
        return logEntryId;
    }

    public void setLogEntryId(Integer logEntryId) {
        this.logEntryId = logEntryId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
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
        result = prime * result + ((logEntryId == null) ? 0 : logEntryId.hashCode());
        result = prime * result + ((userId == null) ? 0 : userId.hashCode());
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

        LogEntry other = (LogEntry) obj;

        if (logEntryId == null) {
            if (other.logEntryId != null)
                return false;
        } else if (!logEntryId.equals(other.logEntryId))
            return false;

        if (userId == null) {
            if (other.userId != null)
                return false;
        } else if (!userId.equals(other.userId))
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
        return "LogEntry [logEntryId=" + logEntryId + ", " +
                "userId=" + userId + ", " +
                "description=" + description + ", " +
                "date=" + date + "]";
    }

}
