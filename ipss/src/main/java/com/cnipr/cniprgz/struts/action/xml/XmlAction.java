package com.cnipr.cniprgz.struts.action.xml;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.authority.AbsDataAuthority;
import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.func.ChannelFunc;
import com.cnipr.cniprgz.func.xml.XMLFunc;
import com.cnipr.cniprgz.func.xml.XMLScopeAuthProxy;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Map;

public class XmlAction extends ActionSupport {

	public XMLFunc xmlFunc;

	public void setXmlFunc(XMLFunc xmlFunc) {
		this.xmlFunc = xmlFunc;
	}
	
	public ChannelFunc channelFunc;

	public void setChannelFunc(ChannelFunc channelFunc) {
		this.channelFunc = channelFunc;
	}
	
	@SuppressWarnings("unchecked")
//	public ActionForward viewXml(ActionMapping mapping, ActionForm form,
//			HttpServletRequest request, HttpServletResponse response) {

	public String viewXml() throws Exception{
			ActionContext cxt = ActionContext.getContext();
			HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
			HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
			HttpSession session = request.getSession();
//		String strPageNo = request.getParameter("pageno");
//		if (strPageNo == null) {
//			strPageNo = "";
//		}

		String strAN = request.getParameter("an");

		String strChannelName = request.getParameter("channelIDs");
		String strPD = request.getParameter("pd");

		String CLM_Page = request.getParameter("CLM_Page");
		String DES_Page = request.getParameter("DES_Page");
		String DRA_Page = request.getParameter("DRA_Page");

		if (CLM_Page == null || CLM_Page.equals("")) {
			CLM_Page = "0";
		}
		if (DES_Page == null || DES_Page.equals("")) {
			DES_Page = "0";
		}
		if (DRA_Page == null || DRA_Page.equals("")) {
			DRA_Page = "0";
		}

		String ft_type = request.getParameter("ft_type");
		if (ft_type == null || ft_type.equals("")) {
			ft_type = "1";
		}
		String pageIndex = request.getParameter("pageIndex");
		if (pageIndex == null) {
			pageIndex = "0";
		}

//		if (!strPageNo.equals("")) {
//			// System.out.println(strPageNo+"...........");
//			// 说明是左侧缩略图的链接
//			int intPageNo = Integer.parseInt(strPageNo);
//			// intPageNo--;
//			if (intPageNo < 1 + intCLM_Page) {
//				ft_type = "1";
//				startpage = intPageNo + "";
//			}
//			if (intPageNo >= (1 + intCLM_Page)
//					&& intPageNo < (1 + intCLM_Page + intDES_Page)) {
//				ft_type = "2";
//				startpage = intPageNo - intCLM_Page + "";
//			}
//			if (intPageNo >= (1 + intCLM_Page + intDES_Page)) {
//				ft_type = "3";
//				startpage = intPageNo - intCLM_Page - intDES_Page + "";
//			}
//		} else {
//			// strPageNo = Integer.parseInt(ft_type)
//			if (ft_type.equals("1")) {
//				strPageNo = "1";
//			} else if (ft_type.equals("2")) {
//				strPageNo = (intCLM_Page + 1) + "";
//			} else if (ft_type.equals("3")) {
//				strPageNo = (intCLM_Page + intDES_Page + 1) + "";
//			}
//		}

		// CniprLogger.LogError("\n\n\n XmlAction - showXML - strChannelIDs = "
		// + strChannelIDs + "\n\n\n");
		// 数据权限验证
		AbsDataAuthority dataAuthority = new XMLScopeAuthProxy(request,
				response);
		/*if (!dataAuthority.hasDataAuthority(((Integer) request.getSession()
				.getAttribute(Constant.APP_USER_ROLE)).toString(),
				Constant.AUTH_FUNC_XML_VIEW, ((List<Map>) request.getSession().getAttribute(
				"userAuthorityList")).get(1), Integer
						.parseInt(pageIndex))) {
			return null;
		}*/

		request.setAttribute("pageIndex", pageIndex);
		request.setAttribute("an", strAN);
		request.setAttribute("channelIDs", strChannelName);
		request.setAttribute("pd", strPD);
		request.setAttribute("CLM_Page", CLM_Page);
		request.setAttribute("DES_Page", DES_Page);
		request.setAttribute("DRA_Page", DRA_Page);
		request.setAttribute("ft_type", ft_type);
//		return mapping.findForward("viewXml");
		
		return SUCCESS;
	}

//	public ActionForward renderXML(ActionMapping mapping, ActionForm form,
//			HttpServletRequest request, HttpServletResponse response) {
	
	public String renderXML() throws Exception{
			ActionContext cxt = ActionContext.getContext();
			Map<String, Object> application = cxt.getApplication();
			HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
			HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		
		String channel = request.getParameter("channelIDs");
		String an = request.getParameter("an");
		String pd = request.getParameter("pd");
		String ft_type = request.getParameter("ft_type");
		String pageIndex = request.getParameter("pageIndex");
		String strPageNum = request.getParameter("pagenum");
		// String s_CopyXML = request.getParameter("i_CopyXML");
		// System.out.println("channel=" + channel + ",an=" + an+ ",pd=" + pd+
		// ",ft_type=" + ft_type
		// + ",strStartPage=" + strStartPage+ ",strPageNum=" + strPageNum);

		String strLocalAddr = request.getLocalAddr();
		int strServerPort = request.getServerPort();
		String strContextPath = request.getContextPath();
		// String strServletPath = httpservletrequest.getServletPath();

		String rootPath = "http://" + strLocalAddr + ":" + strServerPort
				+ strContextPath;

		// String xmlContant = (String) searchFunc.getXmlContant(rootPath,
		// channel, an, pd, ft_type, strStartPage, strPageNum, null)
		// .get(0);
		int CLM_Page = 0;
		if(null!=request.getParameter("CLM_Page") && !"".equals(request.getParameter("CLM_Page")))
			CLM_Page = Integer.parseInt(request.getParameter("CLM_Page"));
		
		int DES_Page = 0;
		if(null!=request.getParameter("DES_Page") && !"".equals(request.getParameter("DES_Page")))
			DES_Page = Integer.parseInt(request.getParameter("DES_Page"));
		
		int DRA_Page = 0;
		if(null!=request.getParameter("DRA_Page") && !"".equals(request.getParameter("DRA_Page")))
			DRA_Page = Integer.parseInt(request.getParameter("DRA_Page"));
		
		int pageNum = 10;
		pageNum = Constant.XmlPageNUM;
		
		// 数据权限验证
		AbsDataAuthority dataAuthority = new XMLScopeAuthProxy(request,
				response);
		/*if (!dataAuthority.hasDataAuthority(((Integer) request.getSession()
				.getAttribute(Constant.APP_USER_ROLE)).toString(),
				Constant.AUTH_FUNC_XML_VIEW, ((List<Map>) request.getSession().getAttribute(
				"userAuthorityList")).get(1), Integer
						.parseInt(pageIndex))) {
			return null;
		}*/
		
		String xmlContant = xmlFunc.getXmlContantForView(rootPath, channel, an,
				pd, ft_type, pageIndex, strPageNum, 1, "admin",
				com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), 0 ,CLM_Page,DES_Page,DRA_Page, pageNum);		

		// String xmlContant = searchFunc.getXmlContant(rootPath, channel, an,
		// pd, "2", strStartPage, strPageNum, s_CopyXML);
		// System.out.println("$$$xmlContant=" + xmlContant);
		// xmlContant =
		// "<?xml version=\"1.0\"?><!DOCTYPE cn-patent-document SYSTEM \"dtd/cn-patent-document-06-10-27.dtd\"><?xml-stylesheet type=\"text/xsl\" href=\"xsl/XSL0117new.xsl\"?><?trs-parser SegmentMark=\"paragraph\" NewLineMark=\"br\" HitShowMark=\"TRSHL\" FilterCData=\"yes\"?><cn-patent-document lang=\"ZH\" country=\"CN\"><application-body lang=\"CN\" country=\"CN\"><description><invention-title id=\"tilte7\">一种用于狭窄间距植物的收割机</invention-title><technical-field id=\"technical-field001\"><p id=\"d0\" num=\"001\"><u><b>技术</b>领域</u><br/></p><p id=\"d1\" num=\"002\">本发明大体上涉及农业收割机，更具体地涉及用于从相邻的紧<br/>密间距的植物行中收割农作物的收割机。<br/></p></technical-field><background-art id=\"background-art001\"><p num=\"add\"><u>背景技术</u><br/></p><p id=\"d2\" num=\"003\">收割机如摘棉机包括具有竖直摘棉滚筒的行单元，摘棉滚筒带<br/>有能伸入行接收区域中以从一行农作物中采摘棉花的摘锭。收割间<br/>距非常狭窄的棉花行一直是个难题。如同为转让的美国专利No.<br/>4821497中所示的带有只在行的一侧一前一后地设置的摘棉滚筒的棉<br/>花采摘单元，或者是如美国专利No.4538403所示的嵌套式行收割单<br/>元已经具有能在较窄行距中进行行收割的能力，但这些改进还不足<br/>以适应15英寸或更小的非常狭窄间距的行。在一些地区，农作物的<br/>行间距可能密集到12英寸(30厘米)，使用传统的行单元进行收割<br/>会导致大量的相邻行中的植物损坏和棉花损失。通常采用带有梳理<br/>式头部的摘棉桃机来从狭窄间距的植物中采摘棉花，然而这种头部<br/>的效率相对较差，并且不能有效地分开棉花和废物。<br/></p><p id=\"d3\" num=\"004\">在同为转让的1999年5月28日提交的题为“狭窄行的棉花收<br/>割机”的美国专利No.6212864中介绍了一种切割和传送农作物的附<br/>加装置，其可切割一行植物，并在植物与前摘锭滚筒接触之前使植<br/>物移动到相邻的直立行中。割下的植物与直立行中地植物相互缠绕，<br/>使得摘棉滚筒可从两行植物中采摘棉花。尽管附加装置能够收割间<br/>距为15英寸或更小的行，然而所示的切割器从滚筒处向前偏移了一<br/>段相当大的距离。植物必须被很好的支撑，以便在对角地向后移动<br/>到相邻的直立行中时保持直立，而且系统要求具有较长的带式传送<br/><!-- SIPO <DP n=\"1\"> --></p></background-art></description></application-body></cn-patent-document>";

		response.setContentType("text/xml");
		response.setCharacterEncoding("UTF-8");
		// xmlContant =
		// "<?xml version=\"1.0\"?><!DOCTYPE cn-patent-document SYSTEM \"dtd/cn-patent-document-06-10-27.dtd\"><?xml-stylesheet type=\"text/xsl\" href=\"xsl/XSL0117new.xsl\"?><?trs-parser SegmentMark=\"paragraph\" NewLineMark=\"br\" HitShowMark=\"TRSHL\" FilterCData=\"yes\"?><cn-patent-document lang=\"ZH\" country=\"CN\"><application-body lang=\"CN\" country=\"CN\"><claims><claim id=\"ci1\" num=\"001\"> 				<claim-text>1.一种适于在田野上向前运动以收割横向隔开预定距离或更小                 <br/>的至少第一行和第二行植物的收割机，所述收割机包括宽度大约等于                 <br/>或大于所述预定距离的行单元，所述行单元包括：第一和第二行接收                 <br/>区域；支撑于所述第一行列接收区域附近的竖直收割机滚筒，可从所                 <br/>述第一行植物中采摘农作物；可绕竖直轴线旋转的竖直进料器，其相                 <br/>邻于所述第二行接收区域并位于所述收割机滚筒的前方；和驱动结                 <br/>构，其可使所述竖直进料器以与所述收割机的对地前进速度同步的速                 <br/>度旋转，并逐渐地将所述第二行植物横向地朝向所述第一行植物引                 <br/>导。                 <br/> 				</claim-text> 			</claim> 			<claim id=\"ci2\" num=\"002\"> 				<claim-text>2.根据权利要求1所述的收割机，其特征在于，所述收割机包括                 <br/>用于切割所述第二行棉花作物的切割器，所述切割器安装成可围绕所                 <br/>述竖直轴线旋转并与所述驱动结构连接，从而可以大于所述竖直进料                 <br/>器速度的速度旋转。                 <br/> 				</claim-text> 			</claim> 			<claim id=\"ci3\" num=\"003\"> 				<claim-text>3.根据权利要求2所述的收割机，其特征在于，所述驱动结构包                 <br/>括可将驱动传给所述竖直进料器的第一滑动离合器和可将驱动传给所                 <br/>述切割器的第二滑动离合器，使得所述进料器和切割器具有分开的驱                 <br/>动保护。                 <br/> 				</claim-text> 			</claim> 			<claim id=\"ci4\" num=\"004\"> 				<claim-text>4.根据权利要求1所述的收割机，其特征在于，所述收割机包括                 <br/>栅格结构，其可将所述第二行朝向所述第一行引导，并保持所述第二                 <br/>行不与所述收割机滚筒接触，直至所述第二行基本上与所述第一行接                 <br/>收区域对准为止。                 <br/> 				</claim-text> 			</claim> 			<claim id=\"ci5\" num=\"005\"> 				<claim-text>5.根据权利要求1所述的收割机，其特征在于，所述竖直进料器                 <br/>包括垂直隔开的指轮，其具有相对于所述进料器的旋转方向向后弯曲                 <br/>的指形件。                 <br/> 				</claim-text> 			</claim> 			<claim id=\"ci6\" num=\"006\"> 				<claim-text>6.根据权利要求1所述的收割机，其特征在于，所述收割机包括                 <br/>支撑于所述竖直进料器附近的进料器栅格结构，所述竖直进料器包括。                 <br/> 				</claim-text> 				<!-- SIPO <DP n=\"1\"> --></claim></claims></application-body></cn-patent-document>";
		try {
			response.getWriter().write(xmlContant);
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

//	public ActionForward renderXMLForPrint(ActionMapping mapping,
//			ActionForm form, HttpServletRequest request,
//			HttpServletResponse response) {
//		String channel = request.getParameter("strChannelIDs");
//		String an = request.getParameter("an");
//		String pd = request.getParameter("pd");
//		String ft_type = request.getParameter("ft_type");
//		String strStartPage = request.getParameter("int_start");
//		String strPageNum = request.getParameter("int_end");
//		// String s_CopyXML = request.getParameter("i_CopyXML");
//		// System.out.println("channel=" + channel + ",an=" + an+ ",pd=" + pd+
//		// ",ft_type=" + ft_type
//		// + ",strStartPage=" + strStartPage+ ",strPageNum=" + strPageNum);
//
//		String strLocalAddr = request.getLocalAddr();
//		int strServerPort = request.getServerPort();
//		String strContextPath = request.getContextPath();
//		// String strServletPath = httpservletrequest.getServletPath();
//
//		String rootPath = "http://" + strLocalAddr + ":" + strServerPort
//				+ strContextPath;
//
//		// String xmlContant = (String) searchFunc.getXmlContant(rootPath,
//		// channel, an, pd, ft_type, strStartPage, strPageNum, null)
//		// .get(0);
//		Integer pagenum = Integer.parseInt(strPageNum) - Integer.parseInt(strStartPage) + 1;
//		
//		String xmlContant = xmlFunc.getXmlContantForPrint(rootPath, channel,
//				an, pd, ft_type, strStartPage, pagenum.toString(), Integer
//						.valueOf((String) request.getSession().getAttribute(
//								Constant.APP_USER_ID)), (String) request
//						.getSession().getAttribute(Constant.APP_USER_NAME),
//				request.getRemoteAddr(), (Integer)request
//				.getSession().getAttribute(Constant.APP_USER_FEETYPE));
//		if (ft_type.equals("1")) {
//			xmlContant = xmlContant.replace("XSL0117new.xsl", "XSL0117newPrint.xsl");
//		} else {
//			xmlContant = xmlContant.replace("XSL0117new.xsl", "XSL0117newPrint.xsl").replace(
//					"<cn-patent-document><application-body><claims>", "").replaceFirst(
//					"</claims></application-body></cn-patent-document>", "");
//		}
//		
//		// String xmlContant = searchFunc.getXmlContant(rootPath, channel, an,
//		// pd, "2", strStartPage, strPageNum, s_CopyXML);
//		// System.out.println("$$$xmlContant=" + xmlContant);
//		// xmlContant =
//		// "<?xml version=\"1.0\"?><!DOCTYPE cn-patent-document SYSTEM \"dtd/cn-patent-document-06-10-27.dtd\"><?xml-stylesheet type=\"text/xsl\" href=\"xsl/XSL0117new.xsl\"?><?trs-parser SegmentMark=\"paragraph\" NewLineMark=\"br\" HitShowMark=\"TRSHL\" FilterCData=\"yes\"?><cn-patent-document lang=\"ZH\" country=\"CN\"><application-body lang=\"CN\" country=\"CN\"><description><invention-title id=\"tilte7\">一种用于狭窄间距植物的收割机</invention-title><technical-field id=\"technical-field001\"><p id=\"d0\" num=\"001\"><u><b>技术</b>领域</u><br/></p><p id=\"d1\" num=\"002\">本发明大体上涉及农业收割机，更具体地涉及用于从相邻的紧<br/>密间距的植物行中收割农作物的收割机。<br/></p></technical-field><background-art id=\"background-art001\"><p num=\"add\"><u>背景技术</u><br/></p><p id=\"d2\" num=\"003\">收割机如摘棉机包括具有竖直摘棉滚筒的行单元，摘棉滚筒带<br/>有能伸入行接收区域中以从一行农作物中采摘棉花的摘锭。收割间<br/>距非常狭窄的棉花行一直是个难题。如同为转让的美国专利No.<br/>4821497中所示的带有只在行的一侧一前一后地设置的摘棉滚筒的棉<br/>花采摘单元，或者是如美国专利No.4538403所示的嵌套式行收割单<br/>元已经具有能在较窄行距中进行行收割的能力，但这些改进还不足<br/>以适应15英寸或更小的非常狭窄间距的行。在一些地区，农作物的<br/>行间距可能密集到12英寸(30厘米)，使用传统的行单元进行收割<br/>会导致大量的相邻行中的植物损坏和棉花损失。通常采用带有梳理<br/>式头部的摘棉桃机来从狭窄间距的植物中采摘棉花，然而这种头部<br/>的效率相对较差，并且不能有效地分开棉花和废物。<br/></p><p id=\"d3\" num=\"004\">在同为转让的1999年5月28日提交的题为“狭窄行的棉花收<br/>割机”的美国专利No.6212864中介绍了一种切割和传送农作物的附<br/>加装置，其可切割一行植物，并在植物与前摘锭滚筒接触之前使植<br/>物移动到相邻的直立行中。割下的植物与直立行中地植物相互缠绕，<br/>使得摘棉滚筒可从两行植物中采摘棉花。尽管附加装置能够收割间<br/>距为15英寸或更小的行，然而所示的切割器从滚筒处向前偏移了一<br/>段相当大的距离。植物必须被很好的支撑，以便在对角地向后移动<br/>到相邻的直立行中时保持直立，而且系统要求具有较长的带式传送<br/><!-- SIPO <DP n=\"1\"> --></p></background-art></description></application-body></cn-patent-document>";
//
//		response.setContentType("text/xml");
//		response.setCharacterEncoding("UTF-8");
//
//		// xmlContant =
//		// "<?xml version=\"1.0\"?><!DOCTYPE cn-patent-document SYSTEM \"dtd/cn-patent-document-06-10-27.dtd\"><?xml-stylesheet type=\"text/xsl\" href=\"xsl/XSL0117new.xsl\"?><?trs-parser SegmentMark=\"paragraph\" NewLineMark=\"br\" HitShowMark=\"TRSHL\" FilterCData=\"yes\"?><cn-patent-document lang=\"ZH\" country=\"CN\"><application-body lang=\"CN\" country=\"CN\"><claims><claim id=\"ci1\" num=\"001\"> 				<claim-text>1.一种适于在田野上向前运动以收割横向隔开预定距离或更小                 <br/>的至少第一行和第二行植物的收割机，所述收割机包括宽度大约等于                 <br/>或大于所述预定距离的行单元，所述行单元包括：第一和第二行接收                 <br/>区域；支撑于所述第一行列接收区域附近的竖直收割机滚筒，可从所                 <br/>述第一行植物中采摘农作物；可绕竖直轴线旋转的竖直进料器，其相                 <br/>邻于所述第二行接收区域并位于所述收割机滚筒的前方；和驱动结                 <br/>构，其可使所述竖直进料器以与所述收割机的对地前进速度同步的速                 <br/>度旋转，并逐渐地将所述第二行植物横向地朝向所述第一行植物引                 <br/>导。                 <br/> 				</claim-text> 			</claim> 			<claim id=\"ci2\" num=\"002\"> 				<claim-text>2.根据权利要求1所述的收割机，其特征在于，所述收割机包括                 <br/>用于切割所述第二行棉花作物的切割器，所述切割器安装成可围绕所                 <br/>述竖直轴线旋转并与所述驱动结构连接，从而可以大于所述竖直进料                 <br/>器速度的速度旋转。                 <br/> 				</claim-text> 			</claim> 			<claim id=\"ci3\" num=\"003\"> 				<claim-text>3.根据权利要求2所述的收割机，其特征在于，所述驱动结构包                 <br/>括可将驱动传给所述竖直进料器的第一滑动离合器和可将驱动传给所                 <br/>述切割器的第二滑动离合器，使得所述进料器和切割器具有分开的驱                 <br/>动保护。                 <br/> 				</claim-text> 			</claim> 			<claim id=\"ci4\" num=\"004\"> 				<claim-text>4.根据权利要求1所述的收割机，其特征在于，所述收割机包括                 <br/>栅格结构，其可将所述第二行朝向所述第一行引导，并保持所述第二                 <br/>行不与所述收割机滚筒接触，直至所述第二行基本上与所述第一行接                 <br/>收区域对准为止。                 <br/> 				</claim-text> 			</claim> 			<claim id=\"ci5\" num=\"005\"> 				<claim-text>5.根据权利要求1所述的收割机，其特征在于，所述竖直进料器                 <br/>包括垂直隔开的指轮，其具有相对于所述进料器的旋转方向向后弯曲                 <br/>的指形件。                 <br/> 				</claim-text> 			</claim> 			<claim id=\"ci6\" num=\"006\"> 				<claim-text>6.根据权利要求1所述的收割机，其特征在于，所述收割机包括                 <br/>支撑于所述竖直进料器附近的进料器栅格结构，所述竖直进料器包括。                 <br/> 				</claim-text> 				<!-- SIPO <DP n=\"1\"> --></claim></claims></application-body></cn-patent-document>";
//		try {
//
//			response.getWriter().write(xmlContant);
//			// response.getWriter().write("<script>document.execCommand('print');</script>");
//			response.getWriter().flush();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		return null;
//	}
}
