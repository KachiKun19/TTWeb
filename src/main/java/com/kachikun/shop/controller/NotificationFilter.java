package com.kachikun.shop.controller;

import com.kachikun.shop.dao.ReplyDAO;
import com.kachikun.shop.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebFilter("/*")
public class NotificationFilter implements Filter {

    private static final Logger log = Logger.getLogger(NotificationFilter.class.getName());
    private static final long CACHE_TTL_MS = 60_000L;

    private final ReplyDAO replyDAO = new ReplyDAO();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        String uri = req.getRequestURI();

        if (isStaticResource(uri)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user != null) {
            refreshNotificationCacheIfNeeded(session, user);
            req.setAttribute("unreadCount", session.getAttribute("cachedUnread"));
            req.setAttribute("list", session.getAttribute("cachedList"));
        }

        chain.doFilter(request, response);
    }

    private void refreshNotificationCacheIfNeeded(HttpSession session, User user) {
        Long lastCheck = (Long) session.getAttribute("notiLastCheck");
        long now = System.currentTimeMillis();

        if (lastCheck != null && (now - lastCheck) < CACHE_TTL_MS) {
            return; // Cache còn hạn, không query DB
        }

        try {
            int unreadCount   = replyDAO.countUnread(user.getEmail());
            var replyList     = replyDAO.getRepliesByUser(user.getEmail());

            session.setAttribute("cachedUnread", unreadCount);
            session.setAttribute("cachedList", replyList);
            session.setAttribute("notiLastCheck", now);

        } catch (Exception e) {
            log.log(Level.WARNING, "Không thể refresh notification cache cho user: "
                    + user.getEmail(), e);

            if (session.getAttribute("cachedUnread") == null) {
                session.setAttribute("cachedUnread", 0);
            }
            if (session.getAttribute("cachedList") == null) {
                session.setAttribute("cachedList", Collections.emptyList());
            }
        }
    }

    private boolean isStaticResource(String uri) {
        return uri.matches(".*(\\.(css|js|png|jpg|jpeg|gif|ico|woff|woff2|svg|map))$");
    }

    @Override public void init(FilterConfig filterConfig) {}
    @Override public void destroy() {}
}