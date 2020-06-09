package com.system.persistence.dao.impl;

import com.system.entity.LogEntry;
import com.system.persistence.dao.ActionLogDao;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * Realizes methods from ActionLogDao interface
 *
 * @author Syniuk Valentyn
 */
public class ActionLogDaoImpl implements ActionLogDao {

    private static final Logger LOGGER = LogManager.getLogger(ActionLogDaoImpl.class);

    /**
     * SQL queries
     */
    private static final String CREATE_LOG_ENTRY =
            "INSERT INTO action_log(user_id, description, date) " +
                    "VALUES(?, ?, ?)";
    private static final String CLEAR_ACTION_LOG = "DELETE FROM action_log WHERE user_id = ?";
    private static final String FIND_LOG_ENTRY_BY_ID = "SELECT * FROM action_log WHERE log_entry_id = ? ORDER BY date DESC";
    private static final String FIND_LOG_ENTRIES_BY_USER_ID = "SELECT * FROM action_log WHERE user_id = ? ORDER BY date DESC";
    private static final String SEARCH_BY_CRITERIA =
            "SELECT * FROM action_log WHERE user_id = ? AND date BETWEEN " +
                    "STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') AND " +
                    "STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s)') ORDER BY date DESC;";
    private static final String SEARCH_BY_CRITERIA_AND_FINAL_DATE_AS_CURRENT_TIMESTAMP =
            "SELECT * FROM action_log " +
                    "WHERE user_id = ? AND date BETWEEN " +
                    "STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') AND " +
                    "CURRENT_TIMESTAMP() ORDER BY date DESC;";

    private static ActionLogDaoImpl instance = null;
    private final QueryExecutor executor = QueryExecutor.getInstance();

    private ActionLogDaoImpl() {
    }

    public static synchronized ActionLogDaoImpl getInstance() {
        if (instance == null) {
            instance = new ActionLogDaoImpl();
        }
        return instance;
    }

    @Override
    public int create(LogEntry entity) {
        entity.setDescription(StringEscapeUtils.escapeJava(entity.getDescription()));

        Object[] args = {
                entity.getUserId(),
                entity.getDescription(),
                entity.getDate()
        };
        return executor.executeStatement(CREATE_LOG_ENTRY, args);
    }

    @Override
    public int clear(Integer userId) {
        return executor.executeStatement(CLEAR_ACTION_LOG, userId);
    }

    @Override
    public LogEntry findLogEntryByLogEntryId(Integer logEntryId) {
        LogEntry logEntry = new LogEntry();
        try {
            ResultSet rs = executor.executeQuery(FIND_LOG_ENTRY_BY_ID, logEntryId);
            while (rs.next()) {
                logEntry = createEntity(rs);
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return logEntry;
    }

    @Override
    public List<LogEntry> findLogEntriesByUserId(Integer userId) {
        List<LogEntry> logEntries = new ArrayList<>();
        try {
            ResultSet rs = executor.executeQuery(FIND_LOG_ENTRIES_BY_USER_ID, userId);
            while (rs.next()) {
                logEntries.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return logEntries;
    }

    @Override
    public List<LogEntry> searchByCriteria(Integer userId, String startDate, String finalDate) {
        List<LogEntry> logEntries = new ArrayList<>();
        try {
            if (startDate.equals("")) {
                startDate = "01/01/2020 00:00:00";
            } else {
                startDate += " 00:00:00";
            }

            ResultSet rs;
            if (finalDate.equals("")) {
                rs = executor.executeQuery(SEARCH_BY_CRITERIA_AND_FINAL_DATE_AS_CURRENT_TIMESTAMP, userId, startDate);
            } else {
                finalDate += " 23:59:59";
                rs = executor.executeQuery(SEARCH_BY_CRITERIA, userId, startDate, finalDate);
            }

            while (rs.next()) {
                logEntries.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return logEntries;
    }

    /**
     * Creates entity from result set
     */
    private LogEntry createEntity(ResultSet rs) {
        LogEntry logEntry = new LogEntry();
        try {
            logEntry.setLogEntryId(rs.getInt("log_entry_id"));
            logEntry.setUserId(rs.getInt("user_id"));
            logEntry.setDescription(StringEscapeUtils.unescapeJava(rs.getString("description")));
            Timestamp timestamp = rs.getTimestamp("date");
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy, HH:mm:ss");
            logEntry.setDate(formatter.format(timestamp));
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return logEntry;
    }

}
