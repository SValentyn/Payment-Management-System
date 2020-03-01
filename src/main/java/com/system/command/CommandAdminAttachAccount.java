package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.LetterService;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminAttachAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ATTACH_ACCOUNT);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("attached", false);
        request.setAttribute("manyAccountWithThisCurrencyError", false);
        request.setAttribute("attachAccountError", false);

        // Data
        String userId = request.getParameter("userId");
        String number = request.getParameter("number");
        String currency = request.getParameter("currency");

        // Check
        if (userId != null) {
            User user = UserService.getInstance().findUserById(Integer.valueOf(userId));
            String name = user.getName();
            String surname = user.getSurname();

            request.getSession().setAttribute("userId", userId);
            request.setAttribute("userId", userId);
            request.setAttribute("bio", name + " " + surname);
        } else {
            request.setAttribute("numberValue", number);
            request.setAttribute("currencyValue", currency);
            request.setAttribute("attachAccountError", true);
            return page;
        }

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Check
            List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(Integer.valueOf(userId));
            for (Account account : accounts) {
                if (account.getNumber().equals(number)) {
                    setRequestAttributes(request, number, currency);
                    request.setAttribute("attachAccountError", true);
                    return page;
                }
            }

            request.setAttribute("accounts", accounts);

            // Check
            int count = 0;
            for (Account account : accounts) {
                if (account.getCurrency().equals(currency)) count++;
            }

            if (count == 3) {
                setRequestAttributes(request, number, currency);
                request.setAttribute("manyAccountWithThisCurrencyError", true);
                return page;
            }

            int status = AccountService.getInstance().createAccount(Integer.parseInt(userId), number, currency);
            if (status == 0) {
                setRequestAttributes(request, number, currency);
                request.setAttribute("attachAccountError", true);
            } else {
                request.setAttribute("accountId", status);
                request.setAttribute("attached", true);
            }
        }

        return page;
    }

    private void setRequestAttributes(HttpServletRequest request, String number, String currency) {
        request.setAttribute("numberValue", number);
        request.setAttribute("currencyValue", currency);
    }

}
