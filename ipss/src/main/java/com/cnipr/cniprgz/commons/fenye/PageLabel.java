package com.cnipr.cniprgz.commons.fenye;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class PageLabel extends BodyTagSupport {
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

	@Override
	public int doStartTag() throws JspException {
		StringBuffer strb = new StringBuffer();		
//		strb.append("<td width=\"72%\" class=\"gray\">");

		if (pageIndex == 1) {
//			strb.append("<input class=\"btn btn-default\" name=\"FirstPage\" type=\"button\" value=\"第一条\" disabled>");
			strb.append("&nbsp;&nbsp;<input class=\"btn btn-default\" name=\"PrevPage\" type=\"button\" value=\"上一条\" disabled>");
		} else {
//			strb.append("<input class=\"btn btn-default\" name=\"FirstPage\" type=\"button\" onClick=\"javascript:MoveTo('1');\" value=\"第一条\">");
			strb.append("&nbsp;&nbsp;<input class=\"btn btn-default\" name=\"PrevPage\" type=\"button\" onClick=\"javascript:MoveTo('"
							+ (pageIndex - 1) + "');\" value=\"上一条\">");
		}

		if (pageIndex == (pageCount) ) {
			strb.append("&nbsp;&nbsp;<input class=\"btn btn-default\" name=\"NextPage\" type=\"button\" value=\"下一条\" disabled>");
//			strb.append("&nbsp;&nbsp;<input class=\"btn btn-default\" name=\"LastPage\" type=\"button\" value=\"最末条\" disabled>");
		} else {
			strb.append("&nbsp;&nbsp;<input class=\"btn btn-default\" name=\"NextPage\" type=\"button\" value=\"下一条\" onClick=\"javascript:MoveTo('"
							+ (pageIndex + 1) + "');\">");
//			strb.append("&nbsp;&nbsp;<input class=\"btn btn-default\" name=\"LastPage\" type=\"button\" value=\"最末条\" onClick=\"javascript:MoveTo('"
//							+ (pageCount) + "');\">");
		}
//		strb.append("&nbsp;&nbsp;&nbsp; 快速定位：<input type=\"text\" id=\"txtJumpPageNumber\" "
//						+ "size=\"4\" value=\"" + (pageIndex + 1 ) + "\">");
//		
//		strb.append("&nbsp;&nbsp; <input name=\"JumpPage\" type=\"button\" value=\"转到\" "
//						+ "onClick=\"javascript:JumpTo();\">");
//		
//		strb.append("</td><td width=\"28%\" align=\"right\">");
//		
//		strb.append("&nbsp;<input type=\"button\" value=\"打印文摘\" onClick=\"javascript:Print()\">");
//
//		strb.append("&nbsp;<input type=\"button\" value=\"下载文摘\" onClick=\"javascript:Download()\">");
//		
//		strb.append("</td>");
		
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
