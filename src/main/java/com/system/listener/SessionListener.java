package com.system.listener;

import com.system.entity.User;
import com.system.service.ActionLogService;
import org.apache.log4j.Logger;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.sql.SQLException;

@WebListener
public class SessionListener implements HttpSessionListener {

    private static final Logger LOGGER = Logger.getLogger(SessionListener.class);

    @Override
    public void sessionCreated(HttpSessionEvent sessionEvent) {
        HttpSession session = sessionEvent.getSession();
        session.setMaxInactiveInterval(600); // 10 min
        LOGGER.info("Session with id = " + session.getId() + " started.");
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent sessionEvent) {
        HttpSession session = sessionEvent.getSession();
        LOGGER.info("Session with id = " + session.getId() + " ended.");

        // If the timeout on the site has expired and the user has not taken any action
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser != null) {
            try {
                ActionLogService.getInstance().addNewLogEntry(currentUser.getUserId(), "SESSION_ENDED");
                session.invalidate();
            } catch (SQLException e) {
                LOGGER.error("Failed to get information from the database. Check connection. Exception:" + e.getMessage());
            }
        }
    }

}
