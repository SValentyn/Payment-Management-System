package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.PaymentService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.SQLException;

public class CommandCreatePayment implements ICommand {

    private static final double PERCENT = 0.01;

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.MAKE_PAYMENT);
        User user = (User) request.getSession().getAttribute("currentUser");

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(user.getUserId()));
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            Integer accountId = Integer.parseInt(request.getParameter("account"));
            String number = request.getParameter("number");
            String summa = request.getParameter("summa");
            String appointment = request.getParameter("appointment");

            // Checks and create payment
            if (number != null && summa != null) {
                PaymentService.getInstance().formPayment(accountId, number, new BigDecimal(summa), PERCENT, appointment);
            }

            page = ResourceManager.getInstance().getProperty(ResourceManager.HOME);
        }

        return page;
    }

}
