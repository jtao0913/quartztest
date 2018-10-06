package com.cnipr.cniprgz.commons.fenye;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class PageLawTag extends BodyTagSupport {
	private static final long serialVersionUID = -4247241487535299862L;

	private String indexColor = "";

	private String countColor = "";

	private String navigationUrl = "";

	private int pageIndex;

	private int pageCount;

	// 自定义参数
	private String params = "";

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

/*
	@Override
	public int doStartTag() throws JspException {

		StringBuffer strb = new StringBuffer();

		if (pageIndex == 0) {
			strb
					.append("<input name=\"FirstPage\" type=\"button\" value=\"首页\" disabled>");
			strb
					.append("&nbsp;<input name=\"PrevPage\" type=\"button\" value=\"上一页\" disabled>");
		} else {
			strb
					.append("<input name=\"FirstPage\" type=\"button\" onClick=\"javascript:MoveTo('0');\" value=\"首页\">");
			strb
					.append("&nbsp;<input name=\"PrevPage\" type=\"button\" onClick=\"javascript:MoveTo('"
							+ (pageIndex - 1) + "');\" value=\"上一页\">");
		}

		if (pageIndex == (pageCount - 1) ) {
			strb
					.append("&nbsp;<input name=\"NextPage\" type=\"button\" value=\"下一页\" disabled>");
			strb
					.append("&nbsp;<input name=\"LastPage\" type=\"button\" value=\"最后一页\" disabled>");
		} else {
			strb
					.append("&nbsp;<input name=\"NextPage\" type=\"button\" value=\"下一页\" onClick=\"javascript:MoveTo('"
							+ (pageIndex + 1) + "');\">");
			strb
					.append("&nbsp;<input name=\"LastPage\" type=\"button\" value=\"最后一页\" onClick=\"javascript:MoveTo('"
							+ (pageCount - 1) + "');\">");
		}
		strb
				.append("&nbsp;&nbsp; 快速定位：<input type=\"text\" id=\"txtJumpPageNumber\" "
						+ "size=\"4\" value=\"" + (pageIndex + 1) + "\">");
		strb
				.append("&nbsp; <input name=\"JumpPage\" type=\"button\" value=\"转到\" "
						+ "onClick=\"javascript:JumpTo();\">");

		JspWriter out = pageContext.getOut();
		try {
			out.println(strb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}
*/
	@Override
	public int doStartTag() throws JspException {
		
		StringBuffer strb = new StringBuffer();

		strb.append("<ul class=\"nav pull-right\">");
		
		if (pageIndex == 1) {			
			strb.append("<li><a href=\"#\"><span class=\"icon-white icon-step-backward\"></span></a></li>");
			strb.append("<li><a href=\"#\"><i class=\"icon-white  icon-chevron-left\"></i></a></li>");
		} else {			
			strb.append("<li><a href=\"#\" onClick=\"javascript:MoveTo('0');\"><span class=\"icon-white icon-step-backward\"></span></a></li>");
			strb.append("<li><a href=\"#\" onClick=\"javascript:MoveTo('"
							+ (pageIndex - 1) + "');\"><i class=\"icon-white  icon-chevron-left\"></i></a></li>");
		}

//		strb.append("<li style=\"color: #fff;margin-top:8px;\"><input onKeyDown=\"if(event.keyCode==13) return false;\" id=\"pageIndex\" name=\"pageIndex\" type=\"text\" style=\"width: 60px; height: 19px; margin: 0px; line-height: 15px; padding: 0px\" value='"+(pageIndex)+"' onClick=\"javascript:JumpTo();\"><span>");
//		strb.append("<input type=\"button\" onClick=\"gotoPage();\" class=\"btn btn-default btn-xs\" style=\"height:23px;line-height:15px;\" name=\"sub\" value=\"GO\">");
		
		strb.append("<li><a href=\"#\"><span style=\"color:rgb(255,255,255);\">"+pageIndex+"/"+pageCount+"</span></a></li>");
		
		if (pageIndex == (pageCount) ) {			
			strb.append("<li><a href=\"#\" ><i class=\"icon-white icon-chevron-right\"></i></a></li>");
			strb.append("<li><a href=\"#\" ><i class=\"icon-white icon-step-forward\"></i></a></li>");
			
		} else {
			
			
			strb.append("<li><a href=\"#\" onClick=\"javascript:MoveTo('"
							+ (pageIndex + 1) + "');\"><i class=\"icon-white  icon-chevron-right\"></i></a></li>");
			strb.append("<li><a href=\"#\" onClick=\"javascript:MoveTo('"
							+ (pageCount - 1) + "');\"><i class=\"icon-white  icon-step-forward\"></i></a></li>");
		}
//		strb.append("&nbsp;&nbsp; 快速定位：<input type=\"text\" id=\"txtJumpPageNumber\" "
//						+ "size=\"4\" value=\"" + (pageIndex + 1) + "\">");
//		strb.append("&nbsp; <input name=\"JumpPage\" type=\"button\" value=\"转到\" "
//						+ "onClick=\"javascript:JumpTo();\">");

		strb.append("</ul>");
		
		JspWriter out = pageContext.getOut();
		try {
			out.println(strb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}
	
	public String getNavigationUrl() {
		return navigationUrl;
	}

	public void setNavigationUrl(String navigationUrl) {
		this.navigationUrl = navigationUrl;
	}

	public String getCountColor() {
		return countColor;
	}

	public void setCountColor(String countColor) {
		this.countColor = countColor;
	}

	public String getIndexColor() {
		return indexColor;
	}

	public void setIndexColor(String indexColor) {
		this.indexColor = indexColor;
	}

	public String getParams() {
		return params;
	}

	public void setParams(String params) {
		this.params = params;
	}

}
