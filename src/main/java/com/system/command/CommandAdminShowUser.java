package com.system.command;

import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.LetterService;
import com.system.service.PaymentService;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminShowUser implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USERS);

        request.setAttribute("showUserError", false);
        request.setAttribute("userIsAdmin", false);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());

        String userId = request.getParameter("userId");
        User user;

        if (userId != null) {
            user = UserService.getInstance().findUserById(Integer.valueOf(userId));
            page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER);
        } else {
            List<User> users = UserService.getInstance().findAllUsers();
            request.setAttribute("users", users);
            request.setAttribute("totalUsers", users.size());
            request.setAttribute("showUserError", true);
            return page;
        }

        request.setAttribute("user", user);

        if (user.getRole().getId() == 2) {
            request.setAttribute("userIsAdmin", true);
            return page;
        }

        request.setAttribute("paymentsEmpty", PaymentService.getInstance().findAllPaymentsByUserId(Integer.valueOf(userId)).isEmpty());
        request.setAttribute("accountsEmpty", AccountService.getInstance().findAllAccountsByUserId(Integer.valueOf(userId)).isEmpty());
        request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByUserId(Integer.valueOf(userId)));
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.valueOf(userId)));
        return page;
    }

}
