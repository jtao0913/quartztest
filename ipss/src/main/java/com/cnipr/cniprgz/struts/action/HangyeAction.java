package com.cnipr.cniprgz.struts.action;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.commons.Util;
import com.cnipr.cniprgz.entity.ChannelInfo;
import com.cnipr.cniprgz.entity.NodeModel;
import com.cnipr.cniprgz.func.HangyeFunc;
import com.cnipr.cniprgz.func.NodeFunc;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.trs.usermanage.Hangye;
import com.trs.usermanage.UserManage;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class HangyeAction extends ActionSupport {

	private static final long serialVersionUID = 1813736647867980713L;
	private HangyeFunc hangyeFunc;

	public HangyeFunc getHangyeFunc() {
		return hangyeFunc;
	}

	public void setHangyeFunc(HangyeFunc hangyeFunc) {
		this.hangyeFunc = hangyeFunc;
	}

	public NodeFunc nodeFunc;

	public NodeFunc getNodeFunc() {
		return nodeFunc;
	}

	public void setNodeFunc(NodeFunc nodeFunc) {
		this.nodeFunc = nodeFunc;
	}

	private String jsonresult;

	public String getJsonresult() {
		return jsonresult;
	}

	public void setJsonresult(String jsonresult) {
		this.jsonresult = jsonresult;
	}

	public String showHangyelist() throws Exception {
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		Map<String, Object> application = cxt.getApplication();

		int intAdminId = Integer.parseInt((String) request.getSession().getAttribute("userid"));

		String name = "";
		String strSequenceNum = "";
		String Expression = "";
		String FRExpression = "";
		String memo = "";

		String strPath = null;
		int intParentID = 0;

		String parentID = request.getParameter("parentid");
		if (parentID == null || parentID.equals("")) {
			parentID = "0";
			intParentID = 0;
		} else {
			intParentID = Integer.parseInt(parentID);
		}

		int intID = 0;

		String intType = request.getParameter("intType");
		if (intType == null || intType.equals(""))
			intType = "1";

		String doing = "";
		Hangye hangye = new Hangye();

		/*
		 * try{ if ((request.getParameter("parentid") == null||
		 * request.getParameter("parentid").equals("")) // &&
		 * (request.getParameter("id") == null|| request.getParameter("id").equals(""))
		 * && (request.getParameter("select") == null||
		 * request.getParameter("select").equals("")) && (request.getParameter("delete")
		 * == null|| request.getParameter("delete").equals(""))) {
		 * strPath="<a href=\"list.jsp?parentid=0&intType="+intType+"\">根节点</a>";
		 * intParentID = 0; } else { if (request.getParameter("parentid") != null &&
		 * !request.getParameter("parentid").equals("")) {//导航条的request int int0 =
		 * Integer.parseInt(request.getParameter("parentid"));
		 * strPath="<a href=\"list.jsp?parentid=0&intType="
		 * +intType+"\" onClick=\"flushmainfr()\">根节点</a>" + " \\ " + ;
		 * intParentID=int0; } } }catch(Exception ex){ ex.printStackTrace(); }
		 */
		/*
		 * String strmsg=""; String[]
		 * arrEnterpriseInfo=UserManage.getEnterpriseInfo(intAdminId); String
		 * chrEnterpriseName=arrEnterpriseInfo[0]; int
		 * intMaxSearchCount=Integer.parseInt(arrEnterpriseInfo[1]); int
		 * intMaxNavCount=Integer.parseInt(arrEnterpriseInfo[2]); int
		 * intMaxUserCount=Integer.parseInt(arrEnterpriseInfo[3]);
		 */

		strPath = hangye.getPath(intParentID, Integer.parseInt(intType));
		// String[]
		// arr=hangye.getTradeList(intParentID,intAdminId,Integer.parseInt(intType));
		List<NodeModel> list = nodeFunc.getDiyNodesByParent(intParentID, intType, "");

		JSONArray json = JSONArray.fromObject(list);// 将list对象转换成json类型数据

		jsonresult = "success##" + intParentID + "##" + strPath + "##" + json.toString();// 给result赋值，传递给页面

		return SUCCESS;
	}

	public String getNodeInfoByID() {
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		Map<String, Object> application = cxt.getApplication();

		String nodeId = request.getParameter("nodeId");
		String treeType = request.getParameter("treeType");

		NodeModel node = nodeFunc.getNodeInfoByID(treeType, nodeId);

//		getPatentTableName
		String strSources = Util.getPatentTable(application, node.getCnTrsTable());
		String strTRSTableName = Util.getPatentTableName(application, strSources);		
		node.setCnTrsTableName(strTRSTableName);
		
		strSources = Util.getPatentTable(application, node.getEnTrsTable());
		strTRSTableName = Util.getPatentTableName(application, strSources);
		node.setEnTrsTableName(strTRSTableName);
		
		JSONObject json = JSONObject.fromObject(node);// 将list对象转换成json类型数据

		jsonresult = "success##" + json.toString();// 给result赋值，传递给页面

		return SUCCESS;
	}

	public String addExpNode() throws Exception {
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		Map<String, Object> application = cxt.getApplication();
		
//		String state = request.getParameter("state");
//		String expId = request.getParameter("expid");
//		expFunc.updateState(Integer.parseInt(expId),Integer.parseInt(state));
		
		int intAdminId = Integer.parseInt((String) request.getSession().getAttribute("userid"));

		String parentID = (request.getParameter("parentid")==null||request.getParameter("parentid").trim().equals("")) ? "0" : request.getParameter("parentid");

		int intParentID = Integer.parseInt(parentID);

		// System.out.println("parentID="+parentID);
		// strSearchData=searchData.getSearchWord();
		// strSearchChannels = searchData.getSearchChannel();
		// int
		// intMaxSearchCount=request.getAttribute("intMaxSearchCount")==null?0:Integer.parseInt((String)request.getAttribute("intMaxSearchCount"));

		int id = 0;
		String action = "";
		String chrName = "";
		int intSequenceNum = 0;
		// String chrMemo="";
		String chrExpression = "";
		String chrFRExpression = "";

		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>) application.get("channelInfoList_cn");//channelInfoList_cn
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>) application.get("channelInfoList_fr");

		String allCNChannelIDs = "";
		String allFRChannelIDs = "";

		Iterator<ChannelInfo> iter = channelInfoList_cn.iterator();
		while (iter.hasNext()) {
			ChannelInfo ci = iter.next();

//			setChrCheck
			if (ci.getChrCheck() != null && ci.getChrCheck().equalsIgnoreCase("checked")) {
				if (!allCNChannelIDs.equals("")) {
					allCNChannelIDs += ",";
				}
				allCNChannelIDs += ci.getIntChannelID();
			}
		}
		if (allCNChannelIDs.endsWith(",")) {
			allCNChannelIDs = allCNChannelIDs.substring(0, allCNChannelIDs.length() - 1);
		}

		iter = channelInfoList_fr.iterator();
		while (iter.hasNext()) {
			ChannelInfo ci = iter.next();

			if (ci.getChrCheck() != null && ci.getChrCheck().equalsIgnoreCase("checked")) {
				if (!allFRChannelIDs.equals("")) {
					allFRChannelIDs += ",";
				}
				allFRChannelIDs += ci.getIntChannelID();
			}
		}
		if (allFRChannelIDs.endsWith(",")) {
			allFRChannelIDs = allFRChannelIDs.substring(0, allFRChannelIDs.length() - 1);
		}

		String chrCNChannels = (request.getParameter("CNChannels") == null
				|| ((String) request.getParameter("CNChannels")).trim().equals("")) ? allCNChannelIDs
						: (String) request.getParameter("CNChannels");
		// System.out.println("值--："+chrCNChannels);
		String chrFRChannels = (request.getParameter("FRChannels") == null
				|| ((String) request.getParameter("FRChannels")).trim().equals("")) ? allFRChannelIDs
						: (String) request.getParameter("FRChannels");
		// System.out.println("值--："+chrFRChannels);

		if (request.getAttribute("id") != null && !request.getAttribute("id").equals("")) {
			id = Integer.parseInt((String) request.getAttribute("id"));
		}
		// if (request.getAttribute("action") != null &&
		// !request.getAttribute("action").equals("")){
		// action=(String)request.getAttribute("action");}

		String intType = request.getParameter("intType");
		if (intType == null || intType.equals(""))
			intType = "1";
		// out.println("<br>");
		// out.println("action : " + action);
		// out.println("<br>");

		intSequenceNum = request.getAttribute("SequenceNum") == null ? 0
				: Integer.parseInt((String) request.getAttribute("SequenceNum"));
		// String chrCNChannelNames=(request.getAttribute("CNChannels")==null ||
		// ((String)request.getAttribute("CNChannels")).trim().equals(""))?"14,15,16":(String)request.getAttribute("CNChannels");
		// String chrFRChannelNames=(request.getAttribute("FRChannels")==null ||
		// ((String)request.getAttribute("FRChannels")).trim().equals(""))?"18,19,20,21,22,23,24,25":(String)request.getAttribute("FRChannels");

		// chrExpression =
		// request.getAttribute("chrExpression")==null?"":(String)request.getAttribute("chrExpression");
		// chrFRExpression =
		// request.getAttribute("chrFRExpression")==null?"":(String)request.getAttribute("chrFRExpression");

		chrExpression = request.getParameter("chrExpression") == null ? ""
				: (String) request.getParameter("chrExpression");
		chrFRExpression = request.getParameter("chrFRExpression") == null ? ""
				: (String) request.getParameter("chrFRExpression");

		/*
		 * if(chrExpression!=null && !chrExpression.equals("")){
		 * chrExpression=getSearchFormat.preprocess(chrExpression); }
		 * if(chrFRExpression!=null && !chrFRExpression.equals("")){
		 * chrFRExpression=getSearchFormat.preprocess(chrFRExpression); }
		 */
		// chrExpression = chrExpression.replaceAll("'","''").trim();
		// chrFRExpression = chrFRExpression.replaceAll("'","''").trim();

		// if (request.getAttribute("name") != null &&
		// !request.getAttribute("name").equals(""))
		// {chrName=(String)request.getAttribute("name");}

		chrName = request.getParameter("name");
//		System.out.println(chrName);
		// if (request.getAttribute("memo") != null &&
		// !request.getAttribute("memo").equals(""))
		// {chrMemo=(String)request.getAttribute("memo");}

		String chrMemo = "";

		jsonresult = "success";// 给result赋值，传递给页面

		int ret = hangyeFunc.insertInfo(intParentID, intSequenceNum, chrName, chrMemo, chrExpression, chrFRExpression,
				chrCNChannels, chrFRChannels, intAdminId, intType);

		if (ret == -1) {
			jsonresult = "error##节点添加失败";
		}else if (ret == -2) {
			jsonresult = "error##节点名称重复，请修改后重新添加";
		}
		
		return SUCCESS;
	}

	public String editExpNode() throws Exception {
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		Map<String, Object> application = cxt.getApplication();

//		String state = request.getParameter("state");
//		String expId = request.getParameter("expid");
//		expFunc.updateState(Integer.parseInt(expId),Integer.parseInt(state));
		String parentID = (request.getParameter("parentid")==null||request.getParameter("parentid").trim().equals("")) ? "0" : request.getParameter("parentid");
		int intParentID = Integer.parseInt(parentID);
		
		int intAdminId = Integer.parseInt((String) request.getSession().getAttribute("userid"));

		String _nodeID = request.getParameter("nodeID") == null ? "0" : request.getParameter("nodeID");
		int nodeID = Integer.parseInt(_nodeID);

		// System.out.println("parentID="+parentID);
		// strSearchData=searchData.getSearchWord();
		// strSearchChannels = searchData.getSearchChannel();
		// int
		// intMaxSearchCount=request.getAttribute("intMaxSearchCount")==null?0:Integer.parseInt((String)request.getAttribute("intMaxSearchCount"));

		int id = 0;
		String action = "";
		String chrName = "";
		int intSequenceNum = 0;
		// String chrMemo="";
		String chrExpression = "";
		String chrFRExpression = "";

		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>) application.get("channelInfoList_cn");// channelInfoList_cn
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>) application.get("channelInfoList_fr");

		String allCNChannelIDs = "";
		String allFRChannelIDs = "";

		Iterator<ChannelInfo> iter = channelInfoList_cn.iterator();
		while (iter.hasNext()) {
			ChannelInfo ci = iter.next();

			// setChrCheck
			if (ci.getChrCheck() != null && ci.getChrCheck().equalsIgnoreCase("checked")) {
				if (!allCNChannelIDs.equals("")) {
					allCNChannelIDs += ",";
				}
				allCNChannelIDs += ci.getIntChannelID();
			}
		}
		if (allCNChannelIDs.endsWith(",")) {
			allCNChannelIDs = allCNChannelIDs.substring(0, allCNChannelIDs.length() - 1);
		}

		iter = channelInfoList_fr.iterator();
		while (iter.hasNext()) {
			ChannelInfo ci = iter.next();

			if (ci.getChrCheck() != null && ci.getChrCheck().equalsIgnoreCase("checked")) {
				if (!allFRChannelIDs.equals("")) {
					allFRChannelIDs += ",";
				}
				allFRChannelIDs += ci.getIntChannelID();
			}
		}
		if (allFRChannelIDs.endsWith(",")) {
			allFRChannelIDs = allFRChannelIDs.substring(0, allFRChannelIDs.length() - 1);
		}

		String chrCNChannels = (request.getParameter("CNChannels") == null
				     || ((String) request.getParameter("CNChannels")).trim().equals("")) ? allCNChannelIDs
						: (String) request.getParameter("CNChannels");
		// System.out.println("值--："+chrCNChannels);
		String chrFRChannels = (request.getParameter("FRChannels") == null
				|| ((String) request.getParameter("FRChannels")).trim().equals("")) ? allFRChannelIDs
						: (String) request.getParameter("FRChannels");
		
//		System.out.println("CNChannels值==="+request.getParameter("CNChannels"));
//		System.out.println("FRChannels值==="+request.getParameter("FRChannels"));
		
		// if (request.getAttribute("id") != null &&
		// !request.getAttribute("id").equals("")){
		// id=Integer.parseInt((String)request.getAttribute("id"));}
		// if (request.getAttribute("action") != null &&
		// !request.getAttribute("action").equals("")){
		// action=(String)request.getAttribute("action");}

		String intType = request.getParameter("intType");
		if (intType == null || intType.equals(""))
			intType = "1";
		// out.println("<br>");
		// out.println("action : " + action);
		// out.println("<br>");

		intSequenceNum = request.getAttribute("SequenceNum") == null ? 0
				: Integer.parseInt((String) request.getAttribute("SequenceNum"));
		// String chrCNChannelNames=(request.getAttribute("CNChannels")==null ||
		// ((String)request.getAttribute("CNChannels")).trim().equals(""))?"14,15,16":(String)request.getAttribute("CNChannels");
		// String chrFRChannelNames=(request.getAttribute("FRChannels")==null ||
		// ((String)request.getAttribute("FRChannels")).trim().equals(""))?"18,19,20,21,22,23,24,25":(String)request.getAttribute("FRChannels");

		// chrExpression =
		// request.getAttribute("chrExpression")==null?"":(String)request.getAttribute("chrExpression");
		// chrFRExpression =
		// request.getAttribute("chrFRExpression")==null?"":(String)request.getAttribute("chrFRExpression");

		chrExpression = request.getParameter("chrExpression") == null ? ""
				: (String) request.getParameter("chrExpression");
		chrFRExpression = request.getParameter("chrFRExpression") == null ? ""
				: (String) request.getParameter("chrFRExpression");

		/*
		 * if(chrExpression!=null && !chrExpression.equals("")){
		 * chrExpression=getSearchFormat.preprocess(chrExpression); }
		 * if(chrFRExpression!=null && !chrFRExpression.equals("")){
		 * chrFRExpression=getSearchFormat.preprocess(chrFRExpression); }
		 */
		// chrExpression = chrExpression.replaceAll("'","''").trim();
		// chrFRExpression = chrFRExpression.replaceAll("'","''").trim();

		// if (request.getAttribute("name") != null &&
		// !request.getAttribute("name").equals(""))
		// {chrName=(String)request.getAttribute("name");}

		chrName = request.getParameter("name");
//		System.out.println(chrName);
		// if (request.getAttribute("memo") != null &&
		// !request.getAttribute("memo").equals(""))
		// {chrMemo=(String)request.getAttribute("memo");}

		String chrMemo = "";

		jsonresult = "success";// 给result赋值，传递给页面

		int ret = hangyeFunc.editInfo(intParentID,nodeID, intSequenceNum, chrName, chrMemo, chrExpression, chrFRExpression,
				chrCNChannels, chrFRChannels, intAdminId,intType);

/*		if (ret != 1) {
			jsonresult = "error";
		}*/
		
		if (ret == -1) {
			jsonresult = "error##节点编辑失败";
		}else if (ret == -2) {
			jsonresult = "error##节点名称重复，请修改后重新提交";
		}

		return SUCCESS;
	}

	public int editInfo() throws Exception {
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		Map<String, Object> application = cxt.getApplication();

		// String state = request.getParameter("state");
		// String expId = request.getParameter("expid");
		// expFunc.updateState(Integer.parseInt(expId),Integer.parseInt(state));
		String parentID = (request.getParameter("parentid")==null||request.getParameter("parentid").trim().equals("")) ? "0" : request.getParameter("parentid");
		int intParentID = Integer.parseInt(parentID);
		
		int intAdminId = Integer.parseInt((String) request.getSession().getAttribute("userid"));

//		String parentID = request.getAttribute("parentid") == null ? "0" : request.getParameter("parentid");
		// System.out.println("parentID="+parentID);
		// strSearchData=searchData.getSearchWord();
		// strSearchChannels = searchData.getSearchChannel();
		int intMaxSearchCount = request.getAttribute("intMaxSearchCount") == null ? 0
				: Integer.parseInt((String) request.getAttribute("intMaxSearchCount"));

		int id = 0;
		String action = "";
		String chrName = "";
		int intSequenceNum = 0;
		String chrMemo = "";
		String chrExpression = "";
		String chrFRExpression = "";

		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>) application.get("channelInfoList_cn");
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>) application.get("channelInfoList_fr");

		String allCNChannelIDs = "";
		String allFRChannelIDs = "";

		Iterator<ChannelInfo> iter = channelInfoList_cn.iterator();
		while (iter.hasNext()) {
			ChannelInfo ci = iter.next();
			if (!allCNChannelIDs.equals("")) {
				allCNChannelIDs += ",";
			}
			allCNChannelIDs += ci.getIntChannelID();
		}

		iter = channelInfoList_fr.iterator();
		while (iter.hasNext()) {
			ChannelInfo ci = iter.next();
			if (!allFRChannelIDs.equals("")) {
				allFRChannelIDs += ",";
			}
			allFRChannelIDs += ci.getIntChannelID();
		}

		String chrCNChannels = (request.getParameter("CNChannels") == null
				|| ((String) request.getParameter("CNChannels")).trim().equals("")) ? allCNChannelIDs
						: (String) request.getParameter("CNChannels");
		// System.out.println("值--："+chrCNChannels);
		String chrFRChannels = (request.getParameter("FRChannels") == null
				|| ((String) request.getParameter("FRChannels")).trim().equals("")) ? allFRChannelIDs
						: (String) request.getParameter("FRChannels");
		// System.out.println("值--："+chrFRChannels);

		if (request.getAttribute("id") != null && !request.getAttribute("id").equals("")) {
			id = Integer.parseInt((String) request.getAttribute("id"));
		}
		if (request.getAttribute("action") != null && !request.getAttribute("action").equals("")) {
			action = (String) request.getAttribute("action");
		}

		String intType = request.getParameter("intType");
		if (intType == null || intType.equals(""))
			intType = "1";
		// out.println("<br>");
		// out.println("action : " + action);
		// out.println("<br>");

		intSequenceNum = request.getAttribute("SequenceNum") == null ? 0
				: Integer.parseInt((String) request.getAttribute("SequenceNum"));
		// String chrCNChannelNames=(request.getAttribute("CNChannels")==null ||
		// ((String)request.getAttribute("CNChannels")).trim().equals(""))?"14,15,16":(String)request.getAttribute("CNChannels");
		// String chrFRChannelNames=(request.getAttribute("FRChannels")==null ||
		// ((String)request.getAttribute("FRChannels")).trim().equals(""))?"18,19,20,21,22,23,24,25":(String)request.getAttribute("FRChannels");

		chrExpression = request.getAttribute("chrExpression") == null ? ""
				: (String) request.getAttribute("chrExpression");
		chrFRExpression = request.getAttribute("chrFRExpression") == null ? ""
				: (String) request.getAttribute("chrFRExpression");
		/*
		 * if(chrExpression!=null && !chrExpression.equals("")){
		 * chrExpression=getSearchFormat.preprocess(chrExpression); }
		 * if(chrFRExpression!=null && !chrFRExpression.equals("")){
		 * chrFRExpression=getSearchFormat.preprocess(chrFRExpression); }
		 */
		// chrExpression = chrExpression.replaceAll("'","''").trim();
		// chrFRExpression = chrFRExpression.replaceAll("'","''").trim();

		if (request.getAttribute("name") != null && !request.getAttribute("name").equals("")) {
			chrName = (String) request.getAttribute("name");
		}
		System.out.println(chrName);
		if (request.getAttribute("memo") != null && !request.getAttribute("memo").equals("")) {
			chrMemo = (String) request.getAttribute("memo");
		}

		return hangyeFunc.editInfo(intParentID, id, intSequenceNum, chrName, chrMemo, chrExpression, chrFRExpression, chrCNChannels,
				chrFRChannels, intAdminId, intType);
	}

	public int deleteAll(int intID, int intAdministerID) throws Exception {
		return hangyeFunc.deleteAll(intID, intAdministerID);
	}
	
	public int deleteExpNode() throws Exception {
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		Map<String, Object> application = cxt.getApplication();

//		String nodeId = request.getParameter("nodeId");
		
		String _nodeId = request.getParameter("nodeId");

		int nodeId = Integer.parseInt(_nodeId);		
		
		return hangyeFunc.deleteExpNode(nodeId);
	}
	
}
