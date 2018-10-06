package com.cnipr.cniprgz.struts.action;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.cniprgz.commons.Log74Access;
import com.cnipr.cniprgz.commons.SetupAccess;
import com.cnipr.cniprgz.commons.SetupConstant;
import com.cnipr.cniprgz.commons.Util;
import com.cnipr.cniprgz.commons.ValidateCodeUtil;
import com.cnipr.cniprgz.commons.ValidateCodeUtil.Validate;
import com.cnipr.cniprgz.commons.fenye.Page;
import com.cnipr.cniprgz.dao.ChannelDAO;
import com.cnipr.cniprgz.dao.NodeDAO;
import com.cnipr.cniprgz.dao.RelevanceQueryDao;
import com.cnipr.cniprgz.entity.AnalyseModulePie;
import com.cnipr.cniprgz.entity.AnalyzeModule;
import com.cnipr.cniprgz.entity.ChannelInfo;
import com.cnipr.cniprgz.entity.ExpressionInfo;
import com.cnipr.cniprgz.entity.IprUser;
import com.cnipr.cniprgz.entity.NameId;
import com.cnipr.cniprgz.entity.NodeModel;
import com.cnipr.cniprgz.entity.WASSectionInfo;
import com.cnipr.cniprgz.func.ChannelFunc;
import com.cnipr.cniprgz.func.DownloadFunc;
import com.cnipr.cniprgz.func.ExpressionFunc;
import com.cnipr.cniprgz.func.FlztFunc;
import com.cnipr.cniprgz.func.NodeFunc;
import com.cnipr.cniprgz.func.SysUserFunc;
import com.cnipr.cniprgz.func.search.SearchFunc;
import com.cnipr.cniprgz.func.search.SemanticSearch;
import com.cnipr.cniprgz.log.Log74Util;
import com.cnipr.cniprgz.log.PlatformLog;
import com.cnipr.cniprgz.security.SecurityTools;
//import com.cnipr.corebiz.search.entity.GBIndex;
import com.cnipr.corebiz.search.entity.LegalStatusInfo;
import com.cnipr.corebiz.search.entity.PatentInfo;
import com.cnipr.corebiz.search.entity.SectionInfo;
import com.cnipr.corebiz.search.log.CoreBizLogger;
import com.cnipr.corebiz.search.util.DecimalFormatUtil;
import com.cnipr.corebiz.search.ws.response.DetailSearchResponse;
import com.cnipr.corebiz.search.ws.response.LegalStatusResponse;
import com.cnipr.corebiz.search.ws.response.OverviewSearchResponse;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import net.jbase.common.util.DateUtil;
import net.jbase.common.util.StringUtil;
import net.sf.json.JSONArray;

public class SearchAction extends ActionSupport {

	class MapValueComparator implements Comparator<String> {
		Map<String, Integer> base;

		// 这里需要将要比较的map集合传进来
		public MapValueComparator(Map<String, Integer> base) {
			this.base = base;
		}

		// Note: this comparator imposes orderings that are inconsistent with equals.
		// 比较的时候，传入的两个参数应该是map的两个key，根据上面传入的要比较的集合base，可以获取到key对应的value，然后按照value进行比较
		public int compare(String a, String b) {
			if (base.get(a) >= base.get(b)) {
				return -1;
			} else {
				return 1;
			} // returning 0 would merge keys
		}
	}

	private static final long serialVersionUID = 1L;

	private DownloadFunc downloadFunc;

	public DownloadFunc getDownloadFunc() {
		return downloadFunc;
	}

	public void setDownloadFunc(DownloadFunc downloadFunc) {
		this.downloadFunc = downloadFunc;
	}

	public FlztFunc flztFunc;

	public FlztFunc getFlztFunc() {
		return flztFunc;
	}

	public void setFlztFunc(FlztFunc flztFunc) {
		this.flztFunc = flztFunc;
	}

	public ChannelFunc channelFunc;

	public ExpressionFunc expFunc;

	public SearchFunc searchFunc;

	private SemanticSearch semanticSearchImpl;

	private RelevanceQueryDao semanticDao;

	public SysUserFunc sysUserFunc;

	private ChannelDAO channelDAO;

	private NodeFunc nodeFunc;

	public NodeFunc getNodeFunc() {
		return nodeFunc;
	}

	public void setNodeFunc(NodeFunc nodeFunc) {
		this.nodeFunc = nodeFunc;
	}

	public SysUserFunc getSysUserFunc() {
		return sysUserFunc;
	}

	public void setSysUserFunc(SysUserFunc sysUserFunc) {
		this.sysUserFunc = sysUserFunc;
	}

	public RelevanceQueryDao getSemanticDao() {
		return semanticDao;
	}

	public void setSemanticDao(RelevanceQueryDao semanticDao) {
		this.semanticDao = semanticDao;
	}

	public void setExpFunc(ExpressionFunc expFunc) {
		this.expFunc = expFunc;
	}

	public void setChannelFunc(ChannelFunc channelFunc) {
		this.channelFunc = channelFunc;
	}

	public void setSearchFunc(SearchFunc searchFunc) {
		this.searchFunc = searchFunc;
	}

	/**
	 * 检索
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	// public ActionForward overviewSearch(ActionMapping mapping, ActionForm form,
	// HttpServletRequest request, HttpServletResponse response) {

	public String getMenu() throws Exception {
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);

		return SUCCESS;
	}

	/*
	 * public String patentAnalysisPie_(){ ActionContext cxt =
	 * ActionContext.getContext(); Map<String, Object> application =
	 * cxt.getApplication();
	 * 
	 * HttpServletRequest request =
	 * (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
	 * HttpServletResponse response =
	 * (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
	 * 
	 * String dbs = request.getParameter("dbs"); System.out.println(dbs); String exp
	 * = request.getParameter("exp"); System.out.println(exp);
	 * 
	 * AnalyseModulePie amp = new AnalyseModulePie(); amp.setStatus(0);
	 * amp.setAnalysisName("饼图");
	 * 
	 * HashMap<String, Integer> hm = new HashMap<String, Integer>();
	 * 
	 * hm.put("直接访问", 335); hm.put("邮件营销", 310); hm.put("联盟广告", 234); hm.put("视频广告",
	 * 135); hm.put("搜索引擎", 1548);
	 * 
	 * amp.setResults(hm);
	 * 
	 * // jsonresult = JSONArray.fromObject(amp).toString(); //
	 * System.out.println(jsonresult);
	 * 
	 * Gson gson = new
	 * GsonBuilder().setPrettyPrinting().disableHtmlEscaping().create(); JsonParser
	 * jp = new JsonParser(); JsonElement je = jp.parse(gson.toJson(amp));
	 * jsonresult = gson.toJson(je); jsonresult = jsonresult.replace("\r", "");
	 * jsonresult = jsonresult.replace("\n", "");
	 * 
	 * System.out.println(jsonresult);
	 * 
	 * // jsonresult = "{jsonMessage:'true'}";
	 * 
	 * return SUCCESS; }
	 */
	/*
	 * public String patentAnalysisPie(){ try{ ActionContext cxt =
	 * ActionContext.getContext(); Map<String, Object> application =
	 * cxt.getApplication();
	 * 
	 * Map<String,String> lastestFlztInfo = new HashMap<String,String>();
	 * 
	 * HttpServletRequest request =
	 * (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
	 * HttpServletResponse response =
	 * (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE); HttpSession
	 * session = request.getSession();
	 * 
	 * String dbs = request.getParameter("dbs"); System.out.println(dbs); String exp
	 * = request.getParameter("exp"); System.out.println(exp);
	 * 
	 * String strWhere = GetSearchFormat.preprocess(exp);
	 * 
	 * OverviewSearchResponse overviewResponse = null;
	 * 
	 * overviewResponse = searchFunc.overviewSearch("",dbs, strWhere, "RELEVANCE",
	 * "", "主权项, 名称, 摘要", 101, 115, false, 0L, 0L, "", "");
	 * 
	 * if(overviewResponse!=null&&overviewResponse.getMap_data_single()!=null&&
	 * overviewResponse.getMap_data_single().size()>0){
	 * 
	 * // EnhancedOption analyse_option =
	 * overviewResponse.getMap_option().get("申请年"); // HashMap<String,
	 * EnhancedOption> hm = overviewResponse.getMap_option();
	 * 
	 * // HashMap<String, String> map_option = overviewResponse.getMap_option(); //
	 * request.setAttribute("map_option", map_option);
	 * 
	 * TreeMap<String,Integer> map_data_single =
	 * overviewResponse.getMap_data_single(); //
	 * request.setAttribute("map_data_single", map_data_single);
	 * /////////////////////////////////////////////////////////////////////////////
	 * /////// AnalyseModulePie amp = new AnalyseModulePie(); amp.setStatus(0);
	 * amp.setAnalysisName("饼图");
	 * 
	 * HashMap<String, Integer> hm = new HashMap<String, Integer>();
	 * 
	 * hm.put("直接访问", 335); hm.put("邮件营销", 310); hm.put("联盟广告", 234); hm.put("视频广告",
	 * 135); hm.put("搜索引擎", 1548);
	 * 
	 * amp.setResults(map_data_single);
	 * 
	 * // jsonresult = JSONArray.fromObject(amp).toString(); //
	 * System.out.println(jsonresult);
	 * 
	 * Gson gson = new
	 * GsonBuilder().setPrettyPrinting().disableHtmlEscaping().create(); JsonParser
	 * jp = new JsonParser(); JsonElement je = jp.parse(gson.toJson(amp));
	 * jsonresult = gson.toJson(je); jsonresult = jsonresult.replace("\r", "");
	 * jsonresult = jsonresult.replace("\n", "");
	 * 
	 * System.out.println(jsonresult);
	 * 
	 * // Iterator iter1 = map_option.entrySet().iterator(); // while
	 * (iter1.hasNext()) { // Map.Entry entry = (Map.Entry) iter1.next(); // Object
	 * key = entry.getKey(); // Object val = entry.getValue(); // //
	 * System.out.println(key + "-----------------------------" + val); // } }
	 * 
	 * }catch(Exception ex){ // throw ex; // jsonresult=ex.toString();
	 * jsonresult=""; // return ERROR; } return SUCCESS; }
	 */
	public String analyse() throws Exception {
		ActionContext cxt = ActionContext.getContext();
		Map<String, Object> application = cxt.getApplication();

		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();

		String exp = request.getParameter("strWhere");
		String dbs = request.getParameter("strSources");

		// System.out.println(exp);
		// System.out.println(dbs);

		return SUCCESS;
	}

	public String patentAnalysisXY() {
		try {
			ActionContext cxt = ActionContext.getContext();
			Map<String, Object> application = cxt.getApplication();

			// Map<String,String> lastestFlztInfo = new HashMap<String,String>();

			HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
			HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
			HttpSession session = request.getSession();

			String dbs = request.getParameter("dbs");

			// dbs = "14,15,28,uspatent,fmsq_ft,16,gbpatent";

			// dbs = "uspatent,fmsq_ft,gbpatent";
			dbs = Util.getPatentTable(application, dbs);
			// System.out.println(dbs);
			//
			// dbs = "14,15,28,uspatent,fmsq_ft,16,gbpatent";
			// dbs = Util.getPatentTable(application,dbs);
			// System.out.println(dbs);
			//
			// dbs = "14,15,28,16,17,30,139";
			// dbs = Util.getPatentTable(application,dbs);
			// System.out.println(dbs);

			// System.out.println(dbs);
			////////////////////////////////////////////////////////////////////////////////////////////////////
			/*
			 * List<ChannelInfo> channelInfoList_cn =
			 * (List<ChannelInfo>)application.get("channelInfoList_cn");//全部CN
			 * if(channelInfoList_cn == null){ channelInfoList_cn =
			 * channelFunc.getChannels("cn");
			 * application.put("channelInfoList_cn",channelInfoList_cn); }
			 * 
			 * List<ChannelInfo> channelInfoList_fr =
			 * (List<ChannelInfo>)application.get("channelInfoList_fr");//全部FR
			 * if(channelInfoList_fr == null){ channelInfoList_fr =
			 * channelFunc.getChannels("fr");
			 * application.put("channelInfoList_fr",channelInfoList_fr); }
			 * 
			 * List<ChannelInfo> channelList = new ArrayList<ChannelInfo>(); //
			 * if(channelList==null||channelList.size()==0) { String[] arrdb =
			 * dbs.split(",");
			 * 
			 * Iterator<ChannelInfo> iter = channelInfoList_cn.iterator();
			 * while(iter.hasNext()) { ChannelInfo channelinfo = ((ChannelInfo)iter.next());
			 * int channelid = channelinfo.getIntChannelID(); String channelname =
			 * channelinfo.getChrTRSTable(); // System.out.println(iter.next()); for(int
			 * i=0;i<arrdb.length;i++){
			 * if(arrdb[i].equals(channelid+"")||arrdb[i].equals(channelname)){
			 * channelList.add(channelinfo); } } }
			 * 
			 * iter = channelInfoList_fr.iterator(); while(iter.hasNext()) { ChannelInfo
			 * channelinfo = ((ChannelInfo)iter.next()); int channelid =
			 * channelinfo.getIntChannelID(); String channelname =
			 * channelinfo.getChrTRSTable(); // System.out.println(iter.next()); for(int
			 * i=0;i<arrdb.length;i++){
			 * if(arrdb[i].equals(channelid+"")||arrdb[i].equals(channelname)){
			 * channelList.add(channelinfo); } } } }
			 * 
			 * // try // { // channelList = channelFunc.getInfoMapByChannel(channelArray);
			 * // }catch(Exception ex){ // throw ex; // }
			 * 
			 * String strSources = ""; if (channelList != null && channelList.size() > 0) {
			 * strSources = ""; } // TRS表名 （egg：发明专利，实用新型，外观设计） 保存表达式时用到 String
			 * strTRSTableName = "";
			 * 
			 * for (ChannelInfo info : channelList) { strSources += info.getChrTRSTable() +
			 * ","; // strTRSTableName += info.getChrChannelName() + ","; }
			 * 
			 * if (strSources != null && !strSources.equals("")&& strSources.endsWith(","))
			 * { strSources = strSources.substring(0, strSources.length() - 1); dbs =
			 * strSources; }
			 */

			// if (strTRSTableName != null && !strTRSTableName.equals("")&&
			// strTRSTableName.endsWith(","))
			// strTRSTableName = strTRSTableName.substring(0, strTRSTableName.length() - 1);

			////////////////////////////////////////////////////////////////////////////////////////////////////

			// System.out.println(dbs);
			String exp = request.getParameter("exp");
			// System.out.println(exp);

			String xAxis = request.getParameter("xAxis");
			// System.out.println(xAxis);
			String yAxis = request.getParameter("yAxis");
			// System.out.println(yAxis);
			int xAxisSize = 20;
			int yAxisSize = 10;

			if (request.getParameter("xAxisSize") != null && !request.getParameter("xAxisSize").equals("")) {
				xAxisSize = Integer.parseInt(request.getParameter("xAxisSize"));
			}
			if (request.getParameter("yAxisSize") != null && !request.getParameter("yAxisSize").equals("")) {
				yAxisSize = Integer.parseInt(request.getParameter("yAxisSize"));
			}

			if (xAxis.toUpperCase().indexOf("IPC") > -1 || yAxis.toUpperCase().indexOf("IPC") > -1) {
				dbs = dbs.toLowerCase().replace("wgzl_ab", "");
				dbs = dbs.replace(",,", ",");
				if (dbs.startsWith(",")) {
					dbs = dbs.substring(1);
				}
				if (dbs.endsWith(",")) {
					dbs = dbs.substring(0, dbs.length() - 1);
				}
			}

			String hangye_analyse_id = request.getParameter("hangye_analyse_id");
			// hangye_analyse_id = "gd_zbzz_1_1,2014,2018";
			// hangye_analyse_id = "gd_zbzz_1_2_1,2014,2018";
			// hangye_analyse_id = "gd_zbzz_1_2_2,2014,2018,1-1";
			// hangye_analyse_id = "gd_zbzz_1_2_3,2014,2018";
//			hangye_analyse_id = "gd_zbzz_1_3_1,2014,2018,1-1";// xy
			// hangye_analyse_id = "gd_zbzz_1_3_2,2014,2018,1-1";
			// hangye_analyse_id = "gd_zbzz_1_3_3,2014,2018,1-1";
//			hangye_analyse_id = "gd_zbzz_1_4_1,2014,2018";// xy
			// hangye_analyse_id = "gd_zbzz_2_1,2014,2018";
			// hangye_analyse_id = "gd_zbzz_2_2,2014,2018";xy
			// hangye_analyse_id = "gd_zbzz_2_3_1,2014,2018";xy
			// hangye_analyse_id = "gd_zbzz_2_4_1,2014,2018,1-1";xy
			// hangye_analyse_id = "gd_zbzz_2_4_2,2014,2018,1-1";
			// hangye_analyse_id = "gd_zbzz_2_4_3,2014,2018,1-1";
			// hangye_analyse_id = "gd_zbzz_2_5_1,2014,2018";xy
			// hangye_analyse_id = "gd_zbzz_2_6_1,2014,2018";xy
			// hangye_analyse_id = "gd_zbzz_2_7_1,2014,2018";xy
			// hangye_analyse_id = "gd_zbzz_2_7_2,2014,2018";xy
			// hangye_analyse_id = "gd_zbzz_3_1,2014,2018";
			// hangye_analyse_id = "gd_zbzz_3_2,2014,2018";xy
			// hangye_analyse_id = "gd_zbzz_3_3,2014,2018";
			// hangye_analyse_id = "gd_zbzz_3_4_1,2014,2018,1-1";//xy
			// hangye_analyse_id = "gd_zbzz_3_4_2,2014,2018,1-1";
			// hangye_analyse_id = "gd_zbzz_3_4_3,2014,2018,1-1";
//			hangye_analyse_id = "gd_zbzz_3_5_1,2014,2018";// xy
//			hangye_analyse_id = "gd_zbzz_3_6_1,2014,2018";// xy
			// hangye_analyse_id = "gd_zbzz_3_7_1,2014,2018";
			// hangye_analyse_id = "gd_zbzz_3_7_2";

			// hangye_analyse_id = "";
			if (hangye_analyse_id != null && !hangye_analyse_id.equals("")) {
				xAxis = "";
				yAxis = "";
			}

			if (dbs.trim().equalsIgnoreCase("")) {
				AnalyzeModule am = new AnalyzeModule();
				am.setStatus(1);

				Gson gson = new GsonBuilder().setPrettyPrinting().disableHtmlEscaping().create();
				JsonParser jp = new JsonParser();
				JsonElement je = jp.parse(gson.toJson(am));
				jsonresult = gson.toJson(je);
				jsonresult = jsonresult.replace("\r", "");
				jsonresult = jsonresult.replace("\n", "");

				return SUCCESS;
			}

			boolean b_reverse = false;
			String reverse = request.getParameter("reverse");
			if (reverse != null && reverse.equals("1")) {
				b_reverse = true;
			}

			String cnfr = request.getParameter("cnfr");
			if (cnfr != null && cnfr.equals("0")) {
				exp = "申请区域=中国 and " + "(" + exp + ")";
			}
			if (cnfr != null && cnfr.equals("1")) {
				exp = "(" + exp + ")" + " not 申请区域=中国";
			}

			String dimension = "xy";
			if (yAxis == null || yAxis.equals("")) {
				dimension = "x";
			} else if (xAxis != null && xAxis.equals("申请年") && yAxis != null && yAxis.equals("公开年")) {
				// '申请年','公开年'
				dimension = "xx";
			}

			/*
			 * if(xAxis!=null&&xAxis.equals("section")) { AnalyseModulePie amp = new
			 * AnalyseModulePie(); amp.setStatus(0); amp.setAnalysisName("section");
			 * 
			 * String results = ""; // List<SectionInfo> ls_section =
			 * overviewResponse.getSectionInfos();
			 * 
			 * if(request.getAttribute("sections")!=null) {
			 * 
			 * List<SectionInfo> ls_section =
			 * (List<SectionInfo>)request.getAttribute("sections");
			 * 
			 * Iterator it = ls_section.iterator(); while(it.hasNext()) { //
			 * System.out.println(it.next()); SectionInfo si = (SectionInfo)it.next();
			 * 
			 * si.getSectionName(); si.getRecordNum();
			 * 
			 * if(!results.equals("")) { results+=","; } results+="\""+si.getSectionName()+
			 * "\":" + si.getRecordNum(); } results = ", \"results\": {" + results + "}";
			 * 
			 * }else { amp.setStatus(1); }
			 * 
			 * Gson gson = new
			 * GsonBuilder().setPrettyPrinting().disableHtmlEscaping().create(); JsonParser
			 * jp = new JsonParser(); JsonElement je = jp.parse(gson.toJson(amp));
			 * jsonresult = gson.toJson(je); jsonresult = jsonresult.replace("\r", "");
			 * jsonresult = jsonresult.replace("\n", ""); jsonresult =
			 * jsonresult.replace("}", results + "}");
			 * 
			 * System.out.println(jsonresult);
			 * 
			 * return SUCCESS; }
			 */

			// String strWhere = GetSearchFormat.preprocess(exp);
			String strWhere = exp;
			strWhere = strWhere.toUpperCase();
			
			OverviewSearchResponse overviewResponse = null;
			overviewResponse = searchFunc.overviewSearch("", dbs, strWhere, "RELEVANCE", hangye_analyse_id,
					xAxis + "," + yAxis, xAxisSize, yAxisSize, b_reverse, 0L, 0L, "", "0");
/*
			if (hangye_analyse_id.indexOf("gd_1_1") == 0) {
				if (overviewResponse != null) {
					System.out.println(overviewResponse.getResult());
				}
			} else if (hangye_analyse_id.indexOf("gd_1_2_1") == 0) {
				if (overviewResponse != null) {
					System.out.println(overviewResponse.getResult());
				}
			} else if (hangye_analyse_id.indexOf("gd_1_2_3") == 0) {
				if (overviewResponse != null) {
					System.out.println(overviewResponse.getResult());
				}
			} else if (hangye_analyse_id.indexOf("gd_1_3_2") == 0) {
				if (overviewResponse != null) {
					System.out.println(overviewResponse.getResult());
				}
			}
*/
			if (dimension.equals("x")) {

				if (overviewResponse != null) {

					if (overviewResponse.getMap_data_single() != null
							&& overviewResponse.getMap_data_single().size() > 0) {
						// if(overviewResponse!=null&&overviewResponse.getList_data_single()!=null&&overviewResponse.getList_data_single().size()>0){
						TreeMap<String, Integer> map_data_single = overviewResponse.getMap_data_single();
						// ArrayList<Map.Entry<String,Integer>> list_data_single =
						// overviewResponse.getList_data_single();

						////////////////////////////////////////////////////////////////////////////////////
						AnalyseModulePie amp = new AnalyseModulePie();
						amp.setStatus(0);
						amp.setAnalysisName(xAxis);
						/*
						 * HashMap<String, Integer> hm = new HashMap<String, Integer>();
						 * 
						 * hm.put("直接访问", 335); hm.put("邮件营销", 310); hm.put("联盟广告", 234); hm.put("视频广告",
						 * 135); hm.put("搜索引擎", 1548);
						 */
						// amp.setResults(map_data_single);
						//////////////////////////////////////////////////////////////////////////////////////////////////////////////
						ArrayList<Map.Entry<String, Integer>> list_data_single = new ArrayList<Map.Entry<String, Integer>>(
								map_data_single.entrySet());

						if (!xAxis.equals("申请年") && !xAxis.equals("公开年")) {

							Collections.sort(list_data_single, new Comparator<Map.Entry<String, Integer>>() {
								public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
									return (o2.getValue().intValue() - o1.getValue().intValue());
								}
							});

						}
						// "results": { "三星电子株式会社": 76, "东南大学": 74}

						String results = "";
						for (Map.Entry<String, Integer> mapping : list_data_single) {
							// System.out.println(mapping.getKey() + ":" + mapping.getValue());
							if (!results.equals("")) {
								results += ",";
							}
							results += "\"" + mapping.getKey() + "\":" + mapping.getValue();
						}

						results = ", \"results\": {" + results + "}";
						//////////////////////////////////////////////////////////////////////////////////////////////////////////////

						/*
						 * String[][] arr_data_single = new String[map_data_single.size()][2];
						 * 
						 * int n=0; Iterator iter1 = map_data_single.entrySet().iterator(); while
						 * (iter1.hasNext()) { Map.Entry entry = (Map.Entry) iter1.next(); String key =
						 * (String)entry.getKey(); Integer val = (Integer)entry.getValue(); //
						 * System.out.println(key + "-----------------------------" + val);
						 * 
						 * arr_data_single[n][0]=key; arr_data_single[n][1]=val+""; n++; }
						 * amp.setArr_data_single(arr_data_single);
						 */

						// jsonresult = JSONArray.fromObject(amp).toString();
						// System.out.println(jsonresult);

						Gson gson = new GsonBuilder().setPrettyPrinting().disableHtmlEscaping().create();
						JsonParser jp = new JsonParser();
						JsonElement je = jp.parse(gson.toJson(amp));
						jsonresult = gson.toJson(je);
						jsonresult = jsonresult.replace("\r", "");
						jsonresult = jsonresult.replace("\n", "");
						jsonresult = jsonresult.replace("}", results + "}");

						// System.out.println(jsonresult);

						/*
						 * Iterator iter1 = map_option.entrySet().iterator(); while (iter1.hasNext()) {
						 * Map.Entry entry = (Map.Entry) iter1.next(); Object key = entry.getKey();
						 * Object val = entry.getValue();
						 * 
						 * System.out.println(key + "-----------------------------" + val); }
						 */
					} else {
						AnalyseModulePie amp = new AnalyseModulePie();
						amp.setStatus(2);
						Gson gson = new GsonBuilder().setPrettyPrinting().disableHtmlEscaping().create();
						JsonParser jp = new JsonParser();
						JsonElement je = jp.parse(gson.toJson(amp));
						jsonresult = gson.toJson(je);
						jsonresult = jsonresult.replace("\r", "");
						jsonresult = jsonresult.replace("\n", "");
						// jsonresult = jsonresult.replace("}", results + "}");
					}
				}
			} else if (dimension.equals("xy")) {
				if (overviewResponse != null) {
					if (overviewResponse.getX_array() != null && overviewResponse.getX_array().length > 0
							&& overviewResponse.getY_array() != null && overviewResponse.getY_array().length > 0) {

						// EnhancedOption analyse_option = overviewResponse.getMap_option().get("申请年");
						// HashMap<String, EnhancedOption> hm = overviewResponse.getMap_option();

						// HashMap<String, String> map_option = overviewResponse.getMap_option();
						// request.setAttribute("map_option", map_option);

						// TreeMap<String,Integer> map_data_single =
						// overviewResponse.getMap_data_single();
						// request.setAttribute("map_data_single", map_data_single);
						////////////////////////////////////////////////////////////////////////////////////
						AnalyzeModule am = new AnalyzeModule();
						am.setStatus(0);
						am.setAnalysisName(xAxis + "-" + yAxis);
						/*
						 * HashMap<String, Integer> hm = new HashMap<String, Integer>();
						 * 
						 * hm.put("直接访问", 335); hm.put("邮件营销", 310); hm.put("联盟广告", 234); hm.put("视频广告",
						 * 135); hm.put("搜索引擎", 1548);
						 */
						am.setLegend(overviewResponse.getY_array());
						am.setxAxisData(overviewResponse.getX_array());
						am.setArrSeries(overviewResponse.getXy_arr());

						// request.setAttribute("am", am);
						// jsonresult = JSONArray.fromObject(amp).toString();
						// System.out.println(jsonresult);

						Gson gson = new GsonBuilder().setPrettyPrinting().disableHtmlEscaping().create();
						JsonParser jp = new JsonParser();
						JsonElement je = jp.parse(gson.toJson(am));
						jsonresult = gson.toJson(je);
						jsonresult = jsonresult.replace("\r", "");
						jsonresult = jsonresult.replace("\n", "");

						// System.out.println(jsonresult);

						/*
						 * Iterator iter1 = map_option.entrySet().iterator(); while (iter1.hasNext()) {
						 * Map.Entry entry = (Map.Entry) iter1.next(); Object key = entry.getKey();
						 * Object val = entry.getValue();
						 * 
						 * System.out.println(key + "-----------------------------" + val); }
						 */
					} else {
						AnalyzeModule am = new AnalyzeModule();
						am.setStatus(2);
						Gson gson = new GsonBuilder().setPrettyPrinting().disableHtmlEscaping().create();
						JsonParser jp = new JsonParser();
						JsonElement je = jp.parse(gson.toJson(am));
						jsonresult = gson.toJson(je);
						jsonresult = jsonresult.replace("\r", "");
						jsonresult = jsonresult.replace("\n", "");
					}
				}
			} else if (dimension.equals("xx")) {
				if (overviewResponse != null && overviewResponse.getX_array() != null
						&& overviewResponse.getX_array().length > 0) {

					// EnhancedOption analyse_option = overviewResponse.getMap_option().get("申请年");
					// HashMap<String, EnhancedOption> hm = overviewResponse.getMap_option();

					// HashMap<String, String> map_option = overviewResponse.getMap_option();
					// request.setAttribute("map_option", map_option);

					// TreeMap<String,Integer> map_data_single =
					// overviewResponse.getMap_data_single();
					// request.setAttribute("map_data_single", map_data_single);
					////////////////////////////////////////////////////////////////////////////////////
					AnalyzeModule am = new AnalyzeModule();
					am.setStatus(0);
					// am.setAnalysisName(xAxis+"-"+yAxis);
					am.setAnalysisName("综合趋势分析");
					/*
					 * HashMap<String, Integer> hm = new HashMap<String, Integer>();
					 * 
					 * hm.put("直接访问", 335); hm.put("邮件营销", 310); hm.put("联盟广告", 234); hm.put("视频广告",
					 * 135); hm.put("搜索引擎", 1548);
					 */
					// am.setLegend(overviewResponse.getY_array());

					String[] _arr = "申请年,公开年".split(",");
					am.setLegend(_arr);
					am.setxAxisData(overviewResponse.getX_array());
					am.setArrSeries(overviewResponse.getXy_arr());

					// request.setAttribute("am", am);

					// jsonresult = JSONArray.fromObject(amp).toString();
					// System.out.println(jsonresult);

					Gson gson = new GsonBuilder().setPrettyPrinting().disableHtmlEscaping().create();
					JsonParser jp = new JsonParser();
					JsonElement je = jp.parse(gson.toJson(am));
					jsonresult = gson.toJson(je);
					jsonresult = jsonresult.replace("\r", "");
					jsonresult = jsonresult.replace("\n", "");

					System.out.println(jsonresult);

					/*
					 * Iterator iter1 = map_option.entrySet().iterator(); while (iter1.hasNext()) {
					 * Map.Entry entry = (Map.Entry) iter1.next(); Object key = entry.getKey();
					 * Object val = entry.getValue();
					 * 
					 * System.out.println(key + "-----------------------------" + val); }
					 */
				} else {
					AnalyzeModule am = new AnalyzeModule();
					am.setStatus(2);
					Gson gson = new GsonBuilder().setPrettyPrinting().disableHtmlEscaping().create();
					JsonParser jp = new JsonParser();
					JsonElement je = jp.parse(gson.toJson(am));
					jsonresult = gson.toJson(je);
					jsonresult = jsonresult.replace("\r", "");
					jsonresult = jsonresult.replace("\n", "");
				}
			}

		} catch (Exception ex) {
			// throw ex;
			// jsonresult=ex.toString();
			jsonresult = "";
			// return ERROR;
		}
		return SUCCESS;
	}

	public String patentAnalysisXYcopy() {
		ActionContext cxt = ActionContext.getContext();
		Map<String, Object> application = cxt.getApplication();

		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		List<NameId> nameIds = new ArrayList<>();
		NodeDAO nodeDAO=new NodeDAO();
		int parentId = Integer.parseInt(request.getSession().getAttribute("nodeId").toString());
		nameIds = nodeDAO.getNameByParentId(parentId);
		String intID=nodeDAO.getintIDById(parentId);
		try {
			String dbs = request.getParameter("dbs");
			dbs = Util.getPatentTable(application, dbs);
			String exp = request.getSession().getAttribute("strWhere").toString();
//			System.out.println(exp);
			
			String xAxis = request.getParameter("xAxis");
			String yAxis = request.getParameter("yAxis");
			
			String hangye = request.getParameter("hangye");
//			intID = "1-1";
			if(hangye.contains("gd_zbzz_1_2_2")) {
				System.out.println(hangye);
			}
			
//			if(hangye.substring(hangye.length()-1, hangye.length()).equals(",")) {
			if(hangye.endsWith(",")) {
				hangye=hangye+intID+","+nameIds.size();
			}
			
			int xAxisSize = 20;
			int yAxisSize = 10;
			
			if (request.getParameter("xAxisSize") != null && !request.getParameter("xAxisSize").equals("")) {
				xAxisSize = Integer.parseInt(request.getParameter("xAxisSize"));
			}
			if (request.getParameter("yAxisSize") != null && !request.getParameter("yAxisSize").equals("")) {
				yAxisSize = Integer.parseInt(request.getParameter("yAxisSize"));
			}

			if (xAxis.toUpperCase().indexOf("IPC") > -1 || yAxis.toUpperCase().indexOf("IPC") > -1) {
				dbs = dbs.toLowerCase().replace("wgzl_ab", "");
				dbs = dbs.replace(",,", ",");
				if (dbs.startsWith(",")) {
					dbs = dbs.substring(1);
				}
				if (dbs.endsWith(",")) {
					dbs = dbs.substring(0, dbs.length() - 1);
				}
			}

			
			if (dbs.trim().equalsIgnoreCase("")) {
				AnalyzeModule am = new AnalyzeModule();
				am.setStatus(1);

				Gson gson = new GsonBuilder().setPrettyPrinting().disableHtmlEscaping().create();
				JsonParser jp = new JsonParser();
				JsonElement je = jp.parse(gson.toJson(am));
				jsonresult = gson.toJson(je);
				jsonresult = jsonresult.replace("\r", "");
				jsonresult = jsonresult.replace("\n", "");
				//判断是否包含行业信息，包含则替换标签
				if(jsonresult.indexOf("ZLXXCY")!=-1) {
					if(nameIds.size()>0) {
						for (NameId nameId : nameIds) {
							String tt=nameId.getChrExpression().substring(4);
							tt="\""+tt+"\"";
							String name="\""+nameId.getChrName()+"\"";
							if(jsonresult.indexOf(tt)!=-1) {
								jsonresult=jsonresult.replace(tt, name);
							}
						}
					}
				}
				jsonresult=jsonresult.replace("<", "");
				jsonresult=jsonresult.replace(">", "");
				return SUCCESS;
			}
			
			boolean b_reverse = false;
			String reverse = request.getParameter("reverse");
			if (reverse != null && reverse.equals("1")) {
				b_reverse = true;
			}

			String cnfr = request.getParameter("cnfr");
			if (cnfr != null && cnfr.equals("0")) {
				exp = "申请区域=中国 and " + "(" + exp + ")";
			}
			if (cnfr != null && cnfr.equals("1")) {
				exp = "(" + exp + ")" + " not 申请区域=中国";
			}

			String dimension = "xy";
			if (yAxis == null || yAxis.equals("")) {
				dimension = "x";
			} else if (xAxis != null && xAxis.equals("申请年") && yAxis != null && yAxis.equals("公开年")) {
				// '申请年','公开年'
				dimension = "xx";
			}

			String strWhere = exp;
			strWhere = strWhere.toUpperCase();

			OverviewSearchResponse overviewResponse = null;
			overviewResponse = searchFunc.overviewSearch("", dbs, strWhere, "RELEVANCE", hangye, xAxis + "," + yAxis,
					xAxisSize, yAxisSize, b_reverse, 0L, 0L, "", "0");
			jsonresult = overviewResponse.getResult();
			
			//判断是否包含行业信息，包含则替换标签
			if(jsonresult.indexOf("ZLXXCY")!=-1) {
				if(nameIds.size()>0) {
					for (NameId nameId : nameIds) {
						String tt=nameId.getChrExpression().substring(4);
						tt="\""+tt+"\"";
						String name="\""+nameId.getChrName()+"\"";
						if(jsonresult.indexOf(tt)!=-1) {
							jsonresult=jsonresult.replace(tt, name);
						}
					}
				}else {
					String chrGDHyName = session.getAttribute("chrGDHyName").toString();
					String[] arr = hangye.split(",");
					String tt="ZLXXCY-"+arr[3];
					tt="\""+tt+"\"";
					String name="\""+chrGDHyName+"\"";
					if(jsonresult.indexOf(tt)!=-1) {
						jsonresult=jsonresult.replace(tt, name);
					}
				}
			}
			jsonresult=jsonresult.replace("<", "");
			jsonresult=jsonresult.replace(">", "");
		} catch (Exception ex) {
			// jsonresult="";
		}
		
		return SUCCESS;
	}	

	public String overviewSearch() throws Exception {
		String ret = "";
		// System.out.println("overviewSearch....");

		ActionContext cxt = ActionContext.getContext();
		Map<String, Object> application = cxt.getApplication();

		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();

		try {
			// String treeType =
			// request.getParameter("treeType")==null?"-1":request.getParameter("treeType");
			// int currentPage =
			// request.getParameter("currentPage")==null?0:Integer.parseInt(request.getParameter("currentPage"));

			HashMap<String, Object> hm_result = getPatentInfos(cxt);

			ret = SUCCESS;
		} catch (Exception ex) {
			ret = ERROR;
			throw ex;
		}

		return ret;
	}

	public String overviewSearch1() throws Exception {
		String ret = "";
		// System.out.println("overviewSearch....");

		ActionContext cxt = ActionContext.getContext();
		Map<String, Object> application = cxt.getApplication();

		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();

		// List<ChannelInfo> channelInfoList_cn =
		// (List<ChannelInfo>)application.get("channelInfoList_cn");
		// List<ChannelInfo> channelInfoList_fr =
		// (List<ChannelInfo>)application.get("channelInfoList_fr");

		/*
		 * List<ChannelInfo> channelInfoList_cn =
		 * (List<ChannelInfo>)application.get("channelInfoList_cn");//全部CN
		 * if(channelInfoList_cn == null){ channelInfoList_cn =
		 * channelFunc.getChannels("cn");
		 * application.put("channelInfoList_cn",channelInfoList_cn); }
		 * 
		 * List<ChannelInfo> channelInfoList_fr =
		 * (List<ChannelInfo>)application.get("channelInfoList_fr");//全部FR
		 * if(channelInfoList_fr == null){ channelInfoList_fr =
		 * channelFunc.getChannels("fr");
		 * application.put("channelInfoList_fr",channelInfoList_fr); }
		 * 
		 * List<ChannelInfo> channelInfoList_sx =
		 * (List<ChannelInfo>)application.get("channelInfoList_sx");//全部CN
		 * if(channelInfoList_sx == null){ channelInfoList_sx =
		 * channelFunc.getChannels("sx");
		 * application.put("channelInfoList_sx",channelInfoList_sx); }
		 */

		Map<String, String> lastestFlztInfo = new HashMap<String, String>();

		try {
			// String strWhere1 = request.getParameter("strWhere");
			// System.out.println("strWhere1="+strWhere1);

			// String output = URLDecoder.decode(request.getParameter("strWhere"), "UTF-8");
			// System.out.println("output="+output);

			int strUserId = Integer.parseInt((String) request.getSession().getAttribute("userid"));
		} catch (java.lang.NumberFormatException ex) {
			throw ex;
		}

		// String strChannels1 = request.getParameter("strChannels");
		// System.out.println("strChannels="+strChannels1);

		String strChannels = request.getParameter("strChannels");// strChannels
		// System.out.println("strChannels="+strChannels);
		// 搜索条件
		String strWhere = request.getParameter("strWhere") == null ? "" : request.getParameter("strWhere");
		// System.out.println("strWhere="+strWhere);

		String wap = request.getParameter("wap") == null ? "" : request.getParameter("wap");
		// System.out.println("----wap="+wap);
		if (wap.equals("1")) {
			// System.out.println("====strWhere="+strWhere);
			strWhere = java.net.URLDecoder.decode(strWhere, "UTF-8");

			String sessionwhere = (String) request.getAttribute("strWhere");

			if (strWhere == null || strWhere.equals("") || strWhere.equals("null")) {
				strWhere = sessionwhere;
			}
			// strWhere = "申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=" + strWhere;
			strWhere = strWhere.replace("申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要 =",
					"申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=");
			// strWhere = com.cnipph.util.Util.unescape(strWhere);
		}

		String expsearch = request.getParameter("expsearch") == null ? "" : request.getParameter("expsearch");
		// System.out.println("expsearch="+expsearch);
		if (expsearch.equals("1")) {
			strWhere = (String) request.getAttribute("strWhere");
			strChannels = (String) request.getAttribute("strChannels");
		}

		// if(strWhere.startsWith("&")){
		//// System.out.println("====strWhere="+strWhere);
		// strWhere = java.net.URLDecoder.decode(strWhere,"UTF-8");
		// strWhere = com.cnipph.util.Util.unescape(strWhere);
		// }
		// System.out.println("====strWhere="+strWhere);

		strWhere = strWhere.replace("&middot;", "·");
		strWhere = strWhere.replace("&ldquo;", "“");
		strWhere = strWhere.replace("&rdquo;", "”");
		strWhere = strWhere.replace("&ndash;", "–");
		strWhere = strWhere.replace("&sdot;", "⋅");
		strWhere = strWhere.replace("&ndash;", "–");
		strWhere = strWhere.replace("&mdash;", "—");
		strWhere = strWhere.replace("&lsquo;", "‘");
		strWhere = strWhere.replace("&rsquo;", "’");
		strWhere = strWhere.replace("&sbquo;", "‚");
		strWhere = strWhere.replace("&bull;", "•");
		strWhere = strWhere.replace("&prime;", "′");

		// 地区（中外）
		String area = request.getParameter("area");
		// area = area.toLowerCase();

		if (area == null || area.toLowerCase().trim().equals("")) {
			area = "cn";
		}
		String simpleSearch = request.getParameter("simpleSearch") == null ? "" : request.getParameter("simpleSearch");

		if (simpleSearch.equals("1") && wap.equals("1")) {
			// 手机版首页
			strWhere = "申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=" + strWhere;
		}

		if (simpleSearch != null && simpleSearch.equals("1") && area != null && !area.equals("")) {
			// if(area.equals("fr")){
			// channelList = channelInfoList_fr;
			// }else{
			// channelList = channelInfoList_cn;
			// }
			strChannels = (area.equals("cn"))
					? com.cnipr.cniprgz.commons.Util.getPatentTableIDsByAreaByIndexChecked(application, "cn", "checked")
					: com.cnipr.cniprgz.commons.Util.getPatentTableIDsByAreaByIndexChecked(application, "fr",
							"checked");
		} else {
			if (strChannels == null || strChannels.equals("")) {
				request.setAttribute("search_error", strWhere + "请选择检索频道");
				request.setAttribute("strWhere", strWhere);
				// request.setAttribute("area", area);
				ret = ERROR;
			}
		}

		String treeType = request.getParameter("treeType");
		String searchKind = request.getParameter("searchKind");

		// 当前页下标
		String pageIndex = request.getParameter("pageIndex");
		if (pageIndex == null || pageIndex.equals("")) {
			pageIndex = "1";
		}
		// 搜索的数据库范围（eg：fmzl_ab，syxx_ab）
		// String strSources = "";
		/*
		 * String strSources = request.getParameter("strSources");
		 * if(strSources==null||strSources.equals("")){
		 * request.setAttribute("search_error", "请选择检索频道");
		 * request.setAttribute("strWhere", strWhere); // request.setAttribute("area",
		 * area); return ERROR; }
		 */

		List<ChannelInfo> channelList = new ArrayList<ChannelInfo>();

		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>) application.get("channelInfoList_cn");
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>) application.get("channelInfoList_fr");

		if (channelList == null || channelList.size() == 0) {
			String[] arrdb = strChannels.split(",");

			Iterator<ChannelInfo> iter = channelInfoList_cn.iterator();
			while (iter.hasNext()) {
				ChannelInfo channelinfo = ((ChannelInfo) iter.next());
				int channelid = channelinfo.getIntChannelID();
				String channelname = channelinfo.getChrTRSTable();
				// System.out.println(iter.next());
				for (int i = 0; i < arrdb.length; i++) {
					if (arrdb[i].equals(channelid + "") || arrdb[i].equals(channelname)) {
						channelList.add(channelinfo);
					}
				}
			}

			iter = channelInfoList_fr.iterator();
			while (iter.hasNext()) {
				ChannelInfo channelinfo = ((ChannelInfo) iter.next());
				int channelid = channelinfo.getIntChannelID();
				String channelname = channelinfo.getChrTRSTable();
				// System.out.println(iter.next());
				for (int i = 0; i < arrdb.length; i++) {
					if (arrdb[i].equals(channelid + "") || arrdb[i].equals(channelname)) {
						channelList.add(channelinfo);
					}
				}
			}
		}
		// String[] channelArray = null;

		// 获取查询频道信息（频道ID）
		// String[] dbArray = request.getParameterValues("strdb");
		// if (dbArray == null) {
		// dbArray = (String[]) request.getAttribute("strdb");
		// }
		//
		// String tempChannel = "";
		// if (dbArray != null) {
		// for (String strChannel : dbArray) {
		// tempChannel += strChannel + ",";
		// }
		// //IPC
		// if (request.getParameter("strChannel") != null
		// && !request.getParameter("strChannel").equals("")) {
		// tempChannel = request.getParameter("strChannel");
		// }
		//
		// if (!tempChannel.equals("")) {
		// channelArray = tempChannel.split(",");
		// }
		// }

		// String othersdb = request.getParameter("othersdb");
		// if(othersdb!=null&&!othersdb.equals("")){
		// strChannels+=",30";
		// }

		// System.out.println(request.getParameter("simpleSearch"));
		// System.out.println(request.getParameter("simpleSearch"));

		/*
		 * String simpleSearch = request.getParameter("simpleSearch");
		 * if(simpleSearch!=null &&
		 * simpleSearch.equals("1")&&area!=null&&!area.equals("")){ // channelList =
		 * channelFunc.getChannelInfoByArea(area);
		 * 
		 * if(area.equals("fr")){ channelList = channelInfoList_fr; }else{ channelList =
		 * channelInfoList_cn; } }
		 */

		String trsLastWhere = request.getParameter("trsLastWhere") == null ? "" : request.getParameter("trsLastWhere");
		/*
		 * if (channelArray != null) { for (int i = 0; i < channelArray.length; i++) {
		 * strChannels += channelArray[i] + ","; } strChannels =
		 * strChannels.substring(0, strChannels.length() - 1); } else { strChannels =
		 * request.getParameter("strChannels");
		 * 
		 * // IPC if (request.getParameter("strChannel") != null &&
		 * !request.getParameter("strChannel").equals("")) { // strChannels =
		 * (String)request.getAttribute("strChannel"); strChannels =
		 * request.getParameter("strChannels");
		 * 
		 * } else if (request.getParameter("strSources") != null) { strSources =
		 * request.getParameter("strSources") + ","; }
		 * 
		 * if (strChannels==null||strChannels.equals("")) { strChannels =
		 * (String)request.getAttribute("strChannel");
		 * request.removeAttribute("strChannel"); }
		 * 
		 * channelArray = strChannels.split(","); }
		 */

		// 数据权限验证
		/**
		 * AbsDataAuthority dataAuthority = new SearchScopeAuthProxy(request, response);
		 * if (!dataAuthority.hasDataAuthority(((Integer)
		 * request.getSession().getAttribute(Constant.APP_USER_ROLE)).toString(),
		 * Constant.AUTH_FUNC_OVERVIEW_SEARCH, strChannels,
		 * Integer.parseInt(pageIndex))) { return null; }
		 **/

		// 通过ID，获取数据库的具体信息
		// if(channelList==null)

		String strSources = Util.getPatentTable(application, strChannels);
		String strTRSTableName = Util.getPatentTableName(application, strSources);
		// System.out.println("strSources=" + strSources);

		String keywords = request.getParameter("keywords");
		String batchSearch = request.getParameter("batchSearch");

		// strWhere = URLDecoder.decode(request.getParameter("strWhere"), "UTF-8");

		// String quickSearch = request.getParameter("quickSearch");
		// if(quickSearch!=null && quickSearch.equals("1")){
		// strWhere = (String)request.getParameter("strWhere");
		// }

		// String colname = request.getParameter("colname");
		// request.setAttribute("colname", (colname == null) ? "" : colname);

		// String content = request.getParameter("content");
		// request.setAttribute("content", (content == null) ? "" : content);

		/**
		 * 批量检索
		 */
		if (batchSearch != null && batchSearch.equals("1")) {
			if (strWhere != null) {
				strWhere = strWhere.replace(")", "");
				strWhere = strWhere.trim();
				if (strWhere.endsWith(","))
					strWhere = strWhere.replace(",", "");
				strWhere = strWhere + ")";
			}
			String[] array = StringUtil.splitStringToArray(strWhere, "\r\n");
			String newWhere = "";
			for (int m = 0; m < array.length; m++) {
				if (StringUtil.hasText(array[m])) {
					if (m == (array.length - 1))
						newWhere += array[m].trim();
					else
						newWhere += array[m].trim() + ",";
				}
			}

			if (newWhere.endsWith(",)"))
				newWhere = newWhere.replace(",)", ")");
			// System.out.println("newWhere="+newWhere);
			strWhere = newWhere;
		}

		String strStat = request.getParameter("strStat");
		if (strStat == null)
			strStat = "";

		/**
		 * 简单检索
		 */
		if (simpleSearch != null && simpleSearch.equals("1")) {
			if (keywords != null && keywords.equals("") == false)
				try {
					keywords = URLDecoder.decode(keywords, "utf-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
		} else {
			if (strWhere == null)
				strWhere = (String) request.getAttribute("strWhere");
			// System.out.println("搜索条件进行处理前："+strWhere);
			// 对搜索条件进行处理
			if (!strWhere.equalsIgnoreCase(trsLastWhere) && !strStat.equals("1")) {
				// strWhere = GetSearchFormat.preprocess(strWhere);
			}
		}

		strWhere = strWhere.toUpperCase();
		// System.out.println("搜索条件进行处理后："+strWhere);
		// 排序
		String strSortMethod = request.getParameter("strSortMethod");
		/**
		 * RELEVANCE排序方式只支持 RELEVANCE
		 */
		if (strSortMethod == null || strSortMethod.equals("") || strSortMethod.equals("+RELEVANCE")
				|| strSortMethod.equals("-RELEVANCE"))
			strSortMethod = "RELEVANCE";
		String strDefautCols = request.getParameter("strDefautCols");
		if (strDefautCols == null)
			strDefautCols = "主权项, 名称, 摘要";

		// 按词或按字搜索
		String option = request.getParameter("iOption");
		int iOption = (option != null && !option.trim().equals("")) ? Integer.parseInt(option) : 1;
		// System.out.println(iOption);

		String iHitPointType = request.getParameter("iHitPointType");
		if (iHitPointType == null || iHitPointType.trim().equals("")) {
			iHitPointType = "115";
		}
		// 二次检索

		String secondSearchFlag = request.getParameter("bContinue");

		boolean bContinue = secondSearchFlag == null || secondSearchFlag.equals("") || secondSearchFlag.equals("false")
				? false
				: true;

		StringBuffer params = new StringBuffer();
		// params.append("strSources=").append(strSources).append("&")
		// .append("strSortMethod=").append(strSortMethod).append("&")
		// .append("strDefautCols=").append(strDefautCols.replace(" ",
		// "%20")).append("&")
		// .append("iOption=").append(iOption).append("&")
		// .append("iHitPointType=").append(iHitPointType).append("&")
		// .append("bContinue=").append(bContinue);

		// System.out.println("当前所在页数pageIndex= " + pageIndex);
		// 同义词检索
		String strSynonymous = request.getParameter("synonymous");
		// if (strSynonymous == null) {
		// strSynonymous = "";
		// } else {
		// strSynonymous = "SYNONYM_UTF8";
		// }
		strSynonymous = "SYNONYM_UTF8";

		// pagerecord
		int pagerecord = (request.getParameter("pagerecord") == null || request.getParameter("pagerecord").equals(""))
				? 0
				: Integer.parseInt(request.getParameter("pagerecord"));
		// System.out.println("pagerecord= " + pagerecord);
		pagerecord = pagerecord == 0 ? Constant.PAGERECORD : pagerecord;
		request.setAttribute("pagerecord", pagerecord);
		// long startIndex = (Integer.parseInt(pageIndex) - 1) * Constant.PAGERECORD;
		// 本次显示 最后一条记录下标
		// long endIndex = startIndex + Constant.PAGERECORD;
		// 概览页查询单个频道专利信息

		long startIndex = (Integer.parseInt(pageIndex) - 1) * pagerecord;
		// 本次显示 最后一条记录下标
		long endIndex = startIndex + pagerecord;
		// 概览页查询单个频道专利信息

		String filterChannel = request.getParameter("filterChannel");
		request.setAttribute("filterChannel", filterChannel);
		// 检索
		OverviewSearchResponse overviewResponse = null;

		String appNo = request.getParameter("appNum") == null ? "" : request.getParameter("appNum");
		String simFlag = request.getParameter("simFlag");
		String an = "";
		try {
			/**
			 * 是否进行了相似检索
			 */
			String pdLimit = request.getParameter("dateLimit") == null || request.getParameter("dateLimit").equals("")
					? "1999"
					: request.getParameter("dateLimit");
			String appDate = request.getParameter("apdRange");

			if (simFlag != null && !simFlag.trim().equals("")) {
				String dateCond = appDate.equals("0") ? ""
						: appDate.equals("1") ? " 申请日=(1900.01.01 to " + pdLimit + ") not (申请日=" + pdLimit + ")"
								: appDate.equals("2") ? "申请日=" + pdLimit + " to 2099.12.31" : "";
				strWhere = dateCond;
				an = "申请号=" + appNo;
				// strSources = "fmzl_ab,fmzl_ft,syxx_ab,syxx_ft";
				strSources = Util.getPatentTableByArea(application, area);
				bContinue = false;
				request.setAttribute("trsLastWhere", "");
				request.setAttribute("apdRange", appDate);
			}

			/**
			 * 是否进行了跨语言检索
			 */
			String crossLanguage = request.getParameter("crossLanguage");
			if (crossLanguage != null && crossLanguage.equals("ON")) {
				// strWhere = CrossLanguage.getCrossLanguageExp(strWhere);
			}

			// /**
			// * 非中国专利检索调用普通检索
			// */
			/*
			 * if (!area.equals("cn")) { overviewResponse =
			 * searchFunc.overviewSearch(wap,strSources, strWhere, strSortMethod, strStat,
			 * strDefautCols, iOption, Integer.parseInt(iHitPointType), bContinue,
			 * startIndex, endIndex, filterChannel, strSynonymous); } else {
			 * //智能检索semanticSearchImpl
			 * //////////////////////////////////////////////////////////////////// int isFR
			 * = 0; if(strSources.indexOf("patent")>-1){ isFR = 1; }
			 * if(wap!=null&&!wap.equals("")){ isFR = 5; }
			 * 
			 * String url = DataAccess.getProperty("SearchServerUrl"); if(isFR==5) url =
			 * DataAccess.getProperty("SearchServerUrl_wap");
			 * ////////////////////////////////////////////////////////////////////
			 * if(url.indexOf("service.cnipr.com")>-1){ //只要cnipr接口才有语义检索，本地接口没有语义检索接口
			 * overviewResponse = semanticSearchImpl.getSemanticResult(wap, strSources,
			 * strWhere, strSortMethod, strStat, strDefautCols, iOption,
			 * Integer.parseInt(iHitPointType), bContinue, startIndex, endIndex,
			 * filterChannel, strSynonymous, an, trsLastWhere); }else{ overviewResponse =
			 * searchFunc.overviewSearch(wap,strSources, strWhere, strSortMethod, strStat,
			 * strDefautCols, iOption, Integer.parseInt(iHitPointType), bContinue,
			 * startIndex, endIndex, filterChannel, strSynonymous); } }
			 */
			// System.out.println("strSources="+strSources);
			// System.out.println("strWhere="+strWhere);

			overviewResponse = searchFunc.overviewSearch(wap, strSources, strWhere, strSortMethod, strStat,
					strDefautCols, iOption, Integer.parseInt(iHitPointType), bContinue, startIndex, endIndex,
					filterChannel, strSynonymous);

			// overviewResponse = searchFunc.overviewSearch(wap,strSources,
			// strWhere, strSortMethod, strStat, strDefautCols,
			// iOption, Integer.parseInt(iHitPointType), bContinue,
			// startIndex, endIndex, filterChannel, strSynonymous);

			// List<PatentInfo> PatentInfoList = overviewResponse.getPatentInfoList();

			if (overviewResponse != null && overviewResponse.getPatentInfoList() != null
					&& overviewResponse.getPatentInfoList().size() > 0) {
				List<PatentInfo> _PatentInfoList = processPatentInfoList(wap, overviewResponse.getPatentInfoList(),
						false, false);
				overviewResponse.setPatentInfoList(_PatentInfoList);

				// String LatestFlzt =
				// DataAccess.getProperty("LatestFlzt")==null?"0":DataAccess.getProperty("LatestFlzt");
				// if(area!=null&&(area.equalsIgnoreCase("cn")||area.toLowerCase().equals("sx"))&&LatestFlzt.equals("1")){
				// lastestFlztInfo = getLatestFlzt(wap, application, overviewResponse);
				// request.setAttribute("lastestFlztInfo", lastestFlztInfo);
				// request.getSession().setAttribute("lastestFlztInfo",lastestFlztInfo);
				// }
			}

			if (SetupAccess.getProperty(SetupConstant.FENXI) != null
					&& SetupAccess.getProperty(SetupConstant.FENXI).equals("1")) {
				if (overviewResponse != null && overviewResponse.getMap_option() != null
						&& overviewResponse.getMap_option().size() > 0) {

					TreeMap<String, Integer> map_data_single = overviewResponse.getMap_data_single();
					request.setAttribute("map_data_single", map_data_single);

					// ArrayList<Map.Entry<String,Integer>> list_data_single =
					// overviewResponse.getList_data_single();

					/*
					 * Iterator iter1 = map_option.entrySet().iterator(); while (iter1.hasNext()) {
					 * Map.Entry entry = (Map.Entry) iter1.next(); Object key = entry.getKey();
					 * Object val = entry.getValue();
					 * 
					 * System.out.println(key + "-----------------------------" + val); }
					 */
				}
			}

			if (overviewResponse.getRecordCount() == 0) {
				request.setAttribute("search_error", "此次检索无结果");
				request.setAttribute("strWhere", strWhere);
				request.setAttribute("area", area);
				ret = ERROR;
			}
			/**
			 * 概览检索记录检索日志
			 */
			if (SetupAccess.getProperty(SetupConstant.DATABASELOG) != null
					&& SetupAccess.getProperty(SetupConstant.DATABASELOG).equals("1")) {
				// System.out.println(request.getSession().getAttribute(Constant.APP_USER_ID));
				int userid = 0;
				userid = Integer.parseInt((String) request.getSession().getAttribute(Constant.APP_USER_ID));

				String userName = "";
				userName = (String) request.getSession().getAttribute(Constant.APP_USER_NAME);
				PlatformLog.insertSearchLog(userid, userName, com.cnipr.cniprgz.commons.Common.getRemoteAddr(request),
						area);
			}
		} catch (Exception e) {

			String errinfo = e.getMessage();
			if (errinfo != null && (errinfo.equals("非法的客户端") || errinfo.equals("客户端过期"))) {
				errinfo = "概览检索出错，" + e.getMessage() + "，请联系客服";
			} else {
				errinfo = "概览检索出错";
			}

			request.setAttribute("search_error", errinfo);
			// request.setAttribute("search_error", "概览检索出错");
			request.setAttribute("strWhere", strWhere);
			ret = ERROR;
		}
		if (overviewResponse != null) {
			/**
			 * 如果执行了二次检索则执行trsLastWhere
			 */
			trsLastWhere = overviewResponse.getTrsLastWhere();
			if (bContinue) {
				// strWhere = trsLastWhere;
			}
			request.setAttribute("trsLastWhere", trsLastWhere);

			// 界面jstl进行迭代
			request.getSession().setAttribute("list", overviewResponse.getPatentInfoList());

			Page nav = new Page();
			long totalRecord = overviewResponse.getRecordCount();
			// 设置总页数
			// String count = Integer.toString((int) java.lang.Math.ceil((totalRecord - 1) /
			// Constant.PAGERECORD) + 1);
			String count = Integer.toString((int) java.lang.Math.ceil((totalRecord - 1) / pagerecord) + 1);

			/*********************************************************************************************************/
			// request.getSession().setAttribute("gl_hm",overviewResponse.getGl_hm());

			/*********************************************************************************************************/

			/*
			 * Gson gson = new
			 * GsonBuilder().setPrettyPrinting().disableHtmlEscaping().create(); JsonParser
			 * jp = new JsonParser(); JsonElement je = jp.parse(gson.toJson(gl_hm)); String
			 * jsonresult = gson.toJson(je); jsonresult = jsonresult.replace("\r", "");
			 * jsonresult = jsonresult.replace("\n", ""); jsonresult =
			 * jsonresult.replace("}", results + "}"); System.out.println(jsonresult);
			 */

			int expid = 0;
			// 是否保存检索表达式
			String savesearch = request.getParameter("savesearchword");
			if (savesearch != null && savesearch.equalsIgnoreCase("ON")) {
				String userID = (String) request.getSession().getAttribute(Constant.APP_USER_ID);
				String userIP = com.cnipr.cniprgz.commons.Common.getRemoteAddr(request);
				int intCountry = (area != null && area.equalsIgnoreCase("fr")) ? 1 : 0;
				/**
				 * 保存智能检索表达式
				 * 
				 * 
				 * expFunc.saveExpression(userIP, Integer.parseInt(userID), strWhere,
				 * strTRSTableName, null, totalRecord, request .getParameter("synonymous"),
				 * intCountry);
				 */
				/*
				 * String commonExp = ParseSemanticExp.getSemanticExp(strWhere)[2]; String
				 * relation = ParseSemanticExp.getSemanticExp(strWhere)[0]; String semantic =
				 * overviewResponse.getPatentWords(); if (semantic != null &&
				 * !semantic.equals("")) { semantic = "ss=" +
				 * Array2StringUtil.parseArray(semantic); strWhere = commonExp + relation +
				 * semantic; }
				 */

				// expFunc.saveExpression(userIP, Integer.parseInt(userID),
				// strWhere, strTRSTableName, null, totalRecord,
				// request.getParameter("synonymous"), intCountry );

				expFunc.saveExpression(userIP, Integer.parseInt(userID), strWhere, strSources, strTRSTableName, null,
						totalRecord, request.getParameter("synonymous"), intCountry);
			}
			/*
			 * System.out.println("count = "+count);
			 * System.out.println("pageIndex = "+pageIndex);
			 * System.out.println("params.toString() = "+params.toString());
			 * System.out.println("request.getContextPath() = "+request.getContextPath());
			 */
			nav.setPageCount(count);
			nav.setPageIndex(pageIndex);
			nav.setParams(params.toString());
			nav.setNavigationUrl(request.getContextPath());
			// 设置表格检索还是逻辑检索
			request.setAttribute("searchKind", request.getParameter("searchKind"));
			request.setAttribute("area", area);
			request.setAttribute("unfilterTotalCount", overviewResponse.getUnfilterTotalCount());
			request.setAttribute("sections", getSectionInfo(channelList, overviewResponse.getSectionInfos()));

			request.setAttribute("nav", nav);
			request.setAttribute("pageCount", count);
			request.setAttribute("totalRecord", totalRecord);
			request.setAttribute("strChannels", strChannels);
			request.setAttribute("strSynonymous", strSynonymous);
			request.setAttribute("strWhere", strWhere);
			request.setAttribute("strSources", strSources);
			request.setAttribute("strSortMethod", strSortMethod);
			request.setAttribute("strDefautCols", strDefautCols);
			request.setAttribute("strStat", strStat);
			request.setAttribute("iOption", iOption);
			request.setAttribute("iHitPointType", iHitPointType);
			request.setAttribute("bContinue", bContinue);
			request.setAttribute("julei", request.getParameter("julei"));
			request.setAttribute("fenxi", request.getParameter("fenxi"));
			request.setAttribute("appNum", appNo);
			request.setAttribute("simFlag", simFlag);

			/**
			 * 将智能检索的相关概念返回
			 */
			// 20160212
			// if (!area.equals("cn")) {
			// request.setAttribute("revWord", overviewResponse.getRelevance()
			// .split(" "));
			// String[] simArray = semanticDao.getSimwords(
			// overviewResponse.getPatentWords()).split(" ");
			// request.setAttribute("simword", simArray);
			// }

			log74(request, overviewResponse, treeType, strSources, searchKind, area);

			// return mapping.findForward("result");

			// if(treeType!=null&&(treeType.equals("0")||treeType.equals("1"))){
			// return INPUT;
			// }else{
			// return SUCCESS;
			// }

			ret = SUCCESS;
		} else {
			request.setAttribute("strWhere", strWhere);
			ret = ERROR;
		}

		return ret;
	}

	public String getGLjieguo() {

		try {
			ActionContext cxt = ActionContext.getContext();
			Map<String, Object> application = cxt.getApplication();

			// Map<String,String> lastestFlztInfo = new HashMap<String,String>();

			HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
			HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
			HttpSession session = request.getSession();

			request.getSession().getAttribute("gl_hm");

			String results = "";
			HashMap<String, HashMap<String, Integer>> gl_hm = (HashMap<String, HashMap<String, Integer>>) request
					.getSession().getAttribute("gl_hm");

			Iterator iter = gl_hm.entrySet().iterator();
			while (iter.hasNext()) {
				Map.Entry entry = (Map.Entry) iter.next();
				String key = (String) entry.getKey();
				// Object val = entry.getValue();

				System.out.println("-----" + key + "-----");

				Map map = (HashMap<String, Integer>) entry.getValue();
				/*
				 * Iterator _iter = map.entrySet().iterator(); while (_iter.hasNext()) {
				 * Map.Entry _entry = (Map.Entry) _iter.next(); String _key =
				 * (String)_entry.getKey(); Integer _val = (Integer)_entry.getValue(); //
				 * System.out.println(key + "---" + _key + "---" + _val); }
				 */

				ArrayList<Map.Entry<String, Integer>> list_data_single = new ArrayList<Map.Entry<String, Integer>>(
						map.entrySet());
				Collections.sort(list_data_single, new Comparator<Map.Entry<String, Integer>>() {
					public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
						return (o2.getValue().intValue() - o1.getValue().intValue());
					}
				});

				String _results = "";
				for (Map.Entry<String, Integer> mapping : list_data_single) {
					// System.out.println(mapping.getKey() + ":" + mapping.getValue());

					if (!_results.equals("")) {
						_results += ",";
					}
					if (!mapping.getKey().equals("")) {
						_results += "\"" + mapping.getKey() + "\":" + mapping.getValue();
					}
				}

				if (!results.equals("")) {
					results += ",";
				}
				results += "\"" + key + "\": {" + _results + "}";
			}
			results = "\"results\": {" + results + "}";
			System.out.println(results);

			jsonresult = results;

		} catch (Exception ex) {
			// throw ex;
			// jsonresult=ex.toString();
			jsonresult = "";
			// return ERROR;
		}
		return SUCCESS;
	}

	private void log74(HttpServletRequest request, OverviewSearchResponse overviewResponse, String treeType,
			String strSources, String searchKind, String area) {

		ActionContext cxt = ActionContext.getContext();
		Map<String, Object> application = cxt.getApplication();
		/**
		 * log74日志
		 */
		if (Log74Access.getProperty(Log74Util.getLOG_OPEN()) != null
				&& Log74Access.getProperty(Log74Util.getLOG_OPEN()).equals("1")) {
			if (request.getSession().getAttribute(Constant.APP_USER_ID) != null) {
				String operateUserId = (String) request.getSession().getAttribute(Constant.APP_USER_ID);
				IprUser ipruser = sysUserFunc.getUserInfo(Integer.parseInt(operateUserId));
				String operateAmount = "";
				if (overviewResponse != null)
					operateAmount = overviewResponse.getRecordCount() + "";

				if (treeType != null && treeType.equals("0"))// ipc检索
				{
					try {
						Log74Util.log_func("2000", operateUserId + "", ipruser.getIntGroupId() + "",
								com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), DateUtil.getCurrentTimeStr(),
								strSources, operateAmount);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if (treeType != null && treeType.equals("1"))// 行业库检索
				{
					try {
						Log74Util.log_func("1500", operateUserId + "", ipruser.getIntGroupId() + "",
								com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), DateUtil.getCurrentTimeStr(),
								strSources, operateAmount);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if (treeType != null && treeType.equals("3"))// 专题库检索
				{
					try {
						Log74Util.log_func("1600", operateUserId + "", ipruser.getIntGroupId() + "",
								com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), DateUtil.getCurrentTimeStr(),
								strSources, operateAmount);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if ((treeType == null || treeType.equals("")) && area.equals("cn"))// 国内检索
				{
					if (searchKind != null && searchKind.equals("tableSearch"))// 国内表格检索
						try {
							Log74Util.log_func("1005", operateUserId + "", ipruser.getIntGroupId() + "",
									com.cnipr.cniprgz.commons.Common.getRemoteAddr(request),
									DateUtil.getCurrentTimeStr(), strSources, operateAmount);
						} catch (IOException e) {
							e.printStackTrace();
						}
					if (searchKind != null && searchKind.equals("logicSearch"))// 国内逻辑检索
						try {
							Log74Util.log_func("1015", operateUserId + "", ipruser.getIntGroupId() + "",
									com.cnipr.cniprgz.commons.Common.getRemoteAddr(request),
									DateUtil.getCurrentTimeStr(), strSources, operateAmount);
						} catch (IOException e) {
							e.printStackTrace();
						}
				}
				if ((treeType == null || treeType.equals("")) && area.equals("fr"))// 国外检索
				{
					if (searchKind != null && searchKind.equals("tableSearch"))// 国外表格检索
						try {
							Log74Util.log_func("1010", operateUserId + "", ipruser.getIntGroupId() + "",
									com.cnipr.cniprgz.commons.Common.getRemoteAddr(request),
									DateUtil.getCurrentTimeStr(), strSources, operateAmount);
						} catch (IOException e) {
							e.printStackTrace();
						}
					if (searchKind != null && searchKind.equals("logicSearch"))// 国外逻辑检索
						try {
							Log74Util.log_func("1020", operateUserId + "", ipruser.getIntGroupId() + "",
									com.cnipr.cniprgz.commons.Common.getRemoteAddr(request),
									DateUtil.getCurrentTimeStr(), strSources, operateAmount);
						} catch (IOException e) {
							e.printStackTrace();
						}
				}
			}
		} /**
			 * log74日志结束
			 */
	}

	private String jsonresult;

	public String getJsonresult() {
		return jsonresult;
	}

	public void setJsonresult(String jsonresult) {
		this.jsonresult = jsonresult;
	}

	private String nodeId;
	private String currentPage;
	private String language;

	public String getNodeId() {
		return nodeId;
	}

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public String getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(String currentPage) {
		this.currentPage = currentPage;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String logicSaveExpression() throws Exception {
		try {
			ActionContext cxt = ActionContext.getContext();
			Map<String, Object> application = cxt.getApplication();
			HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
			HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
			HttpSession session = request.getSession();
			//////////////////////////////////////////////////////////////////////////////////////////////////////////
			String strWhere = request.getParameter("strWhere");

			String area = request.getParameter("area");
			if (area == null)
				area = "cn";

			// 获取查询频道信息（频道ID）
			// String[] dbArray = request.getParameterValues("strdb");//14、15
			// if (dbArray == null) {
			// dbArray = (String[]) request.getAttribute("strdb");
			// }
			String strChannels = request.getParameter("strChannels");

			// String strdb = request.getParameter("strdb");
			// String[] dbArray = strdb.split(",");

			// List<ChannelInfo> channelList = channelFunc.getInfoMapByChannel(dbArray);
			// String strSources = "";
			// String strTRSTableName = "";
			//
			// for (ChannelInfo info : channelList) {
			// strSources += info.getChrTRSTable() + ",";
			// strTRSTableName += info.getChrChannelName() + ",";
			// }
			//
			// if (strSources != null && !strSources.equals(""))
			// strSources = strSources.substring(0, strSources.length() - 1);
			//
			// if (strTRSTableName != null && !strTRSTableName.equals(""))
			// strTRSTableName = strTRSTableName.substring(0, strTRSTableName.length() - 1);

			HashMap<String, Object> hm_result = getPatentInfos(cxt);
			hm_result.get("RecordCount");
			jsonresult = hm_result.get("RecordCount") + "";

			/*
			 * int expid = 0; String userID = (String) request.getSession().getAttribute(
			 * Constant.APP_USER_ID); String userIP =
			 * com.cnipr.cniprgz.commons.Common.getRemoteAddr( request); int intCountry =
			 * (area != null && area.equalsIgnoreCase("fr")) ? 1 : 0;
			 * 
			 * String commonExp = ParseSemanticExp.getSemanticExp(strWhere)[2]; String
			 * relation = ParseSemanticExp.getSemanticExp(strWhere)[0]; String semantic =
			 * overviewResponse.getPatentWords(); if (semantic != null &&
			 * !semantic.equals("")) { semantic = "ss=" +
			 * Array2StringUtil.parseArray(semantic); strWhere = commonExp + relation +
			 * semantic; } // expid = expFunc.saveExpression(userIP,
			 * Integer.parseInt(userID), // strWhere, strTRSTableName, null, totalRecord,
			 * request // .getParameter("synonymous"), intCountry); expid =
			 * expFunc.saveExpression(userIP, Integer.parseInt(userID), strWhere,
			 * strSources, strTRSTableName, null, totalRecord,
			 * request.getParameter("synonymous"), intCountry);
			 */

			// hm_result.put("RecordCount", overviewResponse.getRecordCount());

			/*
			 * String strSources = Util.getPatentTable(application, strChannels); String
			 * strTRSTableName = Util.getPatentTableName(application, strSources); //
			 * strWhere = GetSearchFormat.preprocess(strWhere); //
			 * strWhere=strWhere.replace("申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=",
			 * "快速检索=");
			 * 
			 * String wap =
			 * request.getParameter("wap")==null?"":request.getParameter("wap");
			 * 
			 * OverviewSearchResponse overviewResponse = searchFunc.overviewSearch( wap,
			 * strSources, strWhere, "RELEVANCE", "", "主权项, 名称, 摘要", 2, 115, false, 0, 10,
			 * null, "");
			 * 
			 * // List<PatentInfo> PatentInfoList = overviewResponse.getPatentInfoList();
			 * 
			 * long totalRecord = overviewResponse.getRecordCount();
			 * 
			 * int expid = 0; String synonymous =
			 * request.getParameter("synonymous")==null?"":request.getParameter("synonymous"
			 * ); // if (savesearch != null && savesearch.equals("ON")) { String userID =
			 * (String) request.getSession().getAttribute( Constant.APP_USER_ID); String
			 * userIP = com.cnipr.cniprgz.commons.Common.getRemoteAddr( request); int
			 * intCountry = (area != null && area.equalsIgnoreCase("fr")) ? 1 : 0;
			 * 
			 * String commonExp = ParseSemanticExp.getSemanticExp(strWhere)[2]; String
			 * relation = ParseSemanticExp.getSemanticExp(strWhere)[0]; String semantic =
			 * overviewResponse.getPatentWords(); if (semantic != null &&
			 * !semantic.equals("")) { semantic = "ss=" +
			 * Array2StringUtil.parseArray(semantic); strWhere = commonExp + relation +
			 * semantic; }
			 * 
			 * // expid = expFunc.saveExpression(userIP, Integer.parseInt(userID), //
			 * strWhere, strTRSTableName, null, totalRecord, request //
			 * .getParameter("synonymous"), intCountry);
			 * 
			 * expid = expFunc.saveExpression(userIP, Integer.parseInt(userID), strWhere,
			 * strSources, strTRSTableName, null, totalRecord,
			 * request.getParameter("synonymous"), intCountry); } log74(request,
			 * overviewResponse, "", strSources, "logicSearch", area);
			 * 
			 * /////////////////////////////////////////////////////////////////////////////
			 * /////////////////////////////
			 * 
			 * // List<PatentInfo> _PatentInfoList = null; //
			 * if(PatentInfoList!=null&&PatentInfoList.size()>0){ // _PatentInfoList =
			 * processPatentInfoList(PatentInfoList); // } //
			 * overviewResponse.setPatentInfoList(_PatentInfoList); //
			 * request.getSession().setAttribute("list",_PatentInfoList);
			 * 
			 * if(SetupAccess.getProperty(SetupConstant.DATABASELOG)!=null &&
			 * SetupAccess.getProperty(SetupConstant.DATABASELOG).equals("1")) { int userid
			 * = 0; userid =
			 * Integer.parseInt((String)request.getSession().getAttribute(Constant.
			 * APP_USER_ID));
			 * 
			 * String userName = ""; userName =
			 * (String)request.getSession().getAttribute(Constant.APP_USER_NAME);
			 * PlatformLog.insertSearchLog(userid,userName,
			 * com.cnipr.cniprgz.commons.Common.getRemoteAddr( request),area); }
			 * 
			 * String treeType =
			 * request.getParameter("treeType")==null?"0":request.getParameter("treeType");
			 * log74(request, overviewResponse, treeType, strSources, "logicSearch", area);
			 * 
			 * jsonresult = overviewResponse.getRecordCount()+"";
			 */

//			System.out.println(jsonresult);
		} catch (Exception ex) {
			jsonresult = "";
		}
		return SUCCESS;
	}

	public String pretoJsonOverView() throws Exception {
		try {
			ActionContext cxt = ActionContext.getContext();
			Map<String, Object> application = cxt.getApplication();

//			Map<String,String> lastestFlztInfo = new HashMap<String,String>();

			HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
			HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
			HttpSession session = request.getSession();
			
//			String sss = request.getParameter("strWhere");
//			System.out.println(sss);
			
			String logicexpid = request.getParameter("logicexpid") == null ? ""
					: request.getParameter("logicexpid").toUpperCase();
			if (logicexpid != null && !logicexpid.equals("")) {
				ExpressionInfo ei = expFunc.getExpbyID(Integer.parseInt(logicexpid));
//				System.out.println(ei.getExpression());
//				System.out.println(ei.getSources());

				session.setAttribute("strWhere", ei.getExpression());
				session.setAttribute("strSources", ei.getSources());
			} else {
				String area = request.getParameter("area") == null ? "cn" : request.getParameter("area").toLowerCase();
				String strWhere = request.getParameter("strWhere");
				String strSources = request.getParameter("strChannels") == null ? ""
						: request.getParameter("strChannels");

				strSources = Util.getPatentTable(application, strSources);

//				strSources = Util.getPatentTable(application, selectdbs);
//				String strTRSTableName = Util.getPatentTableName(application, strSources);

				session.setAttribute("area", area);
				session.setAttribute("strWhere", strWhere);
				session.setAttribute("strSources", strSources);
			}
			// System.out.println("area="+area);
			// System.out.println("strWhere="+strWhere);
			// System.out.println("strSources="+strSources);
			// System.out.println("strTRSTableName="+strTRSTableName);

		} catch (Exception ex) {

		}

		return SUCCESS;
	}

	public static void main(String[] args) {

		String strWhere = "主权项语义,摘要语义+='申请号公开号=CN1240392A' not 申请年=(2014 or 2015 or 2016)";
		String prefix_yuyi = "主权项语义,摘要语义+='申请号公开号=";
		if (strWhere.indexOf(prefix_yuyi) > -1) {
			String semanticexp = "";
			String nums = strWhere.substring(strWhere.indexOf(prefix_yuyi) + prefix_yuyi.length());
			System.out.println(nums.indexOf("'"));
			nums.substring(0, nums.indexOf("'"));
			nums = nums.replace("'", "");
			System.out.println(nums);
		}

		String str = "一种1-[2-(二甲氨基)-1-(4-甲氧基苯基)乙基]环己醇盐酸盐的制备方法，其特征在于主要包括如下步骤：(1)4-甲氧基苯乙酸的氯化和胺化反应：      4-甲氧基苯乙酸和氯化亚砜加热回流2～6小时，除去氯化亚砜，加入溶  剂和40％(wt％)的二甲胺水溶液，在10～30℃下搅拌5-12小时，各反应物  的摩尔比为：   4-甲氧基苯乙酸∶氯化亚砜∶40％(wt％)的二甲胺水溶液   ＝1∶(1.2～1.4)∶(2～4)；   所说的溶剂为苯、氯仿或环己烷中的一种；(2)N，N-二甲基-4-甲氧基苯乙酰胺的Ivanov反应和与环己醇的加成反应：       异丙基溴化镁、溶剂与N，N-二甲基-4-甲氧基苯乙酰胺在10～30℃下   反应4～8小时，然后再加入环己酮，在40～45℃下反应5～12小时从反   应产物中收集反应产物-N，N-二甲基-α-(1-羟基环己基)-4-甲氧基苯乙酰   胺；       所说的溶剂为四氢呋喃、乙二醇二甲醚或乙醚中的一种，参加反应的各   物料的摩尔比为：   N，N-二甲基-4-甲氧基苯乙酰胺∶异丙基溴化镁∶环己酮   ＝1∶(2～3)∶(2～3)；(3)N，N-二甲基-α-(1-羟基环己基)-4-甲氧基苯乙酰胺的还原反应：       N，N-二甲基-α-(1-羟基环己基)-4-甲氧基苯乙酰胺、溶剂、硼氢化钾和   三氯化铝在10～30℃下反应2～4小时，从反应产物中收集反应产物1-   [2-(二甲氨基)-1-(4-甲氧基苯基)乙基]环己醇；参加反应的各物料的摩尔比为：N，N-二甲基-α-(1-羟基环己基)-4-甲氧基苯乙酰胺∶硼氢化钾∶三氯化铝＝1∶(5～7)∶(10～12)；所说的溶剂为四氢呋喃、乙二醇二甲醚或乙醚；(4).1-[2-(二甲氨基)-1-(4-甲氧基苯基)乙基]环己醇的盐酸化：     1-[2-(二甲氨基)-1-(4-甲氧基苯基)乙基]环己醇溶解于溶剂中，在25～30℃的条件下通入氯化氢气体，并调节溶液的pH至1～2，冷却至5～10℃，获得结晶物，即目标产物-1-[2-(二甲氨基)-1-(4-甲氧基苯基)乙基]环己醇盐酸盐；     1-[2-(二甲氨基)-1-(4-甲氧基苯基)乙基]环己醇与溶剂的比例为5～7(v/v)，所说的溶剂为异丙醇、乙醇或甲醇中的一种。";
		str = "CN106547854A";
		str = "CN201610912588.7";
		str = "猪 环己醇盐酸盐的制备方法";
		SearchAction sa = new SearchAction();
		String str1 = sa.filterSemanticExp(str);
		System.out.println(str1);

		//String str2 = sa.filterSemanticExp1(str);
		//System.out.println(str2);
	}

	public String createAbstractZip() throws Exception {
		ActionContext cxt = ActionContext.getContext();
		Map<String, Object> application = cxt.getApplication();

		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();

		String downloadcol = request.getParameter("downloadcol");
//		System.out.println("downloadcol="+downloadcol);

		String downloadType = request.getParameter("downtype");
		String strPatentList = request.getParameter("patentList");
		String isbatchdownload = request.getParameter("isbatchdownload");
		String downloadStart = request.getParameter("downloadStart");
		String downloadAmount = request.getParameter("downloadAmount");
		String operateAmount = "";

		String strWhere = request.getParameter("strWhere");
		if (strWhere == null)
			strWhere = (String) request.getAttribute("strWhere");

		String area = request.getParameter("area");
		String strSources = request.getParameter("strSources");
		strSources = Util.getPatentTable(application, strSources);
		String basePath = request.getSession().getServletContext().getRealPath("tempfile");
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////

		// 记录log74日志文摘下载
		if (Log74Access.getProperty(Log74Util.getLOG_OPEN()) != null
				&& Log74Access.getProperty(Log74Util.getLOG_OPEN()).equals("1")) {
			if (request.getSession().getAttribute(Constant.APP_USER_ID) != null) {
				String operateUserId = (String) request.getSession().getAttribute(Constant.APP_USER_ID);
				IprUser ipruser = sysUserFunc.getUserInfo(Integer.parseInt(operateUserId));
				try {
					Log74Util.log_func("9000", operateUserId + "", ipruser.getIntGroupId() + "",
							com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), DateUtil.getCurrentTimeStr(),
							strSources, operateAmount);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		List<PatentInfo> patentList = new ArrayList<PatentInfo>();
		List<PatentInfo> _patentList = new ArrayList<PatentInfo>();

		GregorianCalendar date = new GregorianCalendar();
		long time1 = date.getTimeInMillis() / 1000;
		if (isbatchdownload != null && isbatchdownload.equals("1"))// 批量下载
		{
			// System.out.println("isbatchdownload="+isbatchdownload);
			Long download_start = (long) 0;
			Long download_amount = (long) 0;
			if (downloadStart != null)
				download_start = Long.parseLong(downloadStart);
			if (downloadAmount != null)
				download_amount = Long.parseLong(downloadAmount);
//				 System.out.println("download_start="+download_start);
//				 System.out.println("download_amount="+download_amount);
			try {
//				patentList = overviewSearch(request, response, download_start, download_amount).getPatentInfoList();

//				SearchAction searchaction = new SearchAction();
				HashMap<String, Object> hm_result = getPatentInfos(cxt);

				OverviewSearchResponse overviewResponse = (OverviewSearchResponse) hm_result.get("overviewResponse");
				patentList = overviewResponse.getPatentInfoList();

			} catch (Exception e) {
				e.printStackTrace();
			}

			date = new GregorianCalendar();
			long time3 = date.getTimeInMillis() / 1000;
			if (isbatchdownload != null && isbatchdownload.equals("1")) {}
			// System.out.println("批量下载用时,检索=" + (time3-time1)+"秒");
			File targetFile = downloadFunc.createAbstractZip(basePath, patentList, downloadcol.split(","), downloadType,
					response, area, Integer.valueOf((String) request.getSession().getAttribute(Constant.APP_USER_ID)),
					(String) request.getSession().getAttribute(Constant.APP_USER_NAME),
					com.cnipr.cniprgz.commons.Common.getRemoteAddr(request),
					(Integer) request.getSession().getAttribute(Constant.APP_USER_FEETYPE));

			// long time2 = date.getTimeInMillis()/1000;
			// if(isbatchdownload!=null && isbatchdownload.equals("1")) {
			// System.out.println("批量下载用时,打包=" + (time2-time3)+"秒");
			// }
			// operateAmount = downloadAmount;

			jsonresult = targetFile.getName();
			return SUCCESS;

			// downloadFunc.batchdownloadZip(patentList, displayCol.split(","),
			// downloadType, response, area, Integer.valueOf((String) request
			// .getSession().getAttribute(Constant.APP_USER_ID)),
			// (String) request.getSession().getAttribute(
			// Constant.APP_USER_NAME), request.getRemoteAddr(),
			// (Integer) request.getSession().getAttribute(
			// Constant.APP_USER_FEETYPE));

			// date = new GregorianCalendar();

		} else {
			_patentList = (List<PatentInfo>) request.getSession().getAttribute("list");

			String[] arrPatentAn = strPatentList.split(",");
			// for(int i=0;i<arrPatentAn.length;i++){
			// PatentInfo _pi = patentList.
			// }

			Iterator<PatentInfo> iter = _patentList.iterator();
			while (iter.hasNext()) {
				PatentInfo pi = iter.next();

				for (int i = 0; i < arrPatentAn.length; i++) {
					if (pi.getAn().equals(arrPatentAn[i])) {
						patentList.add(pi);
					}
				}
				// System.out.println(iter.next());
			}

			// System.out.println(displayCol);
			// downloadFunc.downloadZip(patentList, displayCol.split(","),
			// downloadType, response, area, Integer.valueOf((String) request
			// .getSession().getAttribute(Constant.APP_USER_ID)),
			// (String) request.getSession().getAttribute(
			// Constant.APP_USER_NAME), request.getRemoteAddr(),
			// (Integer) request.getSession().getAttribute(
			// Constant.APP_USER_FEETYPE));

			File targetFile = downloadFunc.createAbstractZip(basePath, patentList, downloadcol.split(","), downloadType,
					response, area, Integer.valueOf((String) request.getSession().getAttribute(Constant.APP_USER_ID)),
					(String) request.getSession().getAttribute(Constant.APP_USER_NAME),
					com.cnipr.cniprgz.commons.Common.getRemoteAddr(request),
					(Integer) request.getSession().getAttribute(Constant.APP_USER_FEETYPE));

			jsonresult = targetFile.getName();
			return SUCCESS;

		}
		// if(patentList!=null && patentList.size()>0)
		// operateAmount = patentList.size()+"";
		// }

		// String tifInfos = "";
		//
		//
		// if (tifInfos != null && !"".equals(tifInfos)) {
		// File targetFile = downloadFunc.createTiffZip(basePath, tifInfos);
		//// return new ResultStatus("", "100000", "fileName=" + targetFile.getName());
		//
		// jsonresult=targetFile.getName();
		// return SUCCESS;
		// } else {
		//// return new ResultStatus("下载失败！", "999999", "");
		// return ERROR;
		// }
	}
	
	public String filterSemanticExp(String semanticexp) {
		String _semanticexp = "";
		semanticexp = semanticexp.replace("主权项语义,摘要语义+=", "");
		semanticexp = semanticexp.replace("'", "");

		Pattern pattern = Pattern.compile("[\u4e00-\u9fa5]+");
		Matcher matcher = pattern.matcher(semanticexp);

		if (!matcher.find()) {
			Pattern _pattern = Pattern.compile("[a-zA-Z.0-9]+");
			Matcher _matcher = _pattern.matcher(semanticexp);
			if (_matcher.find()) {
				semanticexp = "申请号公开号=" + semanticexp.replace("'", "");
			}
		} else {
			pattern = Pattern.compile("[\u4e00-\u9fa5]+");
			matcher = pattern.matcher(semanticexp);

			while (matcher.find()) {
				// System.out.println(matcher.group());
				// if(matcher.group().length()>1)
				{
					_semanticexp += matcher.group() + " ";
				}
			}
			semanticexp = _semanticexp;
			// System.out.println(semanticexp);

			/*
			 * String punctuation = "：[]～∶％/“”，,'\"\\-()（）+=!！@#$￥%……^&*×；;"; String[]
			 * arrPunctuation = punctuation.split("");
			 * 
			 * for(int i=0;i<arrPunctuation.length;i++) { semanticexp =
			 * semanticexp.replace(arrPunctuation[i], " "); }
			 */
			semanticexp = semanticexp.replaceAll("[ ]+", " ");

			// semanticexp = semanticexp.replaceAll("[0-9]+", " ");
			// semanticexp = semanticexp.replaceAll("[ ]+", " ");

			String str = "℃,一种用于,一种,其特征在于,还包括,其包括,包括,所述,其用于,用于,表示的,的,其中,中,各种,和,一个,多个,使用,如果,提出,是,并且,基于,过程,步骤,执行,确定,自从,从,"
					+ "到,在,当,于,朝,按,按照,经过,以,根据,因,由于,为了,为,对于,关于,与,跟,叫,让,被,把,将,比,除了,和,跟,同,与,而且,而,以及,及,不但,不仅,或者,或,但是,"
					+ "然而,如果,即使,那么,因为,所以,因此,得,着,了,似的,一样,所,给,吗,呢,吧,啊,优选,本发明,本实用新型,本实用,本实用,涉及,用途,他们,她们,它们,形成,新型,另外,"
					+ "公开了,组成,其,该,可,它,不具有,具有,有,其特征,构成,一,之间,采用,进行,涉,分别,方便,提供了,提供,装置,结构简单,安装,"
					+ "固定,装有,能,方法,上述,此,两个,至少,特别,制成,有一,部分,主要,产生,利用,设有,各,优点,一端,特征,沿着,被黑,可以,"
					+ "设置,带有,含有,这种,之,来提高,提高,即,实现,沿,制造,相应,一起,外,其它,现有,另一端,省略,上有,该装置,在同一,同一,预设,大于,"
					+ "公开,第,后,够,第二,产品,最,要点,产品名称,表明,计计,图片照片,如,制备,降低,解决,底部,另端,依次,系统,避免,在不,面板上,"
					+ "技术领域,再,立体图,然后,保证,效果,简单,高,包含,具体,加入,减少,重量,配合,技术,穿,每个,原料,问题,移动,调节,获取,效率,需要,"
					+ "模块,合配,防止,满足,主视图,第三,进入,增加,生产,产品形状,机构,均匀,合理,若干,领域,保持,快速,调整,提升,"
					+ "结构,设,成本低,相接,选择,情况下,情况,保持,申请,生产,满足,条件,进步,防止,增加,建立,提升,进入,调整,发生,构造,范围,良好,目标,机构,"
					+ "准确,运行,判断,结果,名称,计计,形状,视图,结合,端连接,图无,益果,左右,仰视图,状态,端通,电连接,更加,右视图,分布,要求,准确,组件,右视图,特点,节约,"
					+ "无需,节省,影响,添加,显著,放入,改善,左视图,多种,充分,改变,容易,增强,首先,俯视图,导致,数量,继续,很好,去除,这样,确保,较好,更好,人员,更换,需求,正常,"
					+ "变化,明显,任意,克服,推广,快捷,促进,寿命长,减轻,这些,全部,施加,优异,任何,简化,无法,劳动强度,改进,非常,人们,依据,消除,精确,预先,允许,组内,"
					+ "等特点,选取,模式,符合,引入,返回,保存,并使,常见,通过,相对,表面,相对,方式,上方,下方,板上,下列,方案,加工,由下,面上,上部,下份,上下,大大,稳定,实施例,"
					+ "下部,下述,具备,并通过,整个,针对,清洗,相互,取出,传统,架上,功效,接触,长度,百分,不会,座上,广泛,靠近,相邻,减小,来自,表示,出现,收集,性强,整体,水平,打开,较低,"
					+ "并对,开始,实际,相对应,对应,简便,上开,上还,启动,停止,大小,大量,重复,助剂,关闭,两种,四个,通过对,发出,方面,相关,实施,不易,方向上,管理,向上,二次,较大,效益,排出,带来,"
					+ "选自,引起,表面上,基础上,期间,现象,自身,丰富,除去,描述,迅速,出来,温下,包装,算出,装入,超过,目前,不足,向下,两者,保留,上层,初始,环境下,复杂,形式,发明,大规模,"
					+ "极大,位置处,上面,倍水,工艺,成本,完成,工作,直接,用户,生成,小时,方向,适合,作用,体上,连续,上端,合成,三个,经由,完全,备用,限定,动作,作用下,直至,用来,基本,份数,成品,适应,工业化,"
					+ "活动,用作,全靠,投入,另侧,合并,接近,选用,支持,程度,适用,特定,独立地,否则,关系,定义,指定,每次,优化,重新,来控制,构建,附近,代替,传递,更新,突出,通入,改性,二步,损坏,已经,下面,"
					+ "不含,长期,顺序,触发,送至,远离,判定,地面,线上,不受,加载,两根,机上,代表,接受,计成,通常,逐渐,热好,手动,总成,引出,多根,剩余,位上,专用,不存,扩大,十分,头上,借助,体化,两块,两边,较小,"
					+ "本观,请求保护,相连,应用,相连接,右左,造成,实用,四方,预定,美观,多功,取代,经济,上装,并由,数个,起来,优良,任选,特性,专用,单独,较小,业务,分成,大致,只需,时也,地说,缺点,替代,并用,二个,"
					+ "单个,前述,特殊,观察,两组,力强,离开,十分,大型,发电,头上,放大,成体,两块,反复,且无,两条,两边,省时,彻底,持续,破坏,不用,露出,加强,不需,发挥,扩大,道上,揭示,多次,时候,动地,量大,上上,展开,"
					+ "均布,更多,检测出,更多,随时,理想,次数,连接前,连接,操作,内部,两侧,若不,还下,若不,无须,更改,四条,接个,两道,也就,过来,并获,购买,使内,抖动,提交,信息二,不好,注意,很小,尽量,广告,留下,强大,"
					+ "推荐,内至,右方,内含,低下,备不,更安全,往上,课题,不动,也对,不计,适时,三条,不下,处理过,每对,不断地,前景广阔,两支,大方,端右,转至,四种,口感好,变大,根本上,必要,应对,并作,先进,不二,明确,并置,"
					+ "处理时,截止,处理好,小化,互不,分析处理,备备,量少,往下,更长,来检测,出去,经常,充足,对人,装上,塞上,经二,器三,几乎,无论,取消,旁边,很强,不必,不必要,真正,使水,盒上,推出,况下,送出,求出,两对,常用,"
					+ "不相,并经,下次,大批量,传至,越大,过多,均无,二二,去掉,负责,不利,就会,某个,某些,管管,力大,施用,加大,麻烦,寻找,示例,不低,加上,并处理,先用,来说,每天,点上,提前,专门,改良,并不,不对,也不,几个,小二,"
					+ "并记录,两侧面,随意,更小,公共,两片,出过,只要,投资,由不,环境友好,说明,上不,不等,较长,权利,出时,右边,更强,耐用,更低,两两,大二,必须,转发,五个,水管上,创造,已知,家用,原来,临时,整齐,国内,真实,杜绝,"
					+ "自己,这个,用电,较少,至上,下来,落入,不小,上至,床上,面对,本专利,多余,不良,现存,每条,甚至,表现,三者,重要,降至,操作时,研究,困难,少量,相较,决定,不便,不大,很大,更大,洗净,均由,备上,长时间,且不,准备,动下,对不"
					+ "加快,发现,路上,不断,适宜,并向,正对,前提下,占用,行走,上过,二者,系列,浪费,难度,断开,测定,相匹配,位置,控制,对称,接收,两端,检测,转动,旋转,下端,色彩,驱动,温度,延伸,支撑,插入,制作,放置,平面,垂直,连通,配置,材料,内侧,"
					+ "质量,时间,反应,部件,空间,侧面,分离,平行于,平行,带动,部位,传动,发送,伸出,强度,干燥,过滤,运动,寿命,紧凑,成型,携带,厚度,直径,分钟,延长,排列,体积小,装配,组装,内装,容纳,间隙,独立,周围,间隔,精度,开启,灵活,室内,提取,成分,"
					+ "宽度,传送,组分,环保,图案,缩短,体积,倾斜,维修,横向,回收,顶端,升降,纵向,环境,含量,工序,维护,浓度,速度,切换,省力,复合,新颖,端面,围绕,吸收,作业,参数,片上,套装,缺陷,背面,测试,前部,施工,末端,相反,嵌入,紧密,指示,辅助,盖上,通式,"
					+ "价值,分配,供电,释放,推动,送入,普通,盘上,伸入,端上,分开,速度快,牢固,箱内,导向,类型,物料,维持,上盖,资源,自由,分析,周边,安置,平台,四周,次性,请求,舒适,注入,仰俯,口上,互相,规定,顶面,台上,家庭,右侧,结束,向内,转化,器件,下降,填充,"
					+ "无毒,接通,无边界,流程,吸附,卫生,隔开,患者,存放,本身,配方,两层,接地,运转,导入,前方,粘接,受力,二端,主动,面向,实时,产物,单位,工业,下式,俯仰,类似,费用,包围,原理,病人,缓冲,套上,尾部,对准,上时,适量,定量,定时,消耗,物品,通用,集成,邻近,贴合,"
					+ "综合,组份,进口,用水,粘贴,暴露,始终,防水,小型,大幅度,上电,双向,下侧,平均,扩展,现场,许多,毫米,上套,上带,收容,滚动,排放,清除,上升,下层,上进,透过,简易,涂覆,缩小,置入,多条,翻转,交替,区域内,多用,承受,便携式,生长,采取,附加,预处理,做成,压下,"
					+ "紧贴,藉由,无污染,边上,社会,用量,车上,带上,二级,反向,接起,子上,内上,确认,制品,吸入,流过,写入,上侧,并列,样品,加水,双层,供应,选定,前侧,围成,作成,正确,面内,便携带,不时,组合式,并排,盒内,粘合,个碳原子,每组,不变,相啮合,培养,低廉,向前,周向,由内,"
					+ "适配,数目,完毕,收缩,工人,操纵,合适,机内,安放,限度,开闭,补充,科学,左端,省去,访问,平整,内端,两面,价格低廉,大幅,器用,开发,难题,呈现,板下,配备,时间内,控制控制,读出,并接,延长寿命,参考,保障,依靠,邻接,行业,顺利,修改,固连,质量好,对象,部部,度时,喷出,"
					+ "部份,易行,服用,人力,清理,里面,共用,运用,地方,右端,挤出,过渡,状况,往复,重合,三层,量小,分离出,变成,上显示,炉内,端侧,考虑,取下,二侧,机时,划分,多级,上个,轻便,平台上,二层,加快,通知,多组,几种,进出,成功,前进,两用,区内,前景,较强,对不,加装,替换,搬运,二组,"
					+ "两次,来源,修正,依序,二种,巧妙,创建,配成,改造,上板,时地,轻松,套入,松开,大约,层内,小型化,吻合,赋予,还对,帮助,端处,全面,这里,厘米,拉出,点处,身上,并行,取样,个数,上用,不致,生活,期望,下上,小区,痛苦,预测,两只,三步,充满,空间小,定时间,查找,成对,发起,选出,区分,"
					+ "积极,相似,开放,作出,促使,作动,段上,六个,安排,引发,较佳,孔处,发展,三次,价格,四根,过大,意义,每层,张开,超出,两套,小车,借由,二三,罩上,较短,两级,工况,使光,耐久性,广大,上前,对位,严重,两头,也使,内内,件件,上行,逐步,推拉,层位,来回,取决,轻巧,地上,相加,套套,目地,"
					+ "实行,修饰,优质,又不,用不,三级,又使,脱开,地区,左边,人群,转化成,两排,减去,背景,传播,层厚度,路面,持久,单层,多数,诸多,时时,资料,但不,省工,垫上,用时,这类,做出,禁止,等等,劳动,平坦,长短,过量,试样,顺次,拔出,无害,切成,四步,小巧,下两,日常,不少,公知,个人,娱乐,工位,巨大,前向,经久,"
					+ "制法,送来,充入,这时,事先,很多,盛放,通用性,制备,推力,上转,移至,区别,还用,暂时,加长,过度,连起,升至,变小,细小,扩增,伴随,也作,现代,等大,散发,每隔,器处,仅仅,性时,齐全,正反,更佳,大体,开出,用品,略大,来驱动,量下,强度大,也用,手上,面无,管过,压迫,还作,测出,化成,刷头,屏幕上,正好,个体,"
					+ "多点,上三,卸下,内导,联系,大直径,那样,本体部,多台,优先,上都,建议,量控制,机控制,初步,较差,还带,占地,并发,吸取,移出,工厂,上作,上地,使者,对称地,都由,身体健康,纸上,使人,交替地,墙上,大容量,我国,必需,上发,落下,芯片上,下发,并成,专利,省电,极好,取用,二部,屏上,地二,达成,不使,排列成,找出,"
					+ "极佳,并绕,面积小,成二,远距离,距离,减低,分出,掺入,上计,全方位,内定,新式,上分,风味,较宽,简捷,共聚,预期,短时间内,二分,缩回,送二,规模,全新,现行,首次,过去,抬起,四边,上限,下落,人性化,优越性,介绍,上间,强烈,某种,很低,基基,块内,下半,不不,脚上,略小,综合性,下步,制定,价格低,公用,分选,丢弃,上多,二块,"
					+ "寿命延长,上成,习惯,跨越,价廉,连成,供者,上无,不管,自由地,向左,口时,突然,老年人,制功,报告,更具,三分,矿用,减弱,等不,拉开,且时,心上,摇动,品上,座下,大时,结束时,体积大,多段,深入,结成,特异,八个,别出,平齐,时段,状体,极低,确切,规模化,器地,隐患,时会,二位,市场前景,自带,不适,走向,清楚,候选,安全地,定下,"
					+ "生地,这对,两倍,众多,温差,突然,时会,多样化,进退,观赏,玩耍,不均,人力物力,向右,没药,分钟内,处理,顶部,输出,单元,保护,底座,定位,加热,体内,输入,前端,图片,布置,滑动,侧壁,端部,测量,轴向,区域,安全性,孔内,组合,竖直,尺寸,主体,边缘,循环,覆盖,污染,面料,限位,腔内,左侧,相通,装饰,转换,工件,造型,增大,内腔,"
					+ "识别,并联,匹配,串联,立柱,管内,径向,锁紧,夹紧,出版,公报,夹持,压紧,升温,响应,入口,夹角,体现,面积,进料口,承载,包覆,啮合,直线,板侧,体侧,间距,口处,记录,相等,贯通,侧边,隔离,正面,内置,读取,头部,挤压,降温,便捷,接入,包裹,物质,人体,布料,缠绕,进水口,竖向,室温,负载,联接,分散,计计,平稳,试验,插接,引导,端接,"
					+ "拆装,表达,进水,摆动,侧部,程序,杆端,截面,支座,轮上,闭合,建筑,器器,收纳,排布,体系,对接,体部,冲击,接合,干净,箱体内,顶板,端盖,基础,局部,采样,称取,检查,口内,待测,转向,开口处,上孔,套内,拉伸,体端,每一,第二,第三,第一方向,相交,位于,开口,交叉,颜色,底上,本体,限制,对向,二子,狭缝,侧板,多层,主面,开口部,取向,"
					+ "流动,蓝色,绿色,揭露,显示品质,空隙,物体,变更,断裂,长边,实质上,两行,配向,相向,个子,侧向,损失,两列,治具,场景,黑色,双面,零件,层间,息来,短边,缩减,装载,关联,三种,并显示,形变,劣化,化层,流入,每行,恢复,整合,错开,iii,损害,原始,填入,多行,子元,本文,多列,张力,指向,极不,部侧,附接,顶层,埋入,照片,开口,通孔,内壁,"
					+ "槽内,角度,输送,出口,底面,底端,限制,变形,伸缩,边界,杂质,内容,余量,市场,恢复,流出,缺口,流入,完整,预防,损失,损失,切断,筛选,交错,进气,";

			String[] arr = str.split(",");
			for (int i = 0; i < arr.length; i++) {
				semanticexp = semanticexp.replace(arr[i], " ");
			}
			semanticexp = semanticexp.replaceAll("[ ]+", " ");
			semanticexp = semanticexp.trim();

			// System.out.println(semanticexp);

			Set<String> set = new HashSet<String>();
			String[] _arr = semanticexp.split(" ");
			for (int i = 0; i < _arr.length; i++) {
				// if(_arr[i].length()>1)
				{
					set.add(_arr[i]);
				}
			}
			semanticexp = "";

			for (String cd : set) {
				semanticexp += " " + cd;
			}
			semanticexp = semanticexp.trim();
		}

		return semanticexp;
	}

	public HashMap<String, Object> getPatentInfos(ActionContext cxt) throws Exception {
//		ActionContext cxt = ActionContext.getContext();
		HashMap<String, Object> hm_result = new HashMap<String, Object>();

		Map<String, Object> application = cxt.getApplication();

		String strWhere = "";
		String strWhere_ori = "";
		String strSources = "";
		String strSourceNames = "";

//		Map<String,String> lastestFlztInfo = new HashMap<String,String>();

		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();

		OverviewSearchResponse overviewResponse = null;

		String language = request.getParameter("language") == null ? "CN"
				: request.getParameter("language").toUpperCase();
//		language = "FR";
		
		String nodeId = request.getParameter("nodeId") == null ? "0" : request.getParameter("nodeId");
		String treeType = request.getParameter("treeType") == null ? "-1" : request.getParameter("treeType");

		// System.out.println("-----------treeType="+treeType);

		String xAxis = request.getParameter("xAxis") == null ? "" : request.getParameter("xAxis");
		String yAxis = request.getParameter("yAxis") == null ? "" : request.getParameter("yAxis");

		String _xAxisSize = request.getParameter("xAxisSize") == null ? "10" : request.getParameter("xAxisSize");
		int xAxisSize = 10;
		if (DecimalFormatUtil.isInteger(_xAxisSize)) {
			xAxisSize = Integer.parseInt(_xAxisSize);
		}

		String _yAxisSize = request.getParameter("yAxisSize") == null ? "10" : request.getParameter("yAxisSize");
		int yAxisSize = 10;
		if (DecimalFormatUtil.isInteger(_yAxisSize)) {
			yAxisSize = Integer.parseInt(_yAxisSize);
		}

		String wap = request.getParameter("wap") == null ? "" : request.getParameter("wap");
		/*
		 * iSearchType 0:只有aggs，概览左侧或纯分析; 1:除了aggs，还有hits，概览字段overview
		 * 2:没有aggs，只有hits，细览字段detail
		 */
		int iSearchType = 0;
		String searchType = request.getParameter("searchType");
		if (searchType == null || searchType.equals("")) {
			iSearchType = 0;
		} else {
			if (searchType.matches("^[0-9]+$")) {
				iSearchType = Integer.parseInt(searchType);
			} else {
				iSearchType = 0;
			}
		}
		// System.out.println("iSearchType="+iSearchType);
		// String
		// secondsearchexp=request.getParameter("secondsearchexp")==null?"":request.getParameter("secondsearchexp").toUpperCase();

		strWhere = request.getParameter("strWhere") == null ? "" : request.getParameter("strWhere");
		if (wap.equals("1")) {
			if (strWhere.indexOf("=") < 0) {
				strWhere = "主权项语义,摘要语义+='" + URLDecoder.decode(strWhere, "UTF-8") + "'";
			} else {
				strWhere = URLDecoder.decode(strWhere, "UTF-8");
			}
		}

		strWhere_ori = strWhere;
		strSources = request.getParameter("strSources") == null ? "" : request.getParameter("strSources");

		String strSortMethod = request.getParameter("strSortMethod");
		if (strSortMethod == null || strSortMethod.equals("") || strSortMethod.equals("+RELEVANCE")
				|| strSortMethod.equals("-RELEVANCE"))
			strSortMethod = "RELEVANCE";

		/*
		 * String[] arrSecondsearchexp=null;
		 * if(secondsearchexp!=null&&!secondsearchexp.trim().equals("")&&!
		 * secondsearchexp.toUpperCase().equals("UNDEFINED")){ //
		 * System.out.println(secondsearchexp); secondsearchexp =
		 * secondsearchexp.replaceAll("%(?![0-9a-fA-F]{2})", "%25"); secondsearchexp =
		 * URLDecoder.decode(secondsearchexp, "UTF-8"); arrSecondsearchexp =
		 * secondsearchexp.split(";"); }
		 */

		// String s_semantic = "0";
		/*
		 * String semanticexp = request.getParameter("semanticexp");
		 * if(semanticexp!=null&&!semanticexp.equals("")) { selectexp =
		 * "主权项语义,摘要语义+='"+filterSemanticExp(semanticexp)+"'"; s_semantic = "1"; }
		 */

		if (Integer.parseInt(treeType) >= 0 && !nodeId.equals("")) {
			NodeModel node = nodeFunc.getNodeInfoByID(treeType, nodeId);
			if (language.equalsIgnoreCase("CN") || language.equalsIgnoreCase("SX")) {
				strWhere = node.getCnTrsExp();
				strSources = node.getCnTrsTable();
			} else {
				strWhere = node.getEnTrsExp();
				strSources = node.getEnTrsTable();
			}
		}

		String logicexpid = request.getParameter("logicexpid") == null ? ""
				: request.getParameter("logicexpid").toUpperCase();
		if (logicexpid != null && !logicexpid.equals("")) {
			ExpressionInfo ei = expFunc.getExpbyID(Integer.parseInt(logicexpid));
			// System.out.println(ei.getExpression());
			// System.out.println(ei.getSources());
			// session.setAttribute("strWhere", ei.getExpression());
			// session.setAttribute("strSources", ei.getSources());
			strWhere = ei.getExpression();
			strSources = ei.getSources();

			strWhere_ori = strWhere;
		}
		///////////////////////////////////////////////////////////////////////////////////////////
		strWhere = strWhere.replace("快速检索=", "申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=");
		strWhere = strWhere.replace("语义检索=", "主权项语义,摘要语义+=");

		String prefix_semantic = "主权项语义,摘要语义+=";
		if (strWhere.indexOf(prefix_semantic) > -1) {
			// s_semantic = "1";
			/*
			 * Pattern pattern = Pattern.compile("([A-Z]){0,2}[0-9]+.([A-Z]|[0-9])");
			 * Matcher matcher = pattern.matcher(strWhere); while (matcher.find()) { findStr
			 * = matcher.group(); }
			 */
			// pattern = Pattern.compile("(file=\"[^\u4e00-\u9fa5]+?(." + strGif_Tif +
			// ")\")+");
			List<String> strList = new ArrayList<String>();
			// Pattern pattern = Pattern.compile("(主权项语义,摘要语义+='[\\u0391-\\uFFE5]+')");
			Pattern pattern = Pattern.compile("'([^']*')");
			Matcher matcher = pattern.matcher(strWhere);
			int end = 0;
			// ^[a-zA-Z]*$ 这个正则是以字母开头
			while (matcher.find()) {
				// System.out.println(matcher.group());
				// System.out.println(strWhere.indexOf(prefix_semantic+matcher.group()));

				if (strWhere.indexOf(prefix_semantic + matcher.group()) > -1) {
					String result = prefix_semantic + matcher.group();
					strList.add(strWhere.substring(end, matcher.start() - prefix_semantic.length()));
					strList.add(result);
					end = matcher.end();
				}
				// System.out.println(result);
				// strList.add(strWhere.substring(end, matcher.start()));
			}
			String old = strWhere;
			strWhere = "";
			for (int i = 0; i < strList.size(); i++) {
				String str = (String) strList.get(i);
				if (str.indexOf(prefix_semantic) > -1 && str.indexOf("主权项语义,摘要语义+='申请号公开号=") == -1) {
					str = prefix_semantic + "'" + filterSemanticExp(str) + "'";
				}
				strWhere += str + " ";
			}
			strWhere = strWhere + old.substring(end);
			strWhere = strWhere.trim();
			// System.out.println(strWhere);
		}
		///////////////////////////////////////////////////////////////////////////////////////////

		/*
		 * if(secondsearchexp!=null&&!secondsearchexp.trim().equals("")&&!
		 * secondsearchexp.toUpperCase().equals("UNDEFINED")){ // selectexp =
		 * "("+selectexp+")" + secondsearchexp; for(int
		 * i=0;i<arrSecondsearchexp.length;i++){ // selectexp = "("+selectexp+")" +
		 * " and " + arrSecondsearchexp[i]; selectexp = "("+selectexp+")" + " " +
		 * arrSecondsearchexp[i]; } } selectexp=selectexp.trim();
		 */

		// String selectexp =
		// request.getParameter("selectexp")==null?"":request.getParameter("selectexp");
		// String selectdbs =
		// request.getParameter("selectdbs")==null?"":request.getParameter("selectdbs");
		// alert($('#area').val());
		// alert($('#selectexp').val());
		// alert($('#selectdbs').val());
		String filterexp = request.getParameter("filterexp") == null ? "" : request.getParameter("filterexp");
		if (filterexp != null && !filterexp.trim().equals("") && !filterexp.toUpperCase().equals("UNDEFINED")) {
			String[] arrfilterexp = null;
			arrfilterexp = filterexp.split(";");
			for (int i = 0; i < arrfilterexp.length; i++) {
				strWhere = "(" + strWhere + ")" + " " + arrfilterexp[i];
			}
		}
		strWhere = strWhere.trim();
		//////////////////////////////////////////////////////////////////

		// String filterChannel =
		// request.getParameter("filterChannel")==null?"":request.getParameter("filterChannel");

		int currentPage = request.getParameter("currentPage") == null ? 0
				: Integer.parseInt(request.getParameter("currentPage"));

		int pagerecord = (request.getParameter("pagerecord") == null || request.getParameter("pagerecord").equals(""))
				? 0
				: Integer.parseInt(request.getParameter("pagerecord"));
		// System.out.println("pagerecord= " + pagerecord);
		pagerecord = pagerecord == 0 ? Constant.PAGERECORD : pagerecord;
		
		// String strSources = "";
		// String strWhere = "";
		// String dbs = "";

		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>) application.get("channelInfoList_fr");
		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>) application.get("channelInfoList_cn");
		List<ChannelInfo> channelInfoList_sx = (List<ChannelInfo>) application.get("channelInfoList_sx");

		List<ChannelInfo> channelInfoList = null;
		if ("CN".equalsIgnoreCase(language)) {
			// strWhere = node.getCnTrsExp();
			// dbs = node.getCnTrsTable();
			strSources = Util.getPatentTable(application, strSources);
			channelInfoList = channelInfoList_cn;
		} else if ("SX".equalsIgnoreCase(language)) {
			// strWhere = node.getCnTrsExp();
			// dbs = node.getCnTrsTable();
			strSources = Util.getPatentTable(application, strSources);
			channelInfoList = channelInfoList_sx;
		} else if ("FR".equalsIgnoreCase(language) || "EN".equalsIgnoreCase(language)) {
			// strWhere = node.getEnTrsExp();
			// dbs = node.getEnTrsTable();
			strSources = Util.getPatentTable(application, strSources);
			String strSources_ori = strSources;
			String[] arr = strSources.split(",");
			strSources = "";
			List<String> list = new ArrayList<String>();

			for (int i = 0; i < arr.length; i++) {
				/*
				 * if(arr[i].endsWith("patent")&& !arr[i].equals("uspatent")&&
				 * !arr[i].equals("jppatent")&& !arr[i].equals("gbpatent")&&
				 * !arr[i].equals("depatent")&& !arr[i].equals("frpatent")&&
				 * !arr[i].equals("eppatent")&& !arr[i].equals("wopatent")&&
				 * !arr[i].equals("chpatent")&& !arr[i].equals("twpatent")&&
				 * !arr[i].equals("hkpatent")&& !arr[i].equals("krpatent")&&
				 * !arr[i].equals("rupatent")&& !arr[i].equals("aspatent")&&
				 * !arr[i].equals("gcpatent")&& !arr[i].equals("appatent")&&
				 * !arr[i].equals("aupatent")&& !arr[i].equals("capatent")&&
				 * !arr[i].equals("espatent")&& !arr[i].equals("atpatent")&&
				 * !arr[i].equals("itpatent")&& !arr[i].equals("sepatent")) {
				 * 
				 * // if(!strSources.equals("")) // { // strSources += ","; // } // strSources
				 * += "otherpatent";
				 * 
				 * if(!list.contains("otherpatent")) { list.add("otherpatent"); } }else { //
				 * if(!strSources.equals("")) // { // strSources += ","; // } // strSources +=
				 * arr[i]; if(!list.contains(arr[i])) { list.add(arr[i]); } }
				 */
				if (!list.contains(arr[i])) {
					list.add(arr[i]);
				}
			}
			for (String attribute : list) {
				// System.out.println(attribute);
				if (!strSources.equals("")) {
					strSources += ",";
				}
				strSources += attribute;
			}
			// System.out.println(strSources);
			strSourceNames = Util.getPatentTableName(application, strSources_ori);
			if (strSources_ori.indexOf("otherpatent") > -1) {
				strSourceNames += ",其他国家及地区";
			}
			// System.out.println(strSourceNames);

			String nationWhere = "";
			String[] arrNation = strSourceNames.split(",");
			for (int i = 0; i < arrNation.length; i++) {
				nationWhere += "PATTYPE=" + arrNation[i].replace("非洲组织", "非洲知识产权组织") + " or ";
			}
			if (nationWhere.trim().endsWith(" or")) {
				nationWhere = nationWhere.substring(0, nationWhere.length() - 4);
			}
			nationWhere = "(" + nationWhere + ")";


			if(!strWhere.startsWith("号码批量检索=")) {
				strWhere = nationWhere + " and (" + strWhere + ")";
			}
			
			//strSources =
			//"uspatent,jppatent,gbpatent,depatent,frpatent,eppatent,wopatent,chpatent,hkpatent,twpatent,krpatent,supatent,rupatent,aspatent,gcpatent";
			channelInfoList = channelInfoList_fr;
		}

		{
			strWhere = strWhere.replace("&middot;", "·");
			strWhere = strWhere.replace("&ldquo;", "“");
			strWhere = strWhere.replace("&rdquo;", "”");
			strWhere = strWhere.replace("&ndash;", "–");
			strWhere = strWhere.replace("&sdot;", "⋅");
			strWhere = strWhere.replace("&ndash;", "–");
			strWhere = strWhere.replace("&mdash;", "—");
			strWhere = strWhere.replace("&lsquo;", "‘");
			strWhere = strWhere.replace("&rsquo;", "’");
			strWhere = strWhere.replace("&sbquo;", "‚");
			strWhere = strWhere.replace("&bull;", "•");
			strWhere = strWhere.replace("&prime;", "′");
		}
		
/*		if (strWhere.indexOf("=") < 0) {
//			strWhere = "主权项语义,摘要语义+='" + URLDecoder.decode(strWhere, "UTF-8") + "'";
//			申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=
			strWhere = "主权项语义,摘要语义+=(" + strWhere + ")";
		}
*/
		String cnfr = request.getParameter("cnfr");
		if (cnfr != null && cnfr.equals("0")) {
			strWhere = "申请区域=中国 and " + "(" + strWhere + ")";
		}
		if (cnfr != null && cnfr.equals("1")) {
			strWhere = "(" + strWhere + ")" + " not 申请区域=中国";
		}
		
		
//		strWhere = "CN1240206A CN1240144A CN1240143A CN1240326A CN1240262A CN1240200A CN1240282A CN1240195A CN1240180A CN1240226A CN1240507A CN1240408A CN1240392A CN1240502A CN1240175A CN1240504A CN1240306A CN1240525A CN1240294A CN1240543A CN1240173A CN1240319A CN1240453A CN1240202A CN1240510A CN1240355A CN1240547A CN1240403A CN1240516A CN1240118A CN1240555A CN1240560A CN1240321A CN1240169A CN1240232A CN1240231A CN1240139A CN1240263A CN1240117A CN1240217A CN1240121A CN1240150A CN1240129A CN1240540A CN1240140A CN1240214A CN1240187A CN1240116A CN1240283A CN1240285A CN1240151A CN1240193A CN1240109A CN1240312A CN1240136A CN1240245A CN1240255A CN1240230A CN1240148A CN1240142A CN1240141A CN1240198A CN1240253A CN1240137A CN1240291A CN1240114A CN1240251A CN1240309A CN1240113A CN1240153A CN1240266A CN1240146A CN1240236A CN1240271A CN1240197A CN1240220A CN1240111A CN1240149A CN1240147A CN1240104A CN1240215A CN1240269A CN1240194A CN1240106A CN1240320A CN1240138A CN1240154A CN1240115A CN1240250A CN1240189A CN1240120A CN1240238A CN1240218A CN1240225A CN1240224A CN1240127A CN1240247A CN1240158A CN1240228A CN1240145A CN1240162A CN1240165A CN1240119A CN1240235A CN1240221A CN1240261A CN1240174A CN1240257A CN1240159A CN1240229A CN1240276A CN1240163A CN1240203A CN1240278A CN1240404A CN1240562A CN1240259A CN1240436A CN1240204A CN1240522A CN1240532A CN1240391A CN1240336A CN1240131A CN1240359A CN1240178A CN1240304A CN1240501A CN1240344A CN1240534A CN1240243A CN1240521A CN1240460A CN1240369A CN1240556A CN1240548A CN1240472A CN1240126A CN1240171A CN1240237A CN1240274A CN1240400A CN1240478A CN1240364A CN1240533A CN1240475A CN1240346A CN1240395A CN1240394A CN1240333A CN1240464A CN1240479A CN1240107A CN1240384A CN1240288A CN1240241A CN1240296A CN1240275A CN1240456A CN1240546A CN1240411A CN1240473A CN1240183A CN1240196A CN1240497A CN1240324A CN1240499A CN1240343A CN1240292A CN1240410A CN1240176A CN1240380A CN1240385A CN1240401A CN1240489A CN1240330A CN1240311A CN1240519A CN1240172A CN1240351A CN1240535A CN1240365A CN1240559A CN1240458A CN1240483A CN1240356A CN1240552A CN1240471A CN1240415A CN1240267A CN1240112A CN1240495A CN1240323A CN1240461A CN1240399A CN1240566A CN1240260A CN1240486A CN1240466A CN1240520A CN1240342A CN1240538A CN1240388A CN1240524A CN1240368A CN1240186A CN1240544A CN1240273A CN1240469A CN1240328A CN1240284A CN1240303A CN1240539A CN1240122A CN1240293A CN1240130A CN1240166A CN1240315A CN1240563A CN1240505A CN1240487A CN1240490A CN1240295A CN1240209A CN1240317A CN1240418A CN1240542A CN1240454A CN1240551A CN1240412A CN1240545A CN1240373A CN1240252A CN1240279A CN1240300A CN1240439A CN1240568A CN1240340A CN1240529A CN1240382A CN1240402A CN1240244A CN1240350A CN1240353A CN1240338A CN1240281A CN1240268A CN1240537A CN1240416A CN1240561A CN1240302A CN1240476A CN1240170A CN1240357A CN1240567A CN1240445A CN1240409A CN1240480A CN1240468A CN1240383A CN1240358A CN1240506A CN1240184A CN1240376A CN1240242A CN1240366A CN1240527A CN1240514A CN1240370A CN1240407A CN1240372A CN1240272A CN1240280A CN1240425A CN1240181A CN1240128A CN1240477A CN1240205A CN1240452A CN1240191A CN1240474A CN1240512A CN1240347A CN1240554A CN1240239A CN1240500A CN1240515A CN1240488A CN1240484A CN1240234A CN1240526A CN1240536A CN1240482A CN1240463A CN1240557A CN1240125A CN1240396A CN1240222A CN1240310A CN1240156A CN1240564A CN1240332A CN1240322A CN1240508A CN1240190A CN1240264A CN1240481A CN1240349A CN1240345A CN1240523A CN1240393A CN1240465A CN1240503A CN1240541A CN1240362A CN1240528A CN1240316A CN1240246A CN1240450A CN1240449A CN1240290A CN1240289A CN1240363A CN1240256A CN1240301A CN1240467A CN1240513A CN1240493A CN1240335A CN1240558A CN1240374A CN1240553A CN1240494A CN1240337A CN1240405A CN1240223A CN1240389A CN1240413A CN1240417A CN1240518A CN1240531A CN1240398A CN1240167A CN1240210A CN1240378A CN1240188A CN1240185A CN1240182A CN1240124A CN1240132A CN1240509A CN1240208A CN1240135A CN1240207A CN1240179A CN1240249A CN1240258A CN1240233A CN1240277A CN1240164A CN1240157A CN1240152A CN1240227A CN1240213A CN1240199A CN1240270A CN1240161A CN1240160A CN1240155A CN1240105A CN1240390A CN1240511A CN1240334A CN1240361A CN1240381A CN1240305A CN1240492A CN1240498A CN1240491A CN1240297A CN1240329A CN1240379A CN1240327A CN1240549A CN1240462A CN1240352A CN1240406A CN1240339A CN1240371A CN1240414A CN1240308A CN1240517A CN1240123A CN1240387A CN1240168A CN1240377A CN1240496A CN1240367A CN1240341A CN1240134A CN1240133A CN1240110A CN1240177A CN1240314A CN1240313A CN1240286A CN1240565A CN1240287A CN1240212A CN1240254A CN1240331A CN1240265A CN1240299A CN1240470A CN1240325A CN1240550A CN1240375A CN1240360A CN1240397A CN1240307A CN1240386A CN1240298A CN1240585A CN1240861A CN1240932A CN1240601A CN1241108A CN1240688A CN1240595A CN1241055A CN1240672A CN1241040A CN1240573A CN1240970A CN1240764A CN1240762A CN1240759A CN1240758A CN1240790A CN1240711A CN1240589A CN1241051A CN1240896A CN1240715A CN1241081A CN1240780A CN1240862A CN1240832A CN1240690A CN1240646A CN1240778A CN1240858A CN1240836A CN1240708A CN1240701A CN1240777A CN1240767A CN1240640A CN1240809A CN1240961A CN1240921A CN1240577A CN1240870A CN1240886A CN1240882A CN1240572A CN1240705A CN1240599A CN1240648A CN1241088A CN1240732A CN1240927A CN1240695A CN1240770A CN1240769A CN1240781A CN1240574A CN1241041A CN1240859A CN1240604A CN1240967A CN1240916A CN1240875A CN1241019A CN1240776A CN1240606A CN1240901A CN1240960A CN1240578A CN1240871A CN1241033A CN1240631A CN1240730A CN1240590A CN1240786A CN1240614A CN1240773A CN1240612A CN1240981A CN1240681A CN1240725A CN1240580A CN1240675A CN1240709A CN1240783A CN1240811A CN1240954A CN1240596A CN1240683A CN1240593A CN1241068A CN1240576A CN1240700A CN1240630A CN1240649A CN1240625A CN1240791A CN1240808A CN1240731A CN1241006A CN1240895A CN1240825A CN1240779A CN1240634A CN1240579A CN1240878A CN1240666A CN1240840A CN1240912A CN1240611A CN1240968A CN1240819A CN1240818A CN1240668A CN1240812A CN1240644A CN1240955A CN1241058A CN1240844A CN1240642A CN1240918A CN1240745A CN1240864A CN1240583A CN1240657A CN1240957A CN1240617A CN1240904A CN1240977A CN1240814A CN1240664A CN1240857A CN1240975A CN1240823A CN1240753A CN1240784A CN1240643A CN1240721A CN1240608A CN1240582A CN1240976A CN1240651A CN1240892A CN1241007A CN1240591A CN1240616A CN1240898A CN1241053A CN1240903A CN1240699A CN1240799A CN1240797A CN1240724A CN1241105A CN1240605A CN1241011A CN1240793A CN1240748A CN1240747A CN1240807A CN1240804A CN1240881A CN1241061A CN1240670A CN1240761A CN1240789A CN1240615A CN1240900A CN1240813A CN1240902A CN1240742A CN1240626A CN1240613A CN1240714A CN1240863A CN1240680A CN1240586A CN1240658A CN1240588A CN1240757A CN1240830A CN1240815A CN1240820A CN1240949A CN1240874A CN1241094A CN1240594A CN1240684A CN1240917A CN1240575A CN1240751A CN1240884A CN1240570A CN1240963A CN1240816A CN1240623A CN1240662A CN1240569A CN1240729A CN1240733A CN1240905A CN1240706A CN1240827A CN1240990A CN1240879A CN1240833A CN1240933A CN1240911A CN1241109A CN1240587A CN1241299A CN1241222A CN1240687A CN1240766A CN1240607A CN1240959A CN1240880A CN1240792A CN1240584A CN1241059A CN1240868A CN1240971A CN1240650A CN1240663A CN1240774A CN1240653A CN1240940A CN1240826A CN1240676A CN1240667A CN1240702A CN1240609A CN1240620A CN1240931A CN1240873A CN1241328A CN1240692A CN1240888A CN1241099A CN1240669A CN1240865A CN1240655A CN1241008A CN1240928A CN1240694A CN1240693A CN1240775A CN1240652A CN1240760A CN1240969A CN1240678A CN1241152A CN1241160A CN1240950A CN1241024A CN1241353A CN1240685A CN1241243A CN1241197A CN1240958A CN1241122A CN1241337A CN1241172A CN1241311A CN1241101A CN1241098A CN1241001A CN1241066A CN1241003A CN1241054A CN1240850A CN1240785A CN1240980A CN1240682A CN1240972A CN1241219A CN1241215A CN1241149A CN1241303A CN1241301A CN1240720A CN1240943A CN1240994A CN1240851A CN1241162A CN1241062A CN1241235A CN1241228A CN1241238A CN1241321A CN1241352A CN1241240A CN1241217A CN1240924A CN1241244A CN1241242A CN1240919A CN1241118A CN1241280A CN1241113A CN1241275A CN1240883A CN1241017A CN1241225A CN1241237A CN1241346A CN1240841A CN1241038A CN1240992A CN1240696A CN1241261A CN1241257A CN1240848A CN1240894A CN1240893A CN1241262A CN1241224A CN1241302A CN1241131A CN1240947A CN1240991A CN1240995A CN1241014A CN1241298A CN1241009A CN1240755A CN1241194A CN1241294A CN1241293A CN1240821A CN1241267A CN1241279A CN1241270A CN1241125A CN1241339A CN1241129A CN1241136A CN1241350A CN1241347A CN1241319A CN1241064A CN1241078A CN1240622A CN1241231A CN1241036A CN1240937A CN1241150A CN1240853A CN1241084A CN1241220A CN1241164A CN1240738A CN1241070A CN1241093A CN1241110A CN1241026A CN1241250A CN1241324A CN1240686A CN1241290A CN1241292A CN1241195A CN1241202A CN1241305A CN1241111A CN1241274A CN1241340A CN1241179A CN1241139A CN1241170A CN1241173A CN1241320A CN1241005A CN1240698A CN1240849A CN1240741A CN1241221A CN1241168A CN1241133A CN1241130A CN1240665A CN1240834A CN1240929A CN1241075A CN1241074A CN1240752A CN1241104A CN1240710A CN1240674A CN1240964A CN1240796A CN1241165A CN1241214A CN1241327A CN1241326A CN1241253A CN1241092A CN1240637A CN1241047A CN1241205A CN1241193A CN1240805A CN1241334A CN1241332A CN1241281A CN1241331A CN1241278A CN1241120A CN1241119A CN1241128A CN1241213A CN1241132A CN1241016A CN1241157A CN1241155A CN1241313A CN1241348A CN1240889A CN1241004A CN1241002A CN1240982A CN1240891A CN1241049A CN1240716A CN1240726A CN1240855A CN1241264A CN1240985A CN1241210A CN1241209A CN1240737A CN1241097A CN1240829A CN1241151A CN1240910A CN1240908A CN1240966A CN1241233A CN1241010A CN1241248A CN1241322A CN1241090A CN1240952A CN1241218A CN1241142A CN1241148A CN1241091A CN1241158A CN1240922A CN1240843A CN1241291A CN1241032A CN1240691A CN1241030A CN1241295A CN1241192A CN1241266A CN1241265A CN1241329A CN1241246A CN1241126A CN1241127A CN1241124A CN1241288A CN1241287A CN1241212A CN1241211A CN1241123A CN1241310A CN1241341A CN1241344A CN1241343A CN1240866A CN1241035A CN1240962A CN1240717A CN1240936A CN1240935A CN1241259A CN1241258A CN1241143A CN1241107A CN1241095A CN1240632A CN1240645A CN1240754A CN1240872A CN1241013A CN1240951A CN1241056A CN1241198A CN1241206A CN1241297A CN1241077A CN1240920A CN1241268A CN1240749A CN1241207A CN1241112A CN1241276A CN1241283A CN1241282A CN1241169A CN1241309A CN1241315A CN1241351A CN1241015A CN1241227A CN1241349A CN1241029A CN1240887A CN1241039A CN1240621A CN1241052A CN1241086A CN1240986A CN1241080A CN1240988A CN1241263A CN1240973A CN1241144A CN1240944A CN1240627A CN1241255A CN1241096A CN1240996A CN1240993A CN1241103A CN1241027A CN1241239A CN1241254A CN1241251A CN1241147A CN1241289A CN1241043A CN1241204A CN1241201A CN1241273A CN1241284A CN1241307A CN1241338A CN1241180A CN1240897A CN1241034A CN1240629A CN1240628A CN1240719A CN1241082A CN1240743A CN1240847A CN1240727A CN1241089A CN1240984A CN1241216A CN1240948A CN1240703A CN1241163A CN1241067A CN1240756A CN1241071A CN1241234A CN1241245A CN1241167A CN1241023A CN1241022A CN1241175A CN1241323A CN1241183A CN1241241A CN1241304A CN1241190A CN1241199A CN1241116A CN1241285A CN1241308A CN1241314A CN1241312A CN1241181A CN1241318A CN1241100A CN1241079A CN1240788A CN1240925A CN1241232A CN1240771A CN1240978A CN1240987A CN1240802A CN1240677A CN1240846A CN1240845A CN1241012A CN1241025A CN1241021A CN1240953A CN1241141A CN1241223A CN1241185A CN1241184A CN1240923A CN1241269A CN1241333A CN1241330A CN1241272A CN1241171A CN1241236A CN1241156A CN1241345A CN1241256A CN1240999A CN1241065A CN1240704A CN1241087A CN1240772A CN1241247A CN1240713A CN1241060A CN1241083A CN1240938A CN1240997A CN1241186A CN1240965A CN1240909A CN1240837A CN1240998A CN1240856A CN1240946A CN1241063A CN1240597A CN1240934A CN1240860A CN1240831A CN1240598A CN1241072A CN1240619A CN1240602A CN1240734A CN1240817A CN1240641A CN1240746A CN1240828A CN1240822A CN1240806A CN1240803A CN1240750A CN1240671A CN1240765A CN1240647A CN1240722A CN1240835A CN1240656A CN1240654A CN1240768A CN1240906A CN1240744A CN1240707A CN1240824A CN1240800A CN1240798A CN1240581A CN1240877A CN1240689A CN1240660A CN1240659A CN1240838A CN1240915A CN1240633A CN1240610A CN1240697A CN1241073A CN1240635A CN1240603A CN1240673A CN1240638A CN1240592A CN1240876A CN1240571A CN1240867A CN1240763A CN1240661A CN1240600A CN1240899A CN1240941A CN1241153A CN1241106A CN1240852A CN1241050A CN1241057A CN1241146A CN1241249A CN1241045A CN1241031A CN1241196A CN1241296A CN1241044A CN1241114A CN1241335A CN1241277A CN1241140A CN1241137A CN1241134A CN1241226A CN1241018A CN1241316A CN1241102A CN1241037A CN1240926A CN1240907A CN1240735A CN1240712A CN1241260A CN1240979A CN1240740A CN1240739A CN1241145A CN1241300A CN1240945A CN1240736A CN1240679A CN1241154A CN1240930A CN1240839A CN1241161A CN1240914A CN1240913A CN1241076A CN1240636A CN1240810A CN1241166A CN1241229A CN1241325A CN1240974A CN1240639A CN1241159A CN1241048A CN1241069A CN1240728A CN1241117A CN1241121A CN1241208A CN1241271A CN1241286A CN1241306A CN1241342A CN1240885A CN1241135A CN1241028A CN1240942A CN1241000A CN1240624A CN1240842A CN1240890A CN1240718A CN1240939A CN1240618A CN1240989A CN1240854A CN1241085A CN1241317A CN1241252A CN1241046A CN1241336A CN1240983A CN1241042A CN1241020A CN1241493A CN1241580A CN1241626A CN1241752A CN1241365A CN1241370A CN1241440A CN1241768A CN1241623A CN1241604A CN1241428A CN1241738A CN1242105A CN1242107A CN1241877A CN1241618A CN1241689A CN1241640A CN1241386A CN1241470A CN1241703A CN1241822A CN1241828A CN1241424A CN1241423A CN1241368A CN1241411A CN1241537A CN1241549A CN1241494A CN1241499A CN1241465A CN1241789A CN1241518A CN1241462A CN1241649A CN1241373A CN1241764A CN1241607A CN1241757A CN1241829A CN1241443A CN1241675A CN1241774A CN1241621A CN1241402A CN1241514A CN1241710A CN1241827A CN1241425A CN1241366A CN1241469A CN1241412A CN1241672A CN1241624A CN1241630A CN1241628A CN1242122A CN1241525A CN1241599A CN1241612A CN1241729A CN1241746A CN1241878A CN1241930A CN1242050A CN1241890A CN1241932A CN1241603A CN1242136A CN1241442A CN1241450A CN1241380A CN1241643A CN1241665A CN1241361A CN1241502A CN1241414A CN1241670A CN1241699A CN1241663A CN1241390A CN1241686A CN1241483A CN1241600A CN1241426A CN1241947A CN1241749A CN1241759A CN1241588A CN1241813A CN1241576A CN1241447A CN1241384A CN1241416A CN1241359A CN1241367A CN1241546A CN1241671A CN1241497A CN1241644A CN1241627A CN1241482A CN1241961A CN1241648A CN1241712A CN1241609A CN1241636A CN1241614A CN1242064A CN1241740A CN1241972A CN1241676A CN1241620A CN1241573A CN1241376A CN1241383A CN1241362A CN1241358A CN1241823A CN1241356A CN1241355A CN1241629A CN1241687A CN1241481A CN1241480A CN1242123A CN1241601A CN1241637A CN1241616A CN1241475A CN1241713A CN1241744A CN1242048A CN1241931A CN1241597A CN1242137A CN1241587A CN1241622A CN1241617A CN1241639A CN1241403A CN1241453A CN1241452A CN1241451A CN1241721A CN1241563A CN1241415A CN1241654A CN1241496A CN1241696A CN1241830A CN1241492A CN1241625A CN1241638A CN1241650A CN1241606A CN1241678A CN1241674A CN1241431A CN1241439A CN1242041A CN1241507A CN1241429A CN1241595A CN1241762A CN1241680A CN1241477A CN1241574A CN1241702A CN1241716A CN1241409A CN1241360A CN1241421A CN1241545A CN1241550A CN1241553A CN1241533A CN1242133A CN1241836A CN1242026A CN1241661A CN1241645A CN1241372A CN1241369A CN1241396A CN1241572A CN1241441A CN1241611A CN1241610A CN1241593A CN1241437A CN1241430A CN1241436A CN1242039A CN1241884A CN1242063A CN1241444A CN1241683A CN1241682A CN1241478A CN1241691A CN1241404A CN1241381A CN1241839A CN1241473A CN1241711A CN1241669A CN1241668A CN1241837A CN1241860A CN1241717A CN1241646A CN1241454A CN1241389A CN1241534A CN1241659A CN1241395A CN1241763A CN1241615A CN1241797A CN1241895A CN1241737A CN1241891A CN1241982A CN1241765A CN1241641A CN1241692A CN1241382A CN1241633A CN1241632A CN1241631A CN1241655A CN1241468A CN1241418A CN1241405A CN1241413A CN1241547A CN1241861A CN1241488A CN1241664A CN1241585A CN1241582A CN1241455A CN1241535A CN1241461A CN1241495A CN1241364A CN1241363A CN1241371A CN1241374A CN1241378A CN1241438A CN1241432A CN1241939A CN1241742A CN1241591A CN1242084A CN1241474A CN1241681A CN1242034A CN1241642A CN1241398A CN1241569A CN1241647A CN1241357A CN1241422A CN1241864A CN1241826A CN1241657A CN1242119A CN1241466A CN1241464A CN1241784A CN1242023A CN1241685A CN1242097A CN1241798A CN1241944A CN1242104A CN1241883A CN1242046A CN1241981A CN1242061A CN1241973A CN1242085A CN1241594A CN1241858A CN1241529A CN1241843A CN1241706A CN1241704A CN1241653A CN1241724A CN1242126A CN1241705A CN1242029A CN1241834A CN1242031A CN1241697A CN1241876A CN1241458A CN1241787A CN1241658A CN1242022A CN1241694A CN1241753A CN1241962A CN1241863A CN1241987A CN1241817A CN1242121A CN1242008A CN1241677A CN1241988A CN1241904A CN1241910A CN1241901A CN1242040A CN1241940A CN1241950A CN1242069A CN1242080A CN1242047A CN1241869A CN1241857A CN1241760A CN1241758A CN1242093A CN1241875A CN1241776A CN1241810A CN1241385A CN1242127A CN1241490A CN1241832A CN1242117A CN1241520A CN1241936A CN1241486A CN1241986A CN1242095A CN1241394A CN1241989A CN1241984A CN1241874A CN1241953A CN1241992A CN1241728A CN1241503A CN1242110A CN1241796A CN1241880A CN1242051A CN1241592A CN1241871A CN1241806A CN1241779A CN1242018A CN1241700A CN1241719A CN1242028A CN1241526A CN1241715A CN1241708A CN1241498A CN1241521A CN1241517A CN1241392A CN1242025A CN1241479A CN1241651A CN1241375A CN1241769A CN1241799A CN1241887A CN1242055A CN1241912A CN1242075A CN1241847A CN1241924A CN1242042A CN1241945A CN1241951A CN1242102A CN1242098A CN1241735A CN1242106A CN1242111A CN1241979A CN1242091A CN1242089A CN1242088A CN1241805A CN1241522A CN1242131A CN1241821A CN1241862A CN1241583A CN1241783A CN1242052A CN1241966A CN1241524A CN1241914A CN1241767A CN1242094A CN1242058A CN1241802A CN1241750A CN1241804A CN1241803A CN1242074A CN1242072A CN1242070A CN1241506A CN1241855A CN1242101A CN1242112A CN1241852A CN1241974A CN1241775A CN1242113A CN1241446A CN1241586A CN1241701A CN1241485A CN1241541A CN1241842A CN1241811A CN1241540A CN1241501A CN1241467A CN1241449A CN1241388A CN1241391A CN1241785A CN1241515A CN1242054A CN1241688A CN1241820A CN1241818A CN1241652A CN1241926A CN1241679A CN1241906A CN1241909A CN1241913A CN1241898A CN1241896A CN1241967A CN1242073A CN1241795A CN1241733A CN1241888A CN1241851A CN1241868A CN1241849A CN1242138A CN1241771A CN1241777A CN1242016A CN1241916A CN1241684A CN1241723A CN1241551A CN1242132A CN1242030A CN1242033A CN1241792A CN1242021A CN1242020A CN1241532A CN1241393A CN1241975A CN1241965A CN1241865A CN1241819A CN1242115A CN1241934A CN1241598A CN1241772A CN1242096A CN1242060A CN1241800A CN1241634A CN1241902A CN1242068A CN1242044A CN1241897A CN1241968A CN1241949A CN1241510A CN1242081A CN1242109A CN1241980A CN1241983A CN1242062A CN1241755A CN1241770A CN1241782A CN1241690A CN1241954A CN1241400A CN1241530A CN1241693A CN1242027A CN1241527A CN1241841A CN1242032A CN1241656A CN1241579A CN1241786A CN1241523A CN1242120A CN1241635A CN1241778A CN1242056A CN1241990A CN1241848A CN1241925A CN1242100A CN1242043A CN1242002A CN1242099A CN1241731A CN1241730A CN1242078A CN1242045A CN1241969A CN1241809A CN1241960A CN1241397A CN1241531A CN1241707A CN1241543A CN1241840A CN1241714A CN1241838A CN1241835A CN1241790A CN1242118A CN1241387A CN1242019A CN1241459A CN1241833A CN1242037A CN1241964A CN1242125A CN1241566A CN1241568A CN1241928A CN1242059A CN1241903A CN1241508A CN1241727A CN1241434A CN1241946A CN1241943A CN1242003A CN1241993A CN1242103A CN1242108A CN1241889A CN1241873A CN1241754A CN1241971A CN1241917A CN1241957A CN1241781A CN1241959A CN1241958A CN1241866A CN1241814A CN1241578A CN1241484A CN1241542A CN1242128A CN1241554A CN1241557A CN1242007A CN1241407A CN1241408A CN1241709A CN1241791A CN1242116A CN1242114A CN1242010A CN1241513A CN1241886A CN1241725A CN1242086A CN1241991A CN1242004A CN1242077A CN1241505A CN1242079A CN1241856A CN1241748A CN1241929A CN1241870A CN1241850A CN1241978A CN1242083A CN1241808A CN1241919A CN1241448A CN1242129A CN1241577A CN1241538A CN1241500A CN1241825A CN1241673A CN1241879A CN1241899A CN1241816A CN1241745A CN1241581A CN1241667A CN1241793A CN1241788A CN1241662A CN1241460A CN1241379A CN1241602A CN1241433A CN1241427A CN1241512A CN1241511A CN1241743A CN1241741A CN1241476A CN1241619A CN1241552A CN1241548A CN1241420A CN1241417A CN1242130A CN1241722A CN1241556A CN1241564A CN1241410A CN1241666A CN1241824A CN1241718A CN1241698A CN1241584A CN1241456A CN1241660A CN1241915A CN1241608A CN1241613A CN1241435A CN1241590A CN1241859A CN1241377A CN1241399A CN1241575A CN1241445A CN1241720A CN1241560A CN1241419A CN1241354A CN1241555A CN1241565A CN1241539A CN1241846A CN1241977A CN1241489A CN1241831A CN1241491A CN1241516A CN1241976A CN1241923A CN1241487A CN1242036A CN1241751A CN1241963A CN1242124A CN1241900A CN1241801A CN1241908A CN1242067A CN1242076A CN1242066A CN1241894A CN1241885A CN1242038A CN1241941A CN1241952A CN1242071A CN1242082A CN1241854A CN1241747A CN1241872A CN1242135A CN1241867A CN1241853A CN1241766A CN1241761A CN1242092A CN1241807A CN1241773A CN1241955A CN1241812A CN1241780A CN1241570A CN1241844A CN1241471A CN1241561A CN1241695A CN1241519A CN1241457A CN1241463A CN1241536A CN1242053A CN1241589A CN1242057A CN1241985A CN1241911A CN1242065A CN1241509A CN1241726A CN1241794A CN1241736A CN1241882A CN1241881A CN1242134A CN1241756A CN1242090A CN1241970A CN1241920A CN1241918A CN1241956A CN1241401A CN1241544A CN1241472A CN1241528A CN1242087A CN1241504A CN1241815A CN1242549A CN1242279A CN1242220A CN1242412A CN1242343A CN1242260A CN1242442A CN1242472A CN1242451A CN1242356A CN1242583A CN1242268A CN1242186A CN1242361A CN1242200A CN1242377A CN1242424A CN1242422A CN1242533A CN1242567A CN1242233A CN1242146A CN1242520A CN1242160A CN1242672A CN1242670A CN1242234A CN1242163A CN1242401A CN1242395A CN1242227A CN1242224A CN1242415A CN1242444A CN1242157A CN1242209A CN1242201A CN1242205A CN1242195A CN1242421A CN1242420A CN1242497A CN1242434A CN1242389A CN1242239A CN1242281A CN1242619A CN1242438A CN1242252A CN1242400A CN1242238A CN1242150A CN1242354A CN1242633A CN1242211A CN1242207A CN1242514A CN1242185A CN1242402A CN1242408A CN1242456A CN1242204A CN1242202A CN1242423A CN1242187A CN1242638A CN1242561A CN1242336A CN1242345A CN1242714A CN1242215A CN1242632A CN1242246A CN1242162A CN1242340A CN1242374A CN1242539A CN1242148A CN1242171A CN1242838A CN1242351A CN1242319A CN1242538A CN1242537A CN1242271A CN1242144A CN1242143A CN1242667A CN1242581A CN1242376A CN1242198A CN1242206A CN1242532A CN1242313A CN1242194A CN1242308A CN1242431A CN1242256A CN1242255A CN1242223A CN1242230A CN1242168A CN1242414A CN1242413A CN1242309A CN1242346A CN1242212A CN1242515A CN1242425A CN1242484A CN1242145A CN1242219A CN1242534A CN1242505A CN1242286A CN1242231A CN1242314A CN1242467A CN1242236A CN1242476A CN1242242A CN1242508A CN1242243A CN1242382A CN1242381A CN1242379A CN1242151A CN1242648A CN1242213A CN1242208A CN1242222A CN1242419A CN1242289A CN1242615A CN1242315A CN1242468A CN1242430A CN1242806A CN1242642A CN1242249A CN1242519A CN1242435A CN1242449A CN1242173A CN1242671A CN1242393A CN1242398A CN1242226A CN1242225A CN1242166A CN1242678A CN1242462A CN1242310A CN1242471A CN1242443A CN1242347A CN1242176A CN1242258A CN1242270A CN1242406A CN1242582A CN1242295A CN1242518A CN1242196A CN1242557A CN1242306A CN1242390A CN1242338A CN1242645A CN1242417A CN1242544A CN1242521A CN1242341A CN1242216A CN1242251A CN1242509A CN1242474A CN1242274A CN1242540A CN1242140A CN1242139A CN1242210A CN1242432A CN1242690A CN1242221A CN1242487A CN1242203A CN1242535A CN1242513A CN1242554A CN1242489A CN1242189A CN1242158A CN1242719A CN1242240A CN1242180A CN1242159A CN1242674A CN1242506A CN1242332A CN1242459A CN1242156A CN1242269A CN1242181A CN1242360A CN1242296A CN1242197A CN1242427A CN1242316A CN1242344A CN1242428A CN1242245A CN1242448A CN1242218A CN1242164A CN1242396A CN1242228A CN1242641A CN1242153A CN1242149A CN1242576A CN1242461A CN1242318A CN1242257A CN1242488A CN1242458A CN1242668A CN1242496A CN1242292A CN1242312A CN1242214A CN1242266A CN1242304A CN1242683A CN1242392A CN1242179A CN1242644A CN1242161A CN1242375A CN1242397A CN1242165A CN1242372A CN1242915A CN1242628A CN1242881A CN1242844A CN1242846A CN1242897A CN1242729A CN1242565A CN1242914A CN1242803A CN1242677A CN1242409A CN1242733A CN1242746A CN1242666A CN1242298A CN1242536A CN1242822A CN1242526A CN1242491A CN1242188A CN1242293A CN1242285A CN1242878A CN1242741A CN1242464A CN1242441A CN1242608A CN1242802A CN1242912A CN1242832A CN1242782A CN1242247A CN1242707A CN1242551A CN1242791A CN1242664A CN1242834A CN1242739A CN1242447A CN1242872A CN1242797A CN1242254A CN1242530A CN1242480A CN1242731A CN1242821A CN1242811A CN1242572A CN1242656A CN1242191A CN1242657A CN1242696A CN1242876A CN1242873A CN1242605A CN1242887A CN1242800A CN1242595A CN1242593A CN1242528A CN1242597A CN1242890A CN1242916A CN1242917A CN1242625A CN1242624A CN1242907A CN1242902A CN1242909A CN1242738A CN1242586A CN1242722A CN1242244A CN1242841A CN1242848A CN1242358A CN1242452A CN1242652A CN1242799A CN1242885A CN1242485A CN1242736A CN1242511A CN1242700A CN1242503A CN1242826A CN1242637A CN1242577A CN1242337A CN1242486A CN1242686A CN1242264A CN1242433A CN1242865A CN1242869A CN1242867A CN1242866A CN1242748A CN1242275A CN1242779A CN1242762A CN1242908A CN1242709A CN1242676A CN1242904A CN1242333A CN1242385A CN1242761A CN1242760A CN1242790A CN1242789A CN1242794A CN1242320A CN1242470A CN1242263A CN1242721A CN1242348A CN1242847A CN1242725A CN1242329A CN1242650A CN1242910A CN1242804A CN1242884A CN1242272A CN1242857A CN1242898A CN1242839A CN1242777A CN1242863A CN1242712A CN1242599A CN1242913A CN1242868A CN1242750A CN1242639A CN1242752A CN1242276A CN1242831A CN1242827A CN1242629A CN1242906A CN1242905A CN1242643A CN1242147A CN1242591A CN1242840A CN1242618A CN1242473A CN1242894A CN1242634A CN1242754A CN1242871A CN1242689A CN1242482A CN1242328A CN1242184A CN1242552A CN1242384A CN1242895A CN1242919A CN1242744A CN1242573A CN1242562A CN1242699A CN1242502A CN1242810A CN1242492A CN1242787A CN1242291A CN1242695A CN1242875A CN1242612A CN1242588A CN1242477A CN1242785A CN1242903A CN1242217A CN1242675A CN1242399A CN1242277A CN1242386A CN1242469A CN1242436A CN1242816A CN1242326A CN1242325A CN1242661A CN1242660A CN1242349A CN1242322A CN1242563A CN1242649A CN1242592A CN1242300A CN1242801A CN1242691A CN1242883A CN1242483A CN1242730A CN1242383A CN1242921A CN1242849A CN1242735A CN1242820A CN1242500A CN1242879A CN1242815A CN1242814A CN1242555A CN1242566A CN1242558A CN1242713A CN1242808A CN1242740A CN1242716A CN1242687A CN1242527A CN1242864A CN1242680A CN1242391A CN1242753A CN1242335A CN1242525A CN1242545A CN1242627A CN1242623A CN1242765A CN1242763A CN1242778A CN1242705A CN1242321A CN1242327A CN1242818A CN1242817A CN1242734A CN1242446A CN1242301A CN1242175A CN1242918A CN1242732A CN1242745A CN1242574A CN1242825A CN1242824A CN1242823A CN1242580A CN1242571A CN1242559A CN1242568A CN1242718A CN1242613A CN1242685A CN1242603A CN1242587A CN1242601A CN1242813A CN1242303A CN1242302A CN1242665A CN1242330A CN1242622A CN1242793A CN1242590A CN1242589A CN1242324A CN1242284A CN1242651A CN1242654A CN1242911A CN1242585A CN1242922A CN1242920A CN1242856A CN1242701A CN1242504A CN1242501A CN1242788A CN1242560A CN1242265A CN1242717A CN1242723A CN1242610A CN1242870A CN1242600A CN1242640A CN1242892A CN1242248A CN1242547A CN1242172A CN1242339A CN1242924A CN1242923A CN1242169A CN1242771A CN1242792A CN1242662A CN1242842A CN1242727A CN1242888A CN1242862A CN1242688A CN1242742A CN1242737A CN1242819A CN1242602A CN1242288A CN1242833A CN1242620A CN1242342A CN1242177A CN1242679A CN1242877A CN1242282A CN1242853A CN1242711A CN1242522A CN1242927A CN1242550A CN1242795A CN1242776A CN1242775A CN1242796A CN1242311A CN1242837A CN1242154A CN1242350A CN1242323A CN1242845A CN1242564A CN1242367A CN1242635A CN1242357A CN1242653A CN1242805A CN1242253A CN1242529A CN1242481A CN1242479A CN1242404A CN1242294A CN1242512A CN1242861A CN1242809A CN1242756A CN1242636A CN1242698A CN1242290A CN1242578A CN1242694A CN1242693A CN1242715A CN1242607A CN1242594A CN1242604A CN1242299A CN1242682A CN1242598A CN1242606A CN1242237A CN1242331A CN1242646A CN1242704A CN1242702A CN1242829A CN1242440A CN1242854A CN1242575A CN1242570A CN1242749A CN1242611A CN1242418A CN1242684A CN1242659A CN1242273A CN1242394A CN1242493A CN1242609A CN1242631A CN1242278A CN1242170A CN1242380A CN1242416A CN1242152A CN1242352A CN1242141A CN1242617A CN1242616A CN1242453A CN1242142A CN1242495A CN1242516A CN1242183A CN1242405A CN1242410A CN1242199A CN1242297A CN1242510A CN1242193A CN1242192A CN1242463A CN1242317A CN1242429A CN1242523A CN1242499A CN1242437A CN1242669A CN1242167A CN1242387A CN1242542A CN1242706A CN1242262A CN1242353A CN1242261A CN1242155A CN1242355A CN1242287A CN1242174A CN1242182A CN1242407A CN1242457A CN1242490A CN1242232A CN1242498A CN1242307A CN1242466A CN1242465A CN1242267A CN1242235A CN1242475A CN1242280A CN1242455A CN1242454A CN1242524A CN1242250A CN1242507A CN1242647A CN1242850A CN1242900A CN1242460A CN1242692A CN1242663A CN1242880A CN1242843A CN1242724A CN1242743A CN1242855A CN1242728A CN1242889A CN1242755A CN1242517A CN1242411A CN1242531A CN1242812A CN1242786A CN1242579A CN1242658A CN1242757A CN1242697A CN1242874A CN1242621A CN1242596A CN1242305A CN1242747A CN1242241A CN1242630A CN1242548A CN1242626A CN1242450A CN1242925A CN1242830A CN1242828A CN1242673A CN1242439A CN1242926A CN1242899A CN1242334A CN1242774A CN1242836A CN1242835A CN1242882A CN1242259A CN1242445A CN1242726A CN1242896A CN1242494A CN1242584A CN1242478A CN1242553A CN1242556A CN1242758A CN1242852A CN1242851A CN1242720A CN1242886A CN1242681A CN1242283A CN1242891A CN1242893A CN1242751A CN1242703A CN1242546A CN1242901A CN1242378A CN1242708A CN1242710A CN1242655A CN1242858A CN1242807A CN1242178A CN1242614A CN1242860A CN1243408A CN1243409A CN1243066A CN1243394A CN1243155A CN1243015A CN1243099A CN1243164A CN1243493A CN1243196A CN1243138A CN1243165A CN1243207A CN1243051A CN1242995A CN1243242A CN1243000A CN1243212A CN1242996A CN1243153A CN1243160A CN1243358A CN1243046A CN1243410A CN1242938A CN1243293A CN1242969A CN1243187A CN1243185A CN1242949A CN1242960A CN1243205A CN1243186A CN1243057A CN1243030A CN1243329A CN1243339A CN1243281A CN1242992A CN1243139A CN1243005A CN1243350A CN1243284A CN1243061A CN1242991A CN1243075A CN1243074A CN1242976A CN1243252A CN1243040A CN1242952A CN1243011A CN1242954A CN1242986A CN1243121A CN1242965A CN1243341A CN1243340A CN1243267A CN1243270A CN1242964A CN1243019A CN1243024A CN1242990A CN1243043A CN1242931A CN1243459A CN1242939A CN1242935A CN1243251A CN1243320A CN1243324A CN1243163A CN1242962A CN1242944A CN1243347A CN1243276A CN1243106A CN1243108A CN1243373A CN1243262A CN1242999A CN1243216A CN1243147A CN1243334A CN1243050A CN1243211A CN1243209A CN1242933A CN1243249A CN1243098A CN1243230A CN1243008A CN1243103A CN1243029A CN1243239A CN1243053A CN1242993A CN1243261A CN1243025A CN1243356A CN1243067A CN1242988A CN1243072A CN1243086A CN1243039A CN1243298A CN1243232A CN1243154A CN1243014A CN1243184A CN1243183A CN1242951A CN1243157A CN1242941A CN1243028A CN1243170A CN1243134A CN1243152A CN1243290A CN1243119A CN1243389A CN1243079A CN1242985A CN1243297A CN1242934A CN1243300A CN1242971A CN1243188A CN1243229A CN1242948A CN1242945A CN1243012A CN1243190A CN1243366A CN1243035A CN1243033A CN1243140A CN1243148A CN1243359A CN1242929A CN1243047A CN1243181A CN1243180A CN1243299A CN1243321A CN1243322A CN1243100A CN1243228A CN1243120A CN1242953A CN1243159A CN1242958A CN1242940A CN1243102A CN1243101A CN1243130A CN1243144A CN1243354A CN1243107A CN1243243A CN1243213A CN1242963A CN1243149A CN1243056A CN1243112A CN1243254A CN1243044A CN1242932A CN1242961A CN1242947A CN1243158A CN1243156A CN1243218A CN1243128A CN1243236A CN1243167A CN1243111A CN1243036A CN1243171A CN1243278A CN1243049A CN1242994A CN1243136A CN1243048A CN1243097A CN1242998A CN1242997A CN1243162A CN1242979A CN1243078A CN1242937A CN1242970A CN1243323A CN1243227A CN1242955A CN1242943A CN1242942A CN1243168A CN1243143A CN1243280A CN1243277A CN1243275A CN1243002A CN1243001A CN1243090A CN1243151A CN1243217A CN1243094A CN1243026A CN1243117A CN1242989A CN1243306A CN1243617A CN1243564A CN1243426A CN1243296A CN1243472A CN1243401A CN1243397A CN1243364A CN1243546A CN1243657A CN1243091A CN1243225A CN1243625A CN1243616A CN1243561A CN1243241A CN1243418A CN1243059A CN1243549A CN1243282A CN1243558A CN1243371A CN1243512A CN1243137A CN1243133A CN1243215A CN1243378A CN1243538A CN1243309A CN1242975A CN1242974A CN1243388A CN1243452A CN1243424A CN1243315A CN1243383A CN1243612A CN1243318A CN1243471A CN1243301A CN1243326A CN1243392A CN1243553A CN1243552A CN1243644A CN1243176A CN1243494A CN1243491A CN1243503A CN1243166A CN1243346A CN1243466A CN1243541A CN1243360A CN1243575A CN1243105A CN1243244A CN1243627A CN1243204A CN1243109A CN1243487A CN1243268A CN1243142A CN1243641A CN1243289A CN1243351A CN1243286A CN1243416A CN1243611A CN1242936A CN1243041A CN1243605A CN1243294A CN1243565A CN1243593A CN1243586A CN1243580A CN1243224A CN1243626A CN1243622A CN1243420A CN1243464A CN1243576A CN1243222A CN1243543A CN1243238A CN1243477A CN1243482A CN1243476A CN1243480A CN1243642A CN1243631A CN1243446A CN1243436A CN1243447A CN1243382A CN1243307A CN1243619A CN1243303A CN1243467A CN1243178A CN1243448A CN1243084A CN1243474A CN1243037A CN1243554A CN1243363A CN1243567A CN1243610A CN1243393A CN1243645A CN1243532A CN1243492A CN1243615A CN1243202A CN1243559A CN1243292A CN1243638A CN1243223A CN1243372A CN1243484A CN1243479A CN1243260A CN1243442A CN1243495A CN1243336A CN1243376A CN1243357A CN1243115A CN1243310A CN1243562A CN1243064A CN1243618A CN1243457A CN1243458A CN1243073A CN1243463A CN1242928A CN1243396A CN1243609A CN1243502A CN1243490A CN1243569A CN1243568A CN1243194A CN1243423A CN1243649A CN1243172A CN1243637A CN1243583A CN1243581A CN1243653A CN1243342A CN1243338A CN1243237A CN1243052A CN1243481A CN1243258A CN1243266A CN1243634A CN1243433A CN1243633A CN1243526A CN1243445A CN1243640A CN1243092A CN1243331A CN1243374A CN1243604A CN1243536A CN1243060A CN1243065A CN1243417A CN1243421A CN1243305A CN1243304A CN1243253A CN1243425A CN1243083A CN1243606A CN1243071A CN1243566A CN1243613A CN1243226A CN1243391A CN1243104A CN1243422A CN1243206A CN1243021A CN1243427A CN1243628A CN1243438A CN1243406A CN1243629A CN1243522A CN1243485A CN1243435A CN1243287A CN1243540A CN1243288A CN1243116A CN1243246A CN1243080A CN1243069A CN1242980A CN1243314A CN1243455A CN1243413A CN1243563A CN1243550A CN1243325A CN1243398A CN1243365A CN1243533A CN1243623A CN1243189A CN1243590A CN1243530A CN1243650A CN1243361A CN1243199A CN1243556A CN1243124A CN1243542A CN1243545A CN1243544A CN1243175A CN1243221A CN1243589A CN1243192A CN1243110A CN1243601A CN1243259A CN1243263A CN1243274A CN1243432A CN1243145A CN1243630A CN1243439A CN1243437A CN1243497A CN1243095A CN1243285A CN1243599A CN1243062A CN1243539A CN1243537A CN1243210A CN1243451A CN1243308A CN1243316A CN1242983A CN1243319A CN1243470A CN1243070A CN1243256A CN1243608A CN1243231A CN1243592A CN1243585A CN1243584A CN1243027A CN1243547A CN1243588A CN1243022A CN1243478A CN1243483A CN1243265A CN1243096A CN1243431A CN1243632A CN1243524A CN1243405A CN1243441A CN1243429A CN1243328A CN1243597A CN1243531A CN1243023A CN1243450A CN1243461A CN1243317A CN1243551A CN1243571A CN1243555A CN1243362A CN1243594A CN1243652A CN1243587A CN1243655A CN1243504A CN1243399A CN1243621A CN1243197A CN1243344A CN1243509A CN1243132A CN1243465A CN1243058A CN1243123A CN1243291A CN1243353A CN1243577A CN1243126A CN1243174A CN1243654A CN1243283A CN1243475A CN1243141A CN1243089A CN1243332A CN1243330A CN1243496A CN1243018A CN1243517A CN1243602A CN1243385A CN1243415A CN1243414A CN1243386A CN1242982A CN1243453A CN1243311A CN1242984A CN1243412A CN1243381A CN1243460A CN1243468A CN1243179A CN1243177A CN1243255A CN1243182A CN1243507A CN1243557A CN1243489A CN1242950A CN1243404A CN1243390A CN1243219A CN1243560A CN1243368A CN1243367A CN1243131A CN1243624A CN1243355A CN1243579A CN1243352A CN1243648A CN1243574A CN1243488A CN1243534A CN1243620A CN1243203A CN1243191A CN1243603A CN1243600A CN1243264A CN1243273A CN1243214A CN1243434A CN1243440A CN1243004A CN1243516A CN1243535A CN1243031A CN1243449A CN1243384A CN1243045A CN1243076A CN1243068A CN1242977A CN1243582A CN1242987A CN1243444A CN1243529A CN1243257A CN1243595A CN1243548A CN1243020A CN1243501A CN1243647A CN1243087A CN1243596A CN1243250A CN1243395A CN1243017A CN1243016A CN1242946A CN1243013A CN1243010A CN1242959A CN1242956A CN1243234A CN1243279A CN1243003A CN1242967A CN1242966A CN1243161A CN1243006A CN1243333A CN1243054A CN1243247A CN1242930A CN1243082A CN1243042A CN1243009A CN1243195A CN1243201A CN1243200A CN1243235A CN1243348A CN1243173A CN1243198A CN1243269A CN1243007A CN1243081A CN1243077A CN1243313A CN1243411A CN1243607A CN1243038A CN1243572A CN1243402A CN1243570A CN1243233A CN1243646A CN1243643A CN1243651A CN1243403A CN1243327A CN1243193A CN1242973A CN1243369A CN1243127A CN1243034A CN1243169A CN1243656A CN1243499A CN1243335A CN1243240A CN1243135A CN1243375A CN1243486A CN1243272A CN1243271A CN1243430A CN1243428A CN1243443A CN1243093A CN1243337A CN1243500A CN1243349A CN1243379A CN1243377A CN1243063A CN1243302A CN1242978A CN1243387A CN1243085A CN1243312A CN1243295A CN1243473A CN1242968A CN1243469A CN1243591A CN1242957A CN1243614A CN1242972A CN1243419A CN1243220A CN1243208A CN1243343A CN1243636A CN1243498A CN1243370A CN1243380A CN1243407A CN1243088A CN1243150A CN1243635A CN1243639A CN1243345A CN1243598A CN1243055A CN1243118A CN1243573A CN1243462A CN1243454A CN1243400A CN1243114A CN1243248A CN1243113A CN1243967A CN1243663A CN1243744A CN1243746A CN1243873A CN1243883A CN1243932A CN1244317A CN1243871A CN1243781A CN1243676A CN1243950A CN1244086A CN1244093A CN1243992A CN1243737A CN1243888A CN1243682A CN1243834A CN1243703A CN1243709A CN1243747A CN1243727A CN1243874A CN1243730A CN1243788A CN1243785A CN1243741A CN1243856A CN1243922A CN1243929A CN1243695A CN1243779A CN1243681A CN1243933A CN1243724A CN1243729A CN1243942A CN1243812A CN1243901A CN1243899A CN1243790A CN1243928A CN1243872A CN1243769A CN1243677A CN1243806A CN1244043A CN1243836A CN1243761A CN1243986A CN1243984A CN1243983A CN1243773A CN1243840A CN1243816A CN1243743A CN1243704A CN1243711A CN1243759A CN1243725A CN1243881A CN1243792A CN1244092A CN1243945A CN1243789A CN1243815A CN1244296A CN1243926A CN1243671A CN1243804A CN1244081A CN1244084A CN1243822A CN1243819A CN1243835A CN1243707A CN1243748A CN1244304A CN1243862A CN1243719A CN1243918A CN1243855A CN1244051A CN1243714A CN1243708A CN1244045A CN1244047A CN1243850A CN1243762A CN1243982A CN1243975A CN1243887A CN1243672A CN1243685A CN1243690A CN1243689A CN1244019A CN1243662A CN1243706A CN1243712A CN1243861A CN1243718A CN1243879A CN1243818A CN1243959A CN1243736A CN1243916A CN1243930A CN1243805A CN1243904A CN1244044A CN1243678A CN1243721A CN1243934A CN1243890A CN1243658A CN1243859A CN1243661A CN1243666A CN1243915A CN1243758A CN1243726A CN1243734A CN1243777A CN1243900A CN1243898A CN1244035A CN1244065A CN1244248A CN1243715A CN1243694A CN1243995A CN1243994A CN1243797A CN1243780A CN1243905A CN1243902A CN1243897A CN1243680A CN1243860A CN1243844A CN1243733A CN1243854A CN1243847A CN1243722A CN1243877A CN1243772A CN1243683A CN1243858A CN1243817A CN1243742A CN1243696A CN1243957A CN1243731A CN1243794A CN1243700A CN1244224A CN1243738A CN1243824A CN1243896A CN1243979A CN1244094A CN1243684A CN1243970A CN1243660A CN1243670A CN1243814A CN1243668A CN1243866A CN1243912A CN1243832A CN1243732A CN1243943A CN1243917A CN1243787A CN1243739A CN1243925A CN1244209A CN1243845A CN1243674A CN1244042A CN1243906A CN1243679A CN1244038A CN1243768A CN1243993A CN1243935A CN1243837A CN1244332A CN1244171A CN1243968A CN1243972A CN1244105A CN1243999A CN1243811A CN1244211A CN1244210A CN1244068A CN1244299A CN1244307A CN1244258A CN1244075A CN1243869A CN1243825A CN1244325A CN1243784A CN1244111A CN1244287A CN1244004A CN1243843A CN1243848A CN1243985A CN1244255A CN1244159A CN1244087A CN1244091A CN1244147A CN1244319A CN1244315A CN1243853A CN1243911A CN1244172A CN1244102A CN1243701A CN1244143A CN1244164A CN1244178A CN1244282A CN1244009A CN1244008A CN1243800A CN1244018A CN1244231A CN1244186A CN1244054A CN1244234A CN1244067A CN1244233A CN1243893A CN1244136A CN1244140A CN1243827A CN1243946A CN1243895A CN1243839A CN1244273A CN1244157A CN1244320A CN1244263A CN1243991A CN1243823A CN1243892A CN1244173A CN1244168A CN1244100A CN1243665A CN1244058A CN1243766A CN1243882A CN1244097A CN1244002A CN1244010A CN1244289A CN1244176A CN1244060A CN1244300A CN1243924A CN1243923A CN1244264A CN1244145A CN1243782A CN1244121A CN1244109A CN1244285A CN1243764A CN1243988A CN1243990A CN1244274A CN1243820A CN1243908A CN1244217A CN1244213A CN1244025A CN1244104A CN1244205A CN1243938A CN1244144A CN1244181A CN1243775A CN1244011A CN1244012A CN1243786A CN1244127A CN1244125A CN1244134A CN1244297A CN1244229A CN1243921A CN1244131A CN1244293A CN1244261A CN1244242A CN1243998A CN1244112A CN1244114A CN1243903A CN1244310A CN1243763A CN1244313A CN1244251A CN1244160A CN1244165A CN1244275A CN1244163A CN1244328A CN1243977A CN1244170A CN1244023A CN1244020A CN1243667A CN1243765A CN1244180A CN1244278A CN1244095A CN1244108A CN1243795A CN1244126A CN1243920A CN1244237A CN1244240A CN1244262A CN1244073A CN1244267A CN1244331A CN1244221A CN1244290A CN1243846A CN1244049A CN1243851A CN1244271A CN1244324A CN1244154A CN1244326A CN1244085A CN1243693A CN1244099A CN1243969A CN1244024A CN1244021A CN1243813A CN1243774A CN1243961A CN1244185A CN1244228A CN1244236A CN1244120A CN1244301A CN1244055A CN1244072A CN1244146A CN1244077A CN1244076A CN1244246A CN1243867A CN1243996A CN1243798A CN1244219A CN1244286A CN1244116A CN1244037A CN1244323A CN1244152A CN1244254A CN1244327A CN1244150A CN1244314A CN1244001A CN1243771A CN1243687A CN1243691A CN1244216A CN1244214A CN1244098A CN1244106A CN1243863A CN1243751A CN1243914A CN1243754A CN1244179A CN1243799A CN1243973A CN1243956A CN1243955A CN1244017A CN1244138A CN1244061A CN1244294A CN1244292A CN1243997A CN1244284A CN1243803A CN1243810A CN1243778A CN1244222A CN1244005A CN1244119A CN1244082A CN1244162A CN1244080A CN1244277A CN1244276A CN1244166A CN1244151A CN1244318A CN1244334A CN1244302A CN1243697A CN1243962A CN1243941A CN1243940A CN1244223A CN1243699A CN1244052A CN1244230A CN1244227A CN1244031A CN1244238A CN1244201A CN1244295A CN1244298A CN1244071A CN1244064A CN1244260A CN1244308A CN1244305A CN1244070A CN1244241A CN1243870A CN1243783A CN1244113A CN1243809A CN1244115A CN1243838A CN1244247A CN1244270A CN1243978A CN1244272A CN1244161A CN1244089A CN1244088A CN1243989A CN1244312A CN1244148A CN1244069A CN1243770A CN1243889A CN1244039A CN1243705A CN1243686A CN1244103A CN1244101A CN1243659A CN1243702A CN1243910A CN1243966A CN1244059A CN1243865A CN1243757A CN1244195A CN1244182A CN1244281A CN1244030A CN1244028A CN1243954A CN1244183A CN1244050A CN1244133A CN1244226A CN1244056A CN1244309A CN1243927A CN1244243A CN1243947A CN1244194A CN1244322A CN1244155A CN1244153A CN1244321A CN1244090A CN1244149A CN1244156A CN1244256A CN1244167A CN1243976A CN1243735A CN1243971A CN1244202A CN1243864A CN1244303A CN1244129A CN1243964A CN1243791A CN1243939A CN1243793A CN1244007A CN1244288A CN1243802A CN1244208A CN1244212A CN1244053A CN1244135A CN1244032A CN1244066A CN1244235A CN1243857A CN1244137A CN1244311A CN1244306A CN1244063A CN1244220A CN1244122A CN1243675A CN1244110A CN1244006A CN1244118A CN1244040A CN1243952A CN1244265A CN1244252A CN1244279A CN1244316A CN1244184A CN1243953A CN1244215A CN1244206A CN1244218A CN1244016A CN1243960A CN1243951A CN1244269A CN1243776A CN1243963A CN1244003A CN1244268A CN1243909A CN1243664A CN1243669A CN1244013A CN1243713A CN1243710A CN1243756A CN1243760A CN1243767A CN1243753A CN1243880A CN1243728A CN1243919A CN1244188A CN1243740A CN1243716A CN1243949A CN1243886A CN1243884A CN1243849A CN1243987A CN1243980A CN1243833A CN1243688A CN1243745A CN1243750A CN1244057A CN1243720A CN1243878A CN1243958A CN1243830A CN1243894A CN1243717A CN1243868A CN1243876A CN1243875A CN1243808A CN1243807A CN1243885A CN1243723A CN1243752A CN1244079A CN1243891A CN1243692A CN1244333A CN1244022A CN1244177A CN1244204A CN1244203A CN1243673A CN1244014A CN1244142A CN1244141A CN1243913A CN1244029A CN1244107A CN1244034A CN1244033A CN1244128A CN1244132A CN1244232A CN1244239A CN1244249A CN1244330A CN1244027A CN1244026A CN1244291A CN1243907A CN1244046A CN1244041A CN1243937A CN1244266A CN1244083A CN1244078A CN1244280A CN1243974A CN1244015A CN1244169A CN1243965A CN1243755A CN1244130A CN1244175A CN1244283A CN1243944A CN1244000A CN1243796A CN1243801A CN1243698A CN1244189A CN1244207A CN1244225A CN1244036A CN1243931A CN1244062A CN1244074A CN1244245A CN1244244A CN1244117A CN1243948A CN1244048A CN1244158A CN1243936A CN1244253A CN1244250A CN1243981A CN1244257A CN1244423A CN1244510A CN1244486A CN1244336A CN1244747A CN1244347A CN1244574A CN1244436A CN1244831A CN1244426A CN1244495A CN1244622A CN1244443A CN1244408A CN1244412A CN1244558A CN1244717A CN1244458A CN1244459A CN1244783A CN1244619A CN1244487A CN1244508A CN1244507A CN1244392A CN1244422A CN1244611A CN1244682A CN1244362A CN1244698A CN1244465A CN1244696A CN1244581A CN1244567A CN1244578A CN1244577A CN1244438A CN1244511A CN1244518A CN1244650A CN1244522A CN1244337A CN1244599A CN1244340A CN1244572A CN1244474A CN1244369A CN1244425A CN1244608A CN1244379A CN1244355A CN1244584A CN1244418A CN1244416A CN1244469A CN1244373A CN1244368A CN1244365A CN1244555A CN1244568A CN1244449A CN1244411A CN1244409A CN1244722A CN1244374A CN1244456A CN1244427A CN1244998A CN1244393A CN1244632A CN1244493A CN1244735A CN1244668A CN1244653A CN1244430A CN1244428A CN1244359A CN1244500A CN1244694A CN1244610A CN1244364A CN1244761A CN1244583A CN1244591A CN1244566A CN1244520A CN1244952A CN1244457A CN1244404A CN1244403A CN1244483A CN1244399A CN1244771A CN1244643A CN1244639A CN1244594A CN1244341A CN1244344A CN1244431A CN1244499A CN1244509A CN1244424A CN1244614A CN1244680A CN1244760A CN1244617A CN1244498A CN1244497A CN1244636A CN1244366A CN1244515A CN1244564A CN1244444A CN1244413A CN1244410A CN1244905A CN1244554A CN1244415A CN1244756A CN1244923A CN1245004A CN1244953A CN1244398A CN1244630A CN1244644A CN1244593A CN1244741A CN1244746A CN1244646A CN1244974A CN1244709A CN1244357A CN1244503A CN1244607A CN1244354A CN1244544A CN1244470A CN1244447A CN1244489A CN1244762A CN1244767A CN1244455A CN1244406A CN1244596A CN1244382A CN1244351A CN1244361A CN1244991A CN1244625A CN1244377A CN1244548A CN1244402A CN1244658A CN1244468A CN1244800A CN1244580A CN1244517A CN1244763A CN1244924A CN1244401A CN1244478A CN1244631A CN1244534A CN1244623A CN1244541A CN1244751A CN1244618A CN1244586A CN1244595A CN1244672A CN1244417A CN1244496A CN1244421A CN1244697A CN1244452A CN1244516A CN1244407A CN1244902A CN1244719A CN1244638A CN1244569A CN1244441A CN1244669A CN1244350A CN1244628A CN1244609A CN1244606A CN1244545A CN1244363A CN1244615A CN1244531A CN1244637A CN1244590A CN1244420A CN1244395A CN1244579A CN1244512A CN1244481A CN1244389A CN1244559A CN1244781A CN1244784A CN1244620A CN1244535A CN1244537A CN1244383A CN1244338A CN1244433A CN1244705A CN1244384A CN1244536A CN1244749A CN1244612A CN1244419A CN1244576A CN1244575A CN1244588A CN1244471A CN1244556A CN1244505A CN1244439A CN1244335A CN1244414A CN1244848A CN1244557A CN1244624A CN1244966A CN1244665A CN1244834A CN1245007A CN1244814A CN1244688A CN1244693A CN1244514A CN1244909A CN1244539A CN1244685A CN1244657A CN1244660A CN1244513A CN1244372A CN1244895A CN1244907A CN1244561A CN1244945A CN1245006A CN1244876A CN1244730A CN1244485A CN1245000A CN1245001A CN1244803A CN1244667A CN1244740A CN1244673A CN1244600A CN1244708A CN1244434A CN1244711A CN1244819A CN1244994A CN1244739A CN1244758A CN1244750A CN1244655A CN1244454A CN1244634A CN1244467A CN1244970A CN1244805A CN1244886A CN1244883A CN1244929A CN1244787A CN1244943A CN1244986A CN1244996A CN1244640A CN1244664A CN1244737A CN1244475A CN1244501A CN1244828A CN1244908A CN1244993A CN1244990A CN1244790A CN1244627A CN1244914A CN1244604A CN1244755A CN1244753A CN1244689A CN1244378A CN1244376A CN1244450A CN1244797A CN1244460A CN1244445A CN1244480A CN1244842A CN1244840A CN1244956A CN1244850A CN1244769A CN1244978A CN1244931A CN1244937A CN1244788A CN1244917A CN1244951A CN1244946A CN1244810A CN1244872A CN1244904A CN1244734A CN1244700A CN1244772A CN1244965A CN1244633A CN1244342A CN1244703A CN1244806A CN1244714A CN1244988A CN1244793A CN1244829A CN1244791A CN1244822A CN1244677A CN1244613A CN1244757A CN1244463A CN1244621A CN1244440A CN1244963A CN1244841A CN1244847A CN1244927A CN1244926A CN1244930A CN1244765A CN1244728A CN1244933A CN1244768A CN1244560A CN1244980A CN1244922A CN1244812A CN1244983A CN1244388A CN1244491A CN1244995A CN1244802A CN1244598A CN1244972A CN1244809A CN1244573A CN1244385A CN1244476A CN1244792A CN1244827A CN1244795A CN1244833A CN1244754A CN1244538A CN1244380A CN1244546A CN1244690A CN1244796A CN1244695A CN1244969A CN1244968A CN1244490A CN1244702A CN1244928A CN1244853A CN1244880A CN1244977A CN1244921A CN1244919A CN1244947A CN1245003A CN1244903A CN1244879A CN1244889A CN1244550A CN1244732A CN1244934A CN1244645A CN1244601A CN1244675A CN1244345A CN1244429A CN1244435A CN1244687A CN1244989A CN1244992A CN1244477A CN1244565A CN1244955A CN1244960A CN1244959A CN1244975A CN1244776A CN1244981A CN1245002A CN1244873A CN1244875A CN1244915A CN1244785A CN1244733A CN1244941A CN1244676A CN1244647A CN1244707A CN1245008A CN1244386A CN1244817A CN1244816A CN1244692A CN1244830A CN1244626A CN1244678A CN1244684A CN1244759A CN1244616A CN1244446A CN1244482A CN1244836A CN1244839A CN1244901A CN1244881A CN1244720A CN1244766A CN1244916A CN1244882A CN1244891A CN1244857A CN1244570A CN1244971A CN1244813A CN1244371A CN1244900A CN1244911A CN1244683A CN1244585A CN1244367A CN1244862A CN1244856A CN1244964A CN1244962A CN1244906A CN1244849A CN1244779A CN1244944A CN1244845A CN1244782A CN1244987A CN1244484A CN1244860A CN1244641A CN1244525A CN1244651A CN1244532A CN1244870A CN1244691A CN1244820A CN1244506A CN1244910A CN1244540A CN1244603A CN1244686A CN1244381A CN1244798A CN1244466A CN1244896A CN1244837A CN1244823A CN1244775A CN1244888A CN1244789A CN1244949A CN1244948A CN1245005A CN1244898A CN1244874A CN1244890A CN1244893A CN1244940A CN1244713A CN1244773A CN1244629A CN1244738A CN1244602A CN1244375A CN1244432A CN1244712A CN1244818A CN1244748A CN1244679A CN1244745A CN1244504A CN1244701A CN1244835A CN1244838A CN1244846A CN1244725A CN1244778A CN1244721A CN1244729A CN1244982A CN1244976A CN1244780A CN1244920A CN1244899A CN1244844A CN1244851A CN1244871A CN1244936A CN1244551A CN1244852A CN1244710A CN1244715A CN1244706A CN1244642A CN1244400A CN1244774A CN1244461A CN1244523A CN1244652A CN1244744A CN1244597A CN1244339A CN1244370A";
		// pagerecord=2;

		// System.out.println((currentPage-1)*pagerecord+1);
		// System.out.println((currentPage-1)*pagerecord+10);

		/*
		 * if (strWhere == null) strWhere = (String) request.getAttribute("strWhere");
		 * //System.out.println("搜索条件进行处理前："+strWhere); // 对搜索条件进行处理 if
		 * (!strWhere.equalsIgnoreCase(trsLastWhere)) { strWhere =
		 * GetSearchFormat.preprocess(strWhere); }
		 */
		// filterChannel = "syxx_ft";

		// strWhere = GetSearchFormat.preprocess(selectexp);
		// strWhere = selectexp;

		// System.out.println("strSources="+strSources);
		// System.out.println("strWhere="+strWhere);
		// System.out.println("(currentPage-1)*pagerecord="+((currentPage-1)*pagerecord));
		// System.out.println("(currentPage-1)*pagerecord+10="+((currentPage-1)*pagerecord+10));
		// System.out.println("filterChannel="+filterChannel);

		/*
		 * iSearchType 0:只有aggs，概览左侧或纯分析; 1:除了aggs，还有hits，概览字段overview
		 * 2:没有aggs，只有hits，细览字段detail
		 */
		String isbatchdownload = request.getParameter("isbatchdownload");
		if(isbatchdownload!=null&&isbatchdownload.equals("1")) {
			iSearchType = 3;
		}
		
		try {

//			if (isbatchdownload == null || isbatchdownload.trim().equals("") || isbatchdownload.trim().equals("0")) {
				// if(xAxis!=null&&!xAxis.equals("")) {
				/*
				 * overviewResponse = searchFunc.overviewSearch(wap,strSources, strWhere,
				 * "RELEVANCE", expchange,//expchange=1,说明概览左侧改变了，右侧内容必须跟着改变 xAxis+",", 101,
				 * 115, false, 0L, 0L, "", "");
				 */

				if (
				// expchange.equals("1")
				iSearchType == 1) {

					/*
					 * overviewSearch(String wap,String strSources, String strWhere, String
					 * strSortMethod, String strStat, String strDefautCols, int xAxisSize, int
					 * yAxisSize, boolean b_reverse, long startIndex, long endIndex, String
					 * filterChannel, String strSynonymous)
					 */
					overviewResponse = searchFunc.overviewSearch(wap, strSources, strWhere, strSortMethod, "", // expchange=1,说明概览左侧改变了，右侧内容必须跟着改变
							xAxis + "," + yAxis, xAxisSize, yAxisSize, // iSearchType,
							false, (currentPage - 1) * pagerecord, (currentPage) * pagerecord, "", iSearchType + "");
				} else if (
				// expchange.equals("0")
				iSearchType == 0) {
					// iSearchType = 0;
					overviewResponse = searchFunc.overviewSearch(wap, strSources, strWhere, strSortMethod, "", // expchange=1,说明概览左侧改变了，右侧内容必须跟着改变
							xAxis + "," + yAxis, xAxisSize, yAxisSize, // iSearchType,
							false, 0L, 0L, "", iSearchType + "");
				} else if (iSearchType == 2) {
					// iSearchType = 2;
					overviewResponse = searchFunc.overviewSearch(wap, strSources, strWhere, strSortMethod, "",
							"主权项, 名称, 摘要", xAxisSize, yAxisSize, // iSearchType,
							false, (currentPage - 1) * pagerecord, (currentPage) * pagerecord, "", iSearchType + "");
				} else if (iSearchType == 3) {
					String downloadStart = request.getParameter("downloadStart");
					String downloadAmount = request.getParameter("downloadAmount");
					Long download_start = (long)0;
					Long download_amount = (long)0;
					if(downloadStart!=null) download_start=Long.parseLong(downloadStart);
					if(downloadAmount!=null) download_amount = Long.parseLong(downloadAmount);
					
					long startIndex = download_start-1;
					//Constant.PAGERECORD;
					//本次显示 最后一条记录下标
					long endIndex = download_start + download_amount - 1;
					
/*					overviewResponse = searchFunc.overviewSearch(wap,strSources,
							strWhere, strSortMethod, "",
							"",
							0,
							0,
							false,
							startIndex,
							endIndex,
							"",
							iSearchType + "");
*/
/*					System.out.println(wap);
					System.out.println(strSources);
					System.out.println(strWhere);
					System.out.println(strSortMethod);
					System.out.println(startIndex);
					System.out.println(endIndex);
					System.out.println(iSearchType);
*/					
					overviewResponse = searchFunc.overviewSearch(wap,strSources,
							strWhere, strSortMethod, "",
							"主权项, 名称, 摘要",
							0,
							0,
							false,
							startIndex,
							endIndex,
							"",
							iSearchType+"");
					
				}
			
			///////////////////////////////////////////////////////////////////////////
			/*
			if (isbatchdownload != null && isbatchdownload.equals("1")) {
				iSearchType = 3;
				String downloadStart = request.getParameter("downloadStart");
				String downloadAmount = request.getParameter("downloadAmount");
				Long download_start = (long) 0;
				Long download_amount = (long) 0;
				if (downloadStart != null)
					download_start = Long.parseLong(downloadStart);
				if (downloadAmount != null)
					download_amount = Long.parseLong(downloadAmount);

				long startIndex = download_start - 1;
				// Constant.PAGERECORD;
				// 本次显示 最后一条记录下标
				long endIndex = download_start + download_amount - 1;

				overviewResponse = searchFunc.overviewSearch(wap, strSources, strWhere, strSortMethod, "",
						"主权项, 名称, 摘要", 0, 0, false, startIndex, endIndex, "", "");

			}
			*/
			///////////////////////////////////////////////////////////////////////////

		} catch (Exception ex) {
			String errinfo = ex.getMessage();
			if (errinfo != null && (errinfo.equals("非法的客户端") || errinfo.equals("客户端过期"))) {
				errinfo = "概览检索出错，" + ex.getMessage() + "，请联系客服";
			} else {
				errinfo = "概览检索出错";
			}
			request.setAttribute("search_error", errinfo);
			throw ex;
		}

		/*
		 * overviewResponse = searchFunc.overviewSearch(wap,strSources, strWhere,
		 * "RELEVANCE", "", "主权项, 名称, 摘要", 2, 115, false, (currentPage-1)*pagerecord,
		 * (currentPage-1)*pagerecord+10, filterChannel, "");
		 */
		// request.setAttribute("searchword",
		// URLEncoder.encode((String)request.getAttribute("strWhere"), "UTF-8"));
		// request.setAttribute("securityCode",
		// SecurityTools.getSecurityCode((String)request.getAttribute("strWhere")));

		List<PatentInfo> PatentInfoList = overviewResponse.getPatentInfoList();
		
//		String _jsonresult = overviewResponse.getResult();
//		System.out.println(_jsonresult);

		// PatentInfo pi = PatentInfoList.get(0);
		// pi.getAcceptArea();

		List<PatentInfo> _PatentInfoList = null;

		if (isbatchdownload != null && isbatchdownload.equals("1")) {
//			_PatentInfoList = PatentInfoList;
			overviewResponse.setPatentInfoList(PatentInfoList);
			hm_result.put("overviewResponse", overviewResponse);
			return hm_result;
		}else {
			boolean b_ShowBase64 = false;
			String ShowBase64 = (String) application.get("ShowBase64");
			if (ShowBase64 != null && ShowBase64.equals("1")) {
				b_ShowBase64 = true;
			}
	
			if (PatentInfoList != null && PatentInfoList.size() > 0) {
				_PatentInfoList = processPatentInfoList(wap, PatentInfoList, false, b_ShowBase64);
			}
		}

		overviewResponse.setPatentInfoList(_PatentInfoList);
		request.getSession().setAttribute("list", _PatentInfoList);
		session.setAttribute("list", _PatentInfoList);

		// System.out.println("iSearchType="+iSearchType);
		if (iSearchType == 1 && treeType.equals("-1") && currentPage == 1 && (filterexp == null || filterexp.equals(""))
		// && savesearch!= null && savesearch.equalsIgnoreCase("ON")
		) {
			String userID = (String) request.getSession().getAttribute(Constant.APP_USER_ID);
			String userIP = com.cnipr.cniprgz.commons.Common.getRemoteAddr(request);
			int intCountry = (language != null && (language.equalsIgnoreCase("fr") || language.equalsIgnoreCase("en")))
					? 1
					: 0;

			strWhere_ori = strWhere_ori.replace("申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=", "快速检索=");
			strWhere_ori = strWhere_ori.replace("主权项语义,摘要语义+=", "语义检索=");

			String strTRSTableName = Util.getPatentTableName(application, strSources);
			expFunc.saveExpression(userIP, Integer.parseInt(userID), strWhere_ori, strSources, strTRSTableName, null,
					overviewResponse.getRecordCount(), request.getParameter("synonymous"), intCountry);
		}

		TreeMap<String, Integer> _map_data_single = overviewResponse.getMap_data_single();
		if (_map_data_single != null && _map_data_single.size() > 0) {
			MapValueComparator bvc = new MapValueComparator(_map_data_single);
			TreeMap<String, Integer> map_data_single = new TreeMap<String, Integer>(bvc);
			map_data_single.putAll(_map_data_single);
			overviewResponse.setMap_data_single(map_data_single);
		}
		
//		System.out.println(overviewResponse.getResult());
		String json = overviewResponse.getResult();
		
//		ArrayList al = new ArrayList<String>();
		
		Gson gson = new Gson();
		ArrayList<String> al_wordcloud = gson.fromJson(json, ArrayList.class);
		/*
		HashMap hs_wordcloud = new HashMap<String,String>();
		for (String str : al_wordcloud) {
			System.out.println(str);
			String[] arr = str.split(":");
			hs_wordcloud.put(arr[0], arr[1]);
		}
		*/
		hm_result.put("al_wordcloud", al_wordcloud);
//		hm_result.put("hs_wordcloud", hs_wordcloud);
		hm_result.put("RecordCount", overviewResponse.getRecordCount());
		hm_result.put("overviewResponse", overviewResponse);
		// hm_result.put("lastestFlztInfo", lastestFlztInfo);
		hm_result.put("channelInfo", channelInfoList);
		hm_result.put("strWhere", strWhere);
		hm_result.put("strWhere_ori", strWhere_ori);
		hm_result.put("strSources", strSources);
		// session.setAttribute("strWhere", strWhere);
		// request.setAttribute("sections",
		// getSectionInfo(channelList,overviewResponse.getSectionInfos()));
		hm_result.put("sections", getSectionInfo(channelInfoList, overviewResponse.getSectionInfos()));

		hm_result.put("URLEncoderWhere", URLEncoder.encode(strWhere, "UTF-8"));

		hm_result.put("SecurityCode", SecurityTools.getSecurityCode(strWhere));

		long totalRecord = overviewResponse.getRecordCount();
		// 设置总页数
		// String count = Integer.toString((int) java.lang.Math.ceil((totalRecord - 1) /
		// Constant.PAGERECORD) + 1);
		String totalpages = Integer.toString((int) java.lang.Math.ceil((totalRecord - 1) / pagerecord) + 1);
		request.setAttribute("totalpages", totalpages);

		return hm_result;
	}

	public String toJsonOverView() throws Exception {
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);

		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		int currentPage = request.getParameter("currentPage") == null ? 0
				: Integer.parseInt(request.getParameter("currentPage"));
		
		if (currentPage > 30 && username.equalsIgnoreCase("guest")) {
			jsonresult = "";
			return SUCCESS;
		}

		try {
			// String treeType =
			// request.getParameter("treeType")==null?"-1":request.getParameter("treeType");
			// int currentPage =
			// request.getParameter("currentPage")==null?0:Integer.parseInt(request.getParameter("currentPage"));
			HashMap<String, Object> hm_result = getPatentInfos(cxt);
			// OverviewSearchResponse overviewResponse = getPatentInfos(cxt);
			// String LatestFlzt =
			// DataAccess.getProperty("LatestFlzt")==null?"0":DataAccess.getProperty("LatestFlzt");
			/*
			 * if(("CN".equalsIgnoreCase(language)||"SX".equalsIgnoreCase(language))&&
			 * LatestFlzt.equals("1")){ lastestFlztInfo = getLatestFlzt(wap, application,
			 * overviewResponse); request.setAttribute("lastestFlztInfo", lastestFlztInfo);
			 * // System.out.println(""); }
			 */
			/**
			 * 概览检索记录检索日志
			 */
			if (SetupAccess.getProperty(SetupConstant.DATABASELOG) != null
					&& SetupAccess.getProperty(SetupConstant.DATABASELOG).equals("1")) {
				int userid = 0;
				userid = Integer.parseInt((String) request.getSession().getAttribute(Constant.APP_USER_ID));

				String userName = "";
				userName = (String) request.getSession().getAttribute(Constant.APP_USER_NAME);
				PlatformLog.insertSearchLog(userid, userName, com.cnipr.cniprgz.commons.Common.getRemoteAddr(request),
						language);
			}

			// String treeType =
			// request.getParameter("treeType")==null?"0":request.getParameter("treeType");
			// String searchKind = "";

			// String savesearch = request.getParameter("savesearchword");

			// log74(request, overviewResponse, treeType, strSources, searchKind, language);

			/*
			 * // jsonresult =
			 * JSONArray.fromObject(overviewResponse.getPatentInfoList()).toString();
			 * jsonresult = JSONArray.fromObject(overviewResponse).toString();
			 * 
			 * String flztjsonresult = "";
			 * if("CN".equalsIgnoreCase(language)&&LatestFlzt.equals("1")){ flztjsonresult =
			 * JSONArray.fromObject(lastestFlztInfo).toString(); }
			 * 
			 * String channelinfojson = JSONArray.fromObject(channelInfoList).toString();
			 * 
			 * // System.out.println(URLEncoder.encode(strWhere, "UTF-8")); //
			 * System.out.println(SecurityTools.getSecurityCode(strWhere));
			 * 
			 * jsonresult = overviewResponse.getRecordCount()+ "#"+jsonresult+
			 * "#"+flztjsonresult+ "#"+channelinfojson+ "#"+URLEncoder.encode(strWhere,
			 * "UTF-8")+ "#"+SecurityTools.getSecurityCode(strWhere);
			 */

			jsonresult = JSONArray.fromObject(hm_result).toString();
			// System.out.println(jsonresult);

		} catch (Exception ex) {
			ex.printStackTrace();
			jsonresult = "";
		}
		return SUCCESS;
	}

	private PatentInfo convertPatentbase64(PatentInfo patentInfo, boolean overview_detail) {
		Validate v = null;
		String base64code = null;
		if (patentInfo.getAn() != null && !patentInfo.getAn().equals("")) {
			v = ValidateCodeUtil.getBase64(patentInfo.getAn(), overview_detail);
			base64code = v.getBase64Str();
			// request.setAttribute("anbase64", base64code);
			patentInfo.setAnbase64(base64code);
		} else {
			patentInfo.setAnbase64("");
		}

		if (patentInfo.getPnm() != null && !patentInfo.getPnm().equals("")) {
			v = ValidateCodeUtil.getBase64(patentInfo.getPnm(), overview_detail);
			base64code = v.getBase64Str();
			// request.setAttribute("pnmbase64", base64code);
			patentInfo.setPnmbase64(base64code);
		} else {
			patentInfo.setPnmbase64("");
		}

		if (patentInfo.getAd() != null && !patentInfo.getAd().equals("")) {
			v = ValidateCodeUtil.getBase64(patentInfo.getAd(), overview_detail);
			base64code = v.getBase64Str();
			// request.setAttribute("adbase64", base64code);
			patentInfo.setAdbase64(base64code);
		} else {
			patentInfo.setAdbase64("");
		}

		if (patentInfo.getPd() != null && !patentInfo.getPd().equals("")) {
			v = ValidateCodeUtil.getBase64(patentInfo.getPd(), overview_detail);
			base64code = v.getBase64Str();
			// request.setAttribute("pdbase64", base64code);
			patentInfo.setPdbase64(base64code);
		} else {
			patentInfo.setPdbase64("");
		}

		if (patentInfo.getPic() != null && !patentInfo.getPic().equals("")) {
			v = ValidateCodeUtil.getBase64(patentInfo.getPic(), overview_detail);
			base64code = v.getBase64Str();
			// request.setAttribute("pdbase64", base64code);
			patentInfo.setPicbase64(base64code);
		} else {
			patentInfo.setPicbase64("");
		}

		if (patentInfo.getSic() != null && !patentInfo.getSic().equals("")) {
			v = ValidateCodeUtil.getBase64(patentInfo.getSic(), overview_detail);
			base64code = v.getBase64Str();
			// request.setAttribute("pdbase64", base64code);
			patentInfo.setSicbase64(base64code);
		} else {
			patentInfo.setSicbase64("");
		}
		return patentInfo;
	}

	private List<PatentInfo> processPatentInfoList(String wap, List<PatentInfo> PatentInfoList, boolean b_detail,
			boolean ShowBase64) {
		List<PatentInfo> _PatentInfoList = new ArrayList<PatentInfo>();

		try {

			for (Iterator<PatentInfo> it = PatentInfoList.iterator(); it.hasNext();) {
				PatentInfo patentInfo = it.next();

				if (ShowBase64 == true) {
					patentInfo = convertPatentbase64(patentInfo, false);
				}

				String ti = patentInfo.getTi();
				// System.out.println("ti="+ti);

				String leixing = patentInfo.getSectionName();
				if (patentInfo.getSectionName().toLowerCase().indexOf("zl") > -1) {
					leixing = "FM";
				}
				if (patentInfo.getSectionName().toLowerCase().indexOf("sq") > -1) {
					leixing = "SQ";
				}
				if (patentInfo.getSectionName().toLowerCase().indexOf("xx") > -1) {
					leixing = "XX";
				}
				if (patentInfo.getSectionName().toLowerCase().indexOf("wg") > -1) {
					leixing = "WG";
				}

				// DataAccess.get("WGPicServerURL")

				String an = patentInfo.getAn();
				patentInfo.setCountryCode(patentInfo.getAn().substring(0, 2));

				String imgurl = "";

				// if(an.indexOf(".")<=0){
				//// System.out.println("an="+an);
				// }else
				{
					String prePicServerURL = "";

					if (patentInfo.getCountryCode().equalsIgnoreCase("cn")) {
						if (leixing.equalsIgnoreCase("WG")) {
							// prePicServerURL = DataAccess.get("WGPicServerURL");
							prePicServerURL = DataAccess.get("PicServerURL");
							imgurl = prePicServerURL + patentInfo.getTifDistributePath() + "/000001.jpg";
						} else {
							// DataAccess.get("XMLServerURL")
							prePicServerURL = DataAccess.get("XMLServerURL");

							if (patentInfo.getAn().indexOf(".") > 0) {
								imgurl = patentInfo.getAn().toUpperCase().replace("CN", "").substring(0,
										patentInfo.getAn().indexOf(".") - 2);
							} else {
								imgurl = patentInfo.getAn().toUpperCase().replace("CN", "");
							}

							if (patentInfo.getAb() != null && patentInfo.getAb().toUpperCase().indexOf(".GIF") > -1) {
								// http://pic.cnipr.com/xmlData/xx/20001213/00206609.2/Y0020660900021.GIF
								// searchFunc.replaceInnerPICXML(String chrFigureVirtualPath ,String
								// patent_type,String tmpString,
								// String strAN, String strPD)

								String ab = searchFunc.replaceInnerPICXML("http://pic.cnipr.com/xmlData/",
										leixing.toLowerCase(), patentInfo.getAb(),
										patentInfo.getAn().toUpperCase().replace("CN", ""), patentInfo.getPd());

								patentInfo.setAb(ab);
							}

							if (patentInfo.getCl() != null && patentInfo.getCl().toUpperCase().indexOf(".GIF") > -1) {
								// http://pic.cnipr.com/xmlData/xx/20001213/00206609.2/Y0020660900021.GIF
								// searchFunc.replaceInnerPICXML(String chrFigureVirtualPath ,String
								// patent_type,String tmpString,
								// String strAN, String strPD)

								String cl = searchFunc.replaceInnerPICXML("http://pic.cnipr.com/xmlData/",
										leixing.toLowerCase(), patentInfo.getCl(),
										patentInfo.getAn().toUpperCase().replace("CN", ""), patentInfo.getPd());

								patentInfo.setCl(cl);
							}

							imgurl = prePicServerURL + "/" + leixing + "/" + patentInfo.getPd().replace(".", "") + "/"
									+ patentInfo.getAn().toUpperCase().replace("CN", "") + "/" + imgurl + ".gif";

							if (leixing.equalsIgnoreCase("SQ") || leixing.equalsIgnoreCase("SD")) {

								if (b_detail) {

									OverviewSearchResponse overviewResponse = null;
									overviewResponse = searchFunc.overviewSearch(wap, "fmzl_ft",
											"申请号=" + patentInfo.getAn(), "RELEVANCE", "", "主权项, 名称, 摘要", 2, 115, false,
											0, 1, null, "2");

									// List<PatentInfo> listPI = searchFunc.executeSearch("fmzl_ft",
									// "申请号="+patentInfo.getAn(), false, false);
									// PatentInfo pi = listPI.get(0);
									if (overviewResponse.getPatentInfoList() != null) {
										PatentInfo pi = overviewResponse.getPatentInfoList().get(0);
										patentInfo.setTifDistributePath(pi.getTifDistributePath());
										patentInfo.setPages(pi.getPages());
									}
									// patentInfo.getSqTifPath()
								}
							}
						}
						/*
						 * // if(prePicServerURL.equals("")){ // prePicServerURL =
						 * "http://pic.cnipr.com:8080/XmlData/"; // }
						 * 
						 * if(leixing.equals("WG")){ // DataAccess.get("PicServerURL") //
						 * http://pic.cnipr.com:8080/BOOKS/WG/2014/3034/2013306421509/000002.jpg //
						 * 发布路径='BOOKS/WG/2014/3034/2014300642663' imgurl = prePicServerURL +
						 * patentInfo.getTifDistributePath()+"/000001.jpg"; }else{ imgurl =
						 * prePicServerURL+"/" + leixing+"/" + patentInfo.getPd().replace(".", "") +
						 * "/"+patentInfo.getAn().toUpperCase().replace("CN",
						 * "")+"/"+patentInfo.getAn().toUpperCase().replace("CN", "").substring(0,
						 * patentInfo.getAn().indexOf(".")-2)+".gif"; }
						 */
					} else {
						prePicServerURL = DataAccess.get("PicServerURL");
						// http://pic.cnipr.com:8080//foreignimage/JP\s4\s41\s417\JP2010276417.GIF
						// JP\s4\s41\s417\JP2010276417.GIF
						String abpicpath = patentInfo.getAbPicPath() == null ? "" : patentInfo.getAbPicPath();

						imgurl = prePicServerURL + "/foreignimage/" + abpicpath.replace("\\", "/");
					}

					// String imgurl = "http://pic.cnipr.com:8080/XmlData/"+leixing+"/" +
					// patentInfo.getPd().replace(".", "") +
					// "/"+patentInfo.getAn().toUpperCase().replace("CN",
					// "")+"/"+patentInfo.getAn().toUpperCase().replace("CN", "").substring(0,
					// patentInfo.getAn().indexOf(".")-2)+".gif";
					// patentInfo.setPic(imgurl);
					patentInfo.setAbPicPath(imgurl);
				}

				_PatentInfoList.add(patentInfo);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return _PatentInfoList;
	}

	private Map<String, String> _getLatestFlzt(String wap, Map<String, Object> application,
			OverviewSearchResponse overviewResponse) throws Exception {
		Map<String, String> lastestFlztInfo = new HashMap<String, String>();

		try {
			// String wap =
			// request.getParameter("wap")==null?"":request.getParameter("wap");

			Map<String, String> map_flzt = (Map<String, String>) application.get("map_flzt");// 全部CN
			if (map_flzt == null) {
				map_flzt = flztFunc.getAllFlzt();
				application.put("map_flzt", map_flzt);
			}

			// List<ClientPatentInfo> _PatentInfoList =
			// (List<ClientPatentInfo>)overviewResponse.getPatentInfoList();
			// ClientPatentInfo cpi =
			// (ClientPatentInfo)overviewResponse.getPatentInfoList().get(1);
			String Ans = "";

			Iterator<PatentInfo> it = overviewResponse.getPatentInfoList().iterator();
			while (it.hasNext()) {
				PatentInfo pi = it.next();
				Ans += pi.getAn() + " or ";
				// System.out.println(iter.next());
				// System.out.println(pi.getSectionName());
			}

			if (Ans.endsWith(" or ")) {
				Ans = Ans.substring(0, Ans.length() - 4);
			}
			Ans = Ans.replace("CN", "");
			Ans = Ans.replace("cn", "");

			// List<LegalStatusInfo> ls_flzt = searchFunc.legalStatusSearch(wap, "申请号=("+
			// Ans + " or " + Ans.toUpperCase().replaceAll("CN", "")+")");
			List<LegalStatusInfo> ls_flzt = searchFunc.legalStatusSearch(wap, "申请号=(" + Ans + ")");
			/////////////////////////////////////////////////////////////////////////////////////////////
			Iterator<PatentInfo> it1 = overviewResponse.getPatentInfoList().iterator();
			while (it1.hasNext()) {
				PatentInfo pi = it1.next();
				System.out.println(pi.getAn());

				int n = 0;
				Iterator<LegalStatusInfo> it2 = ls_flzt.iterator();
				while (it2.hasNext()) {
					LegalStatusInfo lsi = it2.next();
					System.out.println(lsi.getStrAn());
					if (pi.getAn().indexOf(lsi.getStrAn()) > -1 || pi.getAn().equals(lsi.getStrAn())) {
						// 如果最新的法律状态在法律状态对照表中对应“待定”
						if (map_flzt.get(lsi.getStrLegalStatus()) != null
								&& map_flzt.get(lsi.getStrLegalStatus()).equals("待定")) {
							/***********************************************
							 * 查倒数第二个法律状态
							 ************************************************/
							boolean b_second = false;
							int n1 = 0;
							Iterator<LegalStatusInfo> it_2 = ls_flzt.iterator();
							while (it_2.hasNext()) {
								// 倒数第二个法律状态，倒数第三个法律状态......
								if (n1 > n && (pi.getAn().indexOf(lsi.getStrAn()) > -1
										|| pi.getAn().equals(lsi.getStrAn()))) {
									LegalStatusInfo lsi_2 = it_2.next(); // 取出倒数第二个法律状态，倒数第三个法律状态......
									if (map_flzt.get(lsi_2.getStrLegalStatus()) != null) {// 如果倒数第二法律状态在法律状态对照表中有对应值
										if (map_flzt.get(lsi_2.getStrLegalStatus()).equals("待定")) {// 倒数第二个法律状态还是“待定”
											lastestFlztInfo.put(pi.getAn(), getFinalFlzt(pi.getAd(),
													pi.getSectionName(), lsi_2.getStrLegalStatus()));
											b_second = true;
											break;
										} else if (!map_flzt.get(lsi_2.getStrLegalStatus()).equals("待定")) {// 倒数第二个法律状态不是“待定”
											lastestFlztInfo.put(pi.getAn(), getFinalFlzt(pi.getAd(),
													pi.getSectionName(), map_flzt.get(lsi_2.getStrLegalStatus())));//
											b_second = true;
											break;
										}
									}
								}
								n1++;
							}

							if (!b_second) {
								// lastestFlztInfo.put(pi.getAn(),
								// map_flzt.get(lsi_2.getStrLegalStatus())==null?lsi_2.getStrLegalStatus():map_flzt.get(lsi_2.getStrLegalStatus()));
								lastestFlztInfo.put(pi.getAn(),
										getFinalFlzt(pi.getAd(), pi.getSectionName(), lsi.getStrLegalStatus()));
							}
							/**********************************************************************************************************************/
						} else {
							lastestFlztInfo.put(pi.getAn(),
									getFinalFlzt(pi.getAd(), pi.getSectionName(),
											map_flzt.get(lsi.getStrLegalStatus()) == null ? lsi.getStrLegalStatus()
													: map_flzt.get(lsi.getStrLegalStatus())));
						}

						break;
					}
					n++;
				}
			}
		} catch (Exception ex) {
			throw ex;
		}
		return lastestFlztInfo;
	}

	private String getFinalFlzt(String patent_ad, String sectionName, String flzt_info) {
		String finalflzt = "";
		try {
			Calendar now_ymd = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
			Date date = sdf.parse(patent_ad);
			Calendar patentAD = Calendar.getInstance();
			patentAD.setTime(date);
			if (sectionName.toLowerCase().indexOf("fm") > -1) {
				patentAD.add(Calendar.YEAR, 20);
			} else {
				patentAD.add(Calendar.YEAR, 10);
			}

			int result = now_ymd.compareTo(patentAD);
			if (result >= 0) {
				finalflzt = "无效";
			} else {
				// String flzt_info = lastestFlztInfo.get(patentInfo.getAn());
				if (flzt_info != null && flzt_info.equals("在审")) {
					finalflzt = "在审";
				} else if (flzt_info != null && flzt_info.equals("无效")) {
					// strb.append("&nbsp;<span class=\"label label-default\">无效</span>");
					finalflzt = "无效";
				} else if (flzt_info != null && flzt_info.equals("有效")) {
					// strb.append("&nbsp;<span class=\"label label-success\">有效</span>");
					finalflzt = "有效";
				} else {
					// strb.append("&nbsp;<span class=\"label
					// label-default\">"+flzt_info+"</span>");
					finalflzt = flzt_info;
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return finalflzt;
	}

	private List<WASSectionInfo> getSectionInfo(List<ChannelInfo> channelList, List<SectionInfo> sectionInfoList) {

		List<WASSectionInfo> infoList = new ArrayList<WASSectionInfo>();
		for (ChannelInfo info : channelList) {
			WASSectionInfo wasSecInfo = new WASSectionInfo();
			wasSecInfo.setSectionName(info.getChrChannelName());

			long recordNum = 0L;
			String[] tables = info.getChrTRSTable().split(",");
			if (sectionInfoList != null) {
				for (SectionInfo trsSectionInfo : sectionInfoList) {
					for (int i = 0; i < tables.length; i++) {
						if (tables[i].equals(trsSectionInfo.getSectionName())) {
							recordNum += trsSectionInfo.getRecordNum();
						}
					}
				}
			}
			wasSecInfo.setChannelName(info.getChrTRSTable());
			wasSecInfo.setRecordNum(recordNum);
			infoList.add(wasSecInfo);
		}
		return infoList;
	}

	public String detailSearch1() throws Exception {
		ActionContext cxt = ActionContext.getContext();
		Map<String, Object> application = cxt.getApplication();

		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();

		String xml_path = ServletActionContext.getServletContext().getRealPath("/temp");
		// System.out.println("path = "+xml_path);

		// public String detailSearch() throws Exception{
		// ActionContext cxt = ActionContext.getContext();
		// HttpServletRequest request =
		// (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);

		// ---------------增加防止频繁刷新网页---------------
		/*
		 * StopRefresh stopRefresh = new StopRefresh();
		 * 
		 * stopRefresh.redirectPage = request.getContextPath() + "/stopRefresh.jsp"; //
		 * 单次屏蔽页，即用户还未超过当天限定次数 stopRefresh.blackPage = request.getContextPath() +
		 * "/blackPage.jsp"; // 用户当天操作超限 try { if (stopRefresh.stopRefreshPage(request,
		 * response)) { return null; } } catch (IOException e1) { e1.printStackTrace();
		 * }
		 */

		String area = (request.getParameter("area") == null || request.getParameter("area").equals("")) ? "cn"
				: request.getParameter("area");
		if (area.toLowerCase().equals("en")) {
			area = "fr";
		}
		/*
		 * String strWhere = request.getParameter("strWhere"); //
		 * System.out.println(strWhere);
		 * 
		 * if(strWhere.startsWith("##")){ strWhere =
		 * com.cnipph.util.Util.unescape(strWhere.substring(2)); }
		 */
		String strWhere = (String) session.getAttribute("strWhere");

		String wap = request.getParameter("wap") == null ? "" : request.getParameter("wap");
		// System.out.println("----wap="+wap);
		if (wap.equals("1")) {
			// System.out.println("====strWhere="+strWhere);
			strWhere = java.net.URLDecoder.decode(strWhere, "UTF-8");
			strWhere = strWhere.replace("申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要 =",
					"申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=");
			// strWhere = com.cnipph.util.Util.unescape(strWhere);
		}

		String strSources = request.getParameter("strSources");
		String filterChannel = request.getParameter("filterChannel");
		if (filterChannel != null && !filterChannel.equals("")) {
			strSources = filterChannel;
		}

		// ========================================================= IPC或行业导航
		// ===========================================================
		String language = request.getParameter("language") == null ? "CN"
				: request.getParameter("language").toUpperCase();
		String nodeId = request.getParameter("nodeId");
		String treeType = request.getParameter("treeType") == null ? "-1" : request.getParameter("treeType");

		if (nodeId != null) {
			String secondsearchexp = request.getParameter("secondsearchexp") == null ? ""
					: request.getParameter("secondsearchexp").toUpperCase();
			String[] arrSecondsearchexp = null;

			if (secondsearchexp != null && !secondsearchexp.trim().equals("")
					&& !secondsearchexp.toUpperCase().equals("UNDEFINED")) {
				// System.out.println(secondsearchexp);
				secondsearchexp = secondsearchexp.replaceAll("%(?![0-9a-fA-F]{2})", "%25");
				secondsearchexp = URLDecoder.decode(secondsearchexp, "UTF-8");
				arrSecondsearchexp = secondsearchexp.split(";");
			}

			NodeModel node = nodeFunc.getNodeInfoByID(treeType, nodeId);
			///////////////////////////////////////////////////////////////////////////////
			String selectexp = node.getCnTrsExp();
			if (language.equals("CN")) {
				selectexp = node.getCnTrsExp();
			} else {
				selectexp = node.getEnTrsExp();
			}

			if (secondsearchexp != null && !secondsearchexp.trim().equals("")
					&& !secondsearchexp.toUpperCase().equals("UNDEFINED")) {
				// selectexp = "("+selectexp+")" + secondsearchexp;
				for (int i = 0; i < arrSecondsearchexp.length; i++) {
					selectexp = "(" + selectexp + ")" + " " + arrSecondsearchexp[i];
				}
			}
			selectexp = selectexp.trim();

			String selectdbs = request.getParameter("selectdbs") == null ? "" : request.getParameter("selectdbs");
			// alert($('#area').val());
			// alert($('#selectexp').val());
			// alert($('#selectdbs').val());
			filterChannel = request.getParameter("filterChannel") == null ? "" : request.getParameter("filterChannel");

			// ++++++++++++++++++++++++++++++++++++++++
			strWhere = selectexp;
			strSources = selectdbs;
			if (filterChannel != null && !filterChannel.equals("")) {
				strSources = filterChannel;
			}
			// ++++++++++++++++++++++++++++++++++++++++
		}
		// ====================================================================================================================

		if (StringUtil.hasText(strSources) == false) {
			// if (!area.equals("cn")) {
			// strSources = channelDAO.getEnablechrTRSTables(area);
			// }else{
			// strSources = "fmzl_ft,syxx_ft,wgzl_ab";
			// }
			strSources = Util.getPatentTableByArea(application, area);
		} else {
			strSources = Util.getPatentTable(application, strSources);
		}

		if (strSources != null && strSources.toLowerCase().indexOf("patent") > -1) {
			area = "fr";
		} else {
			area = "cn";
		}

		String strSortMethod = request.getParameter("strSortMethod");
		String strDefautCols = request.getParameter("strDefautCols");
		String strStat = request.getParameter("strStat");
		if (strStat == null)
			strStat = "";

		if (strDefautCols == null)
			strDefautCols = "名称";

		String strSynonymous = request.getParameter("synonymous");
		if (strSynonymous == null)
			strSynonymous = "";

		String iOption = request.getParameter("iOption");
		String iHitPointType = request.getParameter("iHitPointType");
		String bContinue = request.getParameter("bContinue");
		String index = request.getParameter("index");
		if (index == null || "".equals(index) || "null".equals(index)) {
			index = "0";
		}

		// 数据权限验证

		request.setAttribute("strWhere", strWhere);
		request.setAttribute("strSynonymous", strSynonymous);
		request.setAttribute("strSources", strSources);
		request.setAttribute("strChannels", request.getParameter("strChannels"));
		request.setAttribute("strSortMethod", strSortMethod);
		request.setAttribute("strDefautCols", strDefautCols);
		request.setAttribute("strStat", strStat);
		request.setAttribute("iOption", iOption);
		request.setAttribute("iHitPointType", iHitPointType);
		request.setAttribute("bContinue", bContinue);

		DetailSearchResponse detailResponse = null;

		if (StringUtil.hasText(iOption) == false)
			iOption = "2";

		if (StringUtil.hasText(iHitPointType) == false)
			iHitPointType = "115";

		if (StringUtil.hasText(strSortMethod) == false) {
			strSortMethod = "RELEVANCE";
		}

		try {
			// /**
			// * 如果是国外数据进行普通检索,中国数据进行智能检索
			// */
			// if (!area.equals("cn")) {
			// detailResponse = searchFunc.detailSearch(strSources, strWhere,
			// strSortMethod, strStat, strDefautCols, Integer
			// .parseInt(iOption), Integer
			// .parseInt(iHitPointType), false, Long
			// .parseLong(index), strSynonymous);
			// }
			//
			// /**
			// * 智能检索
			// *
			// */
			// else {
			// String an = "";
			// String pdLimit = request.getParameter("dateLimit") == null
			// || request.getParameter("dateLimit").equals("") ? "1999"
			// : request.getParameter("dateLimit");
			// String appDate = request.getParameter("apdRange");
			// String appNo = request.getParameter("appNum") == null ? ""
			// : request.getParameter("appNum");
			// String simFlag = request.getParameter("simFlag");
			// if (simFlag != null && !simFlag.trim().equals("")) {
			// String dateCond = appDate.equals("0") ? "" : appDate
			// .equals("1") ? " 申请日=1900.01.01 to " + pdLimit
			// : appDate.equals("2") ? "申请日=" + pdLimit
			// + " to 2099.12.31" : "";
			// strWhere = dateCond;
			// an = "申请号=" + appNo;
			// System.out.println(an);
			// request.setAttribute("trsLastWhere", "");
			// request.setAttribute("apdRange", appDate);
			// }
			// detailResponse = semanticSearchImpl.getSemanticResult(
			// strSources, strWhere, strSortMethod, strStat,
			// strDefautCols, Integer.parseInt(iOption), Integer
			// .parseInt(iHitPointType), false, Long
			// .parseLong(index), strSynonymous, an);
			// }
			// 20160212
			// strWhere = GetSearchFormat.preprocess(strWhere);

			if (strWhere != null) {
				strWhere = strWhere.toUpperCase();
			}
			// System.out.println("strSources="+strSources);
			// System.out.println("strWhere="+strWhere);
			// System.out.println("strSortMethod="+strSortMethod);

			detailResponse = searchFunc.detailSearch(wap, strSources, strWhere, strSortMethod, strStat, strDefautCols,
					Integer.parseInt(iOption), Integer.parseInt(iHitPointType), false, Long.parseLong(index),
					strSynonymous);

			// System.out.println(detailResponse.getRecordCount());

			/**
			 * 记录细缆检索日志
			 */
			if (SetupAccess.getProperty(SetupConstant.DATABASELOG) != null
					&& SetupAccess.getProperty(SetupConstant.DATABASELOG).equals("1")) {
				String userName = "";
				userName = (String) request.getSession().getAttribute(Constant.APP_USER_NAME);
				PlatformLog.insertViewLog(userName, com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), area);
			}
			/**
			 * log74日志
			 */
			if (Log74Access.getProperty(Log74Util.getLOG_OPEN()) != null
					&& Log74Access.getProperty(Log74Util.getLOG_OPEN()).equals("1")) {
				if (request.getSession().getAttribute(Constant.APP_USER_ID) != null) {
					String operateUserId = (String) request.getSession().getAttribute(Constant.APP_USER_ID);
					IprUser ipruser = sysUserFunc.getUserInfo(Integer.parseInt(operateUserId));

					try {
						Log74Util.log_func("9999", operateUserId + "", ipruser.getIntGroupId() + "",
								com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), DateUtil.getCurrentTimeStr(),
								strSources, "1");
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		} catch (Exception e) {
			// ActionMessages errors = new ActionMessages();
			// errors.add(Constant.SEARCH_AUTHEN_ERROR, new ActionMessage(
			// "search.authen.error"));
			// this.saveErrors(request, errors);
			e.printStackTrace();
			request.setAttribute("search_error", "细览检索出错," + e.getMessage());
			return ERROR;
		}

		if (detailResponse == null) {
			request.setAttribute("search_error", "对不起,没有找到相应的检索结果");
			return ERROR;
		}

		// PatentInfo pi = detailResponse.getPatentInfo();

		List<PatentInfo> _PatentInfoList = new ArrayList<PatentInfo>();
		_PatentInfoList.add(detailResponse.getPatentInfo());

		// detailResponse.setPatentInfo(processPatentInfoList(wap,
		// _PatentInfoList,true).get(0));
		// PatentInfo patentInfo = detailResponse.getPatentInfo();

		PatentInfo patentInfo = processPatentInfoList(wap, _PatentInfoList, true, false).get(0);

		String leixing = "";
		HashMap<String, String> hm_patenttype = (HashMap<String, String>) application.get("patenttype");
		leixing = hm_patenttype.get(patentInfo.getSectionName());

		// List<ChannelInfo> channelInfoList_cn =
		// (List<ChannelInfo>)application.get("channelInfoList_cn");//全部CN
		// patentInfo.setFt(searchFunc.replaceInnerPICXML(patentInfo.getFt(),
		// patentInfo.getSectionName() String patent_type, String strAN, String strPD));

		if (patentInfo.getFt() != null) {
			String ft = patentInfo.getFt().trim();
			ft = ft.replace("<?xml version=\"1.0\"?>", "");
			ft = ft.replace("<!DOCTYPE cn-patent-document SYSTEM \"dtd/cn-patent-document-06-10-27.dtd\"[]>", "");
			ft = ft.replace("<?xml-stylesheet type=\"text/xsl\" href=\"xsl/XSL0117new.xsl\"?>", "");
			ft = ft.replace(
					"<?trs-parser SegmentMark=\"paragraph\" NewLineMark=\"br\" HitShowMark=\"TRSHL\" FilterCData=\"yes\"?>",
					"");
			ft = ft.replace("<cn-patent-document lang=\"ZH\" country=\"CN\">", "");
			ft = ft.replace("<application-body lang=\"CN\" country=\"CN\">", "");
			ft = ft.replace("<description>", "");
			ft = ft.replace("</description>", "");
			ft = ft.replace("</application-body>", "");
			ft = ft.replace("</cn-patent-document>", "");

			if (patentInfo.getFt().toUpperCase().indexOf(".GIF") > -1
					|| patentInfo.getFt().toUpperCase().indexOf(".TIF") > -1) {
				// http://pic.cnipr.com/xmlData/xx/20001213/00206609.2/Y0020660900021.GIF
				// searchFunc.replaceInnerPICXML(String chrFigureVirtualPath ,String
				// patent_type,String tmpString, String strAN, String strPD)

				ft = searchFunc.replaceInnerPICXML("http://pic.cnipr.com/xmlData/", leixing.toLowerCase(), ft,
						patentInfo.getAn().toUpperCase().replace("CN", ""), patentInfo.getPd());

				// System.out.println(ft);
				// img-content="drawing" img-format="tif" orientation="portrait" inline="yes"
				ft = ft.replace(" img-content=\"drawing\"", "");
				ft = ft.replace(" img-format=\"tif\"", "");
				ft = ft.replace(" orientation=\"portrait\"", "");
				ft = ft.replace(" inline=\"yes\"", "");
			}

			// ft = ft.replace("<p id=\"", "&nbsp;&nbsp;&nbsp;&nbsp;<p id=\"");
			ft = ft.replace("file=\"", " src=\"");
			ft = ft.replace("<br />", "");
			patentInfo.setFt(ft.trim());
		}

		if (patentInfo.getClm() != null) {
			String clm = patentInfo.getClm().trim();
			clm = clm.replace("<?xml version=\"1.0\"?>", "");
			clm = clm.replace("<!DOCTYPE cn-patent-document SYSTEM \"dtd/cn-patent-document-06-10-27.dtd\"[]>", "");
			clm = clm.replace("<?xml-stylesheet type=\"text/xsl\" href=\"xsl/XSL0117new.xsl\"?>", "");
			clm = clm.replace(
					"<?trs-parser SegmentMark=\"paragraph\" NewLineMark=\"br\" HitShowMark=\"TRSHL\" FilterCData=\"yes\"?>",
					"");
			clm = clm.replace("<cn-patent-document lang=\"ZH\" country=\"CN\">", "");
			clm = clm.replace("<application-body lang=\"CN\" country=\"CN\">", "");
			clm = clm.replace("<description>", "");
			clm = clm.replace("</description>", "");
			clm = clm.replace("</application-body>", "");
			clm = clm.replace("</cn-patent-document>", "");

			if (patentInfo.getClm().toUpperCase().indexOf(".GIF") > -1
					|| patentInfo.getClm().toUpperCase().indexOf(".TIF") > -1) {

				// http://pic.cnipr.com/xmlData/xx/20001213/00206609.2/Y0020660900021.GIF
				// searchFunc.replaceInnerPICXML(String chrFigureVirtualPath ,String
				// patent_type,String tmpString,
				// String strAN, String strPD)

				clm = searchFunc.replaceInnerPICXML("http://pic.cnipr.com/xmlData/", leixing.toLowerCase(), clm,
						patentInfo.getAn().toUpperCase().replace("CN", ""), patentInfo.getPd());
			}
			// System.out.println(clm);
			clm = clm.replace("claim-text", "p");
			clm = clm.replace("<br />", "");

			patentInfo.setClm(clm.trim());
		}

		// System.out.println(patentInfo.getFtDra());
		if (patentInfo.getFtDra() != null) {
			String dra = patentInfo.getFtDra().trim();
			dra = dra.replace("<?xml version=\"1.0\"?>", "");
			dra = dra.replace("<!DOCTYPE cn-patent-document SYSTEM \"dtd/cn-patent-document-06-10-27.dtd\"[]>", "");
			dra = dra.replace("<?xml-stylesheet type=\"text/xsl\" href=\"xsl/XSL0117new.xsl\"?>", "");
			dra = dra.replace(
					"<?trs-parser SegmentMark=\"paragraph\" NewLineMark=\"br\" HitShowMark=\"TRSHL\" FilterCData=\"yes\"?>",
					"");
			dra = dra.replace("<cn-patent-document lang=\"ZH\" country=\"CN\">", "");
			dra = dra.replace("<application-body lang=\"CN\" country=\"CN\">", "");
			dra = dra.replace("<description>", "");
			dra = dra.replace("</description>", "");
			dra = dra.replace("</application-body>", "");
			dra = dra.replace("</cn-patent-document>", "");

			if (patentInfo.getFtDra().toUpperCase().indexOf(".GIF") > -1
					|| patentInfo.getFtDra().toUpperCase().indexOf(".TIF") > -1) {

				// http://pic.cnipr.com/xmlData/xx/20001213/00206609.2/Y0020660900021.GIF
				// searchFunc.replaceInnerPICXML(String chrFigureVirtualPath ,String
				// patent_type,String tmpString,String strAN, String strPD)

				dra = searchFunc.replaceInnerPICXML("http://pic.cnipr.com/xmlData/", leixing.toLowerCase(), dra,
						patentInfo.getAn().toUpperCase().replace("CN", ""), patentInfo.getPd());
			}

			// dra = dra.replace("<figure id=\"f0001\" num=\"0001\" figure-labels=\"图1\">",
			// "");
			// dra = dra.replace("</figure>", "");
			dra = dra.replace("file=\"", " class=\"img-thumbnail img-responsive\" src=\"");
			dra = dra.replace("<br />", "");
			// System.out.println(clm);
			patentInfo.setFtDra(dra.trim());
		}
		// http://pic.cnipr.com:8080/XmlData/fm/19970521/95118304.4/A9511830400101.gif
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>) application.get("channelInfoList_fr");
		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>) application.get("channelInfoList_cn");
		List<ChannelInfo> channelInfoList_sx = (List<ChannelInfo>) application.get("channelInfoList_sx");// 全部CN

		HashMap<String, String> hm_channel = new HashMap<String, String>();
		for (ChannelInfo ci : channelInfoList_fr) {
			// System.out.println(ci.getIntChannelID());
			hm_channel.put(ci.getChrTRSTable(), ci.getChrChannelName());
		}
		// HashMap<String,String> hm_channel_cn = new HashMap<String,String>();
		for (ChannelInfo ci : channelInfoList_cn) {
			// System.out.println(ci.getIntChannelID());
			hm_channel.put(ci.getChrTRSTable(), ci.getChrChannelName());
		}
		for (ChannelInfo ci : channelInfoList_sx) {
			// System.out.println(ci.getIntChannelID());
			hm_channel.put(ci.getChrTRSTable(), ci.getChrChannelName());
		}
		String NationTypeName = hm_channel.get(patentInfo.getSectionName());

		if (NationTypeName == null) {
			Iterator iter = hm_channel.entrySet().iterator();
			while (iter.hasNext()) {
				Map.Entry entry = (Map.Entry) iter.next();
				String key = (String) entry.getKey();
				String val = (String) entry.getValue();

				if (key.indexOf(patentInfo.getSectionName()) > -1) {
					NationTypeName = val;
					break;
				}
			}
		}
		patentInfo.setEstype(NationTypeName);
		////////////////////////////////////////////////////////////////////////////////////////////////////////////
		/**
		 * 如果
		 */
		if (patentInfo == null) {
			request.setAttribute("search_error", "对不起,没有找到相应的检索结果");
			return ERROR;
		}
		request.setAttribute("patentInfo", patentInfo);
		session.setAttribute("patentInfo", patentInfo);

		// searchFunc.writeXML(xml_path,patentInfo.getAn(),"ft",patentInfo.getFt());
		// searchFunc.writeXML(xml_path,patentInfo.getAn(),"clm",patentInfo.getClm());

		/*
		 * if(strSources.indexOf("patent")==-1) {
		 * searchFunc.writeXML(xml_path,patentInfo.getAn(),"ft",patentInfo.getFt());
		 * searchFunc.writeXML(xml_path,patentInfo.getAn(),"clm",patentInfo.getClm());
		 * searchFunc.writeXML(xml_path,patentInfo.getAn(),"dra",patentInfo.getFtDra());
		 * }
		 */

		// System.out.println("----------------------------------------------------");
		// System.out.println("patentInfo.getAn() = " + patentInfo.getAn());
		// System.out.println("patentInfo.getPn() = " + patentInfo.getPn());

		List<PatentInfo> patentList = new ArrayList<PatentInfo>();
		patentList.add(patentInfo);
		// request.getSession().setAttribute("list",patentList);
		request.getSession().setAttribute("onePatentInfo", patentList);

		String dbName = detailResponse.getSectionName();
		request.setAttribute("dbName", dbName);

		// 查看是否有摘要附图
		String an = patentInfo.getAn();
		String pd = patentInfo.getPd();
		if (an != null && !an.equals("") && pd != null && !pd.equals("")) {
			String shortAN = Util.getShortAN(pd, an);

			if (an.indexOf(".") > -1) {
				shortAN = an.substring(0, an.indexOf("."));
			}

			shortAN = shortAN.toUpperCase().replace("CN", "");

			Date start = new Date();

			String figureURL = "XmlData/" + Util.getPatentType(dbName) + "/" + pd.replaceAll("\\.", "") + "/"
					+ an.toUpperCase().replace("CN", "") + "/" + shortAN + ".tif";

			if (SetupAccess.getProperty(SetupConstant.ZHAIYAOFUTUTYPE) != null
					&& SetupAccess.getProperty(SetupConstant.ZHAIYAOFUTUTYPE).equals("gif"))
				figureURL = "XmlData/" + Util.getPatentType(dbName) + "/" + pd.replaceAll("\\.", "") + "/"
						+ an.toUpperCase().replace("CN", "") + "/" + shortAN + ".gif";

			figureURL = figureURL.replace("/.gif", ".gif");

			String inUrl = DataAccess.getProperty("PicIntranetServerURL") + figureURL;

			if (Util.isPicExis(inUrl)) {
				request.setAttribute("figureURL", DataAccess.getProperty("PicFuTuServerURL") + figureURL);
			}

			Date end = new Date();
			CoreBizLogger.LogInfo("detailSearch time is : " + (end.getTime() - start.getTime()) + "ms");
			CoreBizLogger.LogInfo("figureURL is : " + figureURL);
		}

		request.setAttribute("scyyzzlList", detailResponse.getScyyzzlList());// 审查员引证专利文献
		request.setAttribute("scyyzfzlList", detailResponse.getScyyzfzlList());// 审查员引证非专利文献
		request.setAttribute("sqryzzlList", detailResponse.getSqryzzlList());// 被引证文献
		request.setAttribute("scybyzzlList", detailResponse.getScybyzzlList());// 被引证文献
		request.setAttribute("sqrbyzzlList", detailResponse.getSqrbyzzlList());// 被引证文献

		Page page = new Page();
		page.setPageCount(Long.toString(detailResponse.getRecordCount()));
		page.setPageIndex(index);
		request.setAttribute("page", page);
		// String sqAndFmFlag = request.getParameter("sqFlag");

		/**
		 * 增加是否需要在授权和发明中进行切换
		 */
		// 20160213

		if (!area.equalsIgnoreCase("fr")) {
			// if(SetupAccess.getProperty(SetupConstant.VIEWGB)!=null &&
			// SetupAccess.getProperty(SetupConstant.VIEWGB).equals("1"))
			// {
			// try {
			// GBIndex gbindex = searchFunc.getGBIndex(an, pd);
			// request.setAttribute("GBIndex", gbindex);
			// } catch (Exception e) {
			// e.printStackTrace();
			// }
			// }

			if (dbName.toLowerCase().startsWith("wgzl")) {
				///////////////////////////////////////////////////////////////////////////////////////
				String strPages = patentInfo.getPages();
				// String pubPath = APIUtils.getProperty("tiffDownload", true) +
				// patentInfo.getTifDistributePath();
				String pubPath = DataAccess.getProperty("PicServerURL") + patentInfo.getTifDistributePath();

				pubPath = pubPath.replace("books", "ThumbnailImage");
				List<String> imagePubPathList = new ArrayList<String>();
				if (strPages == null || "".equals(strPages)) {
					// break;
				}
				int intPages = Integer.parseInt(strPages);
				DecimalFormat df = new DecimalFormat("000000");
				int pageno = 1;
				for (int i = 1; i <= intPages; i++) {
					imagePubPathList.add(pubPath + "/" + df.format((pageno - 1) * 9 + i) + ".jpg");
				}
				request.setAttribute("ThumbnailImagePubPathList", imagePubPathList);

				////////////////////////////////////////////////////////////////////////////////////////
				request.setAttribute("wggb", detailResponse.getWggbInfo());
				// return mapping.findForward("wg_detailPage");
				return INPUT;
			}

			// if (sqAndFmFlag != null && "Y".equals(sqAndFmFlag)) {
			// request.setAttribute("sqFlag", "Y");
			//// return new ActionForward("/jsp/zljs/detailPage_cn_sq.jsp");
			// return NONE;
			// } else {
			//// return mapping.findForward("cn_detailPage");
			// return SUCCESS;
			// }
			return SUCCESS;
		} else {
			// return mapping.findForward("fr_detailPage");
			return NONE;
		}

		// String SUCCESS = "success";
		// String NONE = "none";
		// String ERROR = "error";
		// String INPUT = "input";
		// String LOGIN = "login";
	}

	public String detailSearch() throws Exception {
		ActionContext cxt = ActionContext.getContext();
		Map<String, Object> application = cxt.getApplication();

		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();

		String xml_path = ServletActionContext.getServletContext().getRealPath("/temp");
		// System.out.println("path = "+xml_path);

		// public String detailSearch() throws Exception{
		// ActionContext cxt = ActionContext.getContext();
		// HttpServletRequest request =
		// (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);

		// ---------------增加防止频繁刷新网页---------------

		String area = "cn";

		String strWhere = request.getParameter("strWhere");

		String strSources = request.getParameter("strSources");
		strSources = Util.getPatentTable(application, strSources);

		DetailSearchResponse detailResponse = null;

		try {
			// strWhere = GetSearchFormat.preprocess(strWhere);
			strWhere = strWhere.toUpperCase();
			// System.out.println("strSources="+strSources);
			// System.out.println("strWhere="+strWhere);
			// System.out.println("strSortMethod="+strSortMethod);

			detailResponse = searchFunc.detailSearch("", strSources, strWhere, "", "", "", 0, 1, false,
					Long.parseLong("0"), "");

			// System.out.println(detailResponse.getRecordCount());

			if (strSources.toLowerCase().indexOf("patent") > -1) {
				area = "fr";
			}

			/**
			 * 记录细缆检索日志
			 */
			if (SetupAccess.getProperty(SetupConstant.DATABASELOG) != null
					&& SetupAccess.getProperty(SetupConstant.DATABASELOG).equals("1")) {
				String userName = "";
				userName = (String) request.getSession().getAttribute(Constant.APP_USER_NAME);
				PlatformLog.insertViewLog(userName, com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), area);
			}
			/**
			 * log74日志
			 */
			if (Log74Access.getProperty(Log74Util.getLOG_OPEN()) != null
					&& Log74Access.getProperty(Log74Util.getLOG_OPEN()).equals("1")) {
				if (request.getSession().getAttribute(Constant.APP_USER_ID) != null) {
					String operateUserId = (String) request.getSession().getAttribute(Constant.APP_USER_ID);
					IprUser ipruser = sysUserFunc.getUserInfo(Integer.parseInt(operateUserId));

					try {
						Log74Util.log_func("9999", operateUserId + "", ipruser.getIntGroupId() + "",
								com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), DateUtil.getCurrentTimeStr(),
								strSources, "1");
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		} catch (Exception e) {
			// ActionMessages errors = new ActionMessages();
			// errors.add(Constant.SEARCH_AUTHEN_ERROR, new ActionMessage(
			// "search.authen.error"));
			// this.saveErrors(request, errors);
			e.printStackTrace();
			request.setAttribute("search_error", "细览检索出错," + e.getMessage());
			return ERROR;
		}

		if (detailResponse == null) {
			request.setAttribute("search_error", "对不起,没有找到相应的检索结果");
			return ERROR;
		}
		// PatentInfo pi = detailResponse.getPatentInfo();

		List<PatentInfo> _PatentInfoList = new ArrayList<PatentInfo>();
		_PatentInfoList.add(detailResponse.getPatentInfo());

		// detailResponse.setPatentInfo(processPatentInfoList(wap,
		// _PatentInfoList,true).get(0));
		// PatentInfo patentInfo = detailResponse.getPatentInfo();

		boolean b_ShowBase64 = false;
		String ShowBase64 = (String) application.get("ShowBase64");
		if (ShowBase64 != null && ShowBase64.equals("1")) {
			b_ShowBase64 = true;
		}

		PatentInfo patentInfo = processPatentInfoList("", _PatentInfoList, true, b_ShowBase64).get(0);

		String leixing = "";
		HashMap<String, String> hm_patenttype = (HashMap<String, String>) application.get("patenttype");
		leixing = hm_patenttype.get(patentInfo.getSectionName());

		// List<ChannelInfo> channelInfoList_cn =
		// (List<ChannelInfo>)application.get("channelInfoList_cn");//全部CN
		// patentInfo.setFt(searchFunc.replaceInnerPICXML(patentInfo.getFt(),
		// patentInfo.getSectionName() String patent_type, String strAN, String strPD));

		if (patentInfo.getAb() != null) {
			String ab = patentInfo.getAb().trim();

			if (ab.toUpperCase().indexOf(".GIF") > -1 || ab.toUpperCase().indexOf(".TIF") > -1) {
				// http://pic.cnipr.com/xmlData/xx/20001213/00206609.2/Y0020660900021.GIF
				// searchFunc.replaceInnerPICXML(String chrFigureVirtualPath ,String
				// patent_type,String tmpString, String strAN, String strPD)

				ab = searchFunc.replaceInnerPICXML("http://pic.cnipr.com/xmlData/", leixing.toLowerCase(), ab,
						patentInfo.getAn().toUpperCase().replace("CN", ""), patentInfo.getPd());

				// System.out.println(ft);
				// img-content="drawing" img-format="tif" orientation="portrait" inline="yes"
				ab = ab.replace(" img-content=\"drawing\"", "");
				ab = ab.replace(" img-format=\"tif\"", "");
				ab = ab.replace(" orientation=\"portrait\"", "");
				ab = ab.replace(" inline=\"yes\"", "");

				// ab = ab.replace("<embed", "<img");
				// ab = ab.replace("file=\"", "src=\"");
				ab = ab.replace(
						"type=\"image/tiff\" mousemode=\"none\" toolbar=\"off\" bgcolor=\"#FFFFFF\" negative=\"no\"",
						"");
			}

			// ft = ft.replace("<p id=\"", "&nbsp;&nbsp;&nbsp;&nbsp;<p id=\"");
			ab = ab.replace("file=\"", " src=\"");
			ab = ab.replace("<br />", "");
			patentInfo.setAb(ab.trim());
		}

		if (patentInfo.getCl() != null) {
			String cl = patentInfo.getCl().trim();

			if (cl.toUpperCase().indexOf(".GIF") > -1 || cl.toUpperCase().indexOf(".TIF") > -1) {
				// http://pic.cnipr.com/xmlData/xx/20001213/00206609.2/Y0020660900021.GIF
				// searchFunc.replaceInnerPICXML(String chrFigureVirtualPath ,String
				// patent_type,String tmpString, String strAN, String strPD)

				cl = searchFunc.replaceInnerPICXML("http://pic.cnipr.com/xmlData/", leixing.toLowerCase(), cl,
						patentInfo.getAn().toUpperCase().replace("CN", ""), patentInfo.getPd());

				// System.out.println(ft);
				// img-content="drawing" img-format="tif" orientation="portrait" inline="yes"
				cl = cl.replace(" img-content=\"drawing\"", "");
				cl = cl.replace(" img-format=\"tif\"", "");
				cl = cl.replace(" orientation=\"portrait\"", "");
				cl = cl.replace(" inline=\"yes\"", "");

				// ab = ab.replace("<embed", "<img");
				// ab = ab.replace("file=\"", "src=\"");
				cl = cl.replace(
						"type=\"image/tiff\" mousemode=\"none\" toolbar=\"off\" bgcolor=\"#FFFFFF\" negative=\"no\"",
						"");
			}

			// ft = ft.replace("<p id=\"", "&nbsp;&nbsp;&nbsp;&nbsp;<p id=\"");
			cl = cl.replace("file=\"", " src=\"");
			cl = cl.replace("<br />", "");
			patentInfo.setCl(cl.trim());
		}

		if (patentInfo.getFt() != null) {
			String ft = patentInfo.getFt().trim();
			ft = ft.replace("<?xml version=\"1.0\"?>", "");
			ft = ft.replace("<!DOCTYPE cn-patent-document SYSTEM \"dtd/cn-patent-document-06-10-27.dtd\"[]>", "");
			ft = ft.replace("<?xml-stylesheet type=\"text/xsl\" href=\"xsl/XSL0117new.xsl\"?>", "");
			ft = ft.replace(
					"<?trs-parser SegmentMark=\"paragraph\" NewLineMark=\"br\" HitShowMark=\"TRSHL\" FilterCData=\"yes\"?>",
					"");
			ft = ft.replace("<cn-patent-document lang=\"ZH\" country=\"CN\">", "");
			ft = ft.replace("<application-body lang=\"CN\" country=\"CN\">", "");
			ft = ft.replace("<description>", "");
			ft = ft.replace("</description>", "");
			ft = ft.replace("</application-body>", "");
			ft = ft.replace("</cn-patent-document>", "");

			if (patentInfo.getFt().toUpperCase().indexOf(".GIF") > -1
					|| patentInfo.getFt().toUpperCase().indexOf(".TIF") > -1) {
				// http://pic.cnipr.com/xmlData/xx/20001213/00206609.2/Y0020660900021.GIF
				// searchFunc.replaceInnerPICXML(String chrFigureVirtualPath ,String
				// patent_type,String tmpString, String strAN, String strPD)

				ft = searchFunc.replaceInnerPICXML("http://pic.cnipr.com/xmlData/", leixing.toLowerCase(), ft,
						patentInfo.getAn().toUpperCase().replace("CN", ""), patentInfo.getPd());

				// System.out.println(ft);
				// img-content="drawing" img-format="tif" orientation="portrait" inline="yes"
				ft = ft.replace(" img-content=\"drawing\"", "");
				ft = ft.replace(" img-format=\"tif\"", "");
				ft = ft.replace(" orientation=\"portrait\"", "");
				ft = ft.replace(" inline=\"yes\"", "");
			}

			// ft = ft.replace("<p id=\"", "&nbsp;&nbsp;&nbsp;&nbsp;<p id=\"");
			ft = ft.replace("file=\"", " src=\"");
			ft = ft.replace("<br />", "");
			patentInfo.setFt(ft.trim());
		}

		if (patentInfo.getClm() != null) {
			String clm = patentInfo.getClm().trim();
			clm = clm.replace("<?xml version=\"1.0\"?>", "");
			clm = clm.replace("<!DOCTYPE cn-patent-document SYSTEM \"dtd/cn-patent-document-06-10-27.dtd\"[]>", "");
			clm = clm.replace("<?xml-stylesheet type=\"text/xsl\" href=\"xsl/XSL0117new.xsl\"?>", "");
			clm = clm.replace(
					"<?trs-parser SegmentMark=\"paragraph\" NewLineMark=\"br\" HitShowMark=\"TRSHL\" FilterCData=\"yes\"?>",
					"");
			clm = clm.replace("<cn-patent-document lang=\"ZH\" country=\"CN\">", "");
			clm = clm.replace("<application-body lang=\"CN\" country=\"CN\">", "");
			clm = clm.replace("<description>", "");
			clm = clm.replace("</description>", "");
			clm = clm.replace("</application-body>", "");
			clm = clm.replace("</cn-patent-document>", "");

			if (patentInfo.getClm().toUpperCase().indexOf(".GIF") > -1
					|| patentInfo.getClm().toUpperCase().indexOf(".TIF") > -1) {

				// http://pic.cnipr.com/xmlData/xx/20001213/00206609.2/Y0020660900021.GIF
				// searchFunc.replaceInnerPICXML(String chrFigureVirtualPath ,String
				// patent_type,String tmpString,
				// String strAN, String strPD)

				clm = searchFunc.replaceInnerPICXML("http://pic.cnipr.com/xmlData/", leixing.toLowerCase(), clm,
						patentInfo.getAn().toUpperCase().replace("CN", ""), patentInfo.getPd());
			}
			// System.out.println(clm);
			clm = clm.replace("claim-text", "p");
			clm = clm.replace("<br />", "");

			patentInfo.setClm(clm.trim());
		}

		// System.out.println(patentInfo.getFtDra());
		if (patentInfo.getFtDra() != null) {
			String dra = patentInfo.getFtDra().trim();
			dra = dra.replace("<?xml version=\"1.0\"?>", "");
			dra = dra.replace("<!DOCTYPE cn-patent-document SYSTEM \"dtd/cn-patent-document-06-10-27.dtd\"[]>", "");
			dra = dra.replace("<?xml-stylesheet type=\"text/xsl\" href=\"xsl/XSL0117new.xsl\"?>", "");
			dra = dra.replace(
					"<?trs-parser SegmentMark=\"paragraph\" NewLineMark=\"br\" HitShowMark=\"TRSHL\" FilterCData=\"yes\"?>",
					"");
			dra = dra.replace("<cn-patent-document lang=\"ZH\" country=\"CN\">", "");
			dra = dra.replace("<application-body lang=\"CN\" country=\"CN\">", "");
			dra = dra.replace("<description>", "");
			dra = dra.replace("</description>", "");
			dra = dra.replace("</application-body>", "");
			dra = dra.replace("</cn-patent-document>", "");

			if (patentInfo.getFtDra().toUpperCase().indexOf(".GIF") > -1
					|| patentInfo.getFtDra().toUpperCase().indexOf(".TIF") > -1) {

				// http://pic.cnipr.com/xmlData/xx/20001213/00206609.2/Y0020660900021.GIF
				// searchFunc.replaceInnerPICXML(String chrFigureVirtualPath ,String
				// patent_type,String tmpString,String strAN, String strPD)

				dra = searchFunc.replaceInnerPICXML("http://pic.cnipr.com/xmlData/", leixing.toLowerCase(), dra,
						patentInfo.getAn().toUpperCase().replace("CN", ""), patentInfo.getPd());
			}

			// dra = dra.replace("<figure id=\"f0001\" num=\"0001\" figure-labels=\"图1\">",
			// "");
			// dra = dra.replace("</figure>", "");
			dra = dra.replace("file=\"", " class=\"img-thumbnail img-responsive\" src=\"");
			dra = dra.replace("<br />", "");
			// System.out.println(clm);
			patentInfo.setFtDra(dra.trim());
		}
		// http://pic.cnipr.com:8080/XmlData/fm/19970521/95118304.4/A9511830400101.gif
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>) application.get("channelInfoList_fr");
		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>) application.get("channelInfoList_cn");
		List<ChannelInfo> channelInfoList_sx = (List<ChannelInfo>) application.get("channelInfoList_sx");// 全部CN

		HashMap<String, String> hm_channel = new HashMap<String, String>();
		for (ChannelInfo ci : channelInfoList_fr) {
			// System.out.println(ci.getIntChannelID());
			hm_channel.put(ci.getChrTRSTable(), ci.getChrChannelName());
		}
		// HashMap<String,String> hm_channel_cn = new HashMap<String,String>();
		for (ChannelInfo ci : channelInfoList_cn) {
			// System.out.println(ci.getIntChannelID());
			hm_channel.put(ci.getChrTRSTable(), ci.getChrChannelName());
		}
		for (ChannelInfo ci : channelInfoList_sx) {
			// System.out.println(ci.getIntChannelID());
			hm_channel.put(ci.getChrTRSTable(), ci.getChrChannelName());
		}
		String NationTypeName = hm_channel.get(patentInfo.getSectionName());

		if (NationTypeName == null) {
			Iterator iter = hm_channel.entrySet().iterator();
			while (iter.hasNext()) {
				Map.Entry entry = (Map.Entry) iter.next();
				String key = (String) entry.getKey();
				String val = (String) entry.getValue();

				if (key.indexOf(patentInfo.getSectionName()) > -1) {
					NationTypeName = val;
					break;
				}
			}
		}
		patentInfo.setEstype(NationTypeName);
		////////////////////////////////////////////////////////////////////////////////////////////////////////////
		/**
		 * 如果
		 */
		if (patentInfo == null) {
			request.setAttribute("search_error", "对不起,没有找到相应的检索结果");
			return ERROR;
		}
		request.setAttribute("patentInfo", patentInfo);
		session.setAttribute("patentInfo", patentInfo);

		// searchFunc.writeXML(xml_path,patentInfo.getAn(),"ft",patentInfo.getFt());
		// searchFunc.writeXML(xml_path,patentInfo.getAn(),"clm",patentInfo.getClm());

		/*
		 * if(strSources.indexOf("patent")==-1) {
		 * searchFunc.writeXML(xml_path,patentInfo.getAn(),"ft",patentInfo.getFt());
		 * searchFunc.writeXML(xml_path,patentInfo.getAn(),"clm",patentInfo.getClm());
		 * searchFunc.writeXML(xml_path,patentInfo.getAn(),"dra",patentInfo.getFtDra());
		 * }
		 */

		// System.out.println("----------------------------------------------------");
		// System.out.println("patentInfo.getAn() = " + patentInfo.getAn());
		// System.out.println("patentInfo.getPn() = " + patentInfo.getPn());

		if (b_ShowBase64) {
			patentInfo = convertPatentbase64(patentInfo, true);
		}

		List<PatentInfo> patentList = new ArrayList<PatentInfo>();
		patentList.add(patentInfo);
		// request.getSession().setAttribute("list",patentList);
		request.getSession().setAttribute("onePatentInfo", patentList);

		String dbName = detailResponse.getSectionName();
		request.setAttribute("dbName", dbName);

		// 查看是否有摘要附图
		String an = patentInfo.getAn();
		String pd = patentInfo.getPd();
		if (an != null && !an.equals("") && pd != null && !pd.equals("")) {
			String shortAN = Util.getShortAN(pd, an);

			if (an.indexOf(".") > -1) {
				shortAN = an.substring(0, an.indexOf("."));
			}

			shortAN = shortAN.toUpperCase().replace("CN", "");

			Date start = new Date();

			String figureURL = "XmlData/" + Util.getPatentType(dbName) + "/" + pd.replaceAll("\\.", "") + "/"
					+ an.toUpperCase().replace("CN", "") + "/" + shortAN + ".tif";

			if (SetupAccess.getProperty(SetupConstant.ZHAIYAOFUTUTYPE) != null
					&& SetupAccess.getProperty(SetupConstant.ZHAIYAOFUTUTYPE).equals("gif"))
				figureURL = "XmlData/" + Util.getPatentType(dbName) + "/" + pd.replaceAll("\\.", "") + "/"
						+ an.toUpperCase().replace("CN", "") + "/" + shortAN + ".gif";

			figureURL = figureURL.replace("/.gif", ".gif");

			String inUrl = DataAccess.getProperty("PicIntranetServerURL") + figureURL;

			if (Util.isPicExis(inUrl)) {
				request.setAttribute("figureURL", DataAccess.getProperty("PicFuTuServerURL") + figureURL);
			}

			Date end = new Date();
			CoreBizLogger.LogInfo("detailSearch time is : " + (end.getTime() - start.getTime()) + "ms");
			CoreBizLogger.LogInfo("figureURL is : " + figureURL);
		}

		request.setAttribute("scyyzzlList", detailResponse.getScyyzzlList());// 审查员引证专利文献
		request.setAttribute("scyyzfzlList", detailResponse.getScyyzfzlList());// 审查员引证非专利文献
		request.setAttribute("sqryzzlList", detailResponse.getSqryzzlList());// 被引证文献
		request.setAttribute("scybyzzlList", detailResponse.getScybyzzlList());// 被引证文献
		request.setAttribute("sqrbyzzlList", detailResponse.getSqrbyzzlList());// 被引证文献

		// System.out.println(patentInfo.getAb());
		/*
		 * Page page = new Page();
		 * page.setPageCount(Long.toString(detailResponse.getRecordCount()));
		 * page.setPageIndex(""); request.setAttribute("page", page);
		 */
		// String sqAndFmFlag = request.getParameter("sqFlag");

		/**
		 * 增加是否需要在授权和发明中进行切换
		 */
		// 20160213

		if (!area.equalsIgnoreCase("fr")) {
			// if(SetupAccess.getProperty(SetupConstant.VIEWGB)!=null &&
			// SetupAccess.getProperty(SetupConstant.VIEWGB).equals("1"))
			// {
			// try {
			// GBIndex gbindex = searchFunc.getGBIndex(an, pd);
			// request.setAttribute("GBIndex", gbindex);
			// } catch (Exception e) {
			// e.printStackTrace();
			// }
			// }

			if (dbName.toLowerCase().startsWith("wgzl")) {
				///////////////////////////////////////////////////////////////////////////////////////
				String strPages = patentInfo.getPages();
				// String pubPath = APIUtils.getProperty("tiffDownload", true) +
				// patentInfo.getTifDistributePath();
				String pubPath = DataAccess.getProperty("PicServerURL") + patentInfo.getTifDistributePath();

				pubPath = pubPath.replace("books", "ThumbnailImage");
				List<String> imagePubPathList = new ArrayList<String>();
				if (strPages == null || "".equals(strPages)) {
					// break;
				}
				int intPages = Integer.parseInt(strPages);
				DecimalFormat df = new DecimalFormat("000000");
				int pageno = 1;
				for (int i = 1; i <= intPages; i++) {
					imagePubPathList.add(pubPath + "/" + df.format((pageno - 1) * 9 + i) + ".jpg");
				}
				request.setAttribute("ThumbnailImagePubPathList", imagePubPathList);

				////////////////////////////////////////////////////////////////////////////////////////
				request.setAttribute("wggb", detailResponse.getWggbInfo());
				// return mapping.findForward("wg_detailPage");
				return INPUT;
			}

			// if (sqAndFmFlag != null && "Y".equals(sqAndFmFlag)) {
			// request.setAttribute("sqFlag", "Y");
			//// return new ActionForward("/jsp/zljs/detailPage_cn_sq.jsp");
			// return NONE;
			// } else {
			//// return mapping.findForward("cn_detailPage");
			// return SUCCESS;
			// }
			return SUCCESS;
		} else {
			// return mapping.findForward("fr_detailPage");
			return NONE;
		}

		// String SUCCESS = "success";
		// String NONE = "none";
		// String ERROR = "error";
		// String INPUT = "input";
		// String LOGIN = "login";
	}

	// public ActionForward showInstructionPage(ActionMapping mapping,
	// ActionForm form, HttpServletRequest request,
	// HttpServletResponse response) {
	// String strUrl = request.getParameter("strUrl");
	// String strAn = request.getParameter("strAn");
	// String totalPages = request.getParameter("totalPages");
	//
	// request.setAttribute("tifDistributePath", strUrl);
	// request.setAttribute("an", strAn);
	// request.setAttribute("pages", totalPages);
	//
	// return mapping.findForward("instructionPage");
	// }

	// public ActionForward viewLegalStatus(ActionMapping mapping,
	// ActionForm form, HttpServletRequest request,
	// HttpServletResponse response) {

	// public String legalStatusSearchPage() throws Exception{
	// ActionContext cxt = ActionContext.getContext();
	// HttpServletRequest request =
	// (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
	// HttpSession session = request.getSession();
	//
	// return SUCCESS;
	// }

	public String viewLegalStatus() throws Exception {
		ActionContext cxt = ActionContext.getContext();
		Map<String, Object> application = cxt.getApplication();
		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpSession session = request.getSession();

		String strAn = request.getParameter("strAn");

		String wap = request.getParameter("wap") == null ? "" : request.getParameter("wap");
		// ISearchFunc client = CoreBizClient.getCoreBizClient();
		List<LegalStatusInfo> legalStatusInfoList = null;
		try {
			String strWhere = "";
			if (strAn.toUpperCase().startsWith("CN")) {
				strAn = strAn.substring(2);
			}
			if (strAn.indexOf(".") == 0) {
				strAn = strAn + "%";
			}

			strWhere = "法律状态申请号=(" + strAn + ") or 法律状态申请号=(CN" + strAn + ")";

			// String strWhere = "申请号=(" + strAn.replace("CN", "") + ")";

			// if(SetupAccess.getProperty(SetupConstant.VIEWLEGALSTATUSCN)!=null &&
			// SetupAccess.getProperty(SetupConstant.VIEWLEGALSTATUSCN).equals("1"))
			// strWhere = "申请号=(" + strAn + ")";

			legalStatusInfoList = searchFunc.legalStatusSearch(wap, strWhere);
		} catch (Exception e) {
			// ActionMessages errors = new ActionMessages();
			// errors.add(Constant.SEARCH_AUTHEN_ERROR, new ActionMessage(
			// "search.authen.error"));
			// this.saveErrors(request, errors);
			request.setAttribute("search_error", "法律状态检索出错," + e.getMessage());
			return ERROR;
		}

		request.setAttribute("legalStatusInfoList", legalStatusInfoList);
		request.setAttribute("strAn", strAn);
		// 记录法律状态log74日志
		if (Log74Access.getProperty(Log74Util.getLOG_OPEN()) != null
				&& Log74Access.getProperty(Log74Util.getLOG_OPEN()).equals("1")) {
			if (request.getSession().getAttribute(Constant.APP_USER_ID) != null) {
				String operateUserId = (String) request.getSession().getAttribute(Constant.APP_USER_ID);
				IprUser ipruser = sysUserFunc.getUserInfo(Integer.parseInt(operateUserId));
				try {

					Log74Util.log_func("2500", operateUserId + "", ipruser.getIntGroupId() + "",
							com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), DateUtil.getCurrentTimeStr(), "",
							"");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return SUCCESS;
	}

	// public ActionForward showSearchForm(ActionMapping mapping, ActionForm form,
	// HttpServletRequest request, HttpServletResponse response)
	// throws Exception {

	public String showSearchForm() throws Exception {
		ActionContext cxt = ActionContext.getContext();
		Map<String, Object> application = cxt.getApplication();
		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);

		String area = request.getParameter("area");

		// 快速进入检索频道时，channelId有值,这时应该通过channelId判断出属于中国还是国外
		String channelId = request.getParameter("channelId");
		if (channelId != null && !channelId.equals("")) {
			if (channelId.equals("1")) { // 1 为中国
				area = "cn";
				channelId = "14,15,16";
			} else if (channelId.equals("34,35,36")) {
				area = "cn";
			} else { // 其他为国外
				area = "fr";
			}
		} else if (area == null && (channelId == null || channelId.equals(""))) {
			area = "cn";
			channelId = "14,15,16";
		} else if (channelId != null && channelId.equals("")) {
			channelId = "14,15,16";
		}

		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>) application.get("channelInfoList_cn");// 全部CN
		if (channelInfoList_cn == null) {
			channelInfoList_cn = channelFunc.getChannels("cn");
			application.put("channelInfoList_cn", channelInfoList_cn);
		}

		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>) application.get("channelInfoList_fr");// 全部FR
		if (channelInfoList_fr == null) {
			channelInfoList_fr = channelFunc.getChannels("fr");
			application.put("channelInfoList_fr", channelInfoList_fr);
		}

		List<ChannelInfo> channelInfoList = null;
		if (area.equals("cn")) {
			channelInfoList = channelInfoList_cn;
		} else {
			channelInfoList = channelInfoList_fr;
		}
		// List<ChannelInfo> channelInfoList = channelFunc.getChannels(area);

		if (channelId != null) {
			for (ChannelInfo channelInfo : channelInfoList) {

				if (channelId.contains(Integer.toString(channelInfo.getIntChannelID()))) {
					channelInfo.setChrCheck("checked");
				} else {
					channelInfo.setChrCheck("");
				}
			}
		}

		request.setAttribute("presearchword", request.getParameter("strWhere"));
		request.setAttribute("julei", request.getParameter("julei"));
		request.setAttribute("fenxi", request.getParameter("fenxi"));
		request.setAttribute("channelTag", channelInfoList);
		request.setAttribute("channelId", channelId);
		request.setAttribute("secondOrFilter", request.getParameter("secondOrFilter"));
		request.setAttribute("cizi", request.getParameter("iOption"));
		request.setAttribute("trsLastWhere", request.getParameter("trsLastWhere"));

		if (area.equals("cn"))
			return Action.SUCCESS;
		else
			// return mapping.findForward("frformPage");
			return Action.NONE;
	}

	// public ActionForward showLogicForm(ActionMapping mapping, ActionForm form,
	// HttpServletRequest request, HttpServletResponse response) {
	public String showLogicForm() throws Exception {
		ActionContext cxt = ActionContext.getContext();
		Map<String, Object> application = cxt.getApplication();
		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();

		String area = request.getParameter("area");
		request.setAttribute("area", area);

		String strChannels = request.getParameter("strChannels");

		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>) application.get("channelInfoList_cn");// 全部CN
		if (channelInfoList_cn == null) {
			channelInfoList_cn = channelFunc.getChannels("cn");
			application.put("channelInfoList_cn", channelInfoList_cn);
		}

		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>) application.get("channelInfoList_fr");// 全部FR
		if (channelInfoList_fr == null) {
			channelInfoList_fr = channelFunc.getChannels("fr");
			application.put("channelInfoList_fr", channelInfoList_fr);
		}

		List<ChannelInfo> channelInfoList = null;
		if (area.equals("cn")) {
			channelInfoList = channelInfoList_cn;
		} else {
			channelInfoList = channelInfoList_fr;
		}

		// List<ChannelInfo> channelInfoList = channelFunc.getChannels(area);

		if (strChannels != null) {
			for (ChannelInfo channelInfo : channelInfoList) {
				if (strChannels.contains(Integer.toString(channelInfo.getIntChannelID()))) {
					channelInfo.setChrCheck("checked");
				} else {
					channelInfo.setChrCheck("");
				}
			}
		}
		request.setAttribute("presearchword", request.getParameter("strWhere"));
		request.setAttribute("channelTag", channelInfoList);
		request.setAttribute("secondOrFilter", request.getParameter("secondOrFilter"));
		request.setAttribute("cizi", request.getParameter("iOption"));

		if (area.equals("cn"))
			return Action.SUCCESS;
		else
			return Action.NONE;

		// return Action.SUCCESS;
	}

	/**
	 * 法律状态检索
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	// public ActionForward showLegalStatusSearchForm(ActionMapping mapping,
	// ActionForm form, HttpServletRequest request,
	// HttpServletResponse response) {
	// return mapping.findForward("legalStatusSearchPage");
	// }
	// showFlztSearchForm
	public String showFlztSearchForm() throws Exception {
		return SUCCESS;
	}

	public String showSemanticSearchForm() throws Exception {
		return SUCCESS;
	}
	
	public String showBatchSearchForm() throws Exception {
		return SUCCESS;
	}

	// public ActionForward legalStatusSearch(ActionMapping mapping,
	// ActionForm form, HttpServletRequest request,
	// HttpServletResponse response) {

	public String legalStatusSearch() throws Exception {
		ActionContext cxt = ActionContext.getContext();
		Map<String, Object> application = cxt.getApplication();
		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();

		String strWhere = request.getParameter("strWhere");
		String pageIndex = request.getParameter("pageIndex");

		if (pageIndex == null || pageIndex.equals("")) {
			pageIndex = "1";
		}

		String username = (String) session.getAttribute("username");
		if (Integer.parseInt(pageIndex) > 30 && username.equalsIgnoreCase("guest")) {
			request.setAttribute("search_error", "游客模式仅能浏览30页，如有需要请拨打4001880860");
			return SUCCESS;
		}

		// System.out.println("strWhere="+strWhere);
		/**
		 * 批量检索
		 */
		/*
		 * if(strWhere.contains("申请号")) { String afterswhere = "";
		 * if(strWhere.contains("and")) { afterswhere =
		 * strWhere.substring(strWhere.indexOf("and")); strWhere =
		 * strWhere.substring(0,strWhere.indexOf("and")); } if(strWhere!=null ) {
		 * strWhere = strWhere.replace(")" , ""); strWhere = strWhere.trim();
		 * if(strWhere.endsWith(",")) strWhere = strWhere.replace(",", ""); strWhere =
		 * strWhere+")"; } String[] array =
		 * StringUtil.splitStringToArray(strWhere,"\r\n" ); String newWhere = "";
		 * for(int m=0;m<array.length;m++) { if(StringUtil.hasText(array[m])) { if(m==
		 * (array.length-1)) newWhere +=array[m].trim(); else newWhere
		 * +=array[m].trim()+","; } }
		 * 
		 * if(newWhere.endsWith(",)")) newWhere = newWhere.replace(",)", ")");
		 * 
		 * strWhere = newWhere + " "+ afterswhere;
		 * System.out.println("newWhere="+strWhere); }
		 */
		long startIndex = (Long.parseLong(pageIndex) - 1) * Constant.PAGERECORD;

		String wap = request.getParameter("wap") == null ? "" : request.getParameter("wap");
		if (wap.equals("1")) {
			// System.out.println("====strWhere="+strWhere);
			strWhere = java.net.URLDecoder.decode(strWhere, "UTF-8");
			// strWhere = com.cnipph.util.Util.unescape(strWhere);
		}

		// 本次显示最后一条记录下标
		long endIndex = startIndex + Constant.PAGERECORD;

		LegalStatusResponse searchResponse = null;
		try {
			searchResponse = searchFunc.legalStatusSearch(wap, strWhere, startIndex, endIndex);
		} catch (Exception e) {
			// ActionMessages errors = new ActionMessages();
			// errors.add(Constant.SEARCH_AUTHEN_ERROR, new ActionMessage(
			// "search.authen.error"));
			// this.saveErrors(request, errors);
			request.setAttribute("search_error", "法律状态检索出错," + e.getMessage());
			return ERROR;
		}

		request.setAttribute("legalStatusInfoList", searchResponse.getLegalStatusInfoList());

		String count = Integer
				.toString((int) java.lang.Math.ceil((double) searchResponse.getRecordCount() / Constant.PAGERECORD));

		Page page = new Page();
		page.setPageCount(count);
		page.setPageIndex(pageIndex);
		request.setAttribute("pageCount", count);
		request.setAttribute("lawpage", page);
		request.setAttribute("totalRecord", searchResponse.getRecordCount());
		request.setAttribute("strWhere", strWhere);

		// 记录法律状态log74日志
		if (Log74Access.getProperty(Log74Util.getLOG_OPEN()) != null
				&& Log74Access.getProperty(Log74Util.getLOG_OPEN()).equals("1")) {
			if (request.getSession().getAttribute(Constant.APP_USER_ID) != null) {
				String operateUserId = (String) request.getSession().getAttribute(Constant.APP_USER_ID);
				IprUser ipruser = sysUserFunc.getUserInfo(Integer.parseInt(operateUserId));
				try {
					if (searchResponse != null && searchResponse.getRecordCount() > 0)
						Log74Util.log_func("2500", operateUserId + "", ipruser.getIntGroupId() + "",
								com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), DateUtil.getCurrentTimeStr(),
								"", searchResponse.getRecordCount() + "");
					else
						Log74Util.log_func("2500", operateUserId + "", ipruser.getIntGroupId() + "",
								com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), DateUtil.getCurrentTimeStr(),
								"", "");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		// return mapping.findForward("legalStatusSearchResult");
		return SUCCESS;
	}

	public SemanticSearch getSemanticSearchImpl() {
		return semanticSearchImpl;
	}

	public void setSemanticSearchImpl(SemanticSearch semanticSearchImpl) {
		this.semanticSearchImpl = semanticSearchImpl;
	}

	/**
	 * 同义词检索 : 检索表格显示
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	// public ActionForward showSynonymSearchForm(ActionMapping mapping,
	// ActionForm form, HttpServletRequest request,
	// HttpServletResponse response) {
	// return mapping.findForward("synonym");
	// }

	/**
	 * 同义词检索
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	// public ActionForward synonymSearch(ActionMapping mapping, ActionForm form,
	// HttpServletRequest request, HttpServletResponse response) {
	// String searchword = request.getParameter("search");
	//
	// SynonymSearchResponse synonymSearchResponse = null;
	//
	// try {
	// synonymSearchResponse = searchFunc.synonymSearch("SYNONYM_UTF8",
	// searchword);
	// } catch (Exception e) {
	// request.setAttribute("search_error", "同义词检索出错," + e.getMessage());
	// return mapping.findForward("searchError");
	// }
	//
	// request.setAttribute("searchword", searchword);
	// request.setAttribute("recordCount", synonymSearchResponse
	// .getRecordCount());
	// request.setAttribute("strSynonym", synonymSearchResponse
	// .getStrSynonym());
	//
	// return mapping.findForward("synonym");
	// }

	/**
	 * 分词检索 : 检索表格显示
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	// public ActionForward showParticipleSearchForm(ActionMapping mapping,
	// ActionForm form, HttpServletRequest request,
	// HttpServletResponse response) {
	// return mapping.findForward("participle");
	// }

	/**
	 * 分词检索
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	// public ActionForward participleSearch(ActionMapping mapping,
	// ActionForm form, HttpServletRequest request,
	// HttpServletResponse response) {
	// String searchword = request.getParameter("search");
	//
	// ParticipleSearchResponse participleSearchResponse = null;
	//
	// try {
	// participleSearchResponse = searchFunc.participleSearch(
	// "SEGMENT_UTF8", "system", searchword + "%");
	// } catch (Exception e) {
	// request.setAttribute("search_error", "分词检索出错," + e.getMessage());
	// return mapping.findForward("searchError");
	// }
	//
	// request.setAttribute("searchword", searchword);
	// request.setAttribute("recordCount", participleSearchResponse
	// .getRecordCount());
	// request.setAttribute("participle", participleSearchResponse
	// .getStrParticiple());
	//
	// return mapping.findForward("participle");
	// }

	/*
	 * public ActionForward reportSearch(ActionMapping mapping, ActionForm form,
	 * HttpServletRequest request, HttpServletResponse response) {
	 * 
	 * // ---------------增加防止频繁刷新网页--------------- StopRefresh stopRefresh = new
	 * StopRefresh();
	 * 
	 * stopRefresh.redirectPage = request.getContextPath() + "/stopRefresh.jsp"; //
	 * 单次屏蔽页，即用户还未超过当天限定次数 stopRefresh.blackPage = request.getContextPath() +
	 * "/blackPage.jsp"; // 用户当天操作超限 try { if (stopRefresh.stopRefreshPage(request,
	 * response)) { return null; } } catch (IOException e1) { e1.printStackTrace();
	 * } // -----------------------------------------------
	 * 
	 * String area = request.getParameter("area"); String strWhere =
	 * request.getParameter("strWhere"); String strSources =
	 * request.getParameter("strSources"); String filterChannel =
	 * request.getParameter("filterChannel"); if (filterChannel != null &&
	 * !filterChannel.equals("")) { strSources = filterChannel; } String
	 * strSortMethod = request.getParameter("strSortMethod"); String strDefautCols =
	 * request.getParameter("strDefautCols"); String strStat =
	 * request.getParameter("strStat"); if (strStat == null) strStat = "";
	 * 
	 * String strSynonymous = request.getParameter("synonymous"); if (strSynonymous
	 * == null) strSynonymous = "";
	 * 
	 * String iOption = request.getParameter("iOption"); String iHitPointType =
	 * request.getParameter("iHitPointType"); String bContinue =
	 * request.getParameter("bContinue"); String index =
	 * request.getParameter("index"); if (index == null || "".equals(index)) { index
	 * = "0"; }
	 * 
	 * DetailSearchResponse detailResponse = null; // List<DetailSearchResponse>
	 * detailResponseList = null; try {
	 * 
	 * String[] strAns = request.getParameterValues("strAn");
	 * 
	 * // if(strAns!=null && strAns.length>0) { // detailResponseList = new
	 * ArrayList<DetailSearchResponse>(); //for(int i=0;i<strAns.length;i++) {
	 * detailResponse = detailResponse = semanticSearchImpl.getSemanticResult(
	 * strSources, strWhere, strSortMethod, strStat, strDefautCols,
	 * Integer.parseInt(iOption), Integer .parseInt(iHitPointType), false, Long
	 * .parseLong(index), strSynonymous, ""); } }
	 * 
	 * 
	 * } catch (Exception e) { request.setAttribute("search_error", "单篇检索报告出错," +
	 * e.getMessage()); return mapping.findForward("searchError"); }
	 * 
	 * PatentInfo patentInfo = detailResponse.getPatentInfo();
	 * 
	 * // 如果
	 * 
	 * if (patentInfo == null) { request.setAttribute("search_error",
	 * "对不起,没有找到相应的检索结果"); return mapping.findForward("searchError"); }
	 * request.setAttribute("patentInfo", patentInfo);
	 * 
	 * String dbName = detailResponse.getSectionName();
	 * request.setAttribute("dbName", dbName);
	 * 
	 * // 查看是否有摘要附图 String an = patentInfo.getAn(); String pd = patentInfo.getPd();
	 * String figureURL = null; String imageURL = null;
	 * 
	 * if (an != null && !an.equals("") && pd != null && !pd.equals("")) { String
	 * shortAN = Util.getShortAN(pd, an);
	 * 
	 * 
	 * if (an.indexOf(".") > -1) { shortAN = an.substring(0, an.indexOf(".")); }
	 * 
	 * shortAN = shortAN.toUpperCase().replace("CN", "");
	 * 
	 * Date start = new Date();
	 * 
	 * figureURL = "XmlData/" + Util.getPatentType(dbName) + "/" +
	 * pd.replaceAll("\\.", "") + "/" + an.toUpperCase().replace("CN", "") + "/" +
	 * shortAN + ".tif";
	 * 
	 * if(SetupAccess.getProperty(SetupConstant.ZHAIYAOFUTUTYPE )!=null &&
	 * SetupAccess.getProperty(SetupConstant.ZHAIYAOFUTUTYPE).equals("gif"))
	 * figureURL = "XmlData/" + Util.getPatentType(dbName) + "/" +
	 * pd.replaceAll("\\.", "") + "/" + an.toUpperCase().replace("CN", "") + "/" +
	 * shortAN + ".gif" ;
	 * 
	 * figureURL= figureURL.replace("/.gif", ".gif");
	 * 
	 * String imagetempPath = PathUtil.getAbsoluteWebPath()+"temp/image/"; File
	 * imagetempFile = new File(imagetempPath); if(imagetempFile.exists()==false)
	 * imagetempFile.mkdirs();
	 * 
	 * String inUrl =DataAccess.getProperty("PicIntranetServerURL") + figureURL;
	 * 
	 * if (Util.isPicExis(inUrl)) { figureURL =
	 * SetupAccess.getProperty("searchreportpic")+ figureURL; imageURL =
	 * SaveImage.getImageFromURL(figureURL,imagetempPath); }else { figureURL = null;
	 * } }
	 * 
	 * List<LegalStatusInfo> legalStatusInfoList = null; try { legalStatusInfoList =
	 * searchFunc.legalStatusSearch(strWhere); } catch (Exception e) {
	 * request.setAttribute("search_error", "法律状态检索出错," + e.getMessage()); return
	 * mapping.findForward("searchError"); } PatentInfoPDFCreater
	 * patentInfoPDFCreater = new PatentInfoPDFCreater();
	 * patentInfoPDFCreater.create(detailResponse,legalStatusInfoList,imageURL,
	 * response,area);
	 * 
	 * // 增加是否需要在授权和发明中进行切换
	 * 
	 * return null; }
	 */

	public ChannelDAO getChannelDAO() {
		return channelDAO;
	}

	public void setChannelDAO(ChannelDAO channelDAO) {
		this.channelDAO = channelDAO;
	}

	public ChannelFunc getChannelFunc() {
		return channelFunc;
	}

	public ExpressionFunc getExpFunc() {
		return expFunc;
	}

	public SearchFunc getSearchFunc() {
		return searchFunc;
	}
}
