package com.cnipr.cniprgz.commons;

import java.util.HashMap;
import java.util.Map;

public class LimitConstant {
/**
 * 必须与SetupConstant一致，以确定在系统级别功能下，开启用户功能。
 */
	 
	
	private static Map  limitMap = new HashMap();
	
	static{
		limitMap.put(SetupConstant.FENXI,"专利分析");
		limitMap.put(SetupConstant.DINGQIYUJING,"定期预警");
		limitMap.put(SetupConstant.GAOJIYUJING,"高级预警");
		limitMap.put(SetupConstant.HUOYUEZHISHUYUJING,"活跃指数预警");
		limitMap.put(SetupConstant.SHIXIAOSEARCH,"失效专利检索");
		limitMap.put(SetupConstant.YUYISEARCH,"语义智能检索");
		limitMap.put(SetupConstant.GONGSIDAIMA,"公司代码辅助查询");
		limitMap.put(SetupConstant.DETAILXIANGSISEARCH,"细缆相似检索");
		limitMap.put(SetupConstant.GZGYANALYSE,"公知公用");
		limitMap.put(SetupConstant.AUTOINDEX,"查看自动标引");
		limitMap.put(SetupConstant.CROSSLANGUAGE,"国外专利跨语言检索");
		// limitMap.put(SetupConstant.MYALERT,"左侧菜单‘我的预警’显示");
		limitMap.put(SetupConstant.FRCHANNEL,"国外频道检索");
		limitMap.put(SetupConstant.TRANSLATE,"机器翻译");
		limitMap.put(SetupConstant.QUANWENSEARCH,"全文检索");
		limitMap.put(SetupConstant.DAIMAHUAVIEW,"代码化查看");
		limitMap.put(SetupConstant.GAOJIFENXI,"高级分析，聚类和引证分析");
		//limitMap.put(SetupConstant.XINYINGXINGQINQUANXINGFENXI,"新颖性与侵权性分析链接");
		limitMap.put(SetupConstant.SENIOROPERATOR,"逻辑检索级运算符");
		limitMap.put(SetupConstant.OPENBATCHDOWNLOAD,"文摘批量下载"); 
		limitMap.put(SetupConstant.BATCHSEARCH,"批量检索"); 
		limitMap.put(SetupConstant.LAWWARN,"法律状态预警"); 
		limitMap.put(SetupConstant.IPCHELPSEARCH,"IPC辅助查询"); 
		limitMap.put(SetupConstant.EVALUATION, "专利评估");
		limitMap.put(SetupConstant.OPENPHYSICALDB, "专利物理库模块");
		
		if(SetupAccess.getProperty(SetupConstant.OPENPHYSICALDB)!=null && SetupAccess.getProperty(SetupConstant.OPENPHYSICALDB).equals("1"))
			limitMap.put(SetupConstant.OPENPHYSICALDBADMIN, "专利物理库用户管理");
		
		limitMap.put(SetupConstant.DAIMAHUADOWNLOAD, "代码化下载");
		limitMap.put(SetupConstant.EFFECTLIB, "有效专利检索");
		limitMap.put(SetupConstant.AGENCYHELPSEARCH, "代理机构辅助查询");
		limitMap.put(SetupConstant.AGENCYSEARCH, "代理机构查询");
		limitMap.put(SetupConstant.DETAILSEARCHREPORT, "专利细缆检索报告");
		limitMap.put(SetupConstant.VIEWWGGB, "外观公报浏览");
		limitMap.put(SetupConstant.SIMPLESEARCHLEFT, "简单检索菜单");
	}

	public static Map getLimitMap() {
		return limitMap;
	}

	public static void setLimitMap(Map limitMap) {
		LimitConstant.limitMap = limitMap;
	}
	
	
}
