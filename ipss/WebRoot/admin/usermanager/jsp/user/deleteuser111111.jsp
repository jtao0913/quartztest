<%@ page contentType="text/html;charset=utf-8" errorPage="/error.jsp"%>
<%@ page import="com.trs.usermanage.*,com.trs.usermanage.UserManage"%>
<%@ page import="com.cnipr.cniprgz.log.*, com.cnipr.cniprgz.commons.*,net.jbase.common.util.*,com.cnipr.cniprgz.dao.*,com.cnipr.cniprgz.entity.*"%>
<%
        //定义服务器配置参数
        String[] strUserIDs=request.getParameterValues("sel");
        UserManage usermanage=new UserManage();
        for(int i=0;i<strUserIDs.length;i++)
        {	
        	IprUserDAO userDAO =  new IprUserDAO();
        	IprUser  iprUser =  null;
        	if(strUserIDs[i]!=null)
			   iprUser = userDAO.getUserInfo(Integer.parseInt(strUserIDs[i]));
            usermanage.deleteUser(Integer.parseInt(strUserIDs[i]));
           
          //记录log74日志  
    		if(Log74Access.getProperty(Log74Util.getLOG_OPEN())!=null && Log74Access.getProperty(Log74Util.getLOG_OPEN()).equals("1"))
    		{   if(iprUser!=null)
    			 Log74Util.log_user(iprUser.getChrUserName(), iprUser.getIntUserId()+"", iprUser.getIntGroupId()+"", request.getRemoteAddr(), "delete", DateUtil.getCurrentDateStr());
    		}
        }
        
        int intType=1;
    	String intTypeStr = request.getParameter("intType");
    	if(intTypeStr!=null    )
    	{
    		try{
    			intType = Integer.parseInt(intTypeStr);
    		}catch(Exception e)
    		{
    			e.printStackTrace();
    		}
    	}
    	
    	
        response.sendRedirect("getUserList.do?intType="+intType);
%>