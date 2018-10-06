<%@ page contentType="text/html;charset=utf-8" errorPage="/error.jsp"%>
<%@ page import="Acme.Crypto.*,com.trs.usermanage.*,com.trs.usermanage.UserManage"%>
<%@page import="com.cnipr.cniprgz.authority.user.IPCheckUtils" %>
<%@page import="java.net.URLEncoder"%>

<%@ include file="../../../../jsp/zljs/include-head-base.jsp"%>

<%

try{
	String limitIP = request.getParameter("limitIP");
	String strAdminName= (String)request.getSession().getAttribute("username");

	int intUserID = Integer.parseInt((String)request.getSession().getAttribute("userid"));


int adminID=intUserID;
//**********************取得管理员ID，把属于此id的用户显示出来*****************************
%>
<%
//定义变量
//int	intUserID=0;
int	intGroupId = 0;
String strUserID=null;
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
String strUserState=null;
String strMendGroup=null;
int    intUserState=0;
int intNumberPerPage = 10;
java.util.Date dExp = null;
int    intGroupID=0;
int    mendok=0;
String strMerchantID="",strMAC="",strIPAdress="";
String strHerbal_Name="";
/**************************************** BEGIN ****************************************/
String strMenuID="";
String[] arrMenuIDs;
arrMenuIDs=request.getParameterValues("menuIDs");

if(arrMenuIDs!=null){
	for(int i=0;i<arrMenuIDs.length;i++){
		//System.out.println("arrMenuIDs[i]="+arrMenuIDs[i]);
		strMenuID += arrMenuIDs[i]+",";
	}
}
//System.out.println("strMenuID="+strMenuID);

String[] arrTradeList;
arrTradeList=request.getParameterValues("TradeList");
/*
for(int i=0;i<arrTradeList.length;i++){
	System.out.println("arrTradeList[i]="+arrTradeList[i]);
}*/

int intAdministerState=Integer.parseInt(request.getParameter("AdminState"));
String chrEnterpriseName="";
int intMaxSearchCount=0;
int intMaxNavCount=0;
int intMaxUserCount=0;
int intAdminAreaID=0;
int intUserAreaID=0;
//intAdminAreaID
intUserAreaID=Integer.parseInt(request.getParameter("intUserAreaID"));
//System.out.println("intUserAreaID="+intUserAreaID);

if(intAdministerState==1){
	chrEnterpriseName=request.getParameter("chrEnterpriseName");
	//intMaxSearchCount=Integer.parseInt(request.getParameter("intMaxSearchCount"));
	System.out.println("chrEnterpriseName="+chrEnterpriseName);
	intMaxNavCount=Integer.parseInt(request.getParameter("intMaxNavCount"));
	intMaxUserCount=Integer.parseInt(request.getParameter("intMaxUserCount"));
	intAdminAreaID=Integer.parseInt(request.getParameter("intAdminAreaID"));
}
/***************************************** END ***************************************/
//开通网上分析功能
int intAnalyseState=request.getParameter("AnalyseState")==null?0:Integer.parseInt(request.getParameter("AnalyseState"));
int intAnalyseNumUpperlimit=request.getParameter("AnalyseNumUpperlimit")==null?5000000:Integer.parseInt(request.getParameter("AnalyseNumUpperlimit"));

//文摘批量下载量设置（分析系统批量下载工具）
String strABSTBatchCount = null;
int intABSTBatchCount = 0;

int intIPLimit = request.getParameter("IPLimit")==null?0:Integer.parseInt(request.getParameter("IPLimit"));
//System.out.println("intIPLimit = "+intIPLimit);

String strDownloadedCount = null;
int intDownloadedCount = 0;

boolean bf = false;
	
	//获取参数
	String itemGrants[]=request.getParameterValues("opers");
	strUserID=request.getParameter("userid");
	strGroupID = request.getParameter("groupid");
	strUserName=request.getParameter("UserName");
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
	strMendGroup=request.getParameter("mendgroup");
	
	strIPAdress = request.getParameter("IPAdress");
	//System.out.println("============================================================mend="+strMendGroup);
	strHerbal_Name=(request.getParameter("herbal_name")==null)?"":com.trs.was.bbs.RequestParameterOperation.getParameter(request,"herbal_name");
	
	 String itemGrant=null;
	 if(strMendGroup!=null && strMendGroup.equals("1") && itemGrants!=null && itemGrants.length>0){
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
//int administerID=Integer.parseInt((String)request.getParameter("administerID"));
//System.out.println("administerID====::::::"+request.getParameter("administerID"));
	int administerID=0;
	if(request.getParameter("administerID")==null||request.getParameter("administerID").equals(""))
	{
		administerID=adminID;
	}else{
		administerID=Integer.parseInt((String)request.getParameter("administerID"));
	}
	
	intCount_in = Integer.parseInt(strCount_in);
	intCount_out = Integer.parseInt(strCount_out);
	strExpTime = request.getParameter("SDate");
	strUserState=request.getParameter("UserState");

	intNumberPerPage = Integer.parseInt(request.getParameter("NumberPerPage"));
	//java.text.DateFormat df = java.text.DateFormat.getDateInstance();
	//dExp = df.parse(strExpTime);
	strABSTBatchCount = request.getParameter("ABSTBatchCount");
	strDownloadedCount = request.getParameter("DownloadedCount");
	
	UserManage usermanage=new UserManage();
	if(strUserID!=null)
	{
	  intUserID=Integer.parseInt(strUserID);
	}
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
	}
	*/
	if(strGroupID!=null)
	{
	   intGroupID=Integer.parseInt(strGroupID);
	}
	
	
	
	if(strABSTBatchCount!=null)
	{
	   intABSTBatchCount=Integer.parseInt(strABSTBatchCount);
	}

	if(strDownloadedCount!=null)
	{
	   intDownloadedCount=Integer.parseInt(strDownloadedCount);
	}
	
	if(strUserState!=null)
	{
	   intUserState=Integer.parseInt(strUserState);
	}
	
	//System.out.println("intUserAreaID="+intUserAreaID);
	mendok=usermanage.updateUser(strUserName,strPassword,strRealName,strPhone,strMobile,strFax,strEmail,strAddress,strDepartment,strMaxLogin,strCMemo,intCount_in,intCount_out,strExpTime,intGroupID,
									intUserState,strMendGroup,intUserID,intNumberPerPage,intABSTBatchCount,intDownloadedCount,strMerchantID,strMAC,strIPAdress,administerID,strHerbal_Name,"",
									intIPLimit,
	  								strMenuID,intAdministerState,chrEnterpriseName,intMaxSearchCount,intMaxNavCount,intMaxUserCount,arrTradeList,intAnalyseState,intAnalyseNumUpperlimit,intUserAreaID,intAdminAreaID);
	
	if(mendok==-1)
	  {
	    response.sendRedirect(path+"/admin/usermanager/jsp/common/error1.jsp?act=mend");
		//throw new UNIException(284,"更新用户信息失败！",null);
	  }else if(mendok==-2)
	  {
	    response.sendRedirect(path+"/admin/usermanager/jsp/common/error1.jsp?act=mendsame");
		//throw new UNIException(282,"重名了,请用其他名字！",null);
	  }else if(mendok==-3)
	  {
		//throw new UNIException(282,"MerchantID重名了,请用其他名字！",null);
	  }else if(mendok==-4)
	  {
	  	response.sendRedirect(path+"/admin/usermanager/jsp/common/error1.jsp?act=mendareasame");
		//throw new UNIException(282,"MerchantID重名了,请用其他名字！",null);
	  }else{
	  	/*	boolean b_inuse=false;
			
			WASConfig wasConfig  = (WASConfig)application.getAttribute("wasconfig");	//获得TRS WAS配置信息对象
			if(wasConfig==null)
			{
				wasConfig = new com.trs.was.config.WASConfig(); //构造新的配置信息对象
				application.setAttribute("wasconfig",wasConfig); //保存
			}
			MapWASUser mapwasuser = wasConfig.getMapWASUser();
			Hashtable hashtable = mapwasuser.getHSCount();
			
			if(hashtable!=null){
				Enumeration e = hashtable.keys();
				while(e.hasMoreElements()) {
					int key = ((Integer)e.nextElement()).intValue();
					//WASUser wasuser = (WASUser)ht.get(key); 
					//System.out.println(key + " " + value + " " + key.hashCode() + " " + value.hashCode());
					//System.out.println("key="+key);
					//WASUser wasuser = mapwasuser.getUser(key);
					//System.out.println(wasuser.getRealUserName());
					if(key==intUserID){
						b_inuse=true;
					}
				}
			}

			if(b_inuse){
				WASUser wasuser = mapwasuser.getUser(intUserID);
				mapwasuser.editAPPUser(intUserID,wasuser);
			}

			*/
	
			//IPCheckUtils.setUserLimitIP(strUserName,limitIP);
		  String tip = URLEncoder.encode("用户修改成功！","utf-8");
		  //tip=new String(tip.getBytes("GBK"),"8859_1");
		  String url=path+"/admin/usermanager/jsp/common/success.jsp?tip="+tip+"&f_url=userlist.jsp";
%>
<SCRIPT language="javascript">
//alert("用户修改成功！");
//window.close();
</SCRIPT>
<%		  
		  response.sendRedirect(url);
	  	
	  }

}catch(Exception ex){
	System.out.println(ex.toString());
}
%>