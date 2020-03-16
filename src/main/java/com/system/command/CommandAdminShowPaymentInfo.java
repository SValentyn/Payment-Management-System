package com.system.command;

import com.system.entity.Account;
import com.system.entity.BankCard;
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

public class CommandAdminShowPaymentInfo implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        request.setAttribute("showPaymentError", false);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());

        String paymentId = request.getParameter("paymentId");

        if (paymentId != null) {
            Payment payment = PaymentService.getInstance().findPaymentByPaymentId(Integer.valueOf(paymentId));
            request.setAttribute("payment", payment);

            /* Sender Data */
            Account senderAccount = AccountService.getInstance().findAccountByAccountNumber(payment.getSenderNumber());
            request.setAttribute("senderAccount", senderAccount);
            request.setAttribute("senderUser", UserService.getInstance().findUserById(senderAccount.getUserId()));

            /* Recipient Data */
            Account recipientAccount = null;
            BankCard recipientCard = null;
            User recipientUser = null;

            if (payment.getRecipientNumber().length() == 20) {  // if recipient number is account number
                recipientAccount = AccountService.getInstance().findAccountByAccountNumber(payment.getRecipientNumber());
                recipientUser = UserService.getInstance().findUserById(recipientAccount.getUserId());
                request.setAttribute("recipientIsAccount", true);
            } else {                                            // if recipient number is card number
                recipientCard = new BankCard();
                recipientCard.setNumber(payment.getRecipientNumber());
                // [Obtaining cardholder data]
                request.setAttribute("recipientIsAccount", false);
            }

            request.setAttribute("recipientAccount", recipientAccount);
            request.setAttribute("recipientCard", recipientCard);
            request.setAttribute("recipientUser", recipientUser);
        } else {
            request.setAttribute("showPaymentError", true);
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_PAYMENT_INFO);
    }

}