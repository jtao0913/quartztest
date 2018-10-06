<%@ page contentType="text/html; charset=GBK" errorPage="../common/error.jsp"%>
<%@ include file="../../../../head.jsp" %>
<%@ include file="../../../../zljs/comm/config.jsp"%>
<%
LoginConfig loginConfig; //用户当前登录对象
String username=null;
WASUser wUser = null;
int intUserID = 0;

loginConfig = (LoginConfig)session.getAttribute("loginconfig");
if(loginConfig==null)
{
	throw new WASException("您的登录已经失效！");
}
username=loginConfig.getLoginInfo().getUserName();
wUser = loginConfig.getLoginInfo().getUser();
intUserID = wUser.getID();

String strAdminName=username;
int adminID=intUserID;
%>
<%
     //获取参数、定义变量
	 String   searchWord=request.getParameter("searchWord");	//获取检索关键字
	 String   pageIndex=request.getParameter("pageIndex");		//获取页码
	 int      intPage=0;                                     	//当前页
	 int      pageCount=15;										//每页显示行数
	 int      intCount=0;										//总共记录数
	 int      intPages=0;										//总共页数
	 String   channelNames[];									//资源名称
	 String   trsTables[];										//TRS表名称
	 String   channelMemos[];									//频道说明
	 int      channelIDs[];										//ID
	 if(pageIndex==null)										//检验是否翻转下一页
	 {
	     pageIndex=request.getParameter("biaozhi");				//如果没点击下一页，检查一下是否跳转页码
	 }
	 if(pageIndex!=null)										//获取到了当前要显示的页码
	 {
	     intPage=Integer.parseInt(pageIndex);
	 }
	 Resource resource=new Resource();
	 if(intPage==0)												//如果没有翻转页码也没有跳转页码，默认当前页面为第一页
	 {
	     intPage=1;
	 }
	 if(searchWord==null||searchWord.equals("")) 
	 {
	     searchWord="";											//如果检索条件空，就把字符串置空，以便下面传递正确参数
		 resource.setMulti(intPage,pageCount);
	 }
	 else
	 {
	     searchWord=new String(searchWord.getBytes("8859_1"),"GBK");
	     resource.setMulti(intPage,pageCount,searchWord);
	 }
	 
	 intCount=resource.getCount();							//获取符合条件的总共记录数
	 intPages=resource.getPages();							//获取共有多少页
	 channelNames=resource.getChannelNames();				//获取频道名称
	 trsTables=resource.getTRSTables();						//获取TRS表名
	 channelMemos=resource.getChannelMemos();				//获取频道描述 
	 channelIDs=resource.getChannelIDs();					//获取频道ID
	 
%>
<html>
<head>
<title>检索服务平台后台管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="../../../css/style.css" type="text/css">
<link rel="stylesheet" href="../../../css/cds_style.css" type="text/css">
<script language="javascript">
<!--
	function checkpageform(form)
	{
		if(form.biaozhi.value=="")
		{
			alert("请指定要浏览的页数！");
			return false;
		}
		if(!isInteger(form.biaozhi.value))
		{
			alert("指定要浏览的页数必须是整数！");
			return false;
		}
		if(form.biaozhi.value<=0 || form.biaozhi.value><%=intPages%>)
		{
			alert("指定要浏览的页数超出了允许的范围！");
			return false;
		}
		form.pageIndex.value=form.biaozhi.value;
		return true;
	}
	function isInteger(inputVal)
	{
		inputStr = inputVal.toString();
		for(var i=0;i<inputStr.length;i++)
		{
			var oneChar = inputStr.charAt(i);
			if(oneChar=="-" && i==0)
			{
				continue;
			}
			if(oneChar<"0" || oneChar>"9")
			{
				return false;
			}
		}
		return true;
	}

//全选开关函数
function allselect()
{
	var i
	
	if( typeof(document.all.form2.sel)=="undefined" )
	{
		return;
	}
	if( document.all.idselall.value=="0" )
	{
		if( typeof(document.all.form2.sel.length) == "undefined" )
		{
		 	document.all.form2.sel.checked=true;
		}
		else
		{
			for(i=0;i<document.all.form2.sel.length;i++)
			{
				document.all.form2.sel[i].checked=true
			}
		}
		document.all.idselall.value = "1";
	}
	else
	{
		if( typeof(document.all.form2.sel.length) == "undefined" )
		{
		 	document.all.form2.sel.checked=false;
		}
		else
		{
			for(i=0;i<document.all.form2.sel.length;i++)
			{
				document.all.form2.sel[i].checked=false
			}
		}
		document.all.idselall.value = "0";
	}
}

function sure()
{
	if(typeof(document.all.form2.sel.length)!="undefined")
	{
		var v=0;
		for(i=0;i<document.all.form2.sel.length;i++)
		{
			if(document.all.form2.sel[i].checked==true)
			{
				v++;
			}
		}
		if(v==0)
		{
			alert("请选中要删除的资源！");
			return false;
		}
	}
	else
	{
			if(document.all.form2.sel.checked==false)
			{
				alert("请选中要删除的资源！");
				return false;
			}
	}
	
	
	if (confirm("确信要删除选中的资源吗?"))
	{
		form2.submit();
	}
	else
	{
		return false;
	}
}
-->
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="38" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="right">
      <table width="487" height="25" border="0" cellpadding="0" cellspacing="0" background="../../../images/biaotibg_list.gif" class="14r">
        <tr> 
          <td width="505" align="right" valign="top"><span class="14r">管 理 资 源 列 表</span></td>
          <td width="11" valign="top">&nbsp;</td>
          <td width="24" valign="top">&lt;&lt;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" background="../../../images/bg_list.gif">
  <tr>
    <td valign="top">
      <table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" class="listbg" background="../../../images/tlbg_list.gif">
        <tr> 
          <td height="28">
          	<table width="100%" height="4" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
          		<tr>
          			<td height="4"></td>
          		</tr>
          	</table>
            <table width="100%" height="28" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td width="7%" align="left" valign="top"><img src="../../../images/tl_list.gif" width="20" height="28"></td>
                <td width="93%"> 
                  <table width="350" height="23" border="0" cellpadding="0" cellspacing="0" class="12green">
                    <form name="form1" method="post" action="ChannelList.jsp">
					<tr> 
                        <td>资源名称：
                          <input type="text" name="searchWord" size="15" value=""></td>
                        <td width="68"><input name="imageField" type="image" src="../../../images/search_list.gif" width="52" height="21" border="0"></td>
                    </tr>
					</form>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td height="24" valign="top">
            <table width="361" height="100%" border="0" cellpadding="0" cellspacing="0">
              <tr align="left">
              	<td width="20">&nbsp;</td>
              	<td width="236" height="18">
              		<table width="217" cellspacing="0" border="0" cellpadding="0">
              		  <tr>
              		    <td width="54" height="18"><%if(intPage!=1) {%><a href="ChannelList.jsp?pageIndex=1&searchWord=<%=searchWord%>">首  页</a><%} else{%>首  页<%}%></td>
                        <td width="54"><%if(intPage!=1) {%><a href="ChannelList.jsp?pageIndex=<%=intPage-1%>&searchWord=<%=searchWord%>">上一页</a><%} else{%>上一页<%}%></td>
                        <td width="54"><%if(intPage!=intPages) {%><a href="ChannelList.jsp?pageIndex=<%=intPage+1%>&searchWord=<%=searchWord%>">下一页</a><%} else{%>下一页<%}%></td>
                        <td width="55"><%if(intPage!=intPages) {%><a href="ChannelList.jsp?pageIndex=<%=intPages%>&searchWord=<%=searchWord%>">尾 页</a><%} else{%>尾 页<%}%></td>
              		  </tr>
              		</table>
                </td>
                <td width="105" > 
                  <table width="105" height="20" border="0" cellpadding="0" cellspacing="0" class="12h">
                    <form name="formpage" method="get" action="ChannelList.jsp" onSubmit="javaScript:return checkpageform(this);">
                      <tr> 
                        <td width="15"> 到 </td>
                        <td width="45" align="left" valign="top"><input name="biaozhi" type="text" class="10int" size="4"></td>
                        <td width="15"> 页 </td>
						<td width="30"><input name="imageField2" type="image" src="../../../images/go_list.gif" width="19" height="11" border="0" style="cursor:hand();"></td>
                      </tr>
                      <input type="hidden" name="searchWord" value="<%=searchWord%>">
					  <input type="hidden" name="pageIndex" value="">
                    </form>
                   </table>
                </td>          
			  </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
    <td width="42%" align="right" valign="top">
      <table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" class="12h">
        <tr> 
          <td width="42%" height="32" align="right">&nbsp;</td>
          <td width="36%" align="right"><a href="AddChannel.jsp"><img src="../../../images/xjzylx.gif"></a></td>
          <td width="18%" align="right"><a href="../../../help/usermanager_jsp_group_grouplist.htm" onClick="javaScript:event.returnValue=false;window.open('../../../help/usermanager_jsp_group_grouplist.htm','','width=800,height=600,scrollbars=yes');"><img src="../../../images/help_list.gif" height="32" border="0"></a></td>
          <td width="4%" height="32">&nbsp;</td>
        </tr>
        <tr> 
          <td height="20" colspan="3" align="right" valign="top">
            <table width="220" height="20" border="0" cellpadding="0" cellspacing="0" class="12h">
              <tr>       
                <td align="right" valign="bottom">
                  <table width="100%" height="5" border="0" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td align="right">共<%=intPages%>页&nbsp;&nbsp;第<%=intPage%>页</td>
                    </tr>
                  </table>

                </td>
              </tr>
            </table>
          </td>
          <td height="20">&nbsp;</td>
        </tr>
      </table>
    </td>    
  </tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center" valign="top">
		  	  <table cellspacing=0 bordercolordark=#ffffff width="100%" bordercolorlight=#4787b8 border=1>
		    <tbody> <form name="form2" method="post" action="deletechannel.jsp">
		      <tr bgcolor="#4787b8"> 
		      <td width="6%" nowrap>&nbsp;</td>
		      <td width="7%" align="center" nowrap><font color="#ffffff"><b>序 号</b></font></td>
		      <td width="20%" align="center" nowrap><font color="#ffffff"><b>资源名称</b></font></td>
		      <td width="12%" align="center" nowrap><strong><font color="#ffffff">对应TRS数据表</font></strong></td>
		      <td width="13%" align="center" nowrap><font color="#ffffff"><b>资源说明</b></font></td>
		      <td width="7%" align="center" nowrap><font color="#ffffff"><b>修改</b></font></td>
		    </tr>
			<%
			int   forLength=0;
			if(channelIDs!=null)
			{
		          forLength=channelIDs.length;
		        }
			for(int i=0;i<forLength;i++)
			{
			%>
                 <tr>			
			        <td width="6%" align="center"><input type="checkbox" name="sel" value="<%=channelIDs[i]%>"> </td>
					<td width="7%" align="center"><%=i+1%></td>
					<td width="20%" align="left" ><%=channelNames[i]%></td>
					<td width="20%" align="left" ><%=trsTables[i]%></td>
					<td width="30%" align="left" ><%=channelMemos[i]%>&nbsp;</td>
			        <td width="7%" align="center"><a href="mendchannel.jsp?channelID=<%=channelIDs[i]%>"><img src="../../../images/icon_edit.gif" border="0"></a></td>
			    </tr>
            <%
			}
			%>
		 </form>
		  </tbody>  
		  </table> 
	</td>
  </tr>
</table>
<table width="100%" height="20" border="0" cellpadding="0" cellspacing="0" bgcolor="#BDD6F4">
  <tr> 
    <td width="58%" valign="top">
      <table width="361" height="20" border="0" cellpadding="0" cellspacing="0">
        <tr align="left"> 
          <td width="20">&nbsp;</td>
          <td width="236">
            <table width="217" cellspacing="0" border="0" cellpadding="0">
              		  <tr>
              		    <td width="54" height="18"><%if(intPage!=1) {%><a href="ChannelList.jsp?pageIndex=1&searchWord=<%=searchWord%>">首  页</a><%} else{%>首  页<%}%></td>
                        <td width="54"><%if(intPage!=1) {%><a href="ChannelList.jsp?pageIndex=<%=intPage-1%>&searchWord=<%=searchWord%>">上一页</a><%} else{%>上一页<%}%></td>
                        <td width="54"><%if(intPage!=intPages) {%><a href="ChannelList.jsp?pageIndex=<%=intPage+1%>&searchWord=<%=searchWord%>">下一页</a><%} else{%>下一页<%}%></td>
                        <td width="55"><%if(intPage!=intPages) {%><a href="ChannelList.jsp?pageIndex=<%=intPages%>&searchWord=<%=searchWord%>">尾 页</a><%} else{%>尾 页<%}%></td>
              		  </tr>
              		</table>
          </td>
        </tr>
      </table>
    </td>
    <td width="42%" align="right" valign="top">
    	<input type="hidden" name="selall" id="idselall" value="0">
    	<img src="../../../images/selectall.gif" border="0" style="cursor:hand;" onClick="allselect()"> <a onclick="javascript:sure();"><img src="../../../images/delete_blue.gif" border="0" style="cursor:hand;"></a>
    </td>
  </tr>
  <tr bgcolor="#5F97DB">
    <td height="1" colspan="2"></td>
  </tr>
</table>
</body>
</html>

