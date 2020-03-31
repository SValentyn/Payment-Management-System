package com.system.command;

import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.LetterService;
import com.system.service.PaymentService;
import com.system.service.UserService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminShowUser implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("showUserError", false);

        // Data
        String userIdParam = request.getParameter("userId");

        // Check
        if (!Validator.checkUserId(userIdParam)) {
            request.setAttribute("showUserError", true);
            return page;
        }

        // Data
        Integer userId = Integer.valueOf(userIdParam);
        User user = UserService.getInstance().findUserById(userId);
        request.setAttribute("viewableUser", user);

        // Check and Set attributes
        if (user.getRole().getId() == 2) {
            request.setAttribute("userIsAdmin", true);
        } else if (user.getRole().getId() == 1) {
            setRequestAttributes(request, userId);
            request.setAttribute("userIsAdmin", false);
        } else {
            request.setAttribute("showUserError", true);
        }

        return page;
    }

    private void setRequestAttributes(HttpServletRequest request, Integer userId) throws SQLException {
        request.setAttribute("userId", userId);
        request.setAttribute("paymentsEmpty", PaymentService.getInstance().findLastPaymentsByUserId(userId).isEmpty());
        request.setAttribute("accountsEmpty", AccountService.getInstance().findAllAccountsByUserId(userId).isEmpty());
        request.setAttribute("payments", PaymentService.getInstance().findLastPaymentsByUserId(userId));
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(userId));
    }

}
