package com.system.listener;

import com.system.entity.LogEntry;
import com.system.entity.User;
import com.system.service.ActionLogService;
import org.apache.log4j.Logger;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.List;

@WebListener
public class SessionListener implements HttpSessionListener {

    private static final Logger LOGGER = Logger.getLogger(SessionListener.class);

    @Override
    public void sessionCreated(HttpSessionEvent sessionEvent) {
        HttpSession session = sessionEvent.getSession();
        session.setMaxInactiveInterval(600); // 10 min
        LOGGER.info("Session started! JSESSIONID = " + session.getId());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent sessionEvent) {
        HttpSession session = sessionEvent.getSession();
        LOGGER.info("Session ended! JSESSIONID = " + session.getId());

        // If the timeout on the site has expired, and the user has not taken any action
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser != null) {
            List<LogEntry> logEntries = ActionLogService.getInstance().findLogEntriesByUserId(currentUser.getUserId());
            LogEntry logEntry = logEntries.get(0);
            if (!logEntry.getDescription().equalsIgnoreCase("SESSION_ENDED")) {
                ActionLogService.getInstance().addNewLogEntry(currentUser.getUserId(), "SESSION_ENDED");
            }
        }
    }

}
