package com.system.command;

import com.system.entity.CreditCard;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.CreditCardService;
import com.system.service.PaymentService;
import com.system.utils.StringValidator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommandCreatePayment implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.MAKE_PAYMENT);

        User user = (User) request.getSession().getAttribute("currentUser");
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(user.getUserId()));
        request.setAttribute("created", false);
        request.setAttribute("numberNotExistError", false);
        request.setAttribute("paymentError", false);

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
            }

            // Create
            int status = PaymentService.getInstance().formPayment(Integer.valueOf(accountId), number, new BigDecimal(amount), appointment);
            if (status == 0) {
                setRequestAttributes(request, number, amount, appointment);
                paymentCreateError(request);
            } else {
                request.setAttribute("created", true);
            }
        }

        return page;
    }

    private boolean checkAccountId(HttpServletRequest request, String accountId) {
        if (accountId == null || accountId.isEmpty() || !isNumeric(accountId)) {
            request.setAttribute("accountIdError", true);
            return true;
        }
        return false;
    }

    private boolean checkCardNumber(HttpServletRequest request, String number) {
        if (number.isEmpty() || !StringValidator.checkCardNumber(number)) {
            request.setAttribute("numberError", true);
            return true;
        }
        return false;
    }

    private boolean checkAmount(HttpServletRequest request, String amount) {
        if (amount == null || amount.isEmpty() || isNegative(amount)) {
            request.setAttribute("amountError", true);
            return true;
        }
        return false;
    }

    private void paymentCreateError(HttpServletRequest request) {
        request.setAttribute("paymentError", true);
    }

    private void setRequestAttributes(HttpServletRequest request, String number, String amount, String appointment) {
        request.setAttribute("numberValue", number);
        request.setAttribute("amountValue", amount);
        request.setAttribute("appointmentValue", appointment);
    }

    private boolean isNumeric(String strNum) {
        try {
            Integer.parseInt(strNum);
        } catch (NumberFormatException | NullPointerException e) {
            return false;
        }
        return true;
    }

    private boolean isNegative(String strNum) {
        try {
            if (Integer.parseInt(strNum) < 0) {
                return true;
            }
        } catch (NumberFormatException | NullPointerException e) {
            return true;
        }
        return false;
    }

}
