package com.cnipr.cniprgz.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cnipr.cniprgz.dao.NodeDAO;

public class SaveImageServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		String date = req.getParameter("date");
		boolean result = NodeDAO.updateImage(date, id);
	}
}
