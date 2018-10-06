package com.cnipr.cniprgz.struts.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.entity.ChannelInfo;
import com.cnipr.cniprgz.entity.ExpressionInfo;
import com.cnipr.cniprgz.func.ExpressionFunc;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import net.sf.json.JSONArray;

public class ExpressionAction extends ActionSupport {

	private static final long serialVersionUID = 1482286996326815874L;
	
	private ExpressionFunc expFunc;

	public ExpressionFunc getExpFunc() {
		return expFunc;
	}

	public void setExpFunc(ExpressionFunc expFunc) {
		this.expFunc = expFunc;
	}
	
	public String showExpression() throws Exception{
		return SUCCESS;
	}
	
	public String getExp() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		int pageno = request.getParameter("pageno")==null?1:Integer.parseInt(request.getParameter("pageno"));
		
		String area = request.getParameter("area");
//		if(area==null||area.equals("")){
//			area = (String)request.getAttribute("area");
//		}
		if(area==null||area.equals("")){
			area = "cnfr";
		}
		
		//////////////////////////////////////////////////////////////////////////////////////
    	Map<String, Object> application = cxt.getApplication();
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>)application.get("channelInfoList_fr");
		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>)application.get("channelInfoList_cn");
		
//		HashMap<String,String> hm_channel_fr = new HashMap<String,String>();
//		for(ChannelInfo ci:channelInfoList_fr)  
//		{  
//			System.out.println(ci.getIntChannelID());
//			hm_channel_fr.put(ci.getChrChannelName(), ci.getChrTRSTable());
//		}
//		HashMap<String,String> hm_channel_cn = new HashMap<String,String>();
//		for(ChannelInfo ci:channelInfoList_cn)  
//		{  
//			System.out.println(ci.getIntChannelID());
//			hm_channel_cn.put(ci.getChrChannelName(), ci.getChrTRSTable());
//		}
		
		HashMap<String,String> hm_channel = new HashMap<String,String>();		
		
/*		for(ChannelInfo ci:area.equals("cn")?channelInfoList_cn:channelInfoList_fr)  
		{  
//			System.out.println(ci.getIntChannelID());
			hm_channel.put(ci.getChrChannelName(), ci.getChrTRSTable());
		}
*/		
		if(area.equals("cn")) {
			for(ChannelInfo ci:channelInfoList_cn)  
			{
//				System.out.println(ci.getIntChannelID());
				hm_channel.put(ci.getChrChannelName(), ci.getChrTRSTable());
			}
		}
		else if(area.equals("fr")) {
			for(ChannelInfo ci:channelInfoList_fr)  
			{  
//				System.out.println(ci.getIntChannelID());
				hm_channel.put(ci.getChrChannelName(), ci.getChrTRSTable());
			}
		}
		else if(area.equals("cnfr")) {
			for(ChannelInfo ci:channelInfoList_cn)  
			{  
//				System.out.println(ci.getIntChannelID());
				hm_channel.put(ci.getChrChannelName(), ci.getChrTRSTable());
			}
			for(ChannelInfo ci:channelInfoList_fr)  
			{  
//				System.out.println(ci.getIntChannelID());
				hm_channel.put(ci.getChrChannelName(), ci.getChrTRSTable());
			}
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		String userType = (String) request.getSession().getAttribute("strUserType");
		String userID = (String) request.getSession().getAttribute(Constant.APP_USER_ID);
		
		int intCountry = (area != null && area.equalsIgnoreCase("fr")) ? 1 : 0;  
		if(area.equalsIgnoreCase("cnfr"))
		{
			intCountry=2;
		}
		
		String userIP = null;
		if (userType != null && userType.equals("corp")) {}
		userIP = com.cnipr.cniprgz.commons.Common.getRemoteAddr(request);
		
		
		int totalpages = request.getParameter("totalpages")==null?0:Integer.parseInt(request.getParameter("totalpages"));
		
		expFunc.setTotalpages(totalpages);		
		
		List<ExpressionInfo> expList = expFunc.getExp(Integer.parseInt(userID), userIP, intCountry, pageno);
		
		if(totalpages==0) {
			totalpages = expFunc.getTotalpages();
		}
		
		List<ExpressionInfo> newExpList = new ArrayList<ExpressionInfo>();
		
		Iterator<ExpressionInfo> iter = expList.iterator();
		while(iter.hasNext())
		{
			ExpressionInfo ei = iter.next();			
//			System.out.println(ei.getChannel());
			
			String channeltablename = ei.getChannel();
			String channeltable = "";
			String[] arrchanneltablename = channeltablename.split(",");
			for(int i=0;i<arrchanneltablename.length;i++){
				channeltable += hm_channel.get(arrchanneltablename[i])+",";
			}
			if(channeltable.endsWith(",")){
				channeltable = channeltable.substring(0, channeltable.length()-1);
			}
			
			ei.setChanneltable(channeltable);			
			newExpList.add(ei);
			//System.out.println(iter.next());
		}
		
/*		request.setAttribute("expList", newExpList);
		request.setAttribute("area", area);
		
		if (area.equals("cn")) {
			return Action.SUCCESS;
		}
		else if (area.equals("fr")) {
			return Action.NONE;
		}else {
			return INPUT;
		}*/
		
		JSONArray json = JSONArray.fromObject(newExpList);//将list对象转换成json类型数据
		
//		jsonresult = "success##"+json.toString();//给result赋值，传递给页面
		jsonresult = totalpages+ "#" + json.toString();
		
		return SUCCESS;		
	}
		
	public String changeState() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		String state = request.getParameter("state");
		String expId = request.getParameter("expid");
		expFunc.updateState(Integer.parseInt(expId),Integer.parseInt(state));
		return getExp();
	}
	
	public String showExpContent() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		String expId = request.getParameter("expid");
		if(expId!=null&&!expId.equals("")) {
			ExpressionInfo ei = expFunc.getExpbyID(Integer.parseInt(expId));
			request.setAttribute("strWhere", ei.getExpression());
			request.setAttribute("strChannels", ei.getSources());
		}
		return SUCCESS;
	}
	
	private String jsonresult;

	public String getJsonresult() {
		return jsonresult;
	}

	public void setJsonresult(String jsonresult) {
		this.jsonresult = jsonresult;
	}
	
	public String deleteExp() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		String expId = request.getParameter("expid");
//		int ret = expFunc.deleteExp(Integer.parseInt(expId));
		if(expFunc.deleteExp(expId)>=1){
			jsonresult = "OK";
		}else{
			jsonresult = "";
		}
		return Action.SUCCESS;
	}
}
