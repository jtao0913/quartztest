<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.trs.usermanage.DBConnect"%>
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
	LoginConfig loginConfig; //用户当前登录对象
	WASUser wUser = null;
	int intUserID = 0;

	loginConfig = (LoginConfig) session.getAttribute("loginconfig");
	if (loginConfig == null) {
		throw new WASException("您的登录已经失效！");
	}

	WASConfig wasconfig = (WASConfig) application
			.getAttribute("wasconfig");
	if (wasconfig == null)
		throw new WASException("XXX#配置信息还未构造完成#Download.service#");
	WASSite wassite = wasconfig.getSite();

	wUser = loginConfig.getLoginInfo().getUser();
	intUserID = wUser.getID();
	int adminID = intUserID;

	PrintWriter printwriter = null;
	String s4 = System.getProperty("file.separator");
	if (s4 == null)
		s4 = "/";

	String operation = com.trs.was.bbs.RequestParameterOperation.getParameter(request, "operation");
	String userName = com.trs.was.bbs.RequestParameterOperation.getParameter(request, "userName");
	String time_from = com.trs.was.bbs.RequestParameterOperation.getParameter(request, "time_from");
	String time_to = com.trs.was.bbs.RequestParameterOperation.getParameter(request, "time_to");
	String file_path = com.trs.was.bbs.RequestParameterOperation.getParameter(request, "file_path");
	String s2 = com.trs.was.bbs.RequestParameterOperation.getParameter(request, "zipfile");

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

	Connection dbconn = DBConnect.getConnection();
	PreparedStatement PrePareStmt = null;
	ResultSet rs = null;
	String strSQL = "";
	String strGrant = "0";

	if (operation.equals("print")) {
		strSQL = "select intGrantID from ipr_grant where chrGrantName like '%打印%'";
		PrePareStmt = dbconn.prepareStatement(strSQL);
		rs = PrePareStmt.executeQuery();
		while (rs.next()) {
			strGrant = strGrant + "," + rs.getString("intGrantID");
		}
	}
	if (operation.equals("download")) {
		strSQL = "select intGrantID from ipr_grant where chrGrantName like '%下载%'";
		PrePareStmt = dbconn.prepareStatement(strSQL);
		rs = PrePareStmt.executeQuery();
		while (rs.next()) {
			strGrant = strGrant + "," + rs.getString("intGrantID");
		}
	}
	if (operation.equals("read")) {
		strSQL = "select intGrantID from ipr_grant where chrGrantName like '%阅读%'";
		PrePareStmt = dbconn.prepareStatement(strSQL);
		rs = PrePareStmt.executeQuery();
		while (rs.next()) {
			strGrant = strGrant + "," + rs.getString("intGrantID");
		}
	}
	if (operation.equals("all")) {
		strSQL = "select intGrantID from ipr_grant where chrGrantName like '%下载%' or chrGrantName like '%打印%' or chrGrantName like '%阅读%'";
		PrePareStmt = dbconn.prepareStatement(strSQL);
		rs = PrePareStmt.executeQuery();
		while (rs.next()) {
			strGrant = strGrant + "," + rs.getString("intGrantID");
		}
	}

	boolean b0 = false;
	String str_ex = "";
	try {
		if (adminID == 1) {//超级管理员
			if(userName == null || userName.equals("")){
		strSQL = "select ipr_all_logs.chrAPO,ipr_all_logs.chrVisitIP,ipr_all_logs.dtVisitTime,ipr_all_logs.chrUserName,ipr_all_logs.chrAPO,"
				+ "ipr_all_logs.intAPOPage,ipr_grant.chrGrantName from ipr_all_logs,ipr_grant,ipr_user "
				+ "where ipr_all_logs.intGrantID=ipr_grant.intGrantID and ipr_all_logs.dtVisitTime<='"
				+ time_to
				+ "' and ipr_all_logs.dtVisitTime>='"
				+ time_from
				+ "' and ipr_all_logs.intGrantID in("
				+ strGrant + ")  and ipr_all_logs.chrUserName=ipr_user.chrUserName order by dtVisitTime desc";
			}else{
		strSQL = "select ipr_all_logs.chrAPO,ipr_all_logs.chrVisitIP,ipr_all_logs.dtVisitTime,ipr_all_logs.chrUserName,ipr_all_logs.chrAPO,"
				+ "ipr_all_logs.intAPOPage,ipr_grant.chrGrantName from ipr_all_logs,ipr_grant,ipr_user "
				+ "where ipr_all_logs.intGrantID=ipr_grant.intGrantID and ipr_all_logs.dtVisitTime<='"
				+ time_to
				+ "' and ipr_all_logs.dtVisitTime>='"
				+ time_from
				+ "' and ipr_all_logs.chrUserName = '"
				+ userName
				+ "' and ipr_all_logs.intGrantID in("
				+ strGrant + ")  and ipr_all_logs.chrUserName=ipr_user.chrUserName order by dtVisitTime desc";
			}
		}else{
			if (userName == null || userName.equals("")) {
		strSQL = "select ipr_all_logs.chrAPO,ipr_all_logs.chrVisitIP,ipr_all_logs.dtVisitTime,ipr_all_logs.chrUserName,ipr_all_logs.chrAPO,"
				+ "ipr_all_logs.intAPOPage,ipr_grant.chrGrantName from ipr_all_logs,ipr_grant,ipr_user "
				+ "where ipr_all_logs.intGrantID=ipr_grant.intGrantID and ipr_all_logs.dtVisitTime<='"
				+ time_to
				+ "' and ipr_all_logs.dtVisitTime>='"
				+ time_from
				+ "' and ipr_all_logs.intGrantID in("
				+ strGrant
				+ ") and ipr_all_logs.chrUserName=ipr_user.chrUserName and (ipr_user.intAdministerID="
				+ adminID + " or ipr_user.intUserID="+adminID+") order by dtVisitTime desc";
			}else{
		strSQL = "select ipr_all_logs.chrAPO,ipr_all_logs.chrVisitIP,ipr_all_logs.dtVisitTime,ipr_all_logs.chrUserName,ipr_all_logs.chrAPO,"
				+ "ipr_all_logs.intAPOPage,ipr_grant.chrGrantName from ipr_all_logs,ipr_grant,ipr_user "
				+ "where ipr_all_logs.intGrantID=ipr_grant.intGrantID and ipr_all_logs.dtVisitTime<='"
				+ time_to
				+ "' and ipr_all_logs.dtVisitTime>='"
				+ time_from
				+ "' and ipr_all_logs.chrUserName = '"
				+ userName
				+ "' and ipr_all_logs.intGrantID in("
				+ strGrant
				+ ") and ipr_all_logs.chrUserName=ipr_user.chrUserName and (ipr_user.intAdministerID="
				+ adminID + " or ipr_user.intUserID="+adminID+") order by dtVisitTime desc";
			}
		}


System.out.println(strSQL);
	/*
		 if(adminID==1){//超级管理员
		 if(userName==null || userName.equals("")){
		 strSQL="select ipr_all_logs.chrAPO,ipr_all_logs.chrVisitIP,ipr_all_logs.dtVisitTime,ipr_all_logs.chrUserName,ipr_all_logs.chrAPO,"
		 +"ipr_all_logs.intAPOPage,ipr_grant.chrGrantName from ipr_all_logs,ipr_grant,ipr_user "
		 +"where ipr_all_logs.intGrantID=ipr_grant.intGrantID and ipr_all_logs.dtVisitTime<='"+time_to
		 +"' and ipr_all_logs.dtVisitTime>='"+time_from+"' and ipr_all_logs.intGrantID in("+strGrant+") order by dtVisitTime desc  limit "+offset+","+limit;
		 }else{
		 strSQL="select ipr_all_logs.chrAPO,ipr_all_logs.chrVisitIP,ipr_all_logs.dtVisitTime,ipr_all_logs.chrUserName,ipr_all_logs.chrAPO,"
		 +"ipr_all_logs.intAPOPage,ipr_grant.chrGrantName from ipr_all_logs,ipr_grant,ipr_user "
		 +"where ipr_all_logs.intGrantID=ipr_grant.intGrantID and ipr_all_logs.dtVisitTime<='"+time_to
		 +"' and ipr_all_logs.dtVisitTime>='"+time_from+"' and ipr_all_logs.chrUserName = '"+userName
		 +"' and ipr_all_logs.intGrantID in("+strGrant+") order by dtVisitTime desc  limit "+offset+","+limit;
		 }
		 }else{
		 if(userName==null || userName.equals("")){
		 strSQL="select ipr_all_logs.chrAPO,ipr_all_logs.chrVisitIP,ipr_all_logs.dtVisitTime,ipr_all_logs.chrUserName,ipr_all_logs.chrAPO,"
		 +"ipr_all_logs.intAPOPage,ipr_grant.chrGrantName from ipr_all_logs,ipr_grant,ipr_user "
		 +"where ipr_all_logs.intGrantID=ipr_grant.intGrantID and ipr_all_logs.dtVisitTime<='"+time_to
		 +"' and ipr_all_logs.dtVisitTime>='"+time_from+"' and ipr_all_logs.intGrantID in("+strGrant+")  and ipr_all_logs.chrUserName=ipr_user.chrUserName and ipr_user.intAdministerID="+adminID+" order by dtVisitTime desc  limit "+offset+","+limit;
		 }else{
		 strSQL="select ipr_all_logs.chrAPO,ipr_all_logs.chrVisitIP,ipr_all_logs.dtVisitTime,ipr_all_logs.chrUserName,ipr_all_logs.chrAPO,"
		 +"ipr_all_logs.intAPOPage,ipr_grant.chrGrantName from ipr_all_logs,ipr_grant,ipr_user "
		 +"where ipr_all_logs.intGrantID=ipr_grant.intGrantID and ipr_all_logs.dtVisitTime<='"+time_to
		 +"' and ipr_all_logs.dtVisitTime>='"+time_from+"' and ipr_all_logs.chrUserName = '"+userName
		 +"' and ipr_all_logs.intGrantID in("+strGrant+")  and ipr_all_logs.chrUserName=ipr_user.chrUserName and ipr_user.intAdministerID="+adminID+" order by dtVisitTime desc  limit "+offset+","+limit;
		 }
		 }*/


		PrePareStmt = dbconn.prepareStatement(strSQL);
		rs = PrePareStmt.executeQuery();
//fileoutputstream.write((new String(strSQL)).getBytes());
int j=0;
		String strdes = "";
		while (rs.next()) {
			strdes = new StringBuffer().append(rs.getString("ipr_all_logs.chrUserName")).append("|")
				.append(rs.getString("ipr_all_logs.chrVisitIP"))
				.append("|").append(rs.getString("ipr_all_logs.dtVisitTime"))
				.append("|").append(rs.getString("ipr_grant.chrGrantName"))
				.append("|").append(rs.getString("ipr_all_logs.chrAPO"))
				.append("|").append("第").append(rs.getString("ipr_all_logs.intAPOPage"))
				.append("页").toString();
			if(s2.equals("yes")) {
				//fileoutputstream.write((new String(strdes)).getBytes());
				//fileoutputstream.write((new String("\r\n")).getBytes());
				label = new Label(0, j, rs.getString("ipr_all_logs.chrUserName"));
	        	sheet.addCell(label);
				label = new Label(1, j, rs.getString("ipr_all_logs.chrVisitIP"));
	        	sheet.addCell(label);
				label = new Label(2, j, rs.getString("ipr_all_logs.dtVisitTime"));
	        	sheet.addCell(label);
				label = new Label(3, j, rs.getString("ipr_grant.chrGrantName"));
	        	sheet.addCell(label);
				label = new Label(4, j, rs.getString("ipr_all_logs.chrAPO"));
	        	sheet.addCell(label);
				label = new Label(5, j, "第"+rs.getString("ipr_all_logs.intAPOPage")+"页");
	        	sheet.addCell(label);
			}else {
				printwriter.print(strdes);
				printwriter.print("<br>");
			}
			j++;
		}
		
		rs.close();
		PrePareStmt.close();
		DBConnect.closeConnection(dbconn);

		if (s2.equals("yes")) {
			//fileoutputstream.close();
			book.write();
			book.close();
		} else {
			printwriter.flush();
		}
	} catch (Exception ex) {
		ex.printStackTrace();
		rs.close();
		PrePareStmt.close();
		DBConnect.closeConnection(dbconn);
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