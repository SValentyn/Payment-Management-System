package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandRecoveryPassword implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.RECOVERY);

        request.setAttribute("sended", false);
        request.setAttribute("phoneNotExistError", false);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            String phone = request.getParameter("full_phone"); // set in the validator file (hiddenInput: "full_phone")

            // Check
            int status = 0;
            List<User> users = UserService.getInstance().findAllUsers();
            for (User user : users) {
                if (user.getPhone().equals(phone)) {
                    status = 1;
                    break;
                }
            }

            // Recovery
            if (status == 0) {
                request.setAttribute("phoneValue", phone);
                request.setAttribute("phoneNotExistError", true);
            } else {
                request.setAttribute("sended", true);
            }
        }

        return page;
    }

}
