package com.cnipr.cniprgz.commons.fenye;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class XmlPageTag extends BodyTagSupport {
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
		// 获取URL
		navigationUrl = getParameterUrl();
		// 设置显示页数的颜色
		getColor();
		StringBuffer strb = new StringBuffer();

		HttpServletRequest request = (HttpServletRequest) pageContext
				.getRequest();
		String path = request.getContextPath();

		// String icon_nav_first = "<img src='" + path +
		// "/cniprImages/jieguo_nav_first.jpg' border='0'/>";
		// String icon_nav_pre = "<img src='" + path +
		// "/cniprImages/jieguo_nav_pre.jpg' border='0'/>";
		// String icon_nav_next = "<img src='" + path +
		// "/cniprImages/jieguo_nav_next.jpg' border='0'/>";
		// String icon_nav_last = "<img src='" + path +
		// "/cniprImages/jieguo_nav_last.jpg' border='0'/>";

		strb
				.append("<table border='0' cellpadding='0' cellspacing='0' align='left'>"
						+ "<tr><td>");
		// 分页
		int front = pageIndex - 4; // 前面一截
		int back = pageIndex + 4; // 后面一截

		strb
				.append("<table width='53' border='0' cellpadding='0' cellspacing='0'><tr>");
		if (pageIndex == 1) {
			strb.append("<td><input type=\"button\" value=\"首页\" disabled=\"true\" ></td>");
			// strb.append("<td>" + icon_nav_first + "</td>");
			// strb.append("<a href=\"#\"> 上一页 </a>");
			strb.append("<td><input type=button value=\"上一页\" disabled=\"true\" id=\"btnPrev\"></td>");
		} else {
			// strb.append("<td><a href=\"javascript:nextPage(1)\" target='_self'>"
			// + icon_nav_first + "</a></td>");
			strb.append("<td><input type=\"button\" value=\"首页\" onclick=\"javascript:nextPage(1)\" ></td>");
			strb.append("<td><input type=button value=\"上一页\" onclick=\"javascript:nextPage("
							+ (pageIndex - 1) + ")\"></td>");
		}
		strb.append("</tr></table>");

		strb
				.append("</td><td><table width='53' border='0' cellpadding='0' cellspacing='0'><tr>");

		if (pageIndex == pageCount) {
			strb
					.append("<td><input type=button value=\"下一页\" disabled=\"true\" id=\"btnNext\"></td>");
			 strb.append("<td><input type=\"button\" value=\"尾页\" disabled=\"true\" id=\"btnTail\"></td>");
		} else {
			strb
					.append("<td><input type=button value=\"下一页\" onclick=\"javascript:nextPage("
							+ (pageIndex + 1) + ")\"></td>");
			 strb.append("<td><input type=\"button\" value=\"尾页\" onclick=\"javascript:nextPage("
							+ pageCount + ")\" id=\"btnTail\"></td>");
		}
		strb.append("</tr></table></td><td class=\"style4\">");
		strb
				.append("<input type=\"text\" id=\"page\" name=\"page\" size=\"4\" onkeypress=\"pagetextPress(event);\" value=\""
						+ pageIndex
						+ "\" style=\"height:18;width:48\"> <input type=\"button\" onclick=\"gotoPage();\" name=\"sub\" value=\"转到\"> 共<B>"
						+ pageCount + "</B>页，当前为第<B>" + pageIndex + "</B>页");

		strb.append("</td></tr></table>");

		JspWriter out = pageContext.getOut();
		try {
			out.println(strb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}

	private void getColor() {
		if (indexColor.equals(""))
			indexColor = "red";
		if (countColor.equals(""))
			countColor = "blue";
	}

	private String getParameterUrl() {
		// 没有自定义参数
		if (params.equals(""))
			return navigationUrl;
		StringBuffer url = new StringBuffer();
		url.append(navigationUrl).append("&").append(params);
		return url.toString();
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
