package com.cnipr.cniprgz.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class urlFilter implements Filter {
    public void destroy() {
    }
    /**
     * 在这里面写的任何代码  在执行Servlet JSP 等前 都会被执行
     */
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

        Object username = request.getSession().getAttribute("username");
        System.out.println(username);
        if(username==null||username==""||!username.equals("admin")) {
        	response.sendRedirect(request.getContextPath()+"/jsp/zljs/pageLimit.jsp");
        }        
        //因为有可能不止这一个过滤器,所以需要将所有的过滤器执行
        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {

    }
}