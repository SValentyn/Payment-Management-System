package com.system.command;

import com.system.entity.Account;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.LetterService;
import com.system.service.UserService;

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

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("showUsers", true);
        request.setAttribute("deleted", false);
        request.setAttribute("userHasFundsError", false);
        request.setAttribute("deleteUserError", false);

        String userId = request.getParameter("userId");

        if (userId != null) {
            List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(Integer.valueOf(userId));
            for (Account account : accounts) {
                BigDecimal balance = account.getBalance();
                if (balance.compareTo(BigDecimal.ZERO) != 0) {
                    request.setAttribute("users", UserService.getInstance().findAllUsers());
                    request.setAttribute("userId", userId);
                    request.setAttribute("userHasFundsError", true);
                    return page;
                }
            }

            int status = UserService.getInstance().deleteUserById(Integer.valueOf(userId));
            if (status == 0) {
                request.setAttribute("deleteUserError", true);
            } else {
                request.setAttribute("deleted", true);
            }
        } else {
            request.setAttribute("deleteUserError", true);
        }

        request.setAttribute("users", UserService.getInstance().findAllUsers());
        return page;
    }

}
