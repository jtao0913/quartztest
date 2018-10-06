<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="Acme.Crypto.*,com.cnipr.cniprgz.log.*, com.cnipr.cniprgz.commons.*,
net.jbase.common.util.*,com.cnipr.cniprgz.dao.*,com.cnipr.cniprgz.entity.*,com.trs.usermanage.*"%>
<%@page import="com.cnipr.cniprgz.authority.user.IPCheckUtils" %>
<%@page import="java.net.URLEncoder"%>

<%@ include file="../../../../jsp/zljs/include-head-base.jsp"%>

<%
try{

String limitIP = request.getParameter("limitIP");
//System.out.println("limitIP="+limitIP);

String strAdminName= (String)request.getSession().getAttribute("username");

int intUserID = Integer.parseInt((String)request.getSession().getAttribute("userid"));

int adminID=intUserID;
//**********************取得管理员ID，把属于此id的用户显示出来*****************************
%>
<%
//定义变量
int	intGroupId = 0;
String strUserName=null,strPassword=null,strRealName=null,strRePassword=null;
String strPhone = null,strMobile = null,strFax = null,strEmail = null,strAddress = null,strDepartment;
String strMemo = null;
String strMaxLogin = null,strCMemo = null;
String strCount_in = null,strCount_out = null;
int intCount_in = 0,intCount_out = 0;
String strDefaultIP = null;
String	crypPassword="";
String strGroupID = null;
String strExpTime = "";
String strMerchantID="",strMAC="",strIPAdress="";
String strHerbal_Name="",strHerbal_DataBase="";
int intIPLimit = 0;
String strMenuID="";
String[] arrMenuIDs;
arrMenuIDs=request.getParameterValues("menuIDs");
//System.out.println(arrMenuIDs);

if(arrMenuIDs!=null){
	for(int i=0;i<arrMenuIDs.length;i++){
		//System.out.println("arrMenuIDs[i]="+arrMenuIDs[i]);
		strMenuID += arrMenuIDs[i]+",";
	}
}
//System.out.println(strMenuID);


String[] arrTradeList;
arrTradeList=request.getParameterValues("TradeList");
/*
for(int i=0;i<arrTradeList.length;i++){
	System.out.println("arrTradeList[i]="+arrTradeList[i]);
}
*/
int intAdministerState=Integer.parseInt(request.getParameter("AdminState"));
String chrEnterpriseName="";
int intMaxSearchCount=0;
int intMaxNavCount=0;
int intMaxUserCount=0;
int intAdminAreaID=0;
int intUserAreaID=0;
//intAdminAreaID
intUserAreaID=Integer.parseInt(request.getParameter("intUserAreaID")==null?"0":request.getParameter("intUserAreaID"));

if(intAdministerState==1){
	//chrEnterpriseName=com.trs.was.bbs.RequestParameterOperation.getParameter(request,"chrEnterpriseName");
	chrEnterpriseName=request.getParameter("chrEnterpriseName");
	//intMaxSearchCount=Integer.parseInt(request.getParameter("intMaxSearchCount"));
	intMaxNavCount=Integer.parseInt(request.getParameter("intMaxNavCount"));
	intMaxUserCount=Integer.parseInt(request.getParameter("intMaxUserCount"));
	intAdminAreaID=Integer.parseInt(request.getParameter("intAdminAreaID"));
}
//开通网上分析功能
int intAnalyseState=request.getParameter("AnalyseState")==null?0:Integer.parseInt(request.getParameter("AnalyseState"));
int intAnalyseNumUpperlimit=request.getParameter("AnalyseNumUpperlimit")==null?5000000:Integer.parseInt(request.getParameter("AnalyseNumUpperlimit"));

//文摘批量下载量设置（分析系统批量下载工具）
String strABSTBatchCount = null;
int intABSTBatchCount = 0;

java.util.Date dExp = null;
int addok=0;
int intNumberPerPage = 10;

boolean bf = false;
	
	//获取参数
	int intGroupID = request.getParameter("groupid")==null?9:Integer.parseInt(request.getParameter("groupid"));
	String itemGrants[]=request.getParameterValues("opers");
	strUserName=request.getParameter("UserName");
	//System.out.println("11111111111111................addusersubmit.jsp");
	strPassword=request.getParameter("Password");
	strRePassword=request.getParameter("rePassword");
	strRealName=request.getParameter("RealName");
	strPhone=request.getParameter("Phone");
	strMobile=request.getParameter("Mobile");
	strFax=request.getParameter("Fax");
	strEmail= request.getParameter("Email");
	strAddress=request.getParameter("Address");
	strDepartment=request.getParameter("Department");
	strMaxLogin=request.getParameter("MaxLogin");
	strCMemo=request.getParameter("CMemo");
	strCount_in=request.getParameter("Count_in");
	strCount_out=request.getParameter("Count_out");
	strDefaultIP = request.getParameter("defaultip");
	
	intIPLimit = request.getParameter("IPLimit")==null?0:Integer.parseInt(request.getParameter("IPLimit"));
	
	strIPAdress = request.getParameter("IPAdress");
//	System.out.println("11111111111111................addusersubmit.jsp");
	 
	 String itemGrant="";
	 if(itemGrants!=null && itemGrants.length>0){
		 for(int i=0;i<itemGrants.length;i++)
		 {
		   if(i==0)
		   {
			   itemGrant=itemGrants[i];
		   }
		   else
		   {
			   itemGrant=itemGrant+","+itemGrants[i];
		   }
		 }
	 }
/****************************************************************/
	int administerID=0;
	if(request.getParameter("administerID")==null||request.getParameter("administerID").equals(""))
	{
		administerID=adminID;
	}else{
		administerID=Integer.parseInt((String)request.getParameter("administerID"));
	}
	
	intCount_in = Integer.parseInt(strCount_in);
	intCount_out = Integer.parseInt(strCount_out);
	intNumberPerPage = Integer.parseInt(request.getParameter("NumberPerPage"));
	strExpTime = request.getParameter("SDate");
	
	strHerbal_Name=(request.getParameter("herbal_name")==null)?"":com.trs.was.bbs.RequestParameterOperation.getParameter(request,"herbal_name");
	//System.out.println("addusersubmit.jsp  strExpTime  SDate : "+strExpTime);
	
	strABSTBatchCount = request.getParameter("ABSTBatchCount");
	//java.text.DateFormat df = java.text.DateFormat.getDateInstance();
	//dExp = df.parse(strExpTime);	
	
	UserManage usermanage=new UserManage();
	/*strUserName=new String(strUserName.getBytes("8859_1"),"GBK");
	if(strRealName!=null)
	{
	  strRealName=new String(strRealName.getBytes("8859_1"),"GBK");
	}
	if(strPhone!=null)
	{
	  strPhone=new String(strPhone.getBytes("8859_1"),"GBK");
	}
	if(strMobile!=null)
	{
	  strMobile=new String(strMobile.getBytes("8859_1"),"GBK");
	}
	if(strFax!=null)
	{
	  strFax=new String(strFax.getBytes("8859_1"),"GBK");
	}
	if(strEmail!=null)
	{
	  strEmail=new String(strEmail.getBytes("8859_1"),"GBK");
	}
	if(strAddress!=null)
	{
	  strAddress=new String(strAddress.getBytes("8859_1"),"GBK");
	}
	if(strDepartment!=null)
	{
	  strDepartment=new String(strDepartment.getBytes("8859_1"),"GBK");
	}
	if(strCMemo!=null)
	{
	  strCMemo=new String(strCMemo.getBytes("8859_1"),"GBK");
	}
	if(strCount_in!=null)
	{
	  strCount_in=new String(strCount_in.getBytes("8859_1"),"GBK");
	}
	if(strCount_out!=null)
	{
	  strCount_out=new String(strCount_out.getBytes("8859_1"),"GBK");
	}
	if(strDefaultIP!=null)
	{
	  strDefaultIP=new String(strDefaultIP.getBytes("8859_1"),"GBK");
	}
	if(strMaxLogin!=null)
	{
	  strMaxLogin=new String(strMaxLogin.getBytes("8859_1"),"GBK");
	}
	
	if(strMerchantID!=null)
	{
	  strMerchantID=new String(strMerchantID.getBytes("8859_1"),"GBK");
	}*/
	
	/*
	if(strGroupID!=null)
	{
	   intGroupID=Integer.parseInt(strGroupID);
	}
	*/

	if(strABSTBatchCount!=null)
	{
	   intABSTBatchCount=Integer.parseInt(strABSTBatchCount);
	}

//addok=usermanage.addUser(strUserName,strPassword,strRealName,strPhone,strMobile,strFax,strEmail,strAddress,strDepartment,strMaxLogin,strCMemo,intCount_in,intCount_out,strExpTime,intGroupID,intNumberPerPage,intABSTBatchCount,strMerchantID,strMAC,strIPAdress,administerID,strHerbal_Name,"",strDefaultIP,strMenuID,intAdministerState,chrEnterpriseName,intMaxSearchCount,intMaxNavCount,intMaxUserCount,arrTradeList,intAnalyseState,intUserAreaID,intAdminAreaID);

addok=usermanage.addUser(application,strUserName,strPassword,strRealName,
			strPhone,strMobile,strFax,strEmail,strAddress,strDepartment,
			strMaxLogin,strCMemo,intCount_in,intCount_out,strExpTime,
			intGroupID,intNumberPerPage,intABSTBatchCount,strMerchantID,
			strMAC,strIPAdress,administerID,strHerbal_Name,"",intIPLimit,
			strMenuID,intAdministerState,chrEnterpriseName,
			intMaxSearchCount,intMaxNavCount,intMaxUserCount,
			arrTradeList,
			intAnalyseState,intAnalyseNumUpperlimit,intUserAreaID,intAdminAreaID);

	  if(addok==-1)
	  {
			//throw new UNIException(284,"更新用户信息失败！",null);
			response.sendRedirect(path+"/admin/usermanager/jsp/common/error1.jsp?act=add");
	  }else if(addok==-2)
	  {
	    response.sendRedirect(path+"/admin/usermanager/jsp/common/error1.jsp?act=addsame");
		//throw new UNIException(282,"重名了,请用其他名字！",null);
	  }else if(addok==-3)
	  {
	    //throw new UNIException(282,"MerchantID重名了,请用其他名字！",null);
	  }else if(addok==-4)
	  {
	  	response.sendRedirect(path+"/admin/usermanager/jsp/common/error1.jsp?act=mendareasame");
		//throw new UNIException(282,"MerchantID重名了,请用其他名字！",null);
	  }else{
//		  IPCheckUtils.setUserLimitIP(strUserName,limitIP);
//		  String tip="添加用户成功！";
		  String tip = URLEncoder.encode("添加用户成功！","utf-8");
		  String url=path+"/admin/usermanager/jsp/common/success.jsp?tip="+tip+"&act=goon&strExpTime="+strExpTime;
		//url=new String(url.getBytes("UTF-8"),"ISO8859_1");
			
			//记录log74日志  
			if(Log74Access.getProperty(Log74Util.getLOG_OPEN())!=null && Log74Access.getProperty(Log74Util.getLOG_OPEN()).equals("1"))
			{ 
				 IprUserDAO userDao =  new IprUserDAO();
				 IprUser  iprUser = userDao.getUserInfoByUsername(strUserName);
				 Log74Util.log_user(strUserName, iprUser.getIntUserId()+"", intGroupID+"", request.getRemoteAddr(), "create", DateUtil.getCurrentDateStr());
			}
		  response.sendRedirect(url);
	  }
	
}catch(Exception ex){
	ex.printStackTrace();
}
%>