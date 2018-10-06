<%@ page contentType="text/html; charset=GBK" errorPage="../common/error.jsp"%>
<%@ page import="com.trs.usermanage.*"%>
<%
if((String)session.getAttribute("adminName")==null||((String)session.getAttribute("adminName")).equals(""))
{
   response.sendRedirect("/admin/login.htm");
}
%>
<%
      String year_from=request.getParameter("year1");
	  String month_from=request.getParameter("month1");
	  String day_from=request.getParameter("day1");
	  String year_to=request.getParameter("year2");
	  String month_to=request.getParameter("month2");
	  String day_to=request.getParameter("day2");
	  String strPageNumber=request.getParameter("pagenumber");
	  String time_from=year_from+"-"+month_from+"-"+day_from+" 00:00:00";
	  String time_to=year_to+"-"+month_to+"-"+day_to+" 23:59:59";
	  String userName=request.getParameter("userName");
	  
	  int    pageCount=10;
	  int    pageNumber=1;
	  int    count=0;
	  int    pageTotals=0;
	  if(strPageNumber!=null)
	  {
	      pageNumber=Integer.parseInt(strPageNumber);
	  }
	  StatCardRegManage statcardregmanage=new StatCardRegManage();
	  statcardregmanage.setMulti(time_from,time_to,pageCount,pageNumber);
	  String registerTimes[]=statcardregmanage.getRegisterTimes();
	  String cardNumbers[]=statcardregmanage.getCardNumbers();
	  count=statcardregmanage.getCount();
	  if(count==0||count==1)
	  {
	      pageTotals=1;
	  }
	  if(count>1)
	  {
	      pageTotals=(count-1)/pageCount+1;
	  }
	  
%>
<html>
<head>
<title>检索服务平台后台管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<META http-equiv="cache-control" content="no-cache ; charset=GBK">
<META http-equiv="expires" content="0 ; charset=GBK">
<link rel="stylesheet" href="../../css/style.css">
<link rel="stylesheet" href="../../css/cds_style.css" type="text/css">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="38" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="right">
      <table width="487" height="25" border="0" cellpadding="0" cellspacing="0" background="../../images/biaotibg_list.gif" class="14r">
        <tr> 
          <td width="505" align="right" valign="top"><span class="14r">访 问 情 况 统 计 结 果 </span></td>
          <td width="11" valign="top">&nbsp;</td>
          <td width="24" valign="top">&lt;&lt;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#EBEBEB">
  <tr>
    <td align="center" valign="top">
    	<table width="100%" bordercolordark="#ffffff" bordercolorlight="#4787b8" border="0" cellpadding="0" cellspacing="0">
        	<tr align="center"> 
        	  <td colspan="10" nowrap><table width="100%"   border="1" cellspacing="0" cellpadding="0" bordercolorlight="#4787b8" bordercolordark="#FFFFFF">
                <tr>
				  <td width="7%"><div align="center">序号</div></td>
                  <td width="40%"><div align="center"><strong>卡号</strong></div></td>
                  <td width="53%" height="30"><div align="center"><strong>注册时间</strong></div></td>
                </tr>
				<%
				for(int i=0;i<pageCount&&i<(count-pageCount*(pageNumber-1));i++)
				{
				%>
                <tr>
				  <td><div align="center"><%=i+1%></div></td>
                  <td height="30"><div align="center"><%=registerTimes[i]%></div></td>
                  <td height="30"><div align="center"><%=cardNumbers[i]%></div></td>
                </tr>
				<%
				}
				%>
                <tr>
                  <td height="50" colspan="4"><div align="center">
                    <p>共<%=pageTotals%>页<%=count%>条 
<%
    if(pageNumber==1)
	{
%>
首页 上一页 
<%
    }
	else
	{
%>
<a href="result.jsp?year1=<%=year_from%>&month1=<%=month_from%>&day1=<%=day_from%>&year2=<%=year_to%>&month2=<%=month_to%>&day2=<%=day_to%>&pagenumber=1">首页</a>
 <a href="result.jsp?year1=<%=year_from%>&month1=<%=month_from%>&day1=<%=day_from%>&year2=<%=year_to%>&month2=<%=month_to%>&day2=<%=day_to%>&pagenumber=<%=pageNumber-1%>">上一页</a>
<%
	}
	if(pageNumber==pageTotals)
	{
%>
  下一页 尾页 
<%
     }
	 else
	 {
%>
 <a href="result.jsp?year1=<%=year_from%>&month1=<%=month_from%>&day1=<%=day_from%>&year2=<%=year_to%>&month2=<%=month_to%>&day2=<%=day_to%>&pagenumber=<%=pageNumber+1%>">下一页</a>
 <a href="result.jsp?year1=<%=year_from%>&month1=<%=month_from%>&day1=<%=day_from%>&year2=<%=year_to%>&month2=<%=month_to%>&day2=<%=day_to%>&pagenumber=<%=pageTotals%>">尾页</a>
<%
	 }
%>
					第<%=pageNumber%>页</p>
                    <p>
                      <input type="submit" name="Submit" value="  返  回  " onClick="javascript:history.go(-1);">
                    </p>
                  </div></td>
                </tr>
              </table></td>
       	  </tr>
   	  </table>
    </td>
  </tr>
</table>
</body>
</html>
