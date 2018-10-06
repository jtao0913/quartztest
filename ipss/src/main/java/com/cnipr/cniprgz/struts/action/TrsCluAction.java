/**
 * 
 */
package com.cnipr.cniprgz.struts.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.cnipr.cniprgz.dao.julei.JuLeiDao;
import com.cnipr.cniprgz.dao.julei.bean.CluResultModel;
import com.opensymphony.xwork2.ActionSupport;

/**
 * @author jiangyf
 * 聚类action
 */
public class TrsCluAction extends ActionSupport {
	
	private JuLeiDao juleiDao;
/*
	public String execute(
			HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		String option = "0";
		String synonym = "";
		String docCol1 = "";
		String display = request.getParameter("display");
		String source = request.getParameter("source"); 
		String strWhere = request.getParameter("strWhere");
		strWhere = URLDecoder.decode(strWhere,"utf-8");
		String clsNum = request.getParameter("clsNum"); 
		String kwn = request.getParameter("kwn"); 
		if(display==null||"".equals(display.trim())){
			display = "ap,ti";
		}
		if(org.apache.commons.lang.StringUtils.isBlank(source)){source = "FMZL,SYXX,WGZL";}
//		if(org.apache.commons.lang.StringUtils.isNotBlank(strWhere)){
//			try {
//				strWhere = new String(strWhere.getBytes("iso8859-1"),"UTF-8");
//				System.out.println(strWhere);
//			} catch (UnsupportedEncodingException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		}
		System.out.println(strWhere);
//		jl.setSource("FMZL");
//		jl.setStrWhere("名称=(火花塞)");
		
		CluResultModel model = null;
		try {
			model = this.juleiDao.cluster(source,strWhere,"","",
					option, synonym, docCol1, clsNum, kwn, display);
		} 
//		catch (DocumentException e1) {
//			e1.printStackTrace();
//		} 
//		catch (IOException e1) {
//			e1.printStackTrace();
//		}
		catch (Exception e1) {
			e1.printStackTrace();
		}
//		PatClusterSearchDTO dto = new PatClusterSearchDTO();
//		dto.setChartMsg(chartMsg)
		JSONObject json = null;
		if (model!=null) {
			json = JSONObject.fromObject(model);
		}
		response.setCharacterEncoding("utf-8");
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if(json!=null){
			pw.write(json.toString());
		}
		pw.flush();
		return null;
	}
*/

	public JuLeiDao getJuleiDao() {
		return juleiDao;
	}


	public void setJuleiDao(JuLeiDao juleiDao) {
		this.juleiDao = juleiDao;
	}

}
