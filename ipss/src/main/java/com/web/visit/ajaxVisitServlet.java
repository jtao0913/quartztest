package com.web.visit;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ajaxVisitServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public ajaxVisitServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request,response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	@SuppressWarnings("deprecation")
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		
		String date = VisitCount.get("date");
		
		String ajaxVisitName = request.getParameter("ajaxVisitName");
		if(null==date || "".equals(date))
		{
			VisitCount.set("date", new Date().getDay());			
		} 
		 
		VisitCount.set(ajaxVisitName, Integer.parseInt(VisitCount.get(ajaxVisitName))+1);
		VisitCount.set("t"+ajaxVisitName, Integer.parseInt(VisitCount.get("t"+ajaxVisitName))+1);	
		 
		if((new Date().getDay()+"").equals(VisitCount.get("date")))
		{
			
				
		}else
		{
			VisitCount.set("date", new Date().getDay()); 
			VisitCount.set("tMain",  0); 
			VisitCount.set("t"+ajaxVisitName, Integer.parseInt(VisitCount.get("t"+ajaxVisitName))+1);	
		}  
		PrintWriter writer = response.getWriter();
		writer.print("{"+ajaxVisitName+":"+VisitCount.get(ajaxVisitName)+",t"+ajaxVisitName+":"+VisitCount.get("t"+ajaxVisitName)+"}");
		//System.out.println("{"+ajaxVisitName+":"+VisitCount.get(ajaxVisitName)+",t"+ajaxVisitName+":"+VisitCount.get("t"+ajaxVisitName)+"}");
		writer.close();
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
