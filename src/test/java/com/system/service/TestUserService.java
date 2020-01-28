package com.system.service;

import com.system.entity.Role;
import com.system.entity.User;
import org.junit.BeforeClass;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class TestUserService {

    private static UserService userService = null;
    private static User user = null;
    private static Role role = null;

    @BeforeClass
    public static void setUp() {
        userService = mock(UserService.class);

        user = new User();
        user.setUserId(1);
        user.setName("Jeff");
        user.setSurname("Bezos");
        user.setPhone("8008098101");
        user.setEmail("jeffbezos@gmail.com");
        user.setPassword("jeffbezos");
        role = new Role();
        role.setId(2);
        role.setRolename("admin");
        user.setRole(role);

        when(userService.getRole(user)).thenReturn("admin");
        when(userService.loginUser("8008098101", "jeffbezos")).thenReturn(user);
        when(userService.registerUser("Jeff", "Bezos", "jeffbezos", "jeffbezos@gmail.com", "8008098101")).thenReturn(user.getUserId());
    }

    @Test
    public void testRegisterUser() {
        Integer userId = userService.registerUser("Jeff", "Bezos", "jeffbezos", "jeffbezos@gmail.com", "8008098101");
        assertNotNull(userId);
    }

    @Test
    public void testLoginUser() {
        User checkUser = userService.loginUser(user.getPhone(), user.getPassword());
        assertNotNull(checkUser);
    }

    @Test
    public void testCheckRole() {
        String role = userService.getRole(user);
        assertNotNull(role);
        assertEquals("admin", role);
    }

}
