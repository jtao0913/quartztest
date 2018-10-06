<%@ page import="com.trs.usermanage.*,java.sql.*,java.util.*" %>
<%@ page import="com.trs.was.bbs.*,com.trs.was.*" %>
<%@ page import="com.trs.was.logininfo.*,com.trs.was.*,com.trs.was.config.*,com.trs.was.datasource.*"%>
<%@ page import="java.io.*,java.util.*,Acme.Crypto.*" %>
<%@ page import="com.trs.was.WASException" %>
<%
	String sr_IP = "";
	String cds_AppIP = "";
	String sr_dataIP = "";	
		Connection con_head = null;
	try
	{
		con_head = DBConnect.getConnection();
		PriceSet ps_head = null;
		Hashtable hCn_head = null;
		ps_head = PriceSet.initPriceSet(con_head);
		hCn_head	= ps_head.getCn();
		sr_IP = hCn_head.get("sr_bookip")+"";
		sr_dataIP = hCn_head.get("sr_dataip")+"";
		cds_AppIP = hCn_head.get("cds_ip")+"";
		//out.write(sr_IP + " " + sr_dataIP + " " + cds_AppIP);
	}
	catch(Exception e)
	{
		
	}
	finally
	{
		try
		{
			if(con_head!=null)
			{
				con_head.close();
				con_head = null;
			}
		}
		catch(Exception ee)
		{}
	}

%>

