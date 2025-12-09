package com.kachikun.shop.service;

import com.kachikun.shop.model.User;
import com.kachikun.shop.dao.UserDAO;

public class UserService {
	private UserDAO userDAO = new UserDAO();
	
	public User login(String username, String password) {
		User user = userDAO.checkLogin(username, password);
		return user;
	}
	
	public boolean register(String username, String password, String email, String fullName) {
		if(username == null || password == null || email == null || fullName == null || password.length() < 6) return false;
		
		User newUser = new User();
		newUser.setUsername(username);
		newUser.setPassword(password);
		newUser.setEmail(email);
		newUser.setFullName(fullName);
		newUser.setRole(0);
		return userDAO.register(newUser);
	}
}
