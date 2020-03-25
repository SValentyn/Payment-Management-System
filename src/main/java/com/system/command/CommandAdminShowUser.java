package com.system.command;

import com.system.entity.Account;
import com.system.entity.Payment;
import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.LetterService;
import com.system.service.PaymentService;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class CommandAdminShowUser implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("showUserError", false);
        request.setAttribute("userIsAdmin", false);

        // Data
        String userId = request.getParameter("userId");
        List<User> users = UserService.getInstance().findAllUsers();

        // Check
        if (userId == null) {
            request.setAttribute("users", users);
            request.setAttribute("totalUsers", users.size());
            request.setAttribute("showUserError", true);
            page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USERS);
            return page;
        }

        // Data
        Integer userIdInt = Integer.valueOf(userId);
        List<Integer> usersIds = new ArrayList<>();
        for (User user : users) {
            usersIds.add(user.getUserId());
        }

        // Check
        if (!usersIds.contains(userIdInt)) {
            request.setAttribute("users", users);
            request.setAttribute("totalUsers", users.size());
            request.setAttribute("showUserError", true);
            page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USERS);
            return page;
        }

        // Data
        User user = UserService.getInstance().findUserById(userIdInt);

        // Set session attribute
        request.getSession().setAttribute("viewableUser", user);

        // Check
        if (user.getRole().getId() == 2) {
            request.setAttribute("userIsAdmin", true);
            return page;
        }

        // Data
        List<Payment> payments = PaymentService.getInstance().findAllPaymentsByUserId(userIdInt);
        HashMap<Integer, Account> accountsMap = new HashMap<>();

        for (Payment payment : payments) {
            accountsMap.put(payment.getPaymentId(), AccountService.getInstance().findAccountByAccountId(payment.getAccountId()));
        }

        // Set Attributes
        request.setAttribute("paymentsEmpty", PaymentService.getInstance().findLastPaymentsByUserId(userIdInt).isEmpty());
        request.setAttribute("accountsEmpty", AccountService.getInstance().findAllAccountsByUserId(userIdInt).isEmpty());
        request.setAttribute("payments", PaymentService.getInstance().findLastPaymentsByUserId(userIdInt));
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(userIdInt));
        request.setAttribute("accountsMap", accountsMap);
        return page;
    }

}
