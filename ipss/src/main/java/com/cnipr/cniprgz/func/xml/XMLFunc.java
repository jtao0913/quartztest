package com.cnipr.cniprgz.func.xml;

import java.util.ArrayList;
import java.util.List;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.event.CniprEvent;
import com.cnipr.cniprgz.func.AbsCniprFunc;
import com.cnipr.cniprgz.func.search.SearchFunc;
import com.cnipr.corebiz.search.entity.PatentInfo;

public class XMLFunc extends AbsCniprFunc {

	public SearchFunc searchFunc;

	public void setSearchFunc(SearchFunc searchFunc) {
		this.searchFunc = searchFunc;
	}

	public String getXmlContantForView(String rootPath, String channel,
			String an, String pd, String ft_type, String strStartPage,
			String strPageNum, int userId, String userName, String userIp,
			int feeType, int clmPage, int desPage, int draPage, int pageNum) {

		String contant = (String) searchFunc.getXmlContant(null, rootPath, channel,
				an, pd, ft_type, strStartPage, clmPage, desPage, draPage, null, pageNum).get(0);
		// 触发监听事件
		PatentInfo patent = new PatentInfo();
		patent.setAn(an);
		patent.setSectionName(channel);
		List<PatentInfo> patentList = new ArrayList<PatentInfo>();
		patentList.add(patent);

		//this.fireEvent(new CniprEvent(this, true, false, userId, "", Constant.AUTH_FUNC_XML_VIEW, 1, userIp, 0));
		return contant;
	}

//	public String getXmlContantForPrint(String rootPath, String channel,
//			String an, String pd, String ft_type, String strStartPage,
//			String strPageNum, int userId, String userName, String userIp,
//			int feeType) {
//
//		String contant = (String) searchFunc.getXmlContant(rootPath, channel,
//				an, pd, ft_type, strStartPage, null).get(0);
//
//		for (int i = 1; i <= Integer.parseInt(strPageNum); i++) {
//			contant = contant.replace("<!-- SIPO <DP n=\"" + i + "\"> -->", "");
//		}
//		contant = contant.replaceFirst(
//				"(<description><cn-patent-document><application-body>)", "");
//		contant = contant.replaceFirst(
//				"(</application-body></cn-patent-document></description>)", "");
//
//		// 触发监听事件
//		PatentInfo patent = new PatentInfo();
//		patent.setAn(an);
//		patent.setSectionName(channel);
//		List<PatentInfo> patentList = new ArrayList<PatentInfo>();
//		patentList.add(patent);
//		// this.fireEvent(new CniprEvent(this, true, false, patentList, userId,
//		// userName, Constant.AUTH_FUNC_XML_PRINT, Integer
//		// .parseInt(strStartPage), Integer.parseInt(strPageNum),
//		// userIp, feeType));
//		this.fireEvent(new CniprEvent(this, true, false, userId, "",
//				Constant.AUTH_FUNC_XML_PRINT, 1, userIp, 0));
//		return contant;
//	}
}
