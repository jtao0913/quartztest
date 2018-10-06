package com.cnipr.cniprgz.commons.fenye;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class PageTag extends BodyTagSupport {
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
		// 获取URL
		navigationUrl = getParameterUrl();
		// 设置显示页数的颜色
		getColor();
		StringBuffer strb = new StringBuffer();

		// 分页
		int front = pageIndex - 4; // 前面一截
		int back = pageIndex + 4; // 后面一截

		if (pageIndex == 1) {
			strb.append("<a href=\"#\"> 首页 </a>");
			strb.append("<a href=\"#\"> 上一页 </a>");
		} else {
			strb.append("<a href=\"javascript:nextPage(1)\" target='_self'> 首页 </a>");
			strb.append("<a href=\"javascript:nextPage("+ (pageIndex - 1) +  ")\" target='_self'> 上一页 </a> ");
		}

		if (pageIndex < 5) // 如果索引在前5页
		{
			if (pageCount <= 10) // 总页数不够10页
			{
				for (int i = 1; i <= pageCount; i++) {
					if (i == pageIndex)
						strb.append(" <font color=\"red\">" + pageIndex + "</font> ");
					else
						strb.append("<a href=\"javascript:nextPage("+ i +  ")\" target='_self'>[" + i + "]</a>");
				}
			} else {
				for (int i = 1; i < 10; i++) {
					if (i == pageIndex)
						strb.append(" <font color=\"red\">" + pageIndex + "</font> ");
					else
						strb.append("<a href=\"javascript:nextPage("+ i +  ")\" target='_self'>[" + i + "]</a>");
				}
			}
		} else {
			if (front >= 1) {
				for (int i = 4; i > 0; i--)
					strb.append("<a href=\"javascript:nextPage("+ (pageIndex - i) +  ")\" target='_self'>["
							+ (pageIndex - i) + "]</a>");
			} else {
				for (int i = 1; i < pageIndex; i++)
					strb.append("<a href=\"javascript:nextPage("+ i +  ")\" target='_self'>[" + i + "]</a>");
			}

			strb.append(" <font color=\"red\">" + pageIndex + "</font> "); // 分界线 eg: 5
			// ,前面一截就是1234,后面一截就是6789

			if (back <= pageCount) {
				for (int i = 1; i < 5; i++)
					strb.append("<a href=\"javascript:nextPage("+ (pageIndex + i) +  ")\" target='_self'>["
							+ (pageIndex + i) + "]</a>");
			} else {
				for (int i = 1; i < pageCount - pageIndex + 1; i++)
					strb.append("<a href=\"javascript:nextPage("+ (pageIndex + i) +  ")\" target='_self'>["
							+ (pageIndex + i) + "]</a>");
			}
		}

		if (pageIndex == pageCount) {
			strb.append("<a href=\"#\"> 下一页 </a>");
			strb.append("<a href=\"#\"> 最后一页 </a>");
		} else {
			strb.append(" <a href=\"javascript:nextPage("+ (pageIndex + 1) +  ")\" target='_self'> 下一页 </a>");
			strb.append("<a href=\"javascript:nextPage("+ pageCount +  ")\" target='_self'> 最后一页 </a>");
		}
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
		// 获取URL
		navigationUrl = getParameterUrl();
		// 设置显示页数的颜色
		getColor();
		StringBuffer strb = new StringBuffer();

		//分页
		int front = pageIndex - 4;//前面一截
		int back = pageIndex + 4;//后面一截

		if (pageIndex == 1) {
//			strb.append("<li><a href=\"#\"> <span class=\"icon-white  icon-step-backward\"></span> </a></li>");
//			strb.append("<li><a href=\"#\"> <span class=\"icon-white  icon-chevron-left\" ></span> </a></li>");
//			strb.append("<li><a href=\"#\"> <span style='cursor:pointer;color:#fff'>首页</span> </a></li>");
			strb.append("<li><a href=\"#\"> <span style='cursor:pointer;color:#fff'>上一页</span> </a></li>");
		} else {
//			strb.append("<li><a onClick=\"javascript:nextPage(1)\" target='_self'> <span  style='cursor:pointer;color:#fff'>首页</span> </a></li>");
			strb.append("<li><a onClick=\"javascript:nextPage("+ (pageIndex - 1) +  ")\" target='_self'> <span style='cursor:pointer;color:#fff'>上一页</span> </a></li>");
		}

		strb.append("<li style=\"color: #fff;margin-top:8px;\"><input type=\"text\" onKeyDown=\"if(event.keyCode==13) return false;\" style=\"width: 60px; height: 22px; margin: 0px; line-height: 18px; padding: 0px\" value='"+pageIndex+"' id=\"pageEnterBtn\">");
		
//		strb.append("<input type=\"button\" onClick=\"gotoPage();\" class=\"btn btn-default btn-xs\" style=\"height:23px;line-height:15px;\" id=\"pageEnterGO\" name=\"sub\" value=\"GO\"> ");
		strb.append("<input type=\"button\" onClick=\"gotoPage(this);\" class=\"btn btn-default btn-xs\" style=\"height:25px;line-height:15px;margin-top:1px;\" id=\"pageEnterGO\" name=\"pageEnterGO\" value=\"GO\"> ");
		
		strb.append("/"+pageCount+"</li>");
		
		if (pageIndex == pageCount) {
			strb.append("<li><a href=\"#\"> 下一页 </a></li>");
//			strb.append("<li><a href=\"#\"> <span class=\"icon-white  icon-step-forward\"></span> </a></li>");
//			strb.append("<li><a href=\"#\"> 尾页 </a></li>");
		} else {
//			strb.append("<li><a onClick=\"javascript:nextPage("+ (pageIndex + 1) +  ")\" target='_self'> <span class=\"icon-white  icon-chevron-right\" style='cursor:pointer'></span> </a></li>");
//			strb.append("<li><a onClick=\"javascript:nextPage("+ pageCount +  ")\" target='_self'> <span class=\"icon-white  icon-step-forward\" style='cursor:pointer'></span> </a></li>");
			strb.append("<li><a onClick=\"javascript:nextPage("+ (pageIndex + 1) +  ")\" target='_self'><span style='cursor:pointer;color:#fff''> 下一页 </span></a></li>");
//			strb.append("<li><a onClick=\"javascript:nextPage("+ pageCount +  ")\" target='_self'><span style='cursor:pointer;color:#fff''> 尾页 </span></a></li>");
		}
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
