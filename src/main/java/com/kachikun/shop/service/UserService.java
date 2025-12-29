package com.kachikun.shop.service;

import java.util.List;
import com.kachikun.shop.model.User;
import com.kachikun.shop.dao.UserDAO;

public class UserService {
    private UserDAO userDAO = new UserDAO();
    
    public User login(String username, String password) {
        return userDAO.checkLogin(username, password);
    }
    
    public boolean register(String username, String password, String email, String fullName, int role) {
        if (username == null || password == null || password.length() < 6) {
            return false;
        }
        
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setEmail(email);
        newUser.setFullName(fullName);
        newUser.setRole(role);
        
        return userDAO.register(newUser);
    }
    
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }
    
    public List<User> getAdmins() {
        return userDAO.getUsersByRole(1);
    }
    
    public List<User> getRegularUsers() {
        return userDAO.getUsersByRole(0);
    }
    
    public boolean updateUserRole(int userId, int newRole) {
        User user = userDAO.getUserById(userId);
        if (user != null) {
            user.setRole(newRole);
            return userDAO.updateUser(user);
        }
        return false;
    }
    
    public boolean deleteUser(int userId) {
        return userDAO.deleteUser(userId);
    }
}