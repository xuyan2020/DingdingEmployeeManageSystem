package com.xuyan.crud.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet Filter implementation class PowerFilter
 */
@WebFilter(filterName = "/PowerFilter", urlPatterns = {"/"})
public class PowerFilter implements Filter {

    /**
     * Default constructor. 
     */
    public PowerFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	/**
	 * @param request
	 * @param response
	 * @param chain
	 * @throws IOException
	 * @throws ServletException
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest)request;
		HttpServletResponse httpResponse = (HttpServletResponse)response;
		
		httpResponse.setHeader("Cache-Control","no-cache"); //不对页面进行缓存，再次访问时将从服务器重新获取最新版本
		httpResponse.setHeader("Cache-Control","no-store"); //任何情况下都不缓存页面
		httpResponse.setDateHeader("Expires", -1); //使缓存过期
		httpResponse.setHeader("Pragma","no-cache"); //HTTP 1.0 向后兼容
		
		if(httpRequest.getSession().getAttribute("id") == null && !httpRequest.getServletPath().equalsIgnoreCase("/login.do")) {
			httpResponse.sendRedirect(httpRequest.getContextPath() + "/index.jsp");
			System.out.println(httpRequest.getServletPath());
		}else {
			// pass the request along the filter chain
			chain.doFilter(httpRequest, httpResponse);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
