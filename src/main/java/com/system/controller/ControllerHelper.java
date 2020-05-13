package com.system.controller;

import com.system.command.*;
import com.system.entity.User;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.HashMap;

public class ControllerHelper {

    /**
     * Users roles
     */
    private static final String UNKNOWN = "unknown";
    private static final String ADMIN = "admin";
    private static final String USER = "client";

    /**
     * Request parameter name for command
     */
    private static final String COMMAND = "command";
    private static ControllerHelper instance = null;

    /**
     * Action commands for user types
     */
    HashMap<String, ICommand> commands = new HashMap<>();
    HashMap<String, ICommand> adminCommands = new HashMap<>();
    HashMap<String, ICommand> userCommands = new HashMap<>();

    private ControllerHelper() {

        // Commands for the unregistered users
        commands.put("/", new CommandIndex());
        commands.put("login", new CommandLogin());
        commands.put("registration", new CommandRegistration());
        commands.put("recovery", new CommandRecoveryPassword());

        // User commands
        userCommands.put("logout", new CommandLogout());
        userCommands.put("profile", new CommandUserUpdatePersonalData());
        userCommands.put("deleteProfile", new CommandUserDeleteProfile());
        userCommands.put("updatePassword", new CommandUserUpdatePassword());
        userCommands.put("showAccounts", new CommandUserShowAccounts());
        userCommands.put("showPayments", new CommandUserShowPayments());
        userCommands.put("searchAccounts", new CommandUserSearchAccounts());
        userCommands.put("showAccountSettings", new CommandUserShowAccountSettings());
        userCommands.put("showAccountCards", new CommandUserShowAccountCards());
        userCommands.put("showAccountPayments", new CommandUserShowAccountPayments());
        userCommands.put("showPaymentInfo", new CommandUserShowPaymentInfo());
        userCommands.put("blockAccount", new CommandUserBlockAccount());
        userCommands.put("unblockAccount", new CommandUserUnblockAccount());
        userCommands.put("deleteAccount", new CommandUserDeleteAccount());
        userCommands.put("blockCard", new CommandUserBlockCard());
        userCommands.put("unblockCard", new CommandUserUnblockCard());
        userCommands.put("detachCard", new CommandUserDetachCard());
        userCommands.put("createAccount", new CommandUserCreateAccount());
        userCommands.put("attachCard", new CommandUserAttachCard());
        userCommands.put("makePayment", new CommandUserMakePayment());
        userCommands.put("repeatPayment", new CommandUserRepeatPayment());
        userCommands.put("support", new CommandUserSupport());

        // Admin commands
        adminCommands.put("logout", new CommandLogout());
        adminCommands.put("profile", new CommandAdminUpdatePersonalData());
        adminCommands.put("updatePassword", new CommandAdminUpdatePassword());
        adminCommands.put("searchUsers", new CommandAdminSearchUsers());
        adminCommands.put("searchAccounts", new CommandAdminSearchAccounts());
        adminCommands.put("showAccounts", new CommandAdminShowAccounts());
        adminCommands.put("showUser", new CommandAdminShowUser());
        adminCommands.put("updateUserData", new CommandAdminUpdateUserData());
        adminCommands.put("deleteUser", new CommandAdminDeleteUser());
        adminCommands.put("showUserAccounts", new CommandAdminShowUserAccounts());
        adminCommands.put("showUserPayments", new CommandAdminShowUserPayments());
        adminCommands.put("searchUserAccounts", new CommandAdminSearchUserAccounts());
        adminCommands.put("showAccountInfo", new CommandAdminShowAccountInfo());
        adminCommands.put("searchUserPayments", new CommandAdminSearchUserPayments());
        adminCommands.put("showPaymentInfo", new CommandAdminShowPaymentInfo());
        adminCommands.put("attachAccount", new CommandAdminAttachAccount());
        adminCommands.put("deleteAccount", new CommandAdminDeleteAccount());
        adminCommands.put("blockAccount", new CommandAdminBlockAccount());
        adminCommands.put("unblockAccount", new CommandAdminUnblockAccount());
        adminCommands.put("blockCard", new CommandAdminBlockCard());
        adminCommands.put("unblockCard", new CommandAdminUnblockCard());
        adminCommands.put("detachCard", new CommandAdminDetachCard());
        adminCommands.put("addUser", new CommandAdminAddUser());
        adminCommands.put("support", new CommandAdminSupport());
        adminCommands.put("searchLetters", new CommandAdminSearchLetters());
        adminCommands.put("showLetterInfo", new CommandAdminShowLetterInfo());
    }

    public static ControllerHelper getInstance() {
        if (instance == null) {
            instance = new ControllerHelper();
        }
        return instance;
    }

    /**
     * Find command from request
     */
    public ICommand getCommand(HttpServletRequest request) throws SQLException {
        ICommand command = null;

        String role = getRoleBySession(request);
        switch (role) {
            case UNKNOWN:
                command = commands.get(request.getParameter(COMMAND));
                break;
            case ADMIN:
                command = adminCommands.get(request.getParameter(COMMAND));
                break;
            case USER:
                command = userCommands.get(request.getParameter(COMMAND));
                break;
        }

        if (command == null) {
            command = new CommandIndex();
        }

        return command;
    }

    /**
     * Find role by session
     */
    private String getRoleBySession(HttpServletRequest request) throws SQLException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return UNKNOWN;
        } else {
            return UserService.getInstance().getRole((User) session.getAttribute("currentUser"));
        }
    }

}
