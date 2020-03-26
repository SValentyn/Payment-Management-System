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
import java.util.List;

public class CommandAdminShowPaymentInfo implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_PAYMENT_INFO);

        request.setAttribute("showPaymentError", false);
        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());

        // Data
        String paymentId = request.getParameter("paymentId");

        // Check
        if (paymentId == null) {
            request.setAttribute("showPaymentError", true);
            return page;
        }

        // Data
        List<Payment> payments = PaymentService.getInstance().findAllPayments();
        List<String> paymentsIds = new ArrayList<>();
        for (Payment payment : payments) {
            paymentsIds.add(String.valueOf(payment.getPaymentId()));
        }

        // Check
        if (!paymentsIds.contains(paymentId)) {
            request.setAttribute("showPaymentError", true);
            return page;
        }

        // Data
        Payment payment = PaymentService.getInstance().findPaymentByPaymentId(Integer.valueOf(paymentId));
        Account senderAccount = AccountService.getInstance().findAccountByAccountNumber(payment.getSenderNumber());
        User senderUser = UserService.getInstance().findUserById(senderAccount.getUserId());
        Account recipientAccount = AccountService.getInstance().findAccountByAccountNumber(payment.getRecipientNumber());
        User recipientUser = null;

        if (payment.getRecipientNumber().length() == 20) {
            request.setAttribute("recipientIsAccount", true);
            recipientUser = UserService.getInstance().findUserById(recipientAccount.getUserId());
        } else {
            request.setAttribute("recipientIsAccount", false);
            // [Obtaining cardholder data]
        }

        // Set Attributes
        request.setAttribute("payment", payment);
        request.setAttribute("senderUser", senderUser);
        request.setAttribute("recipientUser", recipientUser);

        return page;
    }

}
