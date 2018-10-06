<%@ page import="com.cnipr.cniprgz.commons.DataAccess,com.cnipr.cniprgz.security.SecurityTools,java.net.URLEncoder" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="n" uri="/WEB-INF/taglib/n.tld"%>
<%@ taglib prefix="s" uri="/WEB-INF/taglib/section.tld"%>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="com.cnipr.cniprgz.commons.*"%>
<%@ page import="com.cnipr.cniprgz.dao.*"%>
<%@ page import="com.cnipr.cniprgz.entity.*"%>
<%@ page import="java.util.* "%>
<%@ page import="net.jbase.common.page.* "%>
<%@ page import="net.jbase.common.util.* "%>

<%
//out.println(SetupAccess.getProperty(SetupConstant.SIMPLEWARNMAX));

	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	String method = request.getParameter("method");
	TSimpleWarnDAO simpleWarnDAO  =  new TSimpleWarnDAO(); 
	TSimpleExecuteDAO simpleExecuteDAO = new TSimpleExecuteDAO();
	
	
	if(request.getSession().getAttribute(Constant.APP_USER_ID)!=null)
	{
		int userId = Integer.parseInt((String)request.getSession().getAttribute(Constant.APP_USER_ID));

		
					if(method!=null && method.equals("create"))//编辑简单预警
					{	 
							String start = "1";
							if(request.getParameter("start")!=null)
								start = request.getParameter("start");  
							String period = request.getParameter("period");  
							int periodint = 1;
							if(period!=null)
								periodint = Integer.parseInt(period);
							String name = request.getParameter("name");  
							String area = request.getParameter("area");  
							String expression = request.getParameter("expression");  
							String channels = request.getParameter("channels");
							
							int count = simpleWarnDAO.countSimpleWarn(userId);
							if(count>= Integer.parseInt(SetupAccess.getProperty(SetupConstant.SIMPLEWARNMAX)))
							{
								request.setAttribute("warnMessage","预警不能超过"+SetupAccess.getProperty(SetupConstant.SIMPLEWARNMAX)+",请清理定期预警。");  
								RequestDispatcher rd = null;
								ServletContext sc = getServletContext();
//							    rd = sc.getRequestDispatcher(basePath + "/getMyWarm.do?start="+start);     //定向的页面 
//							    rd.forward(request, response);
							    
							    response.sendRedirect(basePath + "/getMyWarm.do?start="+start);
							}
							else
							{							
								TSimpleWarn simpleWarn = new TSimpleWarn();
								simpleWarn.setChannels(channels);
								simpleWarn.setCreatetime(new Date());
								simpleWarn.setExpression(expression);
								simpleWarn.setName(name);
								simpleWarn.setPeriod(periodint);
								simpleWarn.setStatus(Integer.parseInt(SetupAccess.getProperty(SetupConstant.SIMPLEWARNRENEWNUM)));
								simpleWarn.setUserId(userId);
								simpleWarn.setArea(Integer.parseInt(area));
								simpleWarnDAO.createSimpleWarn(simpleWarn);
							 
								request.setAttribute("warnMessage","添加成功！"); 
								
								RequestDispatcher rd = null;
								ServletContext sc = getServletContext();
	//					        rd = sc.getRequestDispatcher(basePath + "/getMyWarm.do?start="+start);     //定向的页面 
	//					        rd.forward(request, response);
								
								response.sendRedirect(basePath + "/getMyWarm.do?start="+start);
							}
							//response.sendRedirect("warn-index.jsp?start="+start);
					}
					else if(method!=null && method.equals("edit"))//编辑简单预警
					{
						String id = request.getParameter("id");
						String start = "1";
						if(request.getParameter("start")!=null)
							start = request.getParameter("start"); 
						
						String period = request.getParameter("period");
						int periodint = 1;
						if(period!=null)
							periodint = Integer.parseInt(period);
						String name = request.getParameter("name");  
						simpleWarnDAO.updateNamePeriod(id, periodint,name);

						response.sendRedirect(basePath + "/getMyWarm.do?start="+start);
					}
					else if(method!=null && method.equals("renew"))//续订
					{
						String id = request.getParameter("id");
						String start = "1";
						if(request.getParameter("start")!=null)
							start = request.getParameter("start");  
						
						TSimpleWarn simplewarn = simpleWarnDAO.getSimpleWarn(Integer.parseInt(id));
						if(simplewarn.getStatus()<=0)
							simpleWarnDAO.updateStatus(id,Constant.INCREASE,Integer.parseInt(SetupAccess.getProperty(SetupConstant.SIMPLEWARNRENEWNUM)));
						else
						{
							request.setAttribute("warnMessage","还未失效，不允许续订！"); 
						}
						
						RequestDispatcher rd = null;
						ServletContext sc = getServletContext();
//				        rd = sc.getRequestDispatcher("/getMyWarm.do?start="+start);     //定向的页面 
//				        rd.forward(request, response);
						response.sendRedirect(basePath + "/getMyWarm.do?start="+start);
					}					
					
					else if(method!=null && method.equals("delete"))//续订
					{
						String id = request.getParameter("id");
						String start = "1";
						if(request.getParameter("start")!=null)
							start = request.getParameter("start");   
					 
						simpleWarnDAO.delete(id);
						simpleExecuteDAO.deleteByWarnid(Integer.parseInt(id));
						
						request.setAttribute("warnMessage","删除成功！"); 
						RequestDispatcher rd = null;
						ServletContext sc = getServletContext();
//				        rd = sc.getRequestDispatcher(basePath + "/getMyWarm.do?start="+start);     //定向的页面 
//				        rd.forward(request, response);
				        
				        response.sendRedirect(basePath + "/getMyWarm.do?start="+start);
					}
	}
%>
 
     
 