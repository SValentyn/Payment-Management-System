package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.LetterService;
import com.system.service.PaymentService;
import com.system.service.UserService;
import com.system.utils.Validator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminDeleteUser implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("showUserError", false);
        request.setAttribute("userHasFundsError", false);
        request.setAttribute("deleteUserError", false);
        request.setAttribute("deleted", false);

        // Data
        String userIdParam = request.getParameter("userId");

        // Validation
        if (!Validator.checkUserId(userIdParam)) {
            request.setAttribute("deleteUserError", true);
            return page;
        }

        // Set Attributes
        Integer userId = Integer.parseInt(userIdParam);
        setRequestAttributes(request, userId);

        // Check
        List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(userId);
        for (Account account : accounts) {
            BigDecimal balance = account.getBalance();
            if (balance.compareTo(BigDecimal.ZERO) != 0) {
                request.setAttribute("userHasFundsError", true);
                return page;
            }
        }

        // Action
        int status = UserService.getInstance().deleteUserById(userId);
        if (status == 0) {
            request.setAttribute("deleteUserError", true);
        } else {
            request.setAttribute("showUserError", true);
            request.setAttribute("deleted", true);
        }

        return page;
    }

    private void setRequestAttributes(HttpServletRequest request, Integer userId) throws SQLException {
        User user = UserService.getInstance().findUserById(userId);
        request.setAttribute("userId", userId);
        request.setAttribute("viewableUser", user);
        request.setAttribute("paymentsEmpty", PaymentService.getInstance().findLastPaymentsByUserId(userId).isEmpty());
        request.setAttribute("accountsEmpty", AccountService.getInstance().findAllAccountsByUserId(userId).isEmpty());
        request.setAttribute("payments", PaymentService.getInstance().findLastPaymentsByUserId(userId));
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(userId));
    }

}
