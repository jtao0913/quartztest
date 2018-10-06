package com.cnipph.ipc;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;

import com.cnipph.util.Util;
import com.cnipr.cniprgz.client.CoreBizClient;
import com.cnipr.corebiz.search.entity.IpcVO;
import com.cnipr.corebiz.search.ws.service.ICoreBizFacade;

/**
 * @author Liuc IPC分类逻辑处理
 */
public class IpcHandler {

	/**
	 * 跟踪日志
	 */
	private static final Logger logger = Logger.getLogger(IpcHandler.class);

	/**
	 * 部
	 */
	private static final String IPC_TABLE_PART = "分类号对照表_部";

	/**
	 * 大类
	 */
	private static final String IPC_TABLE_BIG_CLASS = "分类号对照表_大类";

	/**
	 * 小类
	 */
	private static final String IPC_TABLE_SMALL_CLASS = "分类号对照表_小类";

	/**
	 * 大组
	 */
	private static final String IPC_TABLE_BIG_GROUP = "分类号对照表_大组";

	/**
	 * 小组
	 */
	private static final String IPC_TABLE_SMALL_GROUP = "分类号对照表_小组";

	/**
	 * 数据库异常
	 */
	private static final String ERRORS_DB = "数据库连接异常，请稍候再试。";

	/**
	 * 检索结果为空
	 */
	private static final String ERRORS_NULL = "检索结果为空，请检查检索条件。";

	/**
	 * 系统路径
	 */
	private String path;

	/**
	 * 请求参数
	 */
	private String queryString;

	/**
	 * 构造函数
	 */
	public IpcHandler() {
	}

	/**
	 * 构造函数
	 * 
	 * @param request
	 */
	public IpcHandler(HttpServletRequest request) {
		path = request.getContextPath();
		queryString = request.getQueryString();
	}

	/**
	 * 生成XML
	 * 
	 * @param ipcForm
	 * @param response
	 */
	public void createXml(IpcForm ipcForm, HttpServletResponse response) {
		String errMsg = null;
		if (ipcForm.getCode() == null) {
			if ("0".equals(ipcForm.getRdoLogic())) { // 按代码检索
				errMsg = getIpcByKey(ipcForm);
			} else if ("1".equals(ipcForm.getRdoLogic())) { // 按名称检索
				errMsg = getIpcByValue(ipcForm);
			} else { // 初始化
				errMsg = getIpcPart(ipcForm);
			}
		} else {
			errMsg = getIpcByParentNode(ipcForm); // 按父节点检索
		}
		Document document = DocumentHelper.createDocument();
		Element rootElement = document.addElement("tree");
		if (errMsg != null) {
			Element element = rootElement.addElement("tree");
			element.addAttribute("text", errMsg);
		} else {
			setXml(rootElement, ipcForm.getArrayList());
		}
		response.setHeader("pragma", "no-cache");
		response.setHeader("cache-control", "no-cache");
		response.setDateHeader("expires", 0);
		response.setHeader("Content-Type", "application/xml");
		XMLWriter output = null;
		try {
			OutputFormat format = OutputFormat.createPrettyPrint();
			output = new XMLWriter(response.getOutputStream(), format);
			// output = new XMLWriter(response.getWriter(), format);
			output.write(document);
			output.close();
			output = null;
		} catch (IOException ioe) {
			logger.error(ioe.getMessage(), ioe);
		} finally {
			try {
				if (output != null) {
					output.close();
					output = null;
				}
			} catch (Exception ioe) {
				logger.error(ioe.getMessage(), ioe);
			}
		}
	}

	/**
	 * 取部分类
	 * 
	 * @param ipcForm
	 * @return errMsg
	 */
	private String getIpcPart(IpcForm ipcForm) {
		String errMsg = null;
		String expression = "";
		String db = "";
		ICoreBizFacade ipcDAO = CoreBizClient.getCoreBizClient(0);
		try {
			expression = "分类号='%'";
			db = IPC_TABLE_PART;
			List ipcList = ipcDAO.queryIpcFromTRS(expression, db);
			ipcForm.setArrayList(ipcList);
		} catch (Exception trse) {
			errMsg = ERRORS_DB;
		}
		return errMsg;
	}

	/**
	 * 根据分类号查询
	 * 
	 * @param ipcForm
	 * @return errMsg
	 */
	private String getIpcByKey(IpcForm ipcForm) {
		String errMsg = null;
		String expression = "";
		String db = "";
		ICoreBizFacade ipcDAO = CoreBizClient.getCoreBizClient(0);
		try {
			expression = "分类号=('" + ipcForm.getTxtIpc() + "')";
			db = IPC_TABLE_PART + "," + IPC_TABLE_BIG_CLASS + "," + IPC_TABLE_SMALL_CLASS + "," + IPC_TABLE_BIG_GROUP + "," + IPC_TABLE_SMALL_GROUP;
			List ipcList = ipcDAO.queryIpcFromTRS(expression, db);
			if (ipcList.isEmpty()) {
				errMsg = ERRORS_NULL;
			}
			HashSet hashSet = new HashSet();
			for (int i = 0; i < ipcList.size(); i++) {
				IpcVO ipcVO = (IpcVO) ipcList.get(i);
				if (!"".equals(ipcVO.getParent())) {
					hashSet.add(ipcVO.getParent());
				}
			}
			List resultList = new ArrayList();
			Iterator iterator = hashSet.iterator();
			while (iterator.hasNext()) {
				IpcVO ipcVO = getParentIpcBykey(ipcDAO, String.valueOf(iterator.next()), ipcList);
				if (ipcVO == null) {
					continue;
				}
				resultList.add(ipcVO);
			}
			if (resultList.isEmpty()) {
				resultList = ipcList;
			}
			ipcForm.setArrayList(resultList);
		} catch (Exception trse) {
			errMsg = ERRORS_DB;
		}
		return errMsg;
	}

	/**
	 * 根据分类词查询
	 * 
	 * @param ipcForm
	 * @return errMsg
	 */
	private String getIpcByValue(IpcForm ipcForm) {
		String errMsg = null;
		String expression = "";
		String db = "";
		ICoreBizFacade ipcDAO = CoreBizClient.getCoreBizClient(0);
		try {
			HashMap queryMap = Util.parseRequestStr(queryString);
			String txtIpc = (String) queryMap.get("txtIpc");
			expression = "中文注释=('" + URLDecoder.decode(txtIpc, "UTF-8") + "')";
			db = IPC_TABLE_PART + "," + IPC_TABLE_BIG_CLASS + "," + IPC_TABLE_SMALL_CLASS + "," + IPC_TABLE_BIG_GROUP + "," + IPC_TABLE_SMALL_GROUP;
			List<IpcVO> ipcList = ipcDAO.queryIpcFromTRS(expression, db);
			if (ipcList.isEmpty()) {
				errMsg = ERRORS_NULL;
			}
			ipcForm.setArrayList(ipcList);
		} catch (Exception trse) {
			errMsg = ERRORS_DB;
		}
		return errMsg;
	}

	/**
	 * 递归向上检索
	 * 
	 * @param ipcDAO
	 * @param key
	 * @param childList
	 * @return ipcVO
	 * @throws TRSException
	 */
	private IpcVO getParentIpcBykey(ICoreBizFacade ipcDAO, String key, List childList) throws Exception {
		IpcVO ipcVO = null;
		String expression = "";
		String db = "";
		try {
			expression = "分类号='" + key + "'";
			db = IPC_TABLE_PART + "," + IPC_TABLE_BIG_CLASS + "," + IPC_TABLE_SMALL_CLASS + "," + IPC_TABLE_BIG_GROUP + "," + IPC_TABLE_SMALL_GROUP;
			List ipcList = ipcDAO.queryIpcFromTRS(expression, db);
			if (ipcList.isEmpty() || ipcList.size() > 1) {
				return null;
			}
			ipcVO = (IpcVO) ipcList.get(0);
			ipcVO.setChildList(childList);
			if ("".equals(ipcVO.getParent())) {
				return ipcVO;
			} else {
				ipcVO = getParentIpcBykey(ipcDAO, ipcVO.getParent(), ipcList);
			}
		} catch (Exception trse) {
			throw trse;
		}
		return ipcVO;
	}

	/**
	 * 根据父节点分类号取分类
	 * 
	 * @param ipcForm
	 * @return errMsg
	 */
	private String getIpcByParentNode(IpcForm ipcForm) {
		String errMsg = null;
		String expression = "";
		String db = "";
		ICoreBizFacade ipcDAO = CoreBizClient.getCoreBizClient(0);
		try {
			expression = "父节点分类号='" + ipcForm.getCode() + "'";
			db = IPC_TABLE_BIG_CLASS + "," + IPC_TABLE_SMALL_CLASS + "," + IPC_TABLE_BIG_GROUP + "," + IPC_TABLE_SMALL_GROUP;
			List<IpcVO> ipcList = ipcDAO.queryIpcFromTRS(expression, db);
			ipcForm.setArrayList(ipcList);
		} catch (Exception trse) {
			errMsg = ERRORS_DB;
		}
		return errMsg;
	}

	/**
	 * 设置XML
	 * 
	 * @param rootElement
	 * @param elementList
	 */
	private void setXml(Element rootElement, List<IpcVO> elementList) {
		for (int i = 0; i < elementList.size(); i++) {
			IpcVO ipcVO = (IpcVO) elementList.get(i);
			Element element = rootElement.addElement("tree");
			element.addAttribute("text", treeTextParse(ipcVO));
			List childList = ipcVO.getChildList();
			if (childList == null) {
				if ("0".equals(ipcVO.getLeaf())) {
					element.addAttribute("src", treeSrcParse(ipcVO));
				}
				element.addAttribute("action", treeActionParse(ipcVO));
			} else {
				setXml(element, childList);
			}
		}
	}

	/**
	 * 解析树文本
	 * 
	 * @param ipcVO
	 * @return result
	 */
	private String treeTextParse(IpcVO ipcVO) {
		if (ipcVO == null) {
			return null;
		}
		String result = "<b>" + ipcVO.getCode() + "</b> | " + ipcVO.getLabel();
		return result;
	}

	/**
	 * 解析树源
	 * 
	 * @param ipcVO
	 * @return result
	 */
	private String treeSrcParse(IpcVO ipcVO) {
		if (ipcVO == null) {
			return null;
		}
		String result = path + "/ipc/tree.do?code=" + ipcVO.getCode();
		return result;
	}

	/**
	 * 解析树链接
	 * 
	 * @param ipcVO
	 * @return result
	 */
	private String treeActionParse(IpcVO ipcVO) {
		if (ipcVO == null) {
			return null;
		}
		// String result = path + "/ipc/search.do?selType=0&txtIpc=" + ipcVO.getCode();
		String result = "javascript:doSet ('" + ipcVO.getCode() + "');";
		return result;
	}
}