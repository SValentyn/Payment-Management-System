package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandUserCreateAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.USER_CREATE_ACCOUNT);

        request.setAttribute("created", false);
        request.setAttribute("createAccountError", false);

        User user = (User) request.getSession().getAttribute("currentUser");
        request.getSession().setAttribute("currentUser", UserService.getInstance().findUserById(user.getUserId()));

        List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(user.getUserId());
        request.setAttribute("accounts", accounts);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            Integer userId = user.getUserId();
            String number = request.getParameter("number");
            String currency = request.getParameter("currency");

            // Check
            for (Account account : accounts) {
                if (account.getNumber().equals(number)) {
                    request.setAttribute("numberValue", number);
                    request.setAttribute("currencyValue", currency);
                    request.setAttribute("numberExistError", true);
                    return page;
                }
            }

            // Create
            int status = AccountService.getInstance().createAccount(userId, number, currency);
            if (status == 0) {
                request.setAttribute("numberValue", number);
                request.setAttribute("currencyValue", currency);
                request.setAttribute("createAccountError", true);
            } else {
                request.setAttribute("numberValue", null);
                request.setAttribute("created", true);
            }
        }

        return page;
    }

}
