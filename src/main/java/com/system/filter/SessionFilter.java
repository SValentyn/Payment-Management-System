package com.system.filter;

import com.system.entity.Role;
import com.system.entity.User;
import com.system.service.LetterService;
import com.system.service.UserService;
import org.apache.log4j.Logger;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebFilter(urlPatterns = "/*")
public class SessionFilter implements Filter {

    private static final Logger LOGGER = Logger.getLogger(SessionFilter.class);

    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest servletRequest = (HttpServletRequest) request;
        HttpServletResponse servletResponse = (HttpServletResponse) response;
        HttpSession session = servletRequest.getSession(false);

        // Set typeOfError
        if (request.getParameter("typeOfError") != null && !request.getParameter("typeOfError").equals("")) {
            request.setAttribute("typeOfError", request.getParameter("typeOfError"));
            LOGGER.info("typeOfError=" + request.getParameter("typeOfError"));
        } else {
            LOGGER.info("typeOfError=null");
        }

        // Set totalUsers and numberOfLetters
        if (session != null) {
            User user = (User) session.getAttribute("currentUser");
            if (user != null) {
                try {
                    String role = UserService.getInstance().getRole(user);
                    if (role.equals(Role.ROLE_ADMIN)) {
                        session.setAttribute("totalUsers", UserService.getInstance().findAllUsers().size());
                        session.setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
                    } else if (role.equals(Role.ROLE_CLIENT)) {
                        // [Perhaps session variables for the user will be added]
                    }
                } catch (SQLException e) {
                    LOGGER.error("Failed to get information from the database. Check connection. Exception:" + e.getMessage());
                }
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }

}
