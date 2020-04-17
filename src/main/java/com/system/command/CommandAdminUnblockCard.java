package com.system.command;

import com.system.entity.Account;
import com.system.entity.BankCard;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
import com.system.service.BankCardService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminUnblockCard implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACCOUNT_INFO);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name()) || method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_ACCOUNT_INFO);

            // Data
            String accountIdParam = request.getParameter("accountId");
            String cardNumberParam = request.getParameter("cardNumber");

            // Validation
            if (!Validator.checkAccountId(accountIdParam)) {
                return pathRedirect;
            }

            pathRedirect += "&accountId=" + accountIdParam;

            // Validation
            if (!Validator.checkCardNumber(cardNumberParam)) {
                request.getSession().setAttribute("response", ServerResponse.CARD_UNBLOCKED_ERROR.getResponse());
                return pathRedirect;
            }

            // Data
            BankCard card = BankCardService.getInstance().findCardByCardNumber(cardNumberParam);

            // Check
            if (card == null) {
                request.getSession().setAttribute("response", ServerResponse.CARD_UNBLOCKED_ERROR.getResponse());
                return pathRedirect;
            }

            // Data
            Account accountByAccountId = AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountIdParam));
            Account accountByCard = AccountService.getInstance().findAccountByAccountId(card.getAccountId());

            // Check
            if (!accountByAccountId.equals(accountByCard)) {
                request.getSession().setAttribute("response", ServerResponse.CARD_UNBLOCKED_ERROR.getResponse());
                return pathRedirect;
            }

            // Action
            int status = BankCardService.getInstance().unblockBankCard(card.getCardId());
            if (status == 0) {
                request.getSession().setAttribute("response", ServerResponse.CARD_UNBLOCKED_ERROR.getResponse());
            } else {
                request.getSession().setAttribute("response", ServerResponse.CARD_UNBLOCKED_SUCCESS.getResponse());
            }
        }

        return pathRedirect;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("response", "");
    }

}
