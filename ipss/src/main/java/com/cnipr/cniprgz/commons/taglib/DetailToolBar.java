package com.cnipr.cniprgz.commons.taglib;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.cniprgz.commons.SetupAccess;
import com.cnipr.cniprgz.commons.SetupConstant;
import com.cnipr.corebiz.search.entity.PatentInfo;
import com.cnipr.corebiz.search.entity.WGGBInfo;
import com.cnipr.util.patent.format.IPN_util;

public class DetailToolBar extends BodyTagSupport {

	private static final long serialVersionUID = -6093600863193946854L;

	private String area;

	private PatentInfo patentInfo;
	
	private WGGBInfo wggb;

	public WGGBInfo getWggb() {
		return wggb;
	}

	public void setWggb(WGGBInfo wggb) {
		this.wggb = wggb;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public PatentInfo getPatentInfo() {
		return patentInfo;
	}

	public void setPatentInfo(PatentInfo patentInfo) {
		this.patentInfo = patentInfo;
	}

	@Override
	public int doStartTag() throws JspException {
		StringBuffer sb = new StringBuffer();
//		sb.append("<tr>");
		/*
		 * <tr> <td width="152" nowrap align="center"> ［ <a
		 * onClick="javascript:document.legalStatusForm.submit()"
		 * style="cursor:hand">法律状态</a>］ </td> <td> [ <a
		 * onClick="javascript:document.viewInstructionForm.submit()"
		 * style="cursor:hand">专利说明书全文</a>] </td> </tr>
		 */

		if (area.toLowerCase().equalsIgnoreCase("fr")) {
//			sb.append("<td width=\"152\" nowrap align=\"center\">");
//			sb.append("［<a href=\"http://v3.espacenet.com/legal?DB=EPODOC&IDX="
//					+ patentInfo.getPn() + "&QPN=" + patentInfo.getPn()
//					+ "\" target=\"_blank\" >法律状态</a>］");
//			sb.append("</td>");
//			sb.append("<td width=\"152\" nowrap align=\"center\">");
//			sb.append("［<a href=\"http://v3.espacenet.com/textdes?DB=EPODOC&IDX="
//					+ patentInfo.getPn() + "&QPN=" + patentInfo.getPn()
//					+ "\" target=\"_blank\">国外说明书原文</a>］");
//			sb.append("</td>");
			String pn = processPN(patentInfo.getPn());
			
			sb.append("<span class=\"gray\">［</span><a href=\"http://v3.espacenet.com/legal?DB=EPODOC&IDX="
					+ pn + "&QPN=" + pn
					+ "\" target=\"_blank\">法律状态</a><span class=\"gray\">］</span>");
			sb.append("<span class=\"gray\">［</span><a href=\"http://v3.espacenet.com/textdes?DB=EPODOC&IDX="
					+ pn + "&QPN=" + pn
					+ "\" target=\"_blank\">国外说明书原文</a><span class=\"gray\">］</span>");
			//sb.append("<span class=\"gray\">［</span><a onClick=\"javascript:document.gzgyAnalyse.submit()\" style=\"cursor:hand\" target=\"_blank\">公知公用分析</a><span class=\"gray\">］</span>");
		} else {
			sb.append("<span class=\"gray\">［</span><a onClick=\"javascript:document.legalStatusForm.submit()\" style=\"cursor:hand\" class=\"bluel\">法律状态</a><span class=\"gray\">］</span>");
//			sb.append("<td width=\"152\" nowrap align=\"center\">");
//			sb.append("［<a onClick=\"javascript:document.legalStatusForm.submit()\" style=\"cursor:hand\">法律状态</a>］");
//			sb.append("</td>");
			
			 if(SetupAccess.getProperty(SetupConstant.VIEWTIF)!=null 
					   && SetupAccess.getProperty(SetupConstant.VIEWTIF).equals("1")){ 
				 
					if (patentInfo!=null && patentInfo.getTifDistributePath() != null && !patentInfo.getTifDistributePath().equals("") && patentInfo.getSectionName() != null && !patentInfo.getSectionName().startsWith("wgzl")) {
						sb.append("<span class=\"gray\">［</span><a onClick=\"javascript:document.viewInstructionForm.strUrl.value='" + patentInfo.getTifDistributePath().replaceAll("\\\\", "/")
								+ "'; document.viewInstructionForm.totalPages.value='" + patentInfo.getPages() 
								+ "'; document.viewInstructionForm.submit()\" style=\"cursor:hand\" class=\"bluel\">专利说明书全文</a><span class=\"gray\">］</span>");
		//				sb.append("<td width=\"152\" nowrap align=\"center\">");
		//				sb.append("［<a onClick=\"javascript:document.viewInstructionForm.strUrl.value='" + patentInfo.getTifDistributePath().replaceAll("\\\\", "/")
		//						+ "'; document.viewInstructionForm.totalPages.value='" + patentInfo.getPages() 
		//						+ "'; document.viewInstructionForm.submit()\" style=\"cursor:hand\">专利说明书全文</a>］");
		//				sb.append("</td>");
					}
			 }
			 
			if(SetupAccess.getProperty(SetupConstant.DAIMAHUAVIEW)!=null && SetupAccess.getProperty(SetupConstant.DAIMAHUAVIEW).equals("1"))
			{
				
			//if (patentInfo!=null && patentInfo.getClmPage() != null && !patentInfo.getClmPage().equals("") && patentInfo.getSectionName() != null && !patentInfo.getSectionName().startsWith("wgzl")) 
			if (patentInfo.getPages() != null && !patentInfo.getPages().equals("1") && !patentInfo.getPages().equals("0")
						&& patentInfo.getSectionName() != null
						&& !patentInfo.getSectionName().startsWith("wgzl")
						&& patentInfo.getSectionName().contains("_ab")==false)
			{

				String section = patentInfo.getSectionName();
				if (patentInfo.getSectionName().startsWith("fmzl") || patentInfo.getSectionName().startsWith("fmsq"))
					section = "fmzl_ab,fmzl_ft"; 
				
				sb.append("<span class=\"gray\">［</span><a onClick=\"javascript:document.ViewXML.channel.value='"+ section +"';document.ViewXML.submit()\" style=\"cursor:hand\" class=\"bluel\">代码化</a><span class=\"gray\">］</span>");
//				sb.append("<td width=\"152\" nowrap align=\"center\">");
//				sb.append("［<a onClick=\"javascript:document.ViewXML.submit()\" style=\"cursor:hand\">代码化</a>］");
//				sb.append("</td>");
			}
			}
			
			if(patentInfo.getSqTifPath() != null && !patentInfo.getSqTifPath().equals("") && patentInfo.getSectionName() != null && !patentInfo.getSectionName().startsWith("wgzl"))
			{				
				String section = patentInfo.getSectionName();
				if (patentInfo.getSectionName().startsWith("fmzl") || patentInfo.getSectionName().startsWith("fmsq"))
					section = "fmsq_ab,fmsq_ft"; 
				
				sb.append("<span class=\"gray\">［</span><a onClick=\"javascript:document.viewInstructionForm.strUrl.value='" + patentInfo.getSqTifPath().replaceAll("\\\\", "/")
						+ "'; document.viewInstructionForm.totalPages.value='" + patentInfo.getSqTifPages() 
						+ "'; document.viewInstructionForm.submit()\" style=\"cursor:hand\" class=\"bluel\">审定、授权说明书</a><span class=\"gray\">］</span>");
				
				if(SetupAccess.getProperty(SetupConstant.DAIMAHUAVIEW)!=null && SetupAccess.getProperty(SetupConstant.DAIMAHUAVIEW).equals("1"))
				{
					if ( patentInfo.getPages() != null && !patentInfo.getPages().equals("1") && !patentInfo.getPages().equals("0") 
							&& patentInfo.getSectionName().contains("_ab")==false)
						sb.append("［<a onClick=\"javascript:document.ViewXML.channel.value='"+ section +"';document.ViewXML.submit()\" style=\"cursor:hand\">代码化</a>］");
				}
				
//			    sb.append("<td width=\"152\" nowrap align=\"center\">");
//				sb.append("［<a onClick=\"javascript:document.viewInstructionForm.strUrl.value='" + patentInfo.getSqTifPath().replaceAll("\\\\", "/")
//						+ "'; document.viewInstructionForm.totalPages.value='" + patentInfo.getSqTifPages() 
//						+ "'; document.viewInstructionForm.submit()\" style=\"cursor:hand\">审定、授权说明书</a>］");
//				sb.append("</td>");
			}
			
			/*if (patentInfo.getSectionName() != null && patentInfo.getSectionName().startsWith("wgzl") && wggb != null) {
				sb.append("［<a onClick=\"javascript:document.ViewWGGB.submit()\" style=\"cursor:hand\">浏览外观公报</a>］");
			}*/
			
			if(patentInfo.getSectionName() != null && patentInfo.getSectionName().startsWith("fmsq") && patentInfo.getTifDistributePath() != null && !patentInfo.getTifDistributePath().equals("")){
				
				sb.append("[<a style=\"cursor:hand\" onclick=\"javascript:viewPub('fmzl_ab,fmzl_ft')\">→公开信息</a>]");
			}if(patentInfo.getSectionName() != null && patentInfo.getSectionName().startsWith("fmzl") && patentInfo.getSqTifPath() != null && !patentInfo.getSqTifPath().equals("")){
				
				sb.append("[<a style=\"cursor:hand\" onclick=\"javascript:viewPub('fmsq_ab,fmsq_ft')\">→授权信息</a>]");
			}
			if(SetupAccess.getProperty(SetupConstant.XINYINGXINGQINQUANXINGFENXI)!=null && SetupAccess.getProperty(SetupConstant.XINYINGXINGQINQUANXINGFENXI).equals("1"))
			{
			sb.append("<span class=\"gray\">［</span><a href=\"" + DataAccess.getProperty("xinyinxingAnalyse") + patentInfo.getAn() +"\" target=\"_blank\">新颖性与侵权性分析</a><span class=\"gray\">］</span>");
			}
			if(patentInfo.getPages()!=null && patentInfo.getPages().equals("1") && patentInfo.getIpn()!=null && !patentInfo.getIpn().equals("")){
 				sb.append("[<a href=\"http://v3.espacenet.com/publicationDetails/originalDocument?NR="+IPN_util.toWIPO(patentInfo.getIpn())+"&&CC=WO\" target=\"_blank\">PCT中文说明书</a>]\n");
 			}
		}
//		sb.append("</tr>");
		
		JspWriter out = pageContext.getOut();
		try {
			out.println(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

		return EVAL_PAGE;
	}
	
	private String processPN(String pn) {
		char find='n';
		String curstr=null;
		String thenum="0123456789";
		String zlhstr=pn.substring(2);
		int begin=0;
		int end=0;

		if((zlhstr.indexOf("A")!=-1) || (zlhstr.indexOf("B")!=-1)  || (zlhstr.indexOf("C")!=-1) )
		{	
			for(int i=0;i<zlhstr.length();i++){
		   		begin=i;
		   		end=begin+1;
		   		String tmpstr=zlhstr.substring(begin,end);
		    		if(thenum.indexOf(tmpstr)==-1){
		      			find='y';
		      			break;
		    		}
			}

			if (find=='y') {
		 		curstr=pn.substring(0,begin+2);
			} else {
		 		curstr=pn.substring(0,end+2);
			}
		}else {
			curstr=pn;
		}
		
		return curstr;
	}
	
}
