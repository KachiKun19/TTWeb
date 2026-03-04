package com.kachikun.shop.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.kachikun.shop.model.User;

@WebFilter(urlPatterns = {
    "/adminHome", "/adminProducts", "/addProduct", "/deleteProduct", 
    "/adminUsers", "/adminOrders", "/adminContacts", 
    "/loadDailyStats", "/exportRevenueStats"
})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user != null && user.getRole() == 1) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp?error=access_denied");
        }
    }

    @Override public void init(FilterConfig fConfig) throws ServletException {}
    @Override public void destroy() {}
}