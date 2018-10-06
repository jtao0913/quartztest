package com.cnipr.cniprgz.commons.taglib;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

import com.cnipr.cniprgz.entity.ChannelInfo;
import com.cnipr.cniprgz.entity.WASSectionInfo;
import com.opensymphony.xwork2.ActionContext;

public class OverviewPageSectionTag extends BodyTagSupport {

	private static final long serialVersionUID = -3273004883644253853L;

	private String area;

	private String strAllChannels;

	private List<WASSectionInfo> sections;

	private long totalRecord;
	
	private long currentRecord;

	public long getCurrentRecord() {
		return currentRecord;
	}

	public void setCurrentRecord(long currentRecord) {
		this.currentRecord = currentRecord;
	}

	private String filterChannel;

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public List<WASSectionInfo> getSections() {
		return sections;
	}

	public void setSections(List<WASSectionInfo> sections) {
		this.sections = sections;
	}

	public String getStrAllChannels() {
		return strAllChannels;
	}

	public void setStrAllChannels(String strAllChannels) {
		this.strAllChannels = strAllChannels;
	}

	public long getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(long totalRecord) {
		this.totalRecord = totalRecord;
	}

	public String getFilterChannel() {
		return filterChannel;
	}

	public void setFilterChannel(String filterChannel) {
		this.filterChannel = filterChannel;
	}

	public int doStartTag() throws JspException {
		StringBuffer strb = new StringBuffer();
		
		ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>)application.get("channelInfoList_fr");
		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>)application.get("channelInfoList_cn");
		List<ChannelInfo> channelInfoList_sx = (List<ChannelInfo>)application.get("channelInfoList_sx");
		
		HashMap<String,Integer> hm_channel_fr = new HashMap<String,Integer>();
		for(ChannelInfo ci:channelInfoList_fr)  
		{  
//			System.out.println(ci.getIntChannelID());
			hm_channel_fr.put( ci.getChrTRSTable(),ci.getIntChannelID());
		}
		HashMap<String,Integer> hm_channel_cn = new HashMap<String,Integer>();
		for(ChannelInfo ci:channelInfoList_cn)  
		{  
//			System.out.println(ci.getIntChannelID());
			hm_channel_cn.put( ci.getChrTRSTable(),ci.getIntChannelID());
		} 
		HashMap<String,Integer> hm_channel_sx = new HashMap<String,Integer>();
		for(ChannelInfo ci:channelInfoList_sx)
		{  
//			System.out.println(ci.getIntChannelID());
			hm_channel_sx.put( ci.getChrTRSTable(),ci.getIntChannelID());
		}				
		
		String _section = "";
		if (!area.toLowerCase().equalsIgnoreCase("fr"))
		{
			_section = "按类型分别查看检索结果";
		}else{
			_section = "按国家/地区分别查看检索结果";
		}		
		
		strb.append("<ul class=\"nav nav-pills nav-stacked\">");
		
		if(totalRecord==currentRecord){
			strb.append("<li class=\"active\"><a href=\"#\"/>");
		}else{
			strb.append("<li class=\"active\"><a href=\"javascript:getPatentByChannel('"+strAllChannels +"','"+totalRecord+"');\" style=\"background-color: #5cc0cd;\">");
		}
		
		strb.append("<i class=\"icon-chevron-right\" ></i> 全部("+totalRecord+")</a></li>");
		strb.append("</ul>");
				
		strb.append("<p style=\"font-size:14px; padding-left: 15px; color: #66CCCC; padding-top: 7.5px; padding-bottom: 7.5px; background-color: #EFEFEF\">"+_section+"</p>");
		strb.append("<ul class=\"nav nav-pills nav-stacked\" style=\"padding-left: 20px; margin-top: 10px;\">");
		
		String buttonclass = "";
		for (WASSectionInfo section : sections) {
			
			if (section.getChannelName().equals(filterChannel)) {
				buttonclass = "padding:3 0 0 0 ; cursor:hand; width:50; background-color: transparent; border: 0; color:#ff0000; vertical-algin:center;";
			} else {
				buttonclass = "padding:3 0 0 0 ; cursor:hand; width:50; background-color: transparent; border: 0; vertical-algin:center;";
			}
			
//			strb.append("<img src=\"images/index_28.gif\" width=\"16\" height=\"16\">\n");
//			strb.append("<input type=\"button\" onclick=\"getPatentByChannel('"
//							+ section.getChannelName()
//							+ "','"+section.getRecordNum()+"');\" style = \" " + buttonclass + " \" value=\""
//							+ section.getSectionName()
//							+ "\">("
//							+ section.getRecordNum() + ")");
			
			/*
			if(section.getRecordNum()>0){
				strb.append("<li><a href=\"javascript:getPatentByChannel('"+section.getChannelName()+"','"+section.getRecordNum()+"');\">");
			}else{
				strb.append("<li><a href='#');\">");
			}
			*/
//			System.out.println(section.getChannelName());
//			System.out.println(hm_channel.get(section.getChannelName()));
			
			String img = "";
			if (area.toLowerCase().equalsIgnoreCase("fr"))
			{
//				img = "<img style=\"width:25px;margin-bottom:5px\" class=\"img-responsive\" src=\"images/fr/"+hm_channel_fr.get(section.getChannelName())+".png\">";
				
				for(ChannelInfo ci:channelInfoList_fr)  
				{  
//					System.out.println(ci.getIntChannelID());
//					hm_channel_fr.put( ci.getChrTRSTable(),ci.getIntChannelID());
					String nationName = "";
					if(ci.getChrTRSTable().equals(section.getChannelName())){
						nationName = section.getChannelName().toLowerCase().replace(",", "").replace("patent", "");
						img = "<img style=\"width:25px;margin-bottom:5px\" class=\"img-responsive\" src=\"images/fr/"+nationName.toUpperCase()+".png\">";
						break;
					}
				}				
			}else{
//				img = "<img style=\"width:30px;margin-bottom:5px\" class=\"img-responsive\" src=\"images/cn/"+hm_channel_cn.get(section.getChannelName())+".png\">";
			}
			if(section.getRecordNum()==currentRecord){
//				strb.append("<li style=\"font-size:14px; padding-left: 0px; color: #66CCCC; padding-top: 0px; padding-bottom: 0px; background-color: #EFEFEF\">");
				strb.append("<li class=\"active\"><a href=\"#\"/>");
			}else{
				strb.append("<li><a href=\"javascript:getPatentByChannel('"+section.getChannelName()+"','"+section.getRecordNum()+"');\">");
			}
//			strb.append("<a href=\"javascript:getPatentByChannel('"+section.getChannelName()+"','"+section.getRecordNum()+"');\">");
			strb.append("<i class=\"icon-chevron-right\"></i> "+img+" "+section.getSectionName()+"("+section.getRecordNum()+") </a></li>");
			
//			<li><a href="javascript:filterChannelnew('FMZL','791');">
//				<i class="icon-chevron-right"></i> 发明公开(791) </a></li>
//			<li><a href="javascript:filterChannelnew('SYXX','1254');">
//				<i class="icon-chevron-right"></i> 实用新型(1254) </a></li>
//			<li><a href="javascript:filterChannelnew('WGZL','1648');">
//				<i class="icon-chevron-right"></i> 外观设计(1648) </a></li>	
//			</ul>
			
		}
		
		strb.append("</ul>");
		
		
		
//		if (area.equalsIgnoreCase("cn"))
//		{
//			String buttonclass = "";			
//		} else if (area.equalsIgnoreCase("fr")) {
//			strb.append("按国家分别查看检索结果：&nbsp;&nbsp;&nbsp;&nbsp; <select id='sel' name=sel onchange=\"getPatentByChannel(this.options[this.options.selectedIndex].value,'FR')\">\n");
//			String selected = "";
//			if (filterChannel == null || filterChannel.equals("")) {
//				selected = "selected";
//			}
//			strb.append("<option value=\"" + strAllChannels + "\" " + selected
//					+ ">全部(" + totalRecord + ")\n");
//			for (WASSectionInfo section : sections) {
//				if (section.getChannelName().equals(filterChannel)) {
//					selected = "selected";
//				} else {
//					selected = "";
//				}
//				strb.append("<option value=\"" + section.getChannelName()
//						+ "\" " + selected + ">" + section.getSectionName()
//						+ "[" + section.getRecordNum() + "]\n");
//			}
//			strb.append("</select>\n");
//		}

		JspWriter out = pageContext.getOut();
		try {
			out.println(strb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

		return EVAL_PAGE;
	}
}
