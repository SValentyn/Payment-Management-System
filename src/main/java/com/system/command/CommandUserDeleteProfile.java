package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

public class CommandUserDeleteProfile implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.USER_UPDATE_DATA);

        request.setAttribute("userHasFundsError", false);
        request.setAttribute("deleteProfileError", false);

        User user = (User) request.getSession().getAttribute("currentUser");

        // Set Attributes
        request.getSession().setAttribute("currentUser", UserService.getInstance().findUserById(user.getUserId()));
        setRequestAttributes(request, user);

        Integer userId = user.getUserId();
        if (userId != null) {
            List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(userId);
            for (Account account : accounts) {
                BigDecimal balance = account.getBalance();
                if (balance.compareTo(BigDecimal.ZERO) != 0) {
                    request.setAttribute("userHasFundsError", true);
                    return page;
                }
            }

            int status = UserService.getInstance().deleteUserById(userId);
            if (status == 0) {
                request.setAttribute("deleteProfileError", true);
            } else {
                request.getSession().invalidate();
                page = ResourceManager.getInstance().getProperty(ResourceManager.INDEX);
            }
        } else {
            request.setAttribute("deleteProfileError", true);
        }

        return page;
    }

    private void setRequestAttributes(HttpServletRequest request, User user) {
        request.setAttribute("nameValue", user.getName());
        request.setAttribute("surnameValue", user.getSurname());
        request.setAttribute("phoneValue", user.getPhone());
        request.setAttribute("emailValue", user.getEmail());
    }

}
