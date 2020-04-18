package com.system.command;

import com.system.entity.Account;
import com.system.entity.BankCard;
import com.system.entity.Payment;
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

            // Set Attributes
            setRequestAttributes(request);

            // Return from the command if the account was successfully deleted
            if (request.getAttribute("response") == "accountDeletedSuccess") {
                return pathRedirect;
            }

            // Data
            String accountIdParam = request.getParameter("accountId");

            // Validation
            if (!Validator.checkAccountId(accountIdParam)) {
                request.setAttribute("response", ServerResponse.UNABLE_GET_ACCOUNT_ID.getResponse());
                return pathRedirect;
            }

            // Set Attributes
            setRequestAttributes(request, Integer.valueOf(accountIdParam));
        }

        return pathRedirect;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("viewableAccount", null);
        request.setAttribute("viewableUser", null);
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

    private void setRequestAttributes(HttpServletRequest request, Integer accountId) throws SQLException {
        Account viewableAccount = AccountService.getInstance().findAccountByAccountId(accountId);
        List<Payment> payments = PaymentService.getInstance().findAllPaymentsByAccountId(accountId);
        List<BankCard> cards = BankCardService.getInstance().findCardsByAccountId(accountId);

        if (viewableAccount != null && payments != null && cards != null) {
            request.setAttribute("viewableAccount", viewableAccount);
            request.setAttribute("viewableUser", UserService.getInstance().findUserById(viewableAccount.getUserId()));
            request.setAttribute("paymentsEmpty", payments.isEmpty());
            request.setAttribute("payments", payments);
            request.setAttribute("cardsEmpty", cards.isEmpty());
            request.setAttribute("cards", cards);
        } else {
            request.setAttribute("response", ServerResponse.SHOW_ACCOUNT_ERROR.getResponse());
        }
    }

}
