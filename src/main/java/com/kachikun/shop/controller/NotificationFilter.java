package com.kachikun.shop.controller;

import com.kachikun.shop.dao.ReplyDAO;
import com.kachikun.shop.model.Reply;
import com.kachikun.shop.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebFilter("/*")
public class NotificationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        String uri = req.getRequestURI();

        //Bỏ qua hoàn toàn các file tĩnh, không cho chạy xuống DB
        if (uri.matches(".*(\\.(css|js|png|jpg|jpeg|gif|ico|woff|woff2|svg))$")) {
            chain.doFilter(request, response);
            return;
        }

        // Không tự tạo session mới nếu user chưa đăng nhập
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user != null) {
            Long lastCheck = (Long) session.getAttribute("notiLastCheck");
            long now = System.currentTimeMillis();

            if (lastCheck == null || (now - lastCheck) > 60_000) {
                ReplyDAO dao = new ReplyDAO();

                session.setAttribute("cachedUnread", dao.countUnread(user.getEmail()));
                session.setAttribute("cachedList", dao.getRepliesByUser(user.getEmail()));
                session.setAttribute("notiLastCheck", now);
            }

            req.setAttribute("unreadCount", session.getAttribute("cachedUnread"));
            req.setAttribute("list", session.getAttribute("cachedList"));
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}