<%@ page import="java.io.File,com.trs.usermanage.ParameterSource" contentType="text/html;charset=GBK" %>

<%
    //������������ò���
    ParameterSource parametersource=new ParameterSource();	//���в�������Դ
	String  foreignImagePath="";				//���⸽ͼ�����ַ
	String  siteTempPath="";				//��ʱ�ļ������ַ
	String  strDownloadType="";				//
	int     downloadType=0;					//��ժ���ݵ���������
	String  strPriceMode="";
	int     priceMode=0;					//�Ʒ�ģʽ
	String  strIPLimit="";
	int     ipLimit=0;					//�Ƿ�ʹ�ó���������
	String  strDownPrintNums="";
	int     downPrintNums=0;				//ÿ���ӡ��������
	String  strDisplayNums="";
	int     displayNums=0;					//����ÿҳ��ʾ��¼��
	String  fmPublishPath="";				//�������ݷ���·��
	String  xxPublishPath="";				//�������ݷ���·��
	String  wgPublishPath="";				//������ݷ���·��
	String  sqPublishPath="";				//��Ȩ���ݷ���·��
	String  frPublishPath="";				//�������ݷ���·��
	String  siteAppPath="";					//վ��Ӧ�ó���·��
	String InternetIP = "";			//����������IP��ַ
	String IntranetIP = "";			//����������IP��ַ
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
		<div align="center"><a href="javascript:history.go(-1)">��˵���鸽ͼ·����������������������</a></div>
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
	//ִ�гɹ�ҳ��ת
	String redirectURL ="../../jsp/success.jsp"; //�ض���ҳ�� 
	session.setAttribute("f_url","javaScript:window.location='../project/jsp/updateproject1.jsp';window.close();");
		
	response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
	response.setHeader("Location",redirectURL);
}
catch(Exception e)
{
	System.out.println("!!!--------->"+e.toString());
}
%>
