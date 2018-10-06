package com.cnipr.cniprgz.commons.taglib;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

import com.cnipr.cniprgz.commons.Util;

public class DetailABColunm extends BodyTagSupport {
	private static final long serialVersionUID = -3971122694875816116L;
	
	private String channelName;
	
	private String strAn;
	
	private String strPd;

	private String strAb; 
	
	public String getChannelName() {
		return channelName;
	}

	public void setChannelName(String channelName) {
		this.channelName = channelName;
	}

	public String getStrAb() {
		return strAb;
	}

	public void setStrAb(String strAb) {
		this.strAb = strAb;
	}

	public String getStrAn() {
		return strAn;
	}

	public void setStrAn(String strAn) {
		this.strAn = strAn;
	}

	public String getStrPd() {
		return strPd;
	}

	public void setStrPd(String strPd) {
		this.strPd = strPd;
	}
	
	@Override
	public int doStartTag() throws JspException {
		StringBuffer sb = new StringBuffer();
		sb.append("<td height=\"25\" colspan=\"2\" class=\"gray\">");
		sb.append(Util.processTifImgTag(strAb, channelName, strPd, strAn));
		sb.append("</td>");
		JspWriter out = pageContext.getOut();
		try {
			out.println(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}

}
