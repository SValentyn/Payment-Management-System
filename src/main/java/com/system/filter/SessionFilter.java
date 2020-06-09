package com.system.filter;

import com.system.entity.Role;
import com.system.entity.User;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
import com.system.service.LetterService;
import com.system.service.UserService;
import org.apache.log4j.Logger;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = "/*")
public class SessionFilter implements Filter {

    private static final Logger LOGGER = Logger.getLogger(SessionFilter.class);

    @Override
    public void init(FilterConfig filterConfig) {
        LOGGER.info("The session filter started...");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest servletRequest = (HttpServletRequest) request;
        HttpServletResponse servletResponse = (HttpServletResponse) response;
        HttpSession session = servletRequest.getSession();

        if (session.getAttribute("response") != null && !session.getAttribute("response").equals("")) {
            LOGGER.info("Server response --> " + session.getAttribute("response"));
        } else {
            session.setAttribute("response", ServerResponse.EMPTY.getResponse());
            LOGGER.info("Server response --> null");
        }

        // Set session attributes
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser != null) {
            // session.setAttribute("currentUser", UserService.getInstance().findUserById(currentUser.getUserId()));

            String role = currentUser.getRole().getRoleTitle();
            if (role.equals(Role.ROLE_USER)) {
                // [Perhaps session variables for the user will be added]
            } else if (role.equals(Role.ROLE_ADMIN)) {
                session.setAttribute("totalUsers", UserService.getInstance().findAllUsers().size());
                session.setAttribute("totalAccounts", AccountService.getInstance().findAllAccounts().size());
                session.setAttribute("totalLetters", LetterService.getInstance().findUnprocessedLetters().size());
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        LOGGER.info("Session filter destroyed...");
    }

}
