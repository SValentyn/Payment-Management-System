package com.system.dao;

import com.system.entity.User;
import com.system.persistence.dao.UserDao;
import com.system.persistence.dao.impl.UserDaoImpl;
import org.junit.BeforeClass;
import org.junit.Test;

import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class TestUserDao {

    private static UserDao userDao = null;
    private static User user_1 = null;
    private static User user_2 = null;

    @BeforeClass
    public static void setUp() {
        userDao = mock(UserDaoImpl.class);

        user_1 = new User();
        user_1.setUserId(1);
        user_1.setName("Elon");
        user_1.setSurname("Musk");
        user_1.setPhone("8003654210");
        user_1.setEmail("elonmusk@gmail.com");
        user_1.setPassword("elonmusk");

        user_2 = new User();
        user_2.setUserId(2);
        user_2.setName("Thomas");
        user_2.setSurname("Edison");
        user_2.setPhone("8008998686");
        user_2.setEmail("thomasedison@gmail.com");
        user_2.setPassword("thomasedison");

        when(userDao.create(user_1)).thenReturn(user_1.getUserId());
        when(userDao.findUserByUserId(1)).thenReturn(user_1);
        when(userDao.findUserByUserId(2)).thenReturn(user_2);
        when(userDao.findUserByPhoneAndPassword("8003654210", "elonmusk")).thenReturn(user_1);
        when(userDao.findUserByPhoneNumber("8008998686")).thenReturn(user_2);
        when(userDao.findAllUsers()).thenReturn(Arrays.asList(user_1, user_2));
    }

    @Test
    public void testCreateUser() {
        Integer id = user_1.getUserId();
        Integer userId = userDao.create(user_1);
        assertNotNull(userId);
        assertEquals(id, userId);
    }

    @Test
    public void testFindById() {
        String phone = user_2.getPhone();
        User user = userDao.findUserByUserId(2);
        assertNotNull(user);
        assertEquals(phone, user.getPhone());
    }

    @Test
    public void testFindByLoginAndPassword() {
        User user = userDao.findUserByPhoneAndPassword("8003654210", "elonmusk");
        User wrongUser = userDao.findUserByPhoneAndPassword("8003654210", "elonmusc");
        assertNull(wrongUser);
        String surname = user_1.getSurname();
        assertEquals(surname, user.getSurname());
    }

    @Test
    public void testFindByPhone() {
        User user = userDao.findUserByPhoneNumber("8008998686");
        assertEquals("Edison", user.getSurname());
    }

    @Test
    public void testFindAllUsers() {
        List<User> allUsers = userDao.findAllUsers();
        assertEquals(2, allUsers.size());
        assertEquals("8008998686", allUsers.get(1).getPhone());
        assertEquals("elonmusk@gmail.com", allUsers.get(0).getEmail());
    }
}
