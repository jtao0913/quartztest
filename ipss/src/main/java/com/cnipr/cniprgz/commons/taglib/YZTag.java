package com.cnipr.cniprgz.commons.taglib;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

import com.cnipr.cniprgz.commons.Util;
import com.cnipr.corebiz.search.entity.YzwsInfo;

/**
 * 引证、被引证、非引证标签
 * 
 * @author Administrator
 * 
 */
public class YZTag extends BodyTagSupport {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 2437331455380421245L;

	// 审查员引证专利文献
	private List<YzwsInfo> scyyzzlList;

	// 审查员引证非专利文献
	private List<YzwsInfo> scyyzfzlList;

	// 申请人引证专利文献
	private List<YzwsInfo> sqryzzlList;

	// 审查员被引证专利文献
	private List<YzwsInfo> scybyzzlList;

	// 申请人被引证专利文献
	private List<YzwsInfo> sqrbyzzlList;

	public List<YzwsInfo> getScyyzzlList() {
		return scyyzzlList;
	}

	public void setScyyzzlList(List<YzwsInfo> scyyzzlList) {
		this.scyyzzlList = scyyzzlList;
	}

	public List<YzwsInfo> getScyyzfzlList() {
		return scyyzfzlList;
	}

	public void setScyyzfzlList(List<YzwsInfo> scyyzfzlList) {
		this.scyyzfzlList = scyyzfzlList;
	}

	public List<YzwsInfo> getSqryzzlList() {
		return sqryzzlList;
	}

	public void setSqryzzlList(List<YzwsInfo> sqryzzlList) {
		this.sqryzzlList = sqryzzlList;
	}

	public List<YzwsInfo> getScybyzzlList() {
		return scybyzzlList;
	}

	public void setScybyzzlList(List<YzwsInfo> scybyzzlList) {
		this.scybyzzlList = scybyzzlList;
	}

	public List<YzwsInfo> getSqrbyzzlList() {
		return sqrbyzzlList;
	}

	public void setSqrbyzzlList(List<YzwsInfo> sqrbyzzlList) {
		this.sqrbyzzlList = sqrbyzzlList;
	}

	@Override
	public int doStartTag() throws JspException {
		StringBuffer sb = new StringBuffer();

		if (scyyzzlList == null && scyyzfzlList == null && sqryzzlList == null
				&& scybyzzlList == null && sqrbyzzlList == null) {
			sb.append("该专利无引证信息");
		} else {

			if (scyyzzlList != null && scyyzzlList.size() > 0) {
				sb.append("<table width=\"100%\">");
				sb.append("<tr><td align=\"center\">【 审查员引证专利文献（"
						+ scyyzzlList.size() + "）】");
				sb.append("<table width=\"100%\">");
				sb
						.append("<tr><td align=\"center\">被引证文献原始数据</td><td align=\"center\">被引证文献专利号</td><td align=\"center\">被引证文献公布日</td></tr>");
				for (YzwsInfo yzwx : scyyzzlList) {
					sb
							.append("<tr><td align=\"center\">"
									+ yzwx.getStrBaseData()
									+ "</td><td align=\"center\"><a href=\""
									+ getYZHref(yzwx.getStrGBH().toUpperCase(),
											"scyyz") + "\">" + yzwx.getStrGBH()
									+ "</a></td><td align=\"center\">"
									+ yzwx.getStrGBRQ() + "</td></tr>");
				}
				sb.append("</table></td></tr></table><br>");
			}

			if (scyyzfzlList != null && scyyzfzlList.size() > 0) {
				sb.append("<table width=\"100%\">");
				sb.append("<tr><td align=\"center\">【 审查员引证非专利文献（"
						+ scyyzfzlList.size() + "）】");
				sb.append("<table width=\"100%\">");
				sb.append("<tr><td align=\"center\">被引证文献原始数据</td></tr>");
				// for (YzwsInfo fyzwx : fyzList) {
				// sb.append("<tr><td>"+fyzwx.getStrGBH()+"</td><td>"+fyzwx.getStrGBRQ()+"</td><td>"+fyzwx.getStrFLH()+"</td></tr>");
				// }
				for (YzwsInfo fyzwx : scyyzfzlList) {
					sb.append("<tr><td align=\"center\">" + fyzwx.getStrBaseData()
							+ "</td></tr>");
				}
				sb.append("</table></td></tr></table><br>");
			}

			if (sqryzzlList != null && sqryzzlList.size() > 0) {
				sb.append("<table width=\"100%\">");
				sb.append("<tr><td align=\"center\">【  申请人引证专利文献（"
						+ sqryzzlList.size() + "）】");
				sb.append("<table width=\"100%\">");
				// for (YzwsInfo byzwx : byzList) {
				// sb.append("<tr><td>"+byzwx.getStrAn()+"</td></tr>");
				// }
				sb
						.append("<tr><td align=\"center\">被引证文献原始数据</td><td align=\"center\">被引证文献专利号</td><td align=\"center\">被引证文献公布日</td></tr>");
				for (YzwsInfo byzwx : sqryzzlList) {
					String strGBH = "";
					String strGBRQ = "";
					if(byzwx!=null && byzwx.getStrGBH()!=null)
						strGBH = byzwx.getStrGBH().toUpperCase();
					if(byzwx!=null && byzwx.getStrGBRQ()!=null)
						strGBRQ = byzwx.getStrGBRQ().toUpperCase();
					
					sb.append("<tr><td align=\"center\">"
							+ byzwx.getStrBaseData()
							+ "</td><td align=\"center\"><a href=\""
							+ getYZHref(strGBH,
									"sqryz") + "\">" + strGBH
							+ "</a></td><td align=\"center\">" + strGBRQ
							+ "</td></tr>");
				}
				sb.append("</table></td></tr></table>");
			}

			// System.out.println("2222........."+scyyzzlList.size());
			// System.out.println("5555........."+scybyzzlList.size());
			// System.out.println("6666........."+sqrbyzzlList.size());

			// sb.append("【  被引证文献（"+ (scybyzzlList.size()+sqrbyzzlList.size())
			// +"）】");
			if (scybyzzlList != null && scybyzzlList.size() > 0
					|| sqrbyzzlList != null && sqrbyzzlList.size() > 0) {
				int scybyzzlListSize = scybyzzlList != null ? scybyzzlList
						.size() : 0;
				int sqrbyzzlListSize = sqrbyzzlList != null ? sqrbyzzlList
						.size() : 0;
				sb.append("<table width=\"100%\">");
				sb.append("<tr><td align=\"center\">【  被引证文献（"
						+ (scybyzzlListSize + sqrbyzzlListSize) + "）】");
				sb.append("<table width=\"100%\">");
				// for (YzwsInfo byzwx : byzList) {
				// sb.append("<tr><td>"+byzwx.getStrAn()+"</td></tr>");
				// }
				sb
						.append("<tr><td align=\"center\">审查员被引证专利</td><td align=\"center\">申请人被引证专利</td></tr>");

				sb.append("<tr><td align=\"center\">");
				if (scybyzzlList != null && scybyzzlList.size() > 0) {
					sb.append("<table>");
					for (YzwsInfo byzwx : scybyzzlList) {
						sb.append("<tr><td align=\"center\">" + byzwx.getStrAn() + "</td></tr>");
					}
					sb.append("</table>");
				}
				sb.append("</td>");
				/**********************************************************************/
				sb.append("<td align=\"center\">");
				if (sqrbyzzlList != null && sqrbyzzlList.size() > 0) {
					sb.append("<table>");
					for (YzwsInfo byzwx : sqrbyzzlList) {
						sb.append("<tr><td align=\"center\">" + byzwx.getStrAn() + "</td></tr>");
					}
					sb.append("</table>");
				}
				sb.append("</td></tr>");

				sb.append("</table></td></tr></table>");
			}

		}

		JspWriter out = pageContext.getOut();
		try {
			out.println(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

		return EVAL_PAGE;
	}

	private String getYZHref(String pn, String type) {
		StringBuffer sb = new StringBuffer();
		try {
			if (pn != null && pn.length() > 0) {
				pn = pn.split(" ")[0];
				sb.append("javascript:viewYZWX(\'");
				char[] pnCharArray = pn.toCharArray();
				if (pn.startsWith("CN") || !Util.isLetter(pnCharArray[0])) {
					String strTrsTable = "";
					if (Util.isLetter(pnCharArray[pnCharArray.length - 1])) {
						switch (pnCharArray[pnCharArray.length - 1]) {
							case 'A': {
								strTrsTable = "fmzl_ft,fmzl_ab";
								break;
							}
							case 'B': {
								strTrsTable = "fmsq_ft,fmsq_ab";
								break;
							}
							case 'C': {
								strTrsTable = "fmsq_ft,fmsq_ab";
								break;
							}
							case 'U': {
								strTrsTable = "syxx_ft,syxx_ab";
								break;
							}
							case 'Y': {
								strTrsTable = "syxx_ft,syxx_ab";
								break;
							}
							case 'D': {
								strTrsTable = "wgzl_ab";
								break;
							}
							case 'S': {
								strTrsTable = "wgzl_ab";
								break;
							}
							default: {
								strTrsTable = "fmzl_ft,fmzl_ab";
								break;
							}
						}
						pn = pn.substring(0, pn.length() - 1);
					}
					if (type.equals("sqryz")) {
						sb.append("公开（公告）号=(").append(pn.replaceAll("/", ""))
								.append("%)\', \'cn\', \'" + strTrsTable + "\'");
					} else {
						sb
								.append("公开（公告）号=(")
								.append(pn.replaceAll("/", ""))
								.append("%) or 申请号=(")
								.append(pn.replaceAll("/", ""))
								.append(
										"%)\', \'cn\', \'fmzl_ab,fmzl_ft,syxx_ab,syxx_ft,wgzl_ab\'");
					}
				} else {
					sb
							.append("公开（公告）号=(")
							.append(pn.replaceAll("/", ""))
							.append("%) or 申请号=(")
							.append(pn.replaceAll("/", ""))
							.append(
									"%)\', \'fr\', \'uspatent,jppatent,gbpatent,depatent,frpatent,eppatent,wopatent,chpatent,hkpatent,twpatent,krpatent,supatent,rupatent,aspatent,gcpatent\'");
				}
				sb.append(")");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return sb.toString();
	}
}
