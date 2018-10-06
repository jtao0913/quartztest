<%@ page import="com.cnipr.cniprgz.commons.DataAccess,
com.cnipr.cniprgz.security.SecurityTools,java.net.URLEncoder" contentType="text/html; charset=utf-8"%>
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
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	String method = request.getParameter("method");
	 
	TLawWarnDAO lawWarnDAO  =  new TLawWarnDAO(); 
 
	
	
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
							String an = request.getParameter("an");  
							String channels = request.getParameter("channels");
							String pn = request.getParameter("pn");  
							
							int count = lawWarnDAO.countLawWarn(userId);
							if(count>= Integer.parseInt(SetupAccess.getProperty(SetupConstant.SIMPLEWARNMAX)))
							{
								request.setAttribute("warnMessage","预警不能超过"+SetupAccess.getProperty(SetupConstant.SIMPLEWARNMAX)+",请清理定期预警。");  
								RequestDispatcher rd = null;
								ServletContext sc = getServletContext();
							    rd = sc.getRequestDispatcher("/jsp/simplewarn/law-warn-index.jsp?start="+start);     //定向的页面 
							    rd.forward(request, response);
							}
							else
							{							 
							 TLawWarn lawWarn = new TLawWarn(); 
							 lawWarn.setUserId(userId);
							 lawWarn.setAn(an);
							 lawWarn.setChannels(channels); 
							 lawWarn.setPn(pn); 
							 lawWarn.setName(name);
							 lawWarn.setPeriod(periodint);
							 lawWarn.setStatus(Integer.parseInt(SetupAccess.getProperty(SetupConstant.LAWWARNRENEWNUM)));
							 lawWarn.setCreatetime(new Date());
							 
							 SearchFunc searchFunc = new SearchFunc(); 
							 if(an!=null)
							 {
								 List<LegalStatusInfo> list = searchFunc.legalStatusSearch(null, "申请号="+an);
								 if(list!=null && list.size()>0)
								 {
								 LegalStatusInfo newLegalStatusInfo = list.get(0); 
								 Date udate =  DateUtil.parseDate("yyyy.MM.dd",newLegalStatusInfo.getStrLegalStatusDay());
								 lawWarn.setLastupdatetime(udate);
								 lawWarn.setLastupdatestatus(newLegalStatusInfo.getStrLegalStatus());
								 lawWarn.setUpdatetime(udate); 
								 lawWarn.setUpdatestatus(newLegalStatusInfo.getStrLegalStatus());  
								 }
							 }
							 lawWarnDAO.createLawWarn(lawWarn);						 
							 request.setAttribute("warnMessage","添加成功！"); 
							RequestDispatcher rd = null;
							ServletContext sc = getServletContext();
					        rd = sc.getRequestDispatcher("/jsp/simplewarn/law-warn-index.jsp?start="+start);     //定向的页面 
					        rd.forward(request, response);
							}
							//response.sendRedirect("warn-index.jsp?start="+start); 
						 
					}
					
					else if(method!=null && method.equals("renew"))//续订
					{
						String id = request.getParameter("id");
						String start = "1";
						if(request.getParameter("start")!=null)
							start = request.getParameter("start");  
						
						TLawWarn lawWarn = lawWarnDAO.getLawWarn(Integer.parseInt(id));
						if(lawWarn.getStatus()<=0)
							lawWarnDAO.updateStatus(id,Constant.INCREASE,Integer.parseInt(SetupAccess.getProperty(SetupConstant.LAWWARNRENEWNUM)));
						else
						{
							request.setAttribute("warnMessage","还未失效，不允许续订！"); 
						} 
						 
						RequestDispatcher rd = null;
						ServletContext sc = getServletContext();
				        rd = sc.getRequestDispatcher("/jsp/simplewarn/law-warn-index.jsp?start="+start);     //定向的页面 
				        rd.forward(request, response);
						 
						 
					}
					
					
					else if(method!=null && method.equals("delete"))//续订
					{
						String id = request.getParameter("id");
						String start = "1";
						if(request.getParameter("start")!=null)
							start = request.getParameter("start");   
					 
						lawWarnDAO.delete(id);					 
						
						request.setAttribute("warnMessage","删除成功！"); 
						RequestDispatcher rd = null;
						ServletContext sc = getServletContext();
				        rd = sc.getRequestDispatcher("/jsp/simplewarn/law-warn-index.jsp?start="+start);     //定向的页面 
				        rd.forward(request, response);
						 
						 
					}
	}
%>
 
     
 