/**
 * 
 */
package com.cnipr.cniprgz.commons;

public class SetupConstant { 
	 
	
	//企业自建专题库
	public static final String CORPCODEBASE = "corpcodebase";
	//行业导航库
//	public static final String HANGYE = "hangye";
	//行业导航管理
//	public static final String HANGYEADMIN = "hangyeadmin";
	//分析模块
	public static final String FENXI = "fenxi";
	//定期预警
	public static final String DINGQIYUJING = "dingqiyujing";
	//高级预警
	public static final String GAOJIYUJING = "gaojiyujing";
	//活跃指数
	public static final String HUOYUEZHISHUYUJING = "huoyuezhishuyujing";
	//失效查询
	public static final String SHIXIAOSEARCH = "shixiaosearch";
	//语义智能检索
	public static final String YUYISEARCH = "yuyisearch";
	//公司代码查询,需要相应工程corpcode1,并且在app.properties配置查询链接corpcordAppURL
	public static final String GONGSIDAIMA = "gongsidaima";
	//细缆相似检索
	public static final String DETAILXIANGSISEARCH = "detailxiangsisearch";
	//字词检索
	public static final String ZICISEARCH = "zicisearch";
	//公知公用
	public static final String GZGYANALYSE = "gzgyAnalyse";
	//查看自动标引
	public static final String AUTOINDEX = "autoIndex";
	//跨语言检索
	public static final String CROSSLANGUAGE = "crossLanguage";
	//是否有帮助文档
	public static final String HELPWORD = "helpword";
	//帮助文档的连接
	public static final String HELPWORDURL = "helpwordurl";
	//左侧菜单我的预警,2.0.4已废除
	//public static final String MYALERT = "myalert";
	//是否有国外频道
	public static final String FRCHANNEL = "frchannel";
	//ipr_navtable表中表达式频道为空时,默认国外行业导航频道号
	public static final String NAVFRCHANNELS = "navfrchannels";
	//ipr_navtable表中表达式频道为空时,默认国内行业导航频道号
	public static final String NAVCNCHANNELS= "navcnchannels";
	//默认失效行业导航频道号
	public static final String NAVSXCHANNELS= "navsxchannels";
	//默认行业导航入口进入后,顶层表达式自动检索
	public static final String AUTOSEARCH="autosearch";
	//机器翻译
	public static final String TRANSLATE = "translate";
	//全文检索
	public static final String QUANWENSEARCH = "quanwensearch";
	//代码化查看
	public static final String DAIMAHUAVIEW = "daimahuaview";
	//高级分析，聚类和引证分析
	public static final String GAOJIFENXI = "gaojifenxi";
	//概览条数
	public static final String PAGERECORD = "PAGERECORD";
	//开放注册,注册地址为：/cnipr2.x/admin/usermanager/jsp/user/register-user.jsp
	public static final String REGISTERUSER = "registeruser";
	//ip限制开关
	public static final String IPLIMIT = "iplimit";
	//最大登录数开关
	public static final String MAXLOGINAMOUNT = "maxloginamount";
	//每页代码化显示的段数
	public static final String XMLPAGENUM = "XmlPageNUM";
	//全文是否有缩略图
	public static final String SUOLUEPIC = "suoluepic";
	//新颖性与侵权性分析链接
	public static final String XINYINGXINGQINQUANXINGFENXI = "xinyingxingqinquanxingfenxi";
	//摘要附图类型tif,gif
	public static final String ZHAIYAOFUTUTYPE = "zhaiyaofututype";
	//代码化附图类型tif,gif
	public static final String XMLFUTUTYPE = "xmlfututype";
	//细缆代码化法律状态数据带不带CN
	public static final String VIEWLEGALSTATUSCN = "viewLegalStatuscn";
	//检索排序
	public static final String ORDEROPEN = "orderopen";
	//外观大图是tif，jpg
	public static final String WGLARGEPIC = "wglargepic";
	//集团用户登录
	public static final String JITUANLOGIN ="jituanlogin";
	//逻辑检索页面高级运算符
	public static final String SENIOROPERATOR = "senioroperator";
	//文摘批量下载开关
	public static final String OPENBATCHDOWNLOAD = "openbatchdownload";
	//文摘批量下载限制条数
	public static final String BATCHDOWNLOADNUM = "batchdownloadnum";

	//-------------------------2.0.3---------------------//
	//mysql数据库 记录全文以及代码化下载日志、检索概览、细缆日志、全文及代码化浏览日志，记录开关。
	public static final String DATABASELOG = "databaselog";
	//mysql数据库 记录全文以及代码化下载日志、检索概览、细缆日志、全文及代码化浏览日志，后台统计管理开关。
	public static final String DATABASELOGADMIN = "databaselogadmin";	 
	
	
	//#-------------------------2.0.4---------------------# 
	//批量检索
	public static final String BATCHSEARCH = "batchsearch";	 
	//定期预警，用户默认续订预警次数
	public static final String SIMPLEWARNRENEWNUM   = "simplewarnrenewnum" ;
	//定期预警，用户最多预警表达式数量
	public static final String SIMPLEWARNMAX = "simplewarnmax" ;
	//法律状态预警，用户默认续订预警次数
	public static final String LAWWARNRENEWNUM   = "lawwarnrenewnum" ;
	//法律状态预警，用户最多预警表达式数量
	public static final String LAWWARNMAX = "lawwarnmax" ;
	//法律状态开关
	public static final String LAWWARN = "lawwarn" ;
	
	//#---------------------2.0.5-----------------------------
	public static final String IPCHELPSEARCH = "ipchelpsearch";
	public static final String EVALUATION  = "evaluation";
	
	
	//#---------------------2.0.6----------------------------
	public static final String OPENPHYSICALDB = "openphysicaldb";
	public static final String OPENPHYSICALDBADMIN = "openphysicaldbadmin";
	public static final String DAIMAHUADOWNLOAD   = "daimahuadownload";
	public static final String DATAGROUP = "datagroup";
	
	public static final String EFFECTLIB = "effectlib";
	public static final String NAVEFFECTCHANNEL = "naveffectchannel";
	public static final String AGENCYHELPSEARCH = "agencyhelpsearch";
	public static final String AGENCYSEARCH = "agencysearch";
	
	//#---------------------2.0.7-------------------------#
	public static final String DETAILSEARCHREPORT  = "detailsearchreport";	
	public static final String VIEWWGGB  = "viewwggb";
	
	//---------------------2.0.8----------------------------
	public static final String SIMPLESEARCHLEFT = "simplesearchleft";
	public static final String INDEXCOUNT = "indexcount";
	
	//---------------------2.0.9----------------------------
	public static final String BATCHDOWNLOADLAWSTATUS = "batchdownloadlawstatus" ;	
	public static final String BATCHDOWNLOADSTATUSMAX = "batchdownloadlawstatusmax";
	
	//---------------------2.1.0---------------------------
	public static final String HAVELOGOFFBUTTON = "havelogoffbutton";
	public static final String JULEIGAILAN = "juleigailan";
	
	//--------------------2.1.1------------------------
	public static final String VIEWGB = "viewGB";
	public static final String VIEWGBTIFNUM = "viewGBTIFnum";
	public static final String VIEWGBFEIYE = "viewgbfeiye";
	public static final String DETAILYZ = "detailyz";
	//public static final String VIEWLAWGB= "viewlawgb";
	
	public static final String VIEWSWGB = "viewSWGB";
	public static final String VIEWSWGBTIFNUM = "viewSWGBTIFnum";
	public static final String VIEWSWGBFEIYE = "viewswgbfeiye";
	public static final String DETAILTONGZUTABLE = "detailtongzutable";
	
	//-----------------------2.1.2----------------------
	public static final String FRZHAIYAOPIC47 = "frzhaiyaopic47";
	public static final String PHYSICALREPORT = "physicalreport";
	//#-------------------2.1.4-----------------
	public static final String VIEWWGSMALLPIC  = "viewwgsmallpic";
	
	//----------------------2.1.5----------------
	public static final String VIEWTIF= "viewtif";
	
}
