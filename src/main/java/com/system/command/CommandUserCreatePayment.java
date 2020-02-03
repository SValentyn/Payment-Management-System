package com.system.command;

import com.system.entity.CreditCard;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.CreditCardService;
import com.system.service.PaymentService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommandUserCreatePayment implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.USER_MAKE_PAYMENT);

        User user = (User) request.getSession().getAttribute("currentUser");
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(user.getUserId()));
        request.setAttribute("created", false);
        request.setAttribute("numberNotExistError", false);
        request.setAttribute("accountFromBlockedError", false);
        request.setAttribute("receiverAccountOrCardBlockedError", false);
        request.setAttribute("insufficientFundsError", false);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            String accountId = request.getParameter("accountId");
            String number = request.getParameter("number");
            String amount = request.getParameter("amount");
            String appointment = request.getParameter("appointment");

            // Check
            if (checkAccountId(request, accountId) ||
                    checkCardNumber(request, number) ||
                    checkAmount(request, amount)) {
                setRequestAttributes(request, number, amount, appointment);
                return page;
            }

            List<CreditCard> allCards = CreditCardService.getInstance().findAllCards();
            List<String> allCardNumbers = new ArrayList<>();

            for (CreditCard card : allCards) {
                allCardNumbers.add(card.getNumber());
            }

            if (!allCardNumbers.contains(number)) {
                setRequestAttributes(request, number, amount, appointment);
                request.setAttribute("numberNotExistError", true);
                return page;
            }

            // Create
            int status = PaymentService.getInstance().formingPayment(Integer.valueOf(accountId), number, new BigDecimal(amount), appointment);
            if (status == -1) {
                request.setAttribute("accountFromBlockedError", true);
                setRequestAttributes(request, number, amount, appointment);
            } else if (status == -2) {
                request.setAttribute("receiverAccountOrCardBlockedError", true);
                setRequestAttributes(request, number, amount, appointment);
            } else if (status == -3) {
                request.setAttribute("insufficientFundsError", true);
                setRequestAttributes(request, number, amount, appointment);
            } else {
                request.setAttribute("created", true);
            }
        }

        return page;
    }

    private boolean checkAccountId(HttpServletRequest request, String accountId) {
        if (accountId == null || accountId.isEmpty() || !Validator.isNumeric(accountId)) {
            request.setAttribute("accountIdError", true);
            return true;
        }
        return false;
    }

    private boolean checkCardNumber(HttpServletRequest request, String number) {
        if (number.isEmpty() || !Validator.checkCardNumber(number)) {
            request.setAttribute("numberError", true);
            return true;
        }
        return false;
    }

    private boolean checkAmount(HttpServletRequest request, String amount) {
        if (amount == null || amount.isEmpty() || Validator.isNegative(amount)) {
            request.setAttribute("amountError", true);
            return true;
        }
        return false;
    }

    private void setRequestAttributes(HttpServletRequest request, String number, String amount, String appointment) {
        request.setAttribute("numberValue", number);
        request.setAttribute("amountValue", amount);
        request.setAttribute("appointmentValue", appointment);
    }

}
