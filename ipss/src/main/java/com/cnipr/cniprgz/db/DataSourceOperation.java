// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   DataSourceOperation.java

package com.cnipr.cniprgz.db;

//import com.eprobiti.trs.TRSConnection;
//import com.eprobiti.trs.TRSConstant;
//import com.eprobiti.trs.TRSException;
//import com.eprobiti.trs.TRSResultSet;

//Referenced classes of package com.trs.was.datasource:
//WASColumn, WASTable, WASRecord, RDBOperation, 
//TRSOperation

public class DataSourceOperation {

//	public DataSourceOperation() {
//	}
//
//	public static void setExtension(TRSConnection trsconnection, String s) {
//		if (trsconnection == null) {
//		}
//		if (s == null) {
//		}
//		if (!s.equalsIgnoreCase(""))
//			try {
//				if (s.equalsIgnoreCase("all"))
//					trsconnection.setAutoExtend("", "", "", 2047);
//				if (s.equalsIgnoreCase("st"))
//					trsconnection.setAutoExtend("", "", "", 1);
//				if (s.equalsIgnoreCase("at"))
//					trsconnection.setAutoExtend("", "", "", 2);
//				if (s.equalsIgnoreCase("pt"))
//					trsconnection.setAutoExtend("", "", "", 4);
//				if (s.equalsIgnoreCase("uf"))
//					trsconnection.setAutoExtend("", "", "", 8);
//				if (s.equalsIgnoreCase("rt"))
//					trsconnection.setAutoExtend("", "", "", 64);
//				if (s.equalsIgnoreCase("ab"))
//					trsconnection.setAutoExtend("", "", "", 16);
//				if (s.equalsIgnoreCase("abf"))
//					trsconnection.setAutoExtend("", "", "", 32);
//				if (s.equalsIgnoreCase("bt"))
//					trsconnection.setAutoExtend("", "", "", 128);
//				if (s.equalsIgnoreCase("nt"))
//					trsconnection.setAutoExtend("", "", "", 256);
//				if (s.equalsIgnoreCase("allnt"))
//					trsconnection.setAutoExtend("", "", "", 1024);
//				if (s.equalsIgnoreCase("allbt"))
//					trsconnection.setAutoExtend("", "", "", 512);
//			} catch (TRSException trsexception) {
//			}
//		else
//			try {
//				trsconnection.setAutoExtend("", "", "", 0);
//			} catch (TRSException trsexception1) {
//			}
//	}
//
//	@SuppressWarnings("finally")
//	public static TRSResultSet executeSelect(TRSConnection trsconnection,
//			String strSources, String strWhere, String strSortMethod, String strStat, String strDefautCols, int cizi,
//			int iHitPointType, boolean flag) {
//		TRSResultSet trsresultset = null;
//		try {
//			System.out
//					.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
//			System.out.println("DataSourceOperation-->s��" + strSources);
//			System.out.println("DataSourceOperation-->s1��" + strWhere);
//			System.out.println("DataSourceOperation-->s2��" + strSortMethod);
//			System.out.println("DataSourceOperation-->s3��" + strStat);
//			System.out.println("DataSourceOperation-->s4��" + strDefautCols);
//			System.out.println("DataSourceOperation-->cizi��" + cizi);
//			System.out.println("DataSourceOperation-->j��" + iHitPointType);
//			System.out.println("DataSourceOperation-->flag��" + flag);
//			System.out
//					.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
//
//			int ioption = cizi;
//			if (!strSortMethod.equals("RELEVANCE")) {
//				ioption = cizi | TRSConstant.TCM_MIXSORT;
//			}
//
//			trsresultset = trsconnection.executeSelect(strSources, strWhere, strSortMethod, strStat, strDefautCols,
//					ioption, iHitPointType, flag);
//
//		} catch (TRSException trsexception) {
//		} catch (Exception exception) {
//		} finally {
//			return trsresultset;
//		}
//	}
//
//	public static void setBufferSize(TRSResultSet trsresultset, int i, int j) {
//		if (trsresultset == null) {
//		}
//		try {
//			trsresultset.setBufferSize(i, j);
//		} catch (TRSException trsexception) {
//		} catch (Exception exception) {
//		}
//	}
//
//	public static void setReadOptions(TRSResultSet trsresultset, int i,
//			String s, String s1) {
//		if (trsresultset == null) {
//		}
//		if (s == null) {
//		}
//		if (s1 == null) {
//		}
//		try {
//			// DataSourceOperation.setReadOptions(trsresultset, 115, s1, "");
//			trsresultset
//					.setReadOptions(
//							TRSConstant.TCE_ROWCOL,
//							"公开（公告）号; 公开（公告）日; 申请号; 申请日; 专利号; 名称; 主分类号; 分类号; 申请（专利权）人; 发明（设计）人; 摘要; 主权项; 优先权; 同族专利项; 国省代码; 分案原申请号; 地址; 专利代理机构; 代理人; 审查员; 颁证日; 国际申请; 国际公布; 进入国家日期; 摘要附图存储路径; 欧洲主分类号; 欧洲分类号; 本国主分类号; 本国分类号; 发布路径; 页数; 申请来源; 范畴分类",
//							";");
//			// trsresultset.setReadOptions(i, s, s1);
//			// trsresultset.setReadOptions(TRSConstant.TCE_OFFSET, "", "");
//		} catch (TRSException trsexception) {
//		} catch (Exception exception) {
//		}
//	}
//
//	public static void close(TRSResultSet trsresultset) throws Exception {
//		if (trsresultset == null)
//			throw new Exception("#TRS数据源结果集参数为空#DataSourceOperation.close#");
//		try {
//			trsresultset.close();
//		} catch (Exception exception) {
//			throw new Exception("#关闭TRS数据源结果集出现异常#DataSourceOperation.close#"
//					+ exception.getMessage());
//		}
//	}
//
//	public static void close(TRSConnection trsconnection) throws Exception {
//		if (trsconnection == null)
//			throw new Exception("#TRS连接参数为空#DataSourceOperation.close#");
//		try {
//			trsconnection.close();
//		} catch (Exception exception) {
//			throw new Exception("#关闭RS连接出现异常#DataSourceOperation.close#"
//					+ exception.getMessage());
//		}
//	}

}
