package com.system.command;

import com.system.entity.Account;
import com.system.entity.BankCard;
import com.system.entity.Payment;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
import com.system.service.BankCardService;
import com.system.service.PaymentService;
import com.system.service.UserService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminShowAccountInfo implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACCOUNT_INFO);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            return pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_ACCOUNT_INFO);
        } else if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACCOUNT_INFO);

            // Set attributes obtained from the session
            setRequestAttributes(request);

            // Data
            String userIdParam = request.getParameter("userId");
            String accountIdParam = request.getParameter("accountId");

            // Validation
            if (!validation(request, userIdParam, accountIdParam)) {
                return pathRedirect;
            }

            // Set attributes
            setRequestAttributes(request, userIdParam, accountIdParam);
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String userIdParam, String accountIdParam) throws SQLException {

        // Validation userId
        if (!Validator.checkUserId(userIdParam)) {
            setRequestAttributes(request, ServerResponse.UNABLE_GET_USER_ID);
            return false;
        } else {
            request.setAttribute("userId", userIdParam);
        }

        // Return from the command if the account unable get by userId
        if (request.getAttribute("response").equals(ServerResponse.UNABLE_GET_ACCOUNT_BY_USER_ID.getResponse())) {
            return false;
        }

        // Return from the command if the account was successfully deleted
        if (request.getAttribute("response").equals(ServerResponse.ACCOUNT_DELETED_SUCCESS.getResponse())) {
            return false;
        }

        // Validation
        if (!Validator.checkAccountId(accountIdParam)) {
            setRequestAttributes(request, ServerResponse.UNABLE_GET_ACCOUNT_ID);
            return false;
        }

        // Data
        Account account = AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountIdParam));

        // Checking that the userId by account matches the received
        if (!account.getUserId().equals(Integer.valueOf(userIdParam))) {
            setRequestAttributes(request, ServerResponse.UNABLE_GET_ACCOUNT_BY_USER_ID);
            return false;
        }

        return true;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("userId", null);
        request.setAttribute("viewableUser", null);
        request.setAttribute("viewableAccount", null);
        request.setAttribute("paymentsEmpty", null);
        request.setAttribute("payments", null);
        request.setAttribute("cardsEmpty", null);
        request.setAttribute("cards", null);
        request.setAttribute("response", "");
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
        }
    }

    private void setRequestAttributes(HttpServletRequest request, String userIdParam, String accountIdParam) throws SQLException {
        Integer userId = Integer.valueOf(userIdParam);
        Integer accountId = Integer.valueOf(accountIdParam);
        Account viewableAccount = AccountService.getInstance().findAccountByAccountId(accountId);
        User viewableUser = UserService.getInstance().findUserById(userId);
        List<Payment> payments = PaymentService.getInstance().findAllPaymentsByAccountId(accountId);
        List<BankCard> cards = BankCardService.getInstance().findCardsByAccountId(accountId);

        if (viewableUser != null && payments != null && cards != null) {

            // formatting card numbers
            for (BankCard card : cards) {
                card.setNumber(card.getNumber().replaceAll("(.{4})", "$1 "));
            }

            request.setAttribute("userId", userId);
            request.setAttribute("viewableUser", viewableUser);
            request.setAttribute("viewableAccount", viewableAccount);
            request.setAttribute("paymentsEmpty", payments.isEmpty());
            request.setAttribute("payments", payments);
            request.setAttribute("cardsEmpty", cards.isEmpty());
            request.setAttribute("cards", cards);
        } else {
            setRequestAttributes(request, ServerResponse.SHOW_ACCOUNT_ERROR);
        }
    }

    private void setRequestAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.setAttribute("response", serverResponse.getResponse());
    }

}
