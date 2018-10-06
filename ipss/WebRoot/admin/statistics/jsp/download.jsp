<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.trs.usermanage.DBConnect"%>
<%@ page import="com.trs.usermanage.StatsManage"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.trs.was.*"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.Random"%>
<%@ page import="com.trs.was.config.*"%>
<%@ page import="com.trs.was.logininfo.*"%>
<%@ page import="com.trs.was.user.*"%>

<%@ page import="jxl.Workbook"%>
<%@ page import="jxl.write.Label"%>
<%@ page import="jxl.write.WritableSheet"%>
<%@ page import="jxl.write.WritableWorkbook"%>

<%
//out.println("strAdminName------>"+strAdminName);
	int adminID = Integer.parseInt((String)request.getSession().getAttribute("userid"));

	PrintWriter printwriter = null;
	String s4 = System.getProperty("file.separator");
	if (s4 == null)
		s4 = "/";

	String operation = com.trs.was.bbs.RequestParameterOperation.getParameter(request, "operation");
	String userName = com.trs.was.bbs.RequestParameterOperation.getParameter(request, "userName");
	String time_from = com.trs.was.bbs.RequestParameterOperation.getParameter(request, "time_from");
	String time_to = com.trs.was.bbs.RequestParameterOperation.getParameter(request, "time_to");
	String s2 = com.trs.was.bbs.RequestParameterOperation.getParameter(request, "zipfile");

	String selectScope=request.getParameter("selectScope")==null?"all":com.trs.was.bbs.RequestParameterOperation.getParameter(request, "selectScope");
	int paixu=request.getParameter("paixu")==null?0:Integer.parseInt(com.trs.was.bbs.RequestParameterOperation.getParameter(request, "paixu"));

	String all_area_user=request.getParameter("all_area_user")==null?"":request.getParameter("all_area_user");
	String time_span=request.getParameter("time_span")==null?"":request.getParameter("time_span");
	
	if(operation==null || operation.equals("")){
		return;
	}

	Random random = new Random();
	String s11 = "filename=";
	int k = random.nextInt(10000);
	s11 = s11 + String.valueOf(k);
	k = random.nextInt(10000);
	s11 = s11 + String.valueOf(k);
	s11 = s11 + ".xls";

	String s12 = "";
	String s13 = "";
	String s14 = "";
	if (s2.equals("yes")) {
		s12 = PTools.createTempPath(wassite.getTempPath());
		s13 = s12 + s4 + s11.substring(s11.lastIndexOf("=") + 1);
		s14 = wassite.getTempPath() + s4 + s11.substring(s11.lastIndexOf("=") + 1) + ".zip";
		s11 = s11.substring(0, s11.lastIndexOf(".")) + ".zip";
	}

	request.setCharacterEncoding("GBK");
	response.setContentType("text/html;charset=GBK");
	response.addHeader("Content-Disposition", s11);
	
	javax.servlet.ServletOutputStream servletoutputstream = null;
	if (s2.equals("no")) {
		Locale locale = Locale.PRC;
		//locale = Locale.TAIWAN;
		response.setLocale(locale);
		String s15 = "GBK";
		servletoutputstream = response.getOutputStream();
		OutputStreamWriter outputstreamwriter = new OutputStreamWriter(servletoutputstream, s15);
		printwriter = new PrintWriter(outputstreamwriter);
	}
/*
	FileOutputStream fileoutputstream = null;
	if (s2.equals("yes")) {
		servletoutputstream = response.getOutputStream();
		fileoutputstream = new FileOutputStream(s13, true);
	}
*/
WritableWorkbook book = Workbook.createWorkbook(new File(s13));
WritableSheet sheet = null;
Label label =null;
	if (s2.equals("yes")) {
		servletoutputstream = response.getOutputStream();
		book = Workbook.createWorkbook(new File(s13));
		sheet = book.createSheet("统计数据", 0);
	}

//fileoutputstream.write((new String(strSQL)).getBytes());
StatsManage statsManage = new StatsManage();
String[][] arrStatistic = null;

if(operation.equals("user")){
	arrStatistic = statsManage.getUserStatistic(time_from,time_to,userName,selectScope,paixu,10,1,adminID,true);
	 label = new Label(1, 0, "中国专利原文打印");
	 sheet.addCell(label);
	 label = new Label(2, 0, "中国专利原文下载");
	 sheet.addCell(label);
	 label = new Label(3, 0, "国外专利文摘打印");
	 sheet.addCell(label);
	 label = new Label(4, 0, "国外专利文摘下载");
	 sheet.addCell(label);
}
if(operation.equals("area")){
	arrStatistic = statsManage.getAreaStatistic(time_from,time_to);
	//用户数量 中国专利原文打印 中国专利原文下载 国外专利文摘打印 国外专利文摘下载
	 label = new Label(1, 0, "用户数量");
	 sheet.addCell(label);
	 label = new Label(2, 0, "中国专利原文打印");
	 sheet.addCell(label);
	 label = new Label(3, 0, "中国专利原文下载");
	 sheet.addCell(label);
	 label = new Label(4, 0, "国外专利文摘打印");
	 sheet.addCell(label);
	 label = new Label(5, 0, "国外专利文摘下载");
	 sheet.addCell(label);
}
if(operation.equals("time")){
	arrStatistic = statsManage.getTimeStatistic(time_from,time_to,selectScope,all_area_user,time_span,10,1,adminID,true);
	 //中国专利原文打印 中国专利原文下载 国外专利文摘打印 国外专利文摘下载 
	 label = new Label(1, 0, "中国专利原文打印");
	 sheet.addCell(label);
	 label = new Label(2, 0, "中国专利原文下载");
	 sheet.addCell(label);
	 label = new Label(3, 0, "国外专利文摘打印");
	 sheet.addCell(label);
	 label = new Label(4, 0, "国外专利文摘下载");
	 sheet.addCell(label);
}


if(arrStatistic==null){
	return;
}


		for(int m=0;m<arrStatistic.length;m++){
			for(int n=0;n<arrStatistic[m].length;n++){
				label = new Label(n, m+1, arrStatistic[m][n]);
//System.out.println(arrStatistic[m][n]);
	        	sheet.addCell(label);
			}
		}

		if (s2.equals("yes")) {
			//fileoutputstream.close();
			book.write();
			book.close();
		} else {
			printwriter.flush();
		}

	if (!s2.equals("no")) {
		com.trs.usermanage.ZipFile zipfile = new com.trs.usermanage.ZipFile();
		zipfile.createZipFile(s14, s12);
		FileInputStream fileinputstream = new FileInputStream(s14);
		if (fileinputstream != null) {
			byte abyte0[] = new byte[8192];
			//javax.servlet.ServletOutputStream servletoutputstream1 = response.getOutputStream();
			for (int l2 = fileinputstream.read(abyte0); l2 != -1; l2 = fileinputstream.read(abyte0))
			{
				servletoutputstream.write(abyte0, 0, l2);
			}
			servletoutputstream.close();
			fileinputstream.close();
		}
		PTools.deleteFile(s12, true);
		File file = new File(s14);
		file.delete();
	}
%>