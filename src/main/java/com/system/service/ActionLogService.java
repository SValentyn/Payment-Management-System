package com.system.service;

import com.system.entity.LogEntry;
import com.system.persistence.dao.ActionLogDao;
import com.system.persistence.factory.DaoFactory;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

/**
 * Provides service methods for ActionLogDao. Layout between DAO and Command.
 *
 * @author Syniuk Valentyn
 */
public class ActionLogService {

    private static ActionLogService instance = null;
    private final ActionLogDao actionLogDao = DaoFactory.createActionLogDao();

    private ActionLogService() {
    }

    public static synchronized ActionLogService getInstance() {
        if (instance == null) {
            instance = new ActionLogService();
        }
        return instance;
    }

    /**
     * Adds new log entry to the DB
     */
    public int addNewLogEntry(Integer userId, String description) {
        int status = 0;
        if (userId != null && description != null) {
            LogEntry logEntry = new LogEntry();
            logEntry.setUserId(userId);
            logEntry.setDescription(description);
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            formatter.setTimeZone(TimeZone.getTimeZone("UTC"));
            logEntry.setDate(formatter.format(new Date()));
            status = actionLogDao.create(logEntry);
        }
        return status;
    }

    /**
     * Completely clears the user action log
     */
    public int clearActionLog(Integer userId) {
        int status = 0;
        if (userId != null) {
            status = actionLogDao.clear(userId);
        }
        return status;
    }

    /**
     * Finds log entry by log entry id
     */
    public LogEntry findLogEntryByLogEntryId(Integer logEntryId) {
        return actionLogDao.findLogEntryByLogEntryId(logEntryId);
    }

    /**
     * Finds all log entries by user id
     */
    public List<LogEntry> findLogEntriesByUserId(Integer userId) {
        return actionLogDao.findLogEntriesByUserId(userId);
    }

    /**
     * Searches all log entries by criteria
     */
    public List<LogEntry> searchByCriteria(Integer userId, String startDate, String finalDate) {
        return actionLogDao.searchByCriteria(userId, startDate, finalDate);
    }

}
