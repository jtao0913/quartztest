package com.cnipr.cniprgz.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.cnipr.cniprgz.dao.NodeDAO;
/**
 * Servlet implementation class ReporterServlet
 */
public class ReporterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 获取传递过来的接口引擎查询语句信息
		String exp = req.getParameter("strWhere");
		String nodeId=req.getParameter("nodeId");
		String chrGDHyName=NodeDAO.getchrNameById(Integer.parseInt(nodeId));
		//将语句存入作用域
		req.getSession().setAttribute("strWhere", exp);
		req.getSession().setAttribute("nodeId", nodeId);
		req.getSession().setAttribute("chrGDHyName", chrGDHyName);
		// 跳转至生成报告页面
		resp.sendRedirect("jsp/zljs/report.jsp");
	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReporterServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
