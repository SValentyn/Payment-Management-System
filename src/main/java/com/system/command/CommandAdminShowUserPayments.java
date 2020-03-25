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

public class CommandAdminShowUserPayments implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER_PAYMENTS);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("showUserPaymentsError", false);

        // Data
        User user = (User) request.getSession().getAttribute("viewableUser");

        // Check
        if (user == null) {
            request.setAttribute("showUserPaymentsError", true);
            return page;
        }

        // Data
        Integer userId = user.getUserId();
        List<User> users = UserService.getInstance().findAllUsers();
        List<Integer> usersIds = new ArrayList<>();
        for (User aUser : users) {
            usersIds.add(aUser.getUserId());
        }

        // Check
        if (!usersIds.contains(userId)) {
            request.setAttribute("showUserPaymentsError", true);
            return page;
        }

        // Data
        List<Payment> payments = PaymentService.getInstance().findAllPaymentsByUserId(userId);
        HashMap<Integer, Account> accounts = new HashMap<>();

        for (Payment payment : payments) {
            accounts.put(payment.getPaymentId(), AccountService.getInstance().findAccountByAccountId(payment.getAccountId()));
        }

        // Set Attributes
        request.setAttribute("paymentsEmpty", PaymentService.getInstance().findAllPaymentsByUserId(userId).isEmpty());
        request.setAttribute("payments", payments);
        request.setAttribute("accounts", accounts);

        return page;
    }

}
