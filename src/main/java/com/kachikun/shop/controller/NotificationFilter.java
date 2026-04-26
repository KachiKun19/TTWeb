package com.kachikun.shop.controller;

import com.kachikun.shop.dao.ReplyDAO;
import com.kachikun.shop.model.Reply;
import com.kachikun.shop.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.util.List;

@WebFilter("/*")
public class NotificationFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        User user = (User) req.getSession().getAttribute("user");
        if (user != null) {
            ReplyDAO dao = new ReplyDAO();
            int unread = dao.countUnread(user.getEmail());
            req.setAttribute("unreadCount", unread);
            List<Reply> list = dao.getRepliesByUser(user.getEmail());
            req.setAttribute("list", list);
        }
        chain.doFilter(request, response);
    }
}