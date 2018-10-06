<%@ page import="com.cnipr.cniprgz.commons.DataAccess,
com.cnipr.cniprgz.security.SecurityTools,java.net.URLEncoder,java.net.URLDecoder" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="n" uri="/WEB-INF/taglib/n.tld"%>
<%@ taglib prefix="s" uri="/WEB-INF/taglib/section.tld"%>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="com.cnipr.cniprgz.commons.*"%>
<%@ page import="com.cnipr.cniprgz.dao.*"%>
<%@ page import="com.cnipr.cniprgz.entity.*"%>
<%@ page import="com.cnipr.corebiz.search.entity.LegalStatusInfo"%> 
<%@ page import="java.util.* "%>
<%@ page import="net.jbase.common.page.* "%>
<%@ page import="net.jbase.common.util.* "%>
<%@ page import="com.cnipr.cniprgz.func.search.SearchFunc "%>
 

<%
	String path = request.getContextPath();
	String method = request.getParameter("method");
	 
	TbReportDAO reportDAO  =  new TbReportDAO(); 
 
	
	
	if(request.getSession().getAttribute(Constant.APP_USER_ID)!=null)
	{
		int userId = Integer.parseInt((String)request.getSession().getAttribute(Constant.APP_USER_ID));

		
					if(method!=null && method.equals("create"))//编辑简单预警
					{	 
							String start = "1";
							if(request.getParameter("start")!=null)
								start = request.getParameter("start");   
							String name = request.getParameter("name");  
							String exp = request.getParameter("exp");  
							String channels = request.getParameter("channels");
						 
							
						 
							{
							 
							TbReport report = new TbReport(); 
							 report.setUserId(userId); 
							 report.setChannels(channels);  
							 report.setName(name); 
							 report.setStatus(0);
							 report.setType(0);
							 System.out.println(exp);
							 if(exp!=null)
								 exp = URLDecoder.decode(exp,"utf-8");
							// System.out.println(exp);
							 report.setExp(exp);
							 
							 reportDAO.createTbReport(report);					 
							 request.setAttribute("warnMessage","添加成功！"); 
							RequestDispatcher rd = null;
							ServletContext sc = getServletContext();
					        rd = sc.getRequestDispatcher("/jsp/tbreport/report-index.jsp?start="+start);     //定向的页面 
					        rd.forward(request, response);
							}
							//response.sendRedirect("warn-index.jsp?start="+start); 
						 
					}
					
					 
					
					
					else if(method!=null && method.equals("delete"))//续订
					{
						String id = request.getParameter("id");
						String start = "1";
						if(request.getParameter("start")!=null)
							start = request.getParameter("start");   
					 
						reportDAO.delete(id);					 
						
						request.setAttribute("warnMessage","删除成功！"); 
						RequestDispatcher rd = null;
						ServletContext sc = getServletContext();
				        rd = sc.getRequestDispatcher("/jsp/tbreport/report-index.jsp?start="+start);     //定向的页面 
				        rd.forward(request, response);
						 
						 
					}
	}
%>
 
     
 