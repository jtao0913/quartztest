package com.cnipr.cniprgz.commons.taglib;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.cniprgz.commons.SetupAccess;
import com.cnipr.cniprgz.entity.ChannelInfo;
import com.cnipr.corebiz.search.entity.PatentInfo;
import com.opensymphony.xwork2.ActionContext;

public class TableColumnTag extends BodyTagSupport {

	private static final long serialVersionUID = -7085365796285863576L;
	
	// 概览中专利信息
	private List<PatentInfo> patentInfoList;
	// 概览显示的字段  （eg: 专利号|120#主分类号|120#名称|500    ps:注释|列宽#注释|列宽)
	private String strDisplayColumn;

	public List<PatentInfo> getPatentInfoList() {
		return patentInfoList;
	}
	
	public void setPatentInfoList(List<PatentInfo> patentInfoList) {
		this.patentInfoList = patentInfoList;
	}
/*
	private Map<String, String> lastestFlztInfo;
	
	public Map<String, String> getLastestFlztInfo() {
		return lastestFlztInfo;
	}

	public void setLastestFlztInfo(Map<String, String> lastestFlztInfo) {
		this.lastestFlztInfo = lastestFlztInfo;
	}
*/
	public String getStrDisplayColumn() {
		return strDisplayColumn;
	}

	public void setStrDisplayColumn(String strDisplayColumn) {
		this.strDisplayColumn = strDisplayColumn;
	}
	
	private String ctx;
	public String getCtx() {
		return ctx;
	}
	public void setCtx(String ctx) {
		this.ctx = ctx;
	}
	
	public int doStartTag() throws JspException {
		StringBuffer strb = new StringBuffer();
		
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
    	Map<String, Object> application = cxt.getApplication();
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>)application.get("channelInfoList_fr");
		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>)application.get("channelInfoList_cn");
		List<ChannelInfo> channelInfoList_sx = (List<ChannelInfo>)application.get("channelInfoList_sx");//全部CN
		
//		String strWhere = (String)request.getAttribute("strWhere");
		
		HashMap<String,String> hm_channel = new HashMap<String,String>();
		for(ChannelInfo ci:channelInfoList_fr)
		{  
//			System.out.println(ci.getIntChannelID());
			hm_channel.put( ci.getChrTRSTable(),ci.getChrChannelName());
		}
//		HashMap<String,String> hm_channel_cn = new HashMap<String,String>();
		for(ChannelInfo ci:channelInfoList_cn)
		{  
//			System.out.println(ci.getIntChannelID());
			hm_channel.put( ci.getChrTRSTable(),ci.getChrChannelName());
		}
		for(ChannelInfo ci:channelInfoList_sx)
		{  
//			System.out.println(ci.getIntChannelID());
			hm_channel.put( ci.getChrTRSTable(),ci.getChrChannelName());
		}
		String translate = (String)application.get("translate");
		
		strb.append("<div class=\"span9\" >");
		
		int index = 0;
		if (patentInfoList != null && patentInfoList.size() != 0) {
			for (PatentInfo patentInfo : patentInfoList) {
				////////////////////////////////////////////////////////////////////////////////////////////
				try{
				
				strb.append("<!--one 发明 start-->");
				strb.append("<div class=\"row-fluid\">");
				
				strb.append("<span class=\"help-inline\"> <label class=\"checkbox\"");
				strb.append("style=\"width: 100%\"><span style=\"font-weight: bold;\" ");
				strb.append("id=\"pindex0\"></span>");//id=\"ab_"+index+"\"
				strb.append("<input type=\"checkbox\" id=\"ti_"+index+"\" name=\"patent\"");
				strb.append(" an='"+patentInfo.getAn()+"' anpn='"+patentInfo.getAn()+"|"+patentInfo.getPnm()+"' title=\""+patentInfo.getTi().replace("'", "\\'")+"\" pid=\""+patentInfo.getSectionName()+"@"+patentInfo.getPnm()+"\"");
				strb.append("sysid=\"#"+patentInfo.getSectionName()+"@"+patentInfo.getPnm()+"\" pnm=\""+patentInfo.getPnm()+"\" value=\"{" +
						"an:'" + patentInfo.getAn() + "'," +
						"sectionName:'" + patentInfo.getSectionName() + 
						"',ti:'"+ patentInfo.getTi().replace("'", "\\'") + 
//						"',pic:'" + patentInfo.getPic()+
//						"',agt:'" + patentInfo.getAgt()+ 
						"',countryCode:'" + patentInfo.getAn().substring(0, 2) +
//						"',tifDistributePath:'" + patentInfo.getTifDistributePath() +
						"',pages:'" + patentInfo.getPages()+
//						"',sic:'" + patentInfo.getSic() + 
//						"', pic:'" + patentInfo.getPic() + 
	 					"',pd:'" + patentInfo.getPd() + 
	 					"',pnm:'" + patentInfo.getPnm()+
//						"',agc:'" + patentInfo.getAgc() +
						"',ad:'" + patentInfo.getAd() + 
						"',ar:'" + patentInfo.getAr()+

//						"',ab:'" + patentInfo.getAb().replaceAll("\n", "<br>") + 
						"',co:'" + patentInfo.getCo()+
						"',pa:'" + patentInfo.getPa()+
						"',pin:'" + patentInfo.getPin()+
//						"',agc:'" + patentInfo.getAgc()+
//						"',agt:'" + patentInfo.getAgc()+
						 "'}\" tifvalue=\""
								+ patentInfo.getTifDistributePath()
								+ ","
								+ patentInfo.getPages()
								+ ","
								+ patentInfo.getAn()
								+ "\"/>");
				
				String NationTypeName = hm_channel.get(patentInfo.getSectionName());
				
				if(NationTypeName==null){
					Iterator iter = hm_channel.entrySet().iterator();
					while (iter.hasNext()) {
						Map.Entry entry = (Map.Entry) iter.next();
						String key = (String)entry.getKey();
						String val = (String)entry.getValue();
						
						if(key.indexOf(patentInfo.getSectionName())>-1){
							NationTypeName = val;
							break;
						}
					}
				}
				
				strb.append("["+NationTypeName+"]");
				strb.append("<strong class=\"text-info\" style=\"font-size:13px;\"><a style=\"cursor: pointer;\" onclick=\"javascript:getDetail('"+patentInfo.getId()+"','"+patentInfo.getSectionName()+"')\">"+patentInfo.getTi().replace("'", "'")+" ("+patentInfo.getAn()+") </a></strong> ");
				strb.append("<span id=\"ti_en_"+index+"\"></span>");				
//				System.out.println(patentInfo.getCountryCode());				
//				待定
//				无效
//				有效
				
				if(translate.equals("1")&&!patentInfo.getCountryCode().toUpperCase().equals("CN")) {
					strb.append("<span onclick=\"translate0('" + index + "')\" class=\"btn btn-warning btn-mini\">翻译</span>&nbsp;");
				}				
				
//				String LatestFlzt = DataAccess.getProperty("LatestFlzt")==null?"0":DataAccess.getProperty("LatestFlzt");
//				if(patentInfo.getCountryCode().toUpperCase().equals("CN")&&LatestFlzt.equals("1"))
				{
//					strb.append("&nbsp;<span class=\"label label-default\">"+lastestFlztInfo.get(patentInfo.getAn())+"</span>");

//					strb.append("&nbsp;<span class=\"label label-success\">success</span>");
//					strb.append("&nbsp;<span class=\"label label-default\">default</span>");
//					strb.append("&nbsp;<span class=\"label label-primary\">primary</span>");
//					strb.append("&nbsp;<span class=\"label label-info\">info</span>");
//					strb.append("&nbsp;<span class=\"label label-warning\">warning</span>");
//					strb.append("&nbsp;<span class=\"label label-danger\">danger</span>");
					
//					Date now = new Date();
//					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");//可以方便地修改日期格式
//					String hehe = dateFormat.format(now);
//					System.out.println(hehe);
//					int thisyear = Integer.parseInt(dateFormat.format(now));
					
					/*
					if(patentInfo.getSectionName().toLowerCase().indexOf("fm")>-1
//							&&(thisyear-Integer.parseInt(patentInfo.getAd().substring(0, 4)))>=20
							){
						Calendar now_ymd = Calendar.getInstance();
						SimpleDateFormat sdf= new SimpleDateFormat("yyyy.MM.dd");
						Date date =sdf.parse(patentInfo.getAd());
						Calendar patentAD = Calendar.getInstance();
						patentAD.setTime(date);
						patentAD.add(Calendar.YEAR, 20);
						
					    int result = now_ymd.compareTo(patentAD);
					    if (result >= 0){
					    	strb.append("&nbsp;<span class=\"label label-default\">无效</span>");
					    }else{
							String flzt_info = lastestFlztInfo.get(patentInfo.getAn());
							if(flzt_info!=null&&flzt_info.equals("在审")){
								strb.append("&nbsp;<span class=\"label label-info\">在审</span>");
							}else if(flzt_info!=null&&flzt_info.equals("无效")){
								strb.append("&nbsp;<span class=\"label label-default\">无效</span>");
							}else if(flzt_info!=null&&flzt_info.equals("有效")){
								strb.append("&nbsp;<span class=\"label label-success\">有效</span>");
							}else{
								strb.append("&nbsp;<span class=\"label label-default\">"+flzt_info+"</span>");
							}
					    }
					}else if((patentInfo.getSectionName().toLowerCase().indexOf("xx")>-1||patentInfo.getSectionName().toLowerCase().indexOf("wg")>-1)
//							&&(thisyear-Integer.parseInt(patentInfo.getAd().substring(0, 4)))>=10
							){
						
						Calendar now_ymd = Calendar.getInstance();
						SimpleDateFormat sdf= new SimpleDateFormat("yyyy.MM.dd");
						Date date =sdf.parse(patentInfo.getAd());
						Calendar patentAD = Calendar.getInstance();
						patentAD.setTime(date);
						patentAD.add(Calendar.YEAR, 10);
						
					    int result = now_ymd.compareTo(patentAD);
					    if (result >= 0){
					    	strb.append("&nbsp;<span class=\"label label-default\">无效</span>");
					    }else{
							String flzt_info = lastestFlztInfo.get(patentInfo.getAn());
							if(flzt_info!=null&&flzt_info.equals("在审")){
								strb.append("&nbsp;<span class=\"label label-info\">在审</span>");
							}else
							if(flzt_info!=null&&flzt_info.equals("无效")){
								strb.append("&nbsp;<span class=\"label label-default\">无效</span>");
							}else
							if(flzt_info!=null&&flzt_info.equals("有效")){
								strb.append("&nbsp;<span class=\"label label-success\">有效</span>");
							}else{
								strb.append("&nbsp;<span class=\"label label-default\">"+flzt_info+"</span>");
							}
					    }						
					}
//					else		
//					{						
//						String flzt_info = lastestFlztInfo.get(patentInfo.getAn());
//						if(flzt_info!=null&&flzt_info.equals("在审")){
//							strb.append("&nbsp;<span class=\"label label-info\">在审</span>");
//						}else
//						if(flzt_info!=null&&flzt_info.equals("无效")){
//							strb.append("&nbsp;<span class=\"label label-default\">无效</span>");
//						}else
//						if(flzt_info!=null&&flzt_info.equals("有效")){
//							strb.append("&nbsp;<span class=\"label label-success\">有效</span>");
//						}else{
//							strb.append("&nbsp;<span class=\"label label-default\">"+flzt_info+"</span>");
//						}
//					}
					*/
//					String flzt_info = lastestFlztInfo.get(patentInfo.getAn());
					String flzt_info = patentInfo.getFlzt();
					
					if(flzt_info!=null&&!flzt_info.equalsIgnoreCase("null")) {
						if(flzt_info.equals("在审")){
							strb.append("&nbsp;<span class=\"label label-info\">在审</span>");
						}else if(flzt_info.equals("无效")){
							strb.append("&nbsp;<span class=\"label label-default\">无效</span>");
						}else if(flzt_info.equals("有效")){
							strb.append("&nbsp;<span class=\"label label-success\">有效</span>");
						}else{
							strb.append("&nbsp;<span class=\"label label-default\">"+flzt_info+"</span>");
						}
					}
				}
				
				strb.append("</label>");
				strb.append("</span>");
				strb.append("</div>");
				
				strb.append("<div class=\"row-fluid\">");
				
				strb.append("<div class=\"span9\"");
				if(patentInfo.getSectionName().toLowerCase().indexOf("wg")>-1){
					strb.append(" style=\"padding-left:20px;font-size:12px;width:100%;\">");
				}else{
					strb.append(" style=\"padding-left:20px;font-size:12px;\">");
				}
				
				strb.append("<div class=\"row-fluid\">");
				strb.append("<span class=\"p-inline\">公开（公告）号： <a href=\"javascript:findPubNum('"+patentInfo.getPnm()+"');\">"+patentInfo.getPnm()+"</a> </span>");
				strb.append("<span class=\"p-inline\">申请日：<a href=\"javascript:findAppDate('"+patentInfo.getAd()+"');\">" + patentInfo.getAd() + "</a></span>");
				strb.append("</div>");
				strb.append("<div class=\"row-fluid\">");
				strb.append("<span class=\"p-inline\">公开（公告）日：<a href=\"javascript:findPubDate('"+patentInfo.getPd()+"');\">" + patentInfo.getPd() + "</a></span>");
				strb.append("<span class=\"p-inline\">分类号：");
				
				String[] arrSic = patentInfo.getSic().split(" ");
				for(int i=0;i<arrSic.length;i++){
					strb.append("<a href=\"javascript:findIpc(\'"+arrSic[i]+"\');\">"+arrSic[i]+"</a>");
				}
				strb.append("<span style=\"display:none\" id=\"ipc_"+index+"\">"+arrSic[0]+"</span>");
				strb.append("</span>");				
				strb.append("</div>");
				
				strb.append("<div class=\"row-fluid\">");
				strb.append("<span class=\"p-inline\"> 申请（专利权）人：");	
				
				String[] arrAppName = patentInfo.getPa().split(";");
				for(int i=0;i<arrAppName.length;i++){
					strb.append("<a href=\"javascript:findAppName(\'"+arrAppName[i]+"\');\">"+arrAppName[i]+"</a>");
				}
				strb.append("</span>");
				
				strb.append("</div>");
				
				strb.append("<div id=\"ab_"+index+"\"  class=\"row-fluid muted\" style=\"padding-left: 5px; padding-right: 15px; padding-bottom: 8px; \">");
				strb.append(patentInfo.getAb()==null?"":patentInfo.getAb().replaceAll("\n", "<br>"));
				
//				strb.append("---"+patentInfo.getAb()+"====");
				
				strb.append("</div>");
				strb.append("<div id=\"ab_en_"+index+"\"></div>");
				strb.append("</div>");

				
String cnAbfigure = com.cnipr.cniprgz.commons.DataAccess.getProperty("cnAbfigure");
cnAbfigure = (cnAbfigure==null||cnAbfigure.equals(""))?"1":cnAbfigure;

String cnwgAbfigure = com.cnipr.cniprgz.commons.DataAccess.getProperty("cnwgAbfigure");
cnwgAbfigure = (cnwgAbfigure==null||cnwgAbfigure.equals(""))?"1":cnwgAbfigure;

String frAbfigure = com.cnipr.cniprgz.commons.DataAccess.getProperty("frAbfigure");
frAbfigure = (frAbfigure==null||frAbfigure.equals(""))?"1":frAbfigure;

if(cnAbfigure.equals("1")&&patentInfo.getAn().substring(0, 2).toLowerCase().equals("cn")
		||
		cnwgAbfigure.equals("1")&&patentInfo.getAn().substring(0, 2).toLowerCase().equals("cn")
		||
		frAbfigure.equals("1")&&!patentInfo.getAn().substring(0, 2).toLowerCase().equals("cn")
		){
				
				strb.append("<div class=\"span3\"");
				if(patentInfo.getSectionName().indexOf("wg")==-1)
				{
					strb.append(">");
				}else{
					strb.append(" style=\"width:100%\">");
				}
				
				if(patentInfo.getAn().substring(0, 2).toLowerCase().equals("cn")&&patentInfo.getSectionName().toLowerCase().indexOf("wg")==-1&&cnAbfigure.equals("1"))
				{
					//FM、XX、SQ
					String imgurl = patentInfo.getAbPicPath().equals(DataAccess.getProperty("XMLServerURL"))?ctx+"/common/tu/ganlan_pic1.gif":patentInfo.getAbPicPath();
					strb.append("<a class=\"fancybox\" rel=\"group\" href=\""+imgurl+"\">");
					strb.append("<img class=\"img-polaroid img-responsive\" style=\"max-height:160px;\" src=\""+imgurl+"\" complete=\"complete\" onerror=\"javascript:this.src='"+ctx+"/common/tu/ganlan_pic1.gif';\"/>");
					strb.append("</a>");
				}else if(patentInfo.getSectionName().indexOf("patent")>-1&&frAbfigure.equals("1"))
				{
					//国外专利
					String imgurl = patentInfo.getAbPicPath().equals(DataAccess.getProperty("PicServerURL")+"//foreignimage/")?ctx+"/common/tu/ganlan_pic1.gif":patentInfo.getAbPicPath();
					strb.append("<a class=\"fancybox\" rel=\"group\" href=\""+imgurl+"\">");
					strb.append("<img class=\"img-polaroid img-responsive\" style=\"max-height:160px;\" src=\""+imgurl+"\" complete=\"complete\" onerror=\"javascript:this.src='"+ctx+"/common/tu/ganlan_pic1.gif';\"/>");
					strb.append("</a>");					
				}else if(patentInfo.getSectionName().toLowerCase().indexOf("wg")>-1&&cnwgAbfigure.equals("1")){
					//中国WG
//					System.out.println(Thread.currentThread().getContextClassLoader().getResource(""));
//					System.out.println(TableColumnTag20160603.class.getClassLoader().getResource(""));
//					System.out.println(ClassLoader.getSystemResource(""));
//					System.out.println(TableColumnTag20160603.class.getResource(""));
//					System.out.println(TableColumnTag20160603.class.getResource("/"));//Class文件所在路径
//					System.out.println(System.getProperty("user.dir"));
					
//					System.out.println(patentInfo.getTifDistributePath());
//					System.out.println(patentInfo.getPublishPath());
//					System.out.println(DataAccess.getProperty("PicServerURL"));
					
					
					String strPages = patentInfo.getPages();
					String pubPath = DataAccess.getProperty("PicServerURL") + patentInfo.getTifDistributePath();
					
					pubPath = pubPath.replace("books", "ThumbnailImage");
					List<String> imagePubPathList = new ArrayList<String>();
					if(strPages == null || "".equals(strPages)){
//						break;
					}
					int intPages = Integer.parseInt(strPages);
					DecimalFormat df = new DecimalFormat("000000");
					int pageno = 1;
					for (int i = 1; i <= intPages; i++) {
						imagePubPathList.add(pubPath + "/" + df.format((pageno - 1) * 9 + i) + ".jpg");
					}
					
					strb.append("<ul class=\"thumbnails\" style=\"margin-left:0px\">");
					Iterator<String> iter = imagePubPathList.iterator();
					
					while(iter.hasNext())
					{
						String imgpath = iter.next();
						strb.append("<li style=\"margin-left: 0px\">");
						strb.append("<div class=\"thumbnail\" style=\"width:120px;height:120px;margin-left:10px\">");
						strb.append("<a class=\"fancybox\" rel=\"group\" href=\""+imgpath+"\">");						
						strb.append("<img src=\""+imgpath+"\" onerror=\"javascript:this.src='"+ctx+"/common/tu/ganlan_pic1.gif';\" class=\"zoomin\" alt=\"\" style=\"width:120px;height:120px;\">");
						strb.append("</a>");
						strb.append("</div>");
						strb.append("</li>");
					}

					strb.append("</ul>");                
				}
				
				strb.append("</div>");				
}


				
				strb.append("</div>");
				}catch(Exception ex){ex.printStackTrace();}
				/////////////////////////////////////////////////////////////////////////////////////////////
				
				index++;
			}
//			strb.append("</div>");
		} else {
//			strb.append("");
		}
		
		strb.append("</div>");
//		strb.append("</table>\n");


		JspWriter out = pageContext.getOut();
		try {
			out.println(strb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}

}
