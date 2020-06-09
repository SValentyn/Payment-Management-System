package com.system.persistence.dao;

import com.system.entity.LogEntry;

import java.util.List;

/**
 * The interface provides methods for retrieving data for an LogEntry entity
 *
 * @author Syniuk Valentyn
 */
public interface ActionLogDao {

    /**
     * Inserts new entity into database
     */
    int create(LogEntry entity);

    /**
     * Clear action log by user id
     */
    int clear(Integer userId);

    /**
     * Retrieves log entry by log entry id
     */
    LogEntry findLogEntryByLogEntryId(Integer logEntryId);

    /**
     * Retrieves log entries by user id
     */
    List<LogEntry> findLogEntriesByUserId(Integer userId);

    /**
     * Searches all log entries by criteria
     */
    List<LogEntry> searchByCriteria(Integer userId, String startDate, String finalDate);

}
