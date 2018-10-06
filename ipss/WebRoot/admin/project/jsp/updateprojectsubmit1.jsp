<%@ page import="java.io.File,com.trs.usermanage.ParameterSource" contentType="text/html;charset=GBK" %>

<%
    //定义服务器配置参数
    ParameterSource parametersource=new ParameterSource();	//运行参数数据源
	String  foreignImagePath="";				//国外附图物理地址
	String  siteTempPath="";				//临时文件物理地址
	String  strDownloadType="";				//
	int     downloadType=0;					//文摘数据的下载类型
	String  strPriceMode="";
	int     priceMode=0;					//计费模式
	String  strIPLimit="";
	int     ipLimit=0;					//是否使用城域网控制
	String  strDownPrintNums="";
	int     downPrintNums=0;				//每天打印下载数量
	String  strDisplayNums="";
	int     displayNums=0;					//概览每页显示记录数
	String  fmPublishPath="";				//发明数据发布路径
	String  xxPublishPath="";				//新型数据发布路径
	String  wgPublishPath="";				//外观数据发布路径
	String  sqPublishPath="";				//授权数据发布路径
	String  frPublishPath="";				//国外数据发布路径
	String  siteAppPath="";					//站点应用程序路径
	String InternetIP = "";			//服务器外网IP地址
	String IntranetIP = "";			//服务器内网IP地址
	String hangye_visit_style="";
	String PDFPath="";
	String EpoUrl="";

	String FigurePhysicalPath="";
//        foreignImagePath=request.getParameter("foreignImagePath");
//        siteTempPath=request.getParameter("siteTempPath");
//        strDownloadType=request.getParameter("downloadType");
//        strPriceMode=request.getParameter("priceMode");
//        strIPLimit=request.getParameter("ipLimit");
//        strDownPrintNums=request.getParameter("downPrintNums");
//        strDisplayNums=request.getParameter("displayNums");
//        fmPublishPath=request.getParameter("fmPublishPath");
//        xxPublishPath=request.getParameter("xxPublishPath");
//        wgPublishPath=request.getParameter("wgPublishPath");
//        sqPublishPath=request.getParameter("sqPublishPath");
//        frPublishPath=request.getParameter("frPublishPath");
//        siteAppPath=request.getParameter("siteAppPath");
        
        InternetIP=request.getParameter("InternetIP");
        IntranetIP=request.getParameter("IntranetIP");
		hangye_visit_style=request.getParameter("hangye_visit_style")==null?"1":request.getParameter("hangye_visit_style");
		
		FigurePhysicalPath=request.getParameter("FigurePhysicalPath");

		File file =new File(FigurePhysicalPath);
		if(!file.isDirectory()){
%>
		<div align="center"><a href="javascript:history.go(-1)">“说明书附图路径”输入有误，请重新输入</a></div>
<%
			return;
		}else{
			FigurePhysicalPath=file.getAbsolutePath();
		}
//downloadType=Integer.parseInt(strDownloadType);
//priceMode=Integer.parseInt(strPriceMode);
//ipLimit=Integer.parseInt(strIPLimit);
//downPrintNums=Integer.parseInt(strDownPrintNums);
//displayNums=Integer.parseInt(strDisplayNums);
        
try
{
	parametersource.updateParameterSource(foreignImagePath,siteTempPath,downloadType,priceMode,ipLimit,downPrintNums,displayNums,fmPublishPath,xxPublishPath,wgPublishPath,sqPublishPath,frPublishPath,siteAppPath,InternetIP,IntranetIP,"","",Integer.parseInt(hangye_visit_style),FigurePhysicalPath);
	//System.out.println("--------->");
	//执行成功页跳转
	String redirectURL ="../../jsp/success.jsp"; //重定向页面 
	session.setAttribute("f_url","javaScript:window.location='../project/jsp/updateproject1.jsp';window.close();");
		
	response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
	response.setHeader("Location",redirectURL);
}
catch(Exception e)
{
	System.out.println("!!!--------->"+e.toString());
}
%>
