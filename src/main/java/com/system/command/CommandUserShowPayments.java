package com.system.command;

import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.PaymentService;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandUserShowPayments implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        User user = (User) request.getSession().getAttribute("currentUser");

        // Set Attributes
        request.getSession().setAttribute("currentUser", UserService.getInstance().findUserById(user.getUserId()));
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(user.getUserId()));
        request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByUserId(user.getUserId()));

        return ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_PAYMENTS);
    }

}
