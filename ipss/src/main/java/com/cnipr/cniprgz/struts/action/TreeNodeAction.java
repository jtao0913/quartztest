package com.cnipr.cniprgz.struts.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.entity.NodeModel;
import com.cnipr.cniprgz.func.NodeFunc;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class TreeNodeAction extends ActionSupport {

	private static final long serialVersionUID = 3305230153201879543L;
	public NodeFunc NodeFunc;
	
	public NodeFunc getNodeFunc() {
		return NodeFunc;
	}
	
	public void setNodeFunc(NodeFunc nodeFunc) {
		NodeFunc = nodeFunc;
	}
	
	public String getTreeNode() {
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		List<NodeModel> list = null;
//		如果是管理员则取出全部数据
//		if (StringTools.isNotBlank(groupId)&&"GROUPM".equals(groupId)) {
//			groupId = null;
//		}
		
		String userId = (String)session.getAttribute("userid");
//		System.out.println("userId="+userId);				
		
		String _parentId = request.getParameter("parentId");
		if(_parentId==null) {
			_parentId = "0";
		}
		int parentId = Integer.parseInt(_parentId);
		
		String inculeId = "";
		
		String treeType = request.getParameter("treeType");
		
		String selTrade = request.getParameter("selTrade");
		
//		System.out.println("selTrade="+selTrade);
		
/*		if(userId!=null&&userId.equals("1")){
			selTrade = "";
		}
*/
		list = NodeFunc.getDiyNodesByParent(parentId,treeType, selTrade);
		
		if(Integer.parseInt(treeType)==6) {
			list = NodeFunc.getNodes(parentId,treeType, selTrade);
		}else {
			list = NodeFunc.getDiyNodesByParent(parentId,treeType, selTrade);
		}
//		String s1 = "{id:1, pId:0, name:\"test1\" , open:true}";  
//		        String s2 = "{id:2, pId:1, name:\"test2\" , open:true}";  
//		        String s3 = "{id:3, pId:1, name:\"test3\" , open:true}";  
//		        String s4 = "{id:4, pId:2, name:\"test4\" , open:true}";  
//		        List<String> lstTree = new ArrayList<String>();  
//		        lstTree.add(s1);  
//		        lstTree.add(s2);  
//		        lstTree.add(s3);  
//		        lstTree.add(s4);		        
		        
//				利用Json插件将Array转换成Json格式  
//		        response.getWriter().print(JSONArray.fromObject(lstTree).toString());  

		jsonresult = JSONArray.fromObject(list).toString();
//		jsonresult = JSONArray.fromObject(lstTree).toString();
				
		return SUCCESS;
	}
	
	private String jsonresult;

	public String getJsonresult() {
		return jsonresult;
	}

	public void setJsonresult(String jsonresult) {
		this.jsonresult = jsonresult;
	}
	
}
