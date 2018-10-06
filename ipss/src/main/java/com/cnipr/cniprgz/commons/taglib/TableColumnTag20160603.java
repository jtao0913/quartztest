package com.cnipr.cniprgz.commons.taglib;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.cniprgz.entity.ChannelInfo;
import com.cnipr.corebiz.search.entity.PatentInfo;
import com.opensymphony.xwork2.ActionContext;

/**
 * 概览中表格行标签
 * @author lq
 *
 */

public class TableColumnTag20160603 extends BodyTagSupport {

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
    	Map<String, Object> application = cxt.getApplication();
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>)application.get("channelInfoList_fr");
		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>)application.get("channelInfoList_cn");
		
		HashMap<String,String> hm_channel = new HashMap<String,String>();
		for(ChannelInfo ci:channelInfoList_fr)
		{  
			System.out.println(ci.getIntChannelID());
			hm_channel.put( ci.getChrTRSTable(),ci.getChrChannelName());
		}
//		HashMap<String,String> hm_channel_cn = new HashMap<String,String>();
		for(ChannelInfo ci:channelInfoList_cn)
		{  
			System.out.println(ci.getIntChannelID());
			hm_channel.put( ci.getChrTRSTable(),ci.getChrChannelName());
		} 
		
		
		strb.append("<div class=\"span9\" >");
		
		int index = 0;
		if (patentInfoList != null && patentInfoList.size() != 0) {
			for (PatentInfo patentInfo : patentInfoList) {
				
				
				////////////////////////////////////////////////////////////////////////////////////////////
				try{
				
				strb.append("<!--one 发明 start-->");
				strb.append("<div class=\"row-fluid\">");
				
				strb.append("<span class=\"help-inline\"> <label class=\"checkbox\"");
				strb.append("style=\"width: 100%\"><span style=\"font-weight: bold;\"");
				strb.append("id=\"pindex0\"></span>");
				strb.append("<input type=\"checkbox\" id=\"aho\" name=\"patent\"");
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
				strb.append("<strong class=\"text-info\" style=\"font-size:13px;\"><a style=\"cursor: pointer;\" onclick=\"javascript:getDetail('"+patentInfo.getIndex()+"')\">"+patentInfo.getTi().replace("'", "'")+" ("+patentInfo.getAn()+") </a></strong> ");

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
				
				strb.append("<span class=\"label label-success\">"+NationTypeName+"</span>");
				
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
				
				String[] arrSic = patentInfo.getSic().split(";");
				for(int i=0;i<arrSic.length;i++){
					strb.append("<a href=\"javascript:findIpc(\'"+arrSic[i]+"\');\">"+arrSic[i]+"</a>");
				}
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
				
				strb.append("<div class=\"row-fluid muted\" style=\"padding-left: 5px; padding-right: 15px; padding-bottom: 8px; \">");
				strb.append(patentInfo.getAb().replaceAll("\n", "<br>"));
				strb.append("</div>");
				strb.append("</div>");
				
				
				strb.append("<div class=\"span3\"");
				if(patentInfo.getSectionName().indexOf("wg")==-1)
				{
					strb.append(">");
				}else{
					strb.append(" style=\"width:100%\">");
				}
				if(patentInfo.getSectionName().indexOf("wg")==-1)
				{
					String imgurl = patentInfo.getAbPicPath().equals("http://pic.cnipr.com:8080//foreignimage/")?ctx+"/common/tu/ganlan_pic1.gif":patentInfo.getAbPicPath();
					strb.append("<a class=\"fancybox\" rel=\"group\" href=\""+imgurl+"\">");
					strb.append("<img class=\"img-responsive\" style=\"max-height:160px;\" src=\""+patentInfo.getAbPicPath()+"\" complete=\"complete\" onerror=\"javascript:this.src='"+ctx+"/common/tu/ganlan_pic1.gif';\"/>");
					strb.append("</a>");
				}else{					
					System.out.println(Thread.currentThread().getContextClassLoader().getResource(""));
					System.out.println(TableColumnTag20160603.class.getClassLoader().getResource(""));
					System.out.println(ClassLoader.getSystemResource(""));
					System.out.println(TableColumnTag20160603.class.getResource(""));
					System.out.println(TableColumnTag20160603.class.getResource("/"));//Class文件所在路径
					System.out.println(System.getProperty("user.dir"));
					
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
						imagePubPathList.add(pubPath + "/"
								+ df.format((pageno - 1) * 9 + i) + ".jpg");
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
