package com.cnipr.cniprgz.struts.action;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.entity.IprUser;
import com.cnipr.cniprgz.entity.MenuInfo;
import com.cnipr.cniprgz.func.MenuFunc;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class MenuAction extends ActionSupport {

	private MenuFunc menuFunc;

	public void setMenuFunc(MenuFunc menuFunc) {
		this.menuFunc = menuFunc;
	}

//	public ActionForward getMenu(ActionMapping mapping, ActionForm form,
//			HttpServletRequest request, HttpServletResponse response) {
		
	public String obtainMenu() throws Exception{
		System.out.println("obtainMenu..................");		
		
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
//		Map session = actionContext.getSession();
		
//		HttpSession httpSession = ServletActionContext.getRequest().getSession();		
		
		String strMenuIds = (String) request.getSession().getAttribute("userMenu");
//		String adminMenuIds = "1000,1005,1010,1015,1020,1500,1600,2000,2500,3500,5000,5005,5010,5015,5020,5025,5026,5035,5040,6000,70000,7000,7100,";
		
//		ICoreBizFacade client = CoreBizClient.getCoreBizClient();
//		try {
//			List<IpcVO> ipcList = client.queryIpcFromTRS("分类号=%", "分类号对照表_部");
//			System.out.println(ipcList.get(0).getCode());
//		} catch (Exception e) {}

		request.setAttribute("tabno", request.getParameter("tabno"));session.setAttribute("tabno", request.getParameter("tabno"));
		request.setAttribute("autosearch", request.getParameter("autosearch"));session.setAttribute("autosearch", request.getParameter("autosearch"));
		String autosearch = "0";
		if(null!=request.getParameter("autosearch") && request.getParameter("autosearch").equals("")==false)
			autosearch = request.getParameter("autosearch");

//		request.setAttribute("treeType", request.getParameter("treeType"));
		
//		System.out.println("strMenuIds:"+strMenuIds);
//		System.out.println("request.getParameter(\"rootId\"):"+request.getParameter("rootId"));
//		System.out.println("request.getParameter(\"treeType\"):"+request.getParameter("treeType"));
//		System.out.println("autosearch:"+autosearch);
		
		try{
//			request.setAttribute("menuList", menuFunc.getUserMenu("1000,1005,1010,1015,1020,1500,1600,2000,2500,3500,","0", "1","0"));			
//			menuFunc.getUserMenu(strMenuIds,request.getParameter("rootId"), request.getParameter("treeType"),autosearch);			
//			request.setAttribute("menuList", menuFunc.getUserMenu(strMenuIds,request.getParameter("rootId"), request.getParameter("treeType"),autosearch));			
			
//			session.setAttribute("menuList", menuFunc.getUserMenu(strMenuIds,request.getParameter("rootId"), request.getParameter("treeType"),autosearch));
			
//			setMenuList(menuFunc.getUserMenu(strMenuIds,request.getParameter("rootId"), request.getParameter("treeType"),autosearch));
			
			
			
			List<MenuInfo> menuinfolist = menuFunc.getUserMenu(strMenuIds,request.getParameter("rootId"), request.getParameter("treeType"),autosearch);
			
			session.setAttribute("menuList",menuinfolist);
			
			JSONArray json = JSONArray.fromObject(menuinfolist);//将map对象转换成json类型数据
			
			jsonresult = json.toString();//给result赋值，传递给页面

//			System.out.println(jsonresult);			
//			List<PatentInfo> patentList = Util.getList4Json(strPatentList,PatentInfo.class);			
			
			Map<String,Object> application = ActionContext.getContext().getApplication();
			List<MenuInfo> adminmenuinfolist = null;			
			if(application.get("adminmenuinfo")!=null&&!application.get("adminmenuinfo").equals("")){
//				IprUser admin = sysUserFunc.getUserInfo(1);			
				application.put("adminmenuinfolist", menuFunc.getUserMenu((String)application.get("adminmenuinfo"),request.getParameter("rootId"), request.getParameter("treeType"),autosearch));
			}
			//guestmenuinfolist
			if(application.get("guestmenuinfo")!=null&&!application.get("guestmenuinfo").equals("")){
//				IprUser admin = sysUserFunc.getUserInfo(1);			
				application.put("guestmenuinfolist", menuFunc.getUserMenu((String)application.get("guestmenuinfo"),request.getParameter("rootId"), request.getParameter("treeType"),autosearch));
			}
			
			
			if(true)
			{
				Map<String,Object> _session = ActionContext.getContext().getSession();//${sessionScope.user.username}menuList
				_session.put("menuList",menuinfolist);
			}
//			if(application.get("adminmenuinfolist")==null){			
//				application.put("adminmenuinfolist", adminmenuinfolist);
//			}
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return SUCCESS;
	}
	
	private String jsonresult;

	public String getJsonresult() {
		return jsonresult;
	}

	public void setJsonresult(String jsonresult) {
		this.jsonresult = jsonresult;
	}

//	public List<MenuInfo> getMenuList() {
//		return menuList;
//	}
//	public void setMenuList(List<MenuInfo> menuList) {
//		this.menuList = menuList;
//	}
//	private List<MenuInfo> menuList;
}
