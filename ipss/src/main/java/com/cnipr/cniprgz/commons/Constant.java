/**
 * 
 */
package com.cnipr.cniprgz.commons;

import java.util.HashMap;
import java.util.Map;

public class Constant {
	 
	
	 
	public static Map	periodMap = new HashMap();
		
	/** 减少 标志 */
	public final static String DECREASE = "decrease";//
	/** 增加 标志 */
	public final static String INCREASE = "increase";//
	
	//每页代码化显示的页数
	public static int XmlPageNUM = 150;
	
	//定期预警分页数
	public static int WARNPAGESIZE = 20;
	
	// ------------------ 数据权限功能点名称 ，与数据库ipr_dataauthority表function字段一致  ------------------
	public static final String AUTH_FUNC_OVERVIEW_SEARCH = "overviewSearch";
	
	public static final String AUTH_FUNC_XML_VIEW = "viewXml";
	
	public static final String AUTH_FUNC_DETAIL_SEARCH = "detailSearch";
	
	public static final String AUTH_FUNC_ABSTRACT_DOWNLOAD = "downloadAbstract";
	
	public static final String AUTH_FUNC_ABSTRACT_PRINT = "abstractPrint";
	
	public static final String AUTH_FUNC_XML_DOWNLOAD = "downloadXml";
	
	public static final String AUTH_FUNC_DOC_DOWNLOAD = "documentDownload";
	
	public static final String AUTH_FUNC_XML_PRINT = "printXml";
	
	// ----------------------------------------------------------------
	
	public static final int MAX_CORP_GROUP_MEMBER_NUM = 500;

	public static final String APP_USER_NAME = "username";
	
	public static final String APP_USER_PWD = "userpwd";

	public static final String APP_LOGIN_ERROR = "login_error";

	public static final String APP_USER_ID = "userid";

	public static final String APP_USER_INFOS = "app_user_infos";
	
	public static final String APP_USER_CHANNELID = "user_channel_id";

	public static final String APP_USER_ITEMGRANT = "user_itemGrant";
	
	public static final String APP_USER_ROLE = "user_group";
	
	public static final String APP_USER_FEETYPE = "user_feetype";

	public static final String INFO = "info";

	public static final String LOGIN_ERROR = "login_error";
	
	public static final String SEARCH_AUTHEN_ERROR = "search_authen_error";
	
	public static final int MAX_FAVORITE_COUNT = 50;
	
	public static final int HYK_ID = 749;
	
	public static final int QYK_ID = 750;
	
	public static final int GRK_ID = 751;
	
	public static final String AUTH_FUNC_XML_BATCHDOWNLOAD = "doBatchDownloadXML";

	/***************************************************************************
	 * TRS表中字段名称 命名规则：拼音方式，每个字以下划线分隔，超过三个字的取首字母
	 **************************************************************************/
	// 公开（公告）号
	public static final String GONG_KAI_HAO = "公开（公告）号";

	// 公开（公告）日
	public static final String GONG_KAI_RI = "公开（公告）日";

	// 申请号
	public static final String SHEN_QING_HAO = "申请号";

	// 公开（公告）日
	public static final String SHENG_QING_RI = "申请日";

	// 专利号
	public static final String ZHUAN_LI_HAO = "专利号";

	// 名称
	public static final String MING_CHENG = "名称";

	// 主分类号
	public static final String ZHU_FEN_LEI_H = "主分类号";

	// 分类号
	public static final String FEN_LEI_HAO = "分类号";

	// 申请（专利权）人
	public static final String SHEN_QING_REN = "申请（专利权）人";

	// 发明（设计）人
	public static final String FA_MING_REN = "发明（设计）人";

	// 摘要
	public static final String ZHAI_YAO = "摘要";

	// 主权项
	public static final String ZHU_QUAN_XIANG = "主权项";

	// 优先权
	public static final String YOU_XIAN_QUAN = "优先权";

	// 同族专利项
	public static final String TONG_ZU_ZHUAN_LX = "同族专利项";

	// 国省代码
	public static final String GUO_SHENG_DAI_M = "国省代码";

	// 分案原申请号
	public static final String FEN_AN_YUAN_SQH = "分案原申请号";

	// 地址
	public static final String DI_ZHI = "地址";

	// 专利代理机构
	public static final String ZHUAN_LI_DAI_LJG = "专利代理机构";

	// 代理人
	public static final String DAI_LI_REN = "代理人";

	// 审查员
	public static final String SHEN_CHA_YUAN = "审查员";

	// 颁证日
	public static final String BAN_ZHENG_RI = "颁证日";

	// 国际申请
	public static final String GUO_JI_SHEN_Q = "国际申请";

	// 国际公布
	public static final String GUO_JI_GONG_B = "国际公布";

	// 进入国家日期
	public static final String GUO_JIA_RI_Q = "进入国家日期";

	// 摘要附图存储路径
	public static final String ZHUAI_YAO_FU_TCCLJ = "摘要附图存储路径";

	// 欧洲主分类号
	public static final String OU_ZHOU_ZHU_FLH = "欧洲主分类号";

	// 欧洲分类号
	public static final String OU_ZHOU_FEN_LH = "欧洲分类号";

	// 本国主分类号
	public static final String BEN_GUO_ZHU_FLH = "本国主分类号";

	// 本国分类号
	public static final String BEN_GUO_FEN_LH = "本国分类号";

	// 发布路径
	public static final String FA_BU_LU_J = "发布路径";

	// 页数
	public static final String YE_SHU = "页数";

	// 申请国代码
	public static final String SHIN_QING_GUO_DM = "申请国代码";

	// 专利类型
	public static final String ZHUAN_LI_LEI_X = "专利类型";

	// 申请来源
	public static final String SHEN_QING_LAI_Y = "申请来源";

	// 参考文献
	public static final String CAN_KAO_WEN_X = "参考文献";

	// 范畴分类
	public static final String FAN_CHOU_FEN_L = "范畴分类";

	// 权利要求书
	public static final String QUAN_LI_YAO_QS = "权利要求书";

	// 说明书
	public static final String SHUO_MING_SHU = "说明书";

	// 说明书附图
	public static final String SHUO_MING_SHU_FT = "说明书附图";

	// 权利要求书页数
	public static final String QUAN_LI_YAO_QSYS = "权利要求书页数";

	// 说明书页数
	public static final String SHUO_MING_SHU_YS = "说明书页数";

	// 说明书附图页数
	public static final String SHUO_MING_SHU_FTYS = "说明书附图页数";

	/***************************************************************************
	 * 搜索结果分页页面相关配置
	 **************************************************************************/
	// 每页显示记录数
	public static  int PAGERECORD = 10;

	static{
		String PAGERECORD_str = SetupAccess.getProperty("PAGERECORD");
		if(null!=PAGERECORD_str && PAGERECORD_str.equals("")==false)
			PAGERECORD = Integer.parseInt(PAGERECORD_str);
		
		String XmlPageNUM_str = SetupAccess.getProperty(SetupConstant.XMLPAGENUM);
		if(null!=XmlPageNUM_str && XmlPageNUM_str.equals("")==false)
			XmlPageNUM  = Integer.parseInt(XmlPageNUM_str);
		
		
		periodMap.put(1, "每周"); 
		periodMap.put(3, "每月");
		//periodMap.put(4, "每季度");		 
	}
	 
}
