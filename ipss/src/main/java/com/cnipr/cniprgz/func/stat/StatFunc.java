package com.cnipr.cniprgz.func.stat;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;
import javax.servlet.http.HttpServletResponse;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.cniprgz.commons.PathUtil;
import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.func.download.JspFileDownload;

/**
 * 平台统计
 * @author zhaoliang
 *
 */
public class StatFunc {
	
	private String userName;
	
	private String tempFilePath = PathUtil.getAbsoluteWebPath()+"/temp/";//DataAccess.getProperty("tempFilePath")
	
	int pageSize = 20;
	
	public StatFunc(){
		
	}
	
	public StatFunc(String userName){
		this.userName = userName;
	}

	/**
	 * 用户登录统计列表
	 * @param userid
	 * @param currentPage
	 * @return
	 */
	public Page<StatBean> loginList(String userName,int currentPage,int type){
		Page<StatBean> page = new Page<StatBean>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql ="select user.chrUserName as userName,user.chrRealName as realName,log.dtVisitTime,log.chrVisitIP from ipr_user user,ipr_login_logs log where user.chrUserName=log.chrUserName and log.chrUserName=? limit ?,?";
		String countSql = "select count(1) as cnt from ipr_user user,ipr_login_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?";
		//按照月份统计
		if(type==1){
			sql = "select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y-%m') as visitTime from ipr_user user,ipr_login_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime order by visitTime desc";
			countSql = "select count(1) cnt from (select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y-%m') as visitTime from ipr_user user,ipr_login_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime) t";
		//按照年份统计
		}else if(type==2){
			sql = "select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y') as visitTime from ipr_user user,ipr_login_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime order by visitTime desc";
			countSql = "select count(1) cnt from (select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y') as visitTime from ipr_user user,ipr_login_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime) t";
		}
		List<StatBean> resultList = new ArrayList<StatBean>();
		try {
			int start = (currentPage-1) * pageSize;
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, userName);
			//不是按记录统计的则需要设置分页
			if(type!=1 && type!=2){
				ps.setInt(2, start);
				ps.setInt(3, pageSize);
			}
			rs = ps.executeQuery();
			while(rs.next()){
				StatBean bean = new StatBean();
				bean.setUserName(userName);
				String vTime = rs.getString("visitTime");
				if(type==1){
					vTime = vTime.replace("-", "年") + "月";
				}else if(type==2){
					vTime += "年";
				}
				bean.setStrTime(vTime);
				bean.setRealName(rs.getString("realName"));
				bean.setCount(rs.getInt("cnt"));
				resultList.add(bean);
			}
			//设置结果列表
			page.setResultList(resultList);
			//设置每页显示记录数量
			page.setPageSize(pageSize);
			//设置当前页码
			page.setCurrentPage(currentPage);
			rs.close();
			ps.close();
			ps = conn.prepareStatement(countSql);
			ps.setString(1, userName);
			rs = ps.executeQuery();
			int totalCount = 0; 
			if(rs.next()){
				totalCount = rs.getInt("cnt");
			}
			page.setTotalCount(totalCount);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return page;
	}
	
	public List<StatBean> statDetail(int userid,int n){
		List<StatBean> list = new ArrayList<StatBean>();
		Date dt = new Date();
//		String realName = getRealName(userName);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
		for(int i=0;i<n;i++){
			
			String searchTime = format.format(dt);
			StatBean bean = new StatBean();
//			bean.setRealName(realName);
			String disTime = searchTime.replace("-", "年") + "月";
			bean.setStrTime(disTime);
			//登录统计
			int loginCount = statSearch(userid,searchTime,"login");
			bean.setLoginCount(loginCount);
			//检索统计
			int searchCount = statSearch(userid,searchTime,"search");
			bean.setSearchCount(searchCount);
			//查看统计
			int viewCount = statSearch(userid,searchTime,"view");
			bean.setViewCount(viewCount);
			/** 查看国外文摘 */
			int viewFrCount = statSearch(userid,searchTime,"viewFr");
			bean.setViewFrCount(viewFrCount);
			/** 发明授权说明书浏览  */
//			int viewSQDocCount = statSearch(userid,searchTime,"view_docSQ");
//			bean.setViewSQDocCount(viewSQDocCount);
			/** 实用新型说明书浏览  */
//			int viewXXDocCount = statSearch(userid,searchTime,"view_docXX");
//			bean.setViewXXDocCount(viewXXDocCount);
			/** 外观设计说明书浏览  */
//			int viewWGDocCount = statSearch(userid,searchTime,"view_docWG");
//			bean.setViewWGDocCount(viewWGDocCount);
			//查看说明书统计
			int viewDocCount = statSearch(userid,searchTime,"view_doc");
			bean.setViewDocCount(viewDocCount);
			//查看代码化统计
//			int viewXmlCount = statSearch(userName,searchTime,"view_xml");
//			bean.setViewXmlCount(viewXmlCount);
			//下载著录项统计
//			int downloadCount = statSearch(userid,searchTime,"download");
//			bean.setDownloadCount(downloadCount);
			//下载说明书统计
//			int downloadDocCount = statSearch(userid,searchTime,"download_doc");
//			bean.setDownloadDocCount(downloadDocCount);
			//下载代码化统计
//			int downloadXmlCount = statSearch(userName,searchTime,"download_xml");
//			bean.setDownloadXmlCount(downloadXmlCount);
			//打印著录项统计
//			int printCount = statSearch(userName,searchTime,"print");
//			bean.setPrintCount(printCount);
			//打印说明书统计
//			int printDocCount = statSearch(userid,searchTime,"print_doc");
//			bean.setPrintDocCount(printDocCount);
			//打印代码化统计
//			int printXmlCount = statSearch(userName,searchTime,"print_xml");
//			bean.setPrintXmlCount(printXmlCount);
			//添加到列表
			list.add(bean);
			dt = getDateAddMonth(dt,-1);
		}
		return list;
	}
	
	public List<StatBean> statDetail(int userid,String startTime,String endTime) throws ParseException{
		List<StatBean> list = new ArrayList<StatBean>();
//		String realName = getRealName(userName);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
		Date startDt = format.parse(startTime); 
		String searchTime = endTime;
		while(true){
			StatBean bean = new StatBean();
//			bean.setRealName(realName);
			String disTime = searchTime.replace("-", "年") + "月";
			bean.setStrTime(disTime);
			//登录统计
			int loginCount = statSearch(userid,searchTime,"login");
			bean.setLoginCount(loginCount);
			//检索统计
			int searchCount = statSearch(userid,searchTime,"search");
			bean.setSearchCount(searchCount);
			//查看统计
			int viewCount = statSearch(userid,searchTime,"view");
			bean.setViewCount(viewCount);
			/** 查看国外文摘 */
			int viewFrCount = statSearch(userid,searchTime,"viewFr");
			bean.setViewFrCount(viewFrCount);
			/** 发明授权说明书浏览  */
//			int viewSQDocCount = statSearch(userid,searchTime,"view_docSQ");
//			bean.setViewSQDocCount(viewSQDocCount);
			/** 实用新型说明书浏览  */
//			int viewXXDocCount = statSearch(userid,searchTime,"view_docXX");
//			bean.setViewXXDocCount(viewXXDocCount);
			/** 外观设计说明书浏览  */
//			int viewWGDocCount = statSearch(userid,searchTime,"view_docWG");
//			bean.setViewWGDocCount(viewWGDocCount);
			//查看说明书统计
//			int viewDocCount = statSearch(userid,searchTime,"view_doc");
//			bean.setViewDocCount(viewDocCount);
			//查看代码化统计
//			int viewXmlCount = statSearch(userName,searchTime,"view_xml");
//			bean.setViewXmlCount(viewXmlCount);
			//下载著录项统计
//			int downloadCount = statSearch(userid,searchTime,"download");
//			bean.setDownloadCount(downloadCount);
			//下载说明书统计
//			int downloadDocCount = statSearch(userid,searchTime,"download_doc");
//			bean.setDownloadDocCount(downloadDocCount);
			//下载代码化统计
//			int downloadXmlCount = statSearch(userName,searchTime,"download_xml");
//			bean.setDownloadXmlCount(downloadXmlCount);
			//打印著录项统计
//			int printCount = statSearch(userName,searchTime,"print");
//			bean.setPrintCount(printCount);
			//打印说明书统计
//			int printDocCount = statSearch(userid,searchTime,"print_doc");
//			bean.setPrintDocCount(printDocCount);
			//打印代码化统计
//			int printXmlCount = statSearch(userName,searchTime,"print_xml");
//			bean.setPrintXmlCount(printXmlCount);
			//添加到列表
			list.add(bean);
			Date dt = format.parse(searchTime);
			dt = getDateAddMonth(dt,-1);
			if(dt.getTime()<startDt.getTime()){
				break;
			}
			searchTime = format.format(dt);
		}
		
		return list;
	}
	
	public static void main(String[] args) {
		StatFunc func = new StatFunc();
		List<StatBean> ls = func.statDetail(2, 12);
		for(StatBean b: ls){
			System.out.println(b.getRealName());
			System.out.println(b.getStrTime());
			System.out.println(b.getLoginCount());
			System.out.println(b.getSearchCount());
			System.out.println("**********");
		}
		
	}
	
	/**
	    * 取得几个月前[相对于今天]的日期
	    * @return
	    */
	public Date getDateAddMonth(Date date,int months)
	{		  
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MONTH, months);

		return calendar.getTime();
	 }
	
	public String getRealName(String userName){
		String sql = "select chrRealName from ipr_user where chrUserName=?";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String result = "未知用户";
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, userName);
			//不是按记录统计的则需要设置分页
			rs = ps.executeQuery();
			if(rs.next()){
				result = rs.getString("chrRealName");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return result;
	}
	
	private int statSearch(int userid,String visitTime,String table){
		String sql = "select count(1) as cnt from ipr_" + table + "_logs where intUserID=? and DATE_FORMAT(dtVisitTime,'%Y-%m')=?";
//		查看国外文摘浏览量
		if("viewFr".equals(table)){
			sql = "select count(1) as cnt from ipr_view_logs where intUserID=? and intGrantID=95 and DATE_FORMAT(dtVisitTime,'%Y-%m')=?";
		}else if(table!=null && table.startsWith("view_doc") && table.indexOf("SQ")>-1){
			sql = "select count(1) as cnt from ipr_view_doc_logs where intUserID=? and intGrantID=89 and DATE_FORMAT(dtVisitTime,'%Y-%m')=?";
		}else if(table!=null && table.startsWith("view_doc") && table.indexOf("XX")>-1){
			sql = "select count(1) as cnt from ipr_view_doc_logs where intUserID=? and intGrantID=71 and DATE_FORMAT(dtVisitTime,'%Y-%m')=?";
		}else if(table!=null && table.startsWith("view_doc") && table.indexOf("WG")>-1){
			sql = "select count(1) as cnt from ipr_view_doc_logs where intUserID=? and intGrantID=80 and DATE_FORMAT(dtVisitTime,'%Y-%m')=?";
		}
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int result = 0;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, userid);
			ps.setString(2, visitTime);
			//不是按记录统计的则需要设置分页
			rs = ps.executeQuery();
			if(rs.next()){
				result = rs.getInt("cnt");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return result;
	}

	public String getEarliestTime(int userid) {
		String earliesttime = "";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "SELECT dtVisitTime FROM "
				+ "("
				+ "SELECT * FROM (SELECT dtVisitTime FROM ipr_login_logs WHERE intUserID="+userid+" ORDER BY dtVisitTime) AS p1 "
				+ "UNION "
				+ "SELECT * FROM (SELECT dtVisitTime FROM ipr_search_logs WHERE intUserID="+userid+" ORDER BY dtVisitTime) AS p2"
				+ ")as p3 "
				+ "ORDER BY dtVisitTime";
		
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()){
				earliesttime = rs.getString("dtVisitTime");
			}
		
		}catch(Exception ex)
		{
			
		}
		
		return earliesttime;
	}
	
	/**
	 * 
	 * @param currentPage
	 * @return
	 */
	public Page<StatBean> loginGroupList(int currentPage){
		Page<StatBean> page = new Page<StatBean>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
//		String sql ="select user.chrUserName,r.cnt, user.chrRealName from (select chrUserName, count(1) as cnt from ipr_login_logs group by chrUserName) r,ipr_user user where user.chrUserName=r.chrUserName order by r.cnt desc limit ?,?";
//		String countSql = "select count(1) as cnt from (select user.chrRealName as chrUserName,count(1) as cnt from ipr_login_logs log,ipr_user user where user.chrUserName=log.chrUserName group by chrUserName) r";
		
//		String sql = "select u.chrUserName,u.chrRealName, (case when r.cnt is null then 0 else r.cnt end) cnt from ipr_user u left join (select chrUserName,count(1) cnt from ipr_login_logs group by chrUserName order by cnt) r on u.chrUserName=r.chrUserName order by cnt desc limit ?,?";
//		String countSql = "select count(1) cnt from ipr_user";
		
		String sql = "select u.intUserID,u.chrUserName,u.chrRealName, "
						+ "(case when r.cnt is null then 0 else r.cnt end) cnt "
						+ "from ipr_user u left join "
						+ "(select intUserID,count(1) cnt from ipr_login_logs group by intUserID order by cnt) r on "
						+ "u.intUserID=r.intUserID order by cnt desc limit ?,?";
		String countSql = "select count(1) cnt from ipr_user";
		
		List<StatBean> resultList = new ArrayList<StatBean>();
		try {
			int start = (currentPage-1) * pageSize;
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, pageSize);
			rs = ps.executeQuery();
			while(rs.next()){
				StatBean bean = new StatBean();
				bean.setUserID(rs.getInt("intUserID"));
				bean.setUserName(rs.getString("chrUserName"));
				bean.setRealName(rs.getString("chrRealName"));
				bean.setCount(rs.getInt("cnt"));
				resultList.add(bean);
			}
			//设置结果列表
			page.setResultList(resultList);
			//设置当前页码
			page.setCurrentPage(currentPage);
			page.setPageSize(pageSize);
			rs.close();
			ps.close();
			ps = conn.prepareStatement(countSql);
			rs = ps.executeQuery();
			int cnt = 0;
			if(rs.next()){
				cnt = rs.getInt("cnt");
			}
			//设置记录总数
			page.setTotalCount(cnt);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return page;
	}
	
	/**
	 * 用户检索统计列表
	 * @param userid
	 * @param currentPage
	 * @return
	 */
	public Page<StatBean> searchList(String userName,int currentPage,int type){
		Page<StatBean> page = new Page<StatBean>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql ="select user.chrUserName as userName,user.chrRealName as realName,log.dtVisitTime,log.chrVisitIP from ipr_user user,ipr_search_logs log where user.chrUserName=log.chrUserName and log.chrUserName=? limit ?,?";
		String countSql = "select count(1) as cnt from ipr_user user,ipr_search_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?";
		//按照月份统计
		if(type==1){
			sql = "select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y-%m') as visitTime from ipr_user user,ipr_search_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime order by visitTime desc";
			countSql = "select count(1) cnt from (select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y-%m') as visitTime from ipr_user user,ipr_search_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime) t";
		//按照年份统计
		}else if(type==2){
			sql = "select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y') as visitTime from ipr_user user,ipr_search_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime order by visitTime desc";
			countSql = "select count(1) cnt from (select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y') as visitTime from ipr_user user,ipr_search_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime) t";
		}
		List<StatBean> resultList = new ArrayList<StatBean>();
		try {
			int start = (currentPage-1) * pageSize;
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, userName);
			//不是按记录统计的则需要设置分页
			if(type!=1 && type!=2){
				ps.setInt(2, start);
				ps.setInt(3, pageSize);
			}
			rs = ps.executeQuery();
			while(rs.next()){
				StatBean bean = new StatBean();
				bean.setUserName(userName);
				String vTime = rs.getString("visitTime");
				if(type==1){
					vTime = vTime.replace("-", "年") + "月";
				}else if(type==2){
					vTime += "年";
				}
				bean.setStrTime(vTime);
				bean.setRealName(rs.getString("realName"));
				bean.setCount(rs.getInt("cnt"));
				resultList.add(bean);
			}
			//设置结果列表
			page.setResultList(resultList);
			//设置每页显示记录数量
			page.setPageSize(pageSize);
			//设置当前页码
			page.setCurrentPage(currentPage);
			rs.close();
			ps.close();
			ps = conn.prepareStatement(countSql);
			ps.setString(1, userName);
			rs = ps.executeQuery();
			int totalCount = 0; 
			if(rs.next()){
				totalCount = rs.getInt("cnt");
			}
			page.setTotalCount(totalCount);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return page;
	}
	
	/**
	 * 用户检索量总体概览
	 * @param currentPage
	 * @return
	 */
	public Page<StatBean> searchGroupList(int currentPage){
		Page<StatBean> page = new Page<StatBean>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql ="select u.intUserID,u.chrUserName,u.chrRealName, (case when r.cnt is null then 0 else r.cnt end) cnt from ipr_user u left join (select intUserID,count(1) cnt from ipr_search_logs group by intUserID order by cnt) r on u.intUserID=r.intUserID order by cnt desc limit ?,?";
		String countSql = "select count(1) as cnt from ipr_user";
//		String sql ="select user.chrUserName,r.cnt, user.chrRealName from (select chrUserName, count(1) as cnt from ipr_search_logs group by chrUserName) r,ipr_user user where user.chrUserName=r.chrUserName order by r.cnt desc limit ?,?";
//		String countSql = "select count(1) as cnt from (select user.chrRealName as chrUserName,count(1) as cnt from ipr_search_logs log,ipr_user user where user.chrUserName=log.chrUserName group by chrUserName) r";
		List<StatBean> resultList = new ArrayList<StatBean>();
		try {
			int start = (currentPage-1) * pageSize;
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, pageSize);
			rs = ps.executeQuery();
			while(rs.next()){
				StatBean bean = new StatBean();
				bean.setUserID(rs.getInt("intUserID"));
				bean.setUserName(rs.getString("chrUserName"));
				bean.setRealName(rs.getString("chrRealName"));
				bean.setCount(rs.getInt("cnt"));
				resultList.add(bean);
			}
			//设置结果列表
			page.setResultList(resultList);
			//设置当前页码
			page.setCurrentPage(currentPage);
			page.setPageSize(pageSize);
			rs.close();
			ps.close();
			ps = conn.prepareStatement(countSql);
			rs = ps.executeQuery();
			int cnt = 0;
			if(rs.next()){
				cnt = rs.getInt("cnt");
			}
			//设置记录总数
			page.setTotalCount(cnt);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return page;
	}
	
	
	/**
	 * 用户查看统计列表
	 * @param userid
	 * @param currentPage
	 * @return
	 */
	public Page<StatBean> viewList(String userName,int currentPage,int type){
		Page<StatBean> page = new Page<StatBean>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql ="select user.chrUserName as userName,user.chrRealName as realName,log.dtVisitTime,log.chrVisitIP from ipr_user user,ipr_view_logs log where user.chrUserName=log.chrUserName and log.chrUserName=? limit ?,?";
		String countSql = "select count(1) as cnt from ipr_user user,ipr_view_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?";
		//按照月份统计
		if(type==1){
			sql = "select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y-%m') as visitTime from ipr_user user,ipr_view_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime order by visitTime desc";
			countSql = "select count(1) cnt from (select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y-%m') as visitTime from ipr_user user,ipr_view_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime) t";
		//按照年份统计
		}else if(type==2){
			sql = "select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y') as visitTime from ipr_user user,ipr_view_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime order by visitTime desc";
			countSql = "select count(1) cnt from (select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y') as visitTime from ipr_user user,ipr_view_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime) t";
		}
		List<StatBean> resultList = new ArrayList<StatBean>();
		try {
			int start = (currentPage-1) * pageSize;
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, userName);
			//不是按记录统计的则需要设置分页
			if(type!=1 && type!=2){
				ps.setInt(2, start);
				ps.setInt(3, pageSize);
			}
			rs = ps.executeQuery();
			while(rs.next()){
				StatBean bean = new StatBean();
				bean.setUserName(userName);
				String vTime = rs.getString("visitTime");
				if(type==1){
					vTime = vTime.replace("-", "年") + "月";
				}else if(type==2){
					vTime += "年";
				}
				bean.setStrTime(vTime);
				bean.setRealName(rs.getString("realName"));
				bean.setCount(rs.getInt("cnt"));
				resultList.add(bean);
			}
			//设置结果列表
			page.setResultList(resultList);
			//设置每页显示记录数量
			page.setPageSize(pageSize);
			//设置当前页码
			page.setCurrentPage(currentPage);
			rs.close();
			ps.close();
			ps = conn.prepareStatement(countSql);
			ps.setString(1, userName);
			rs = ps.executeQuery();
			int totalCount = 0; 
			if(rs.next()){
				totalCount = rs.getInt("cnt");
			}
			page.setTotalCount(totalCount);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return page;
	}
	
	/**
	 * 用户查看专利量总体概览
	 * @param currentPage
	 * @return
	 */
	public Page<StatBean> viewGroupList(int currentPage){
		Page<StatBean> page = new Page<StatBean>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql ="select u.intUserID,u.chrUserName,u.chrRealName, (case when r.cnt is null then 0 else r.cnt end) cnt from ipr_user u left join (select intUserID,count(1) cnt from ipr_view_logs group by intUserID order by cnt) r on u.intUserID=r.intUserID order by cnt desc limit ?,?";
		String countSql = "select count(1) as cnt from ipr_user";
//		String sql ="select user.chrUserName,r.cnt, user.chrRealName from (select chrUserName, count(1) as cnt from ipr_view_logs group by chrUserName) r,ipr_user user where user.chrUserName=r.chrUserName order by r.cnt desc limit ?,?";
//		String countSql = "select count(1) as cnt from (select user.chrRealName as chrUserName,count(1) as cnt from ipr_view_logs log,ipr_user user where user.chrUserName=log.chrUserName group by chrUserName) r";
		List<StatBean> resultList = new ArrayList<StatBean>();
		try {
			int start = (currentPage-1) * pageSize;
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, pageSize);
			rs = ps.executeQuery();
			while(rs.next()){
				StatBean bean = new StatBean();
				bean.setUserID(rs.getInt("intUserID"));
				bean.setUserName(rs.getString("chrUserName"));
				bean.setRealName(rs.getString("chrRealName"));
				bean.setCount(rs.getInt("cnt"));
				resultList.add(bean);
			}
			//设置结果列表
			page.setResultList(resultList);
			//设置当前页码
			page.setCurrentPage(currentPage);
			page.setPageSize(pageSize);
			rs.close();
			ps.close();
			ps = conn.prepareStatement(countSql);
			rs = ps.executeQuery();
			int cnt = 0;
			if(rs.next()){
				cnt = rs.getInt("cnt");
			}
			//设置记录总数
			page.setTotalCount(cnt);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return page;
	}
	
	/**
	 * 用户检索统计列表
	 * @param userid
	 * @param currentPage
	 * @return
	 */
	public Page<StatBean> printDocList(String userName,int currentPage,int type){
		Page<StatBean> page = new Page<StatBean>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql ="select user.chrUserName as userName,user.chrRealName as realName,log.dtVisitTime,log.chrVisitIP from ipr_user user,ipr_print_doc_logs log where user.chrUserName=log.chrUserName and log.chrUserName=? limit ?,?";
		String countSql = "select count(1) as cnt from ipr_user user,ipr_print_doc_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?";
		//按照月份统计
		if(type==1){
			sql = "select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y-%m') as visitTime from ipr_user user,ipr_print_doc_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime order by visitTime desc";
			countSql = "select count(1) cnt from (select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y-%m') as visitTime from ipr_user user,ipr_print_doc_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime) t";
		//按照年份统计
		}else if(type==2){
			sql = "select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y') as visitTime from ipr_user user,ipr_print_doc_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime order by visitTime desc";
			countSql = "select count(1) cnt from (select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y') as visitTime from ipr_user user,ipr_print_doc_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime) t";
		}
		List<StatBean> resultList = new ArrayList<StatBean>();
		try {
			int start = (currentPage-1) * pageSize;
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, userName);
			//不是按记录统计的则需要设置分页
			if(type!=1 && type!=2){
				ps.setInt(2, start);
				ps.setInt(3, pageSize);
			}
			rs = ps.executeQuery();
			while(rs.next()){
				StatBean bean = new StatBean();
				bean.setUserName(userName);
				String vTime = rs.getString("visitTime");
				if(type==1){
					vTime = vTime.replace("-", "年") + "月";
				}else if(type==2){
					vTime += "年";
				}
				bean.setStrTime(vTime);
				bean.setRealName(rs.getString("realName"));
				bean.setCount(rs.getInt("cnt"));
				resultList.add(bean);
			}
			//设置结果列表
			page.setResultList(resultList);
			//设置每页显示记录数量
			page.setPageSize(pageSize);
			//设置当前页码
			page.setCurrentPage(currentPage);
			rs.close();
			ps.close();
			ps = conn.prepareStatement(countSql);
			ps.setString(1, userName);
			rs = ps.executeQuery();
			int totalCount = 0; 
			if(rs.next()){
				totalCount = rs.getInt("cnt");
			}
			page.setTotalCount(totalCount);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return page;
	}
	
	/**
	 * 用户打印说明书量总体概览
	 * @param currentPage
	 * @return
	 */
	public Page<StatBean> printDocGroupList(int currentPage){
		Page<StatBean> page = new Page<StatBean>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql ="select u.chrUserName,u.chrRealName, (case when r.cnt is null then 0 else r.cnt end) cnt from ipr_user u left join (select chrUserName,count(1) cnt from ipr_print_doc_logs group by chrUserName order by cnt) r on u.chrUserName=r.chrUserName order by cnt desc limit ?,?";
		String countSql = "select count(1) as cnt from ipr_user";
//		String sql ="select user.chrUserName,r.cnt, user.chrRealName from (select chrUserName, count(1) as cnt from ipr_print_doc_logs group by chrUserName) r,ipr_user user where user.chrUserName=r.chrUserName order by r.cnt desc limit ?,?";
//		String countSql = "select count(1) as cnt from (select user.chrRealName as chrUserName,count(1) as cnt from ipr_print_doc_logs log,ipr_user user where user.chrUserName=log.chrUserName group by chrUserName) r";
		List<StatBean> resultList = new ArrayList<StatBean>();
		try {
			int start = (currentPage-1) * pageSize;
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, pageSize);
			rs = ps.executeQuery();
			while(rs.next()){
				StatBean bean = new StatBean();
				bean.setUserName(rs.getString("chrUserName"));
				bean.setRealName(rs.getString("chrRealName"));
				bean.setCount(rs.getInt("cnt"));
				resultList.add(bean);
			}
			//设置结果列表
			page.setResultList(resultList);
			//设置当前页码
			page.setCurrentPage(currentPage);
			page.setPageSize(pageSize);
			rs.close();
			ps.close();
			ps = conn.prepareStatement(countSql);
			rs = ps.executeQuery();
			int cnt = 0;
			if(rs.next()){
				cnt = rs.getInt("cnt");
			}
			//设置记录总数
			page.setTotalCount(cnt);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return page;
	}
	
	/**
	 * 用户下载说明书统计列表
	 * @param userid
	 * @param currentPage
	 * @return
	 */
	public Page<StatBean> downloadDocList(String userName,int currentPage,int type){
		Page<StatBean> page = new Page<StatBean>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql ="select user.chrUserName as userName,user.chrRealName as realName,log.dtVisitTime,log.chrVisitIP from ipr_user user,ipr_download_doc_logs log where user.chrUserName=log.chrUserName and log.chrUserName=? limit ?,?";
		String countSql = "select count(1) as cnt from ipr_user user,ipr_download_doc_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?";
		//按照月份统计
		if(type==1){
			sql = "select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y-%m') as visitTime from ipr_user user,ipr_download_doc_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime order by visitTime desc";
			countSql = "select count(1) cnt from (select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y-%m') as visitTime from ipr_user user,ipr_download_doc_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime) t";
		//按照年份统计
		}else if(type==2){
			sql = "select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y') as visitTime from ipr_user user,ipr_download_doc_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime order by visitTime desc";
			countSql = "select count(1) cnt from (select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y') as visitTime from ipr_user user,ipr_download_doc_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime) t";
		}
		List<StatBean> resultList = new ArrayList<StatBean>();
		try {
			int start = (currentPage-1) * pageSize;
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, userName);
			//不是按记录统计的则需要设置分页
			if(type!=1 && type!=2){
				ps.setInt(2, start);
				ps.setInt(3, pageSize);
			}
			rs = ps.executeQuery();
			while(rs.next()){
				StatBean bean = new StatBean();
				bean.setUserName(userName);
				String vTime = rs.getString("visitTime");
				if(type==1){
					vTime = vTime.replace("-", "年") + "月";
				}else if(type==2){
					vTime += "年";
				}
				bean.setStrTime(vTime);
				bean.setRealName(rs.getString("realName"));
				bean.setCount(rs.getInt("cnt"));
				resultList.add(bean);
			}
			//设置结果列表
			page.setResultList(resultList);
			//设置每页显示记录数量
			page.setPageSize(pageSize);
			//设置当前页码
			page.setCurrentPage(currentPage);
			rs.close();
			ps.close();
			ps = conn.prepareStatement(countSql);
			ps.setString(1, userName);
			rs = ps.executeQuery();
			int totalCount = 0; 
			if(rs.next()){
				totalCount = rs.getInt("cnt");
			}
			page.setTotalCount(totalCount);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return page;
	}
	
	/**
	 * 用户下载说明书量总体概览
	 * @param currentPage
	 * @return
	 */
	public Page<StatBean> downloadDocGroupList(int currentPage){
		Page<StatBean> page = new Page<StatBean>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql ="select u.chrUserName,u.chrRealName, (case when r.cnt is null then 0 else r.cnt end) cnt from ipr_user u left join (select chrUserName,count(1) cnt from ipr_download_doc_logs group by chrUserName order by cnt) r on u.chrUserName=r.chrUserName order by cnt desc limit ?,?";
		String countSql = "select count(1) as cnt from ipr_user";
//		String sql ="select user.chrUserName,r.cnt, user.chrRealName from (select chrUserName, count(1) as cnt from ipr_download_doc_logs group by chrUserName) r,ipr_user user where user.chrUserName=r.chrUserName order by r.cnt desc limit ?,?";
//		String countSql = "select count(1) as cnt from (select user.chrRealName as chrUserName,count(1) as cnt from ipr_download_doc_logs log,ipr_user user where user.chrUserName=log.chrUserName group by chrUserName) r";
		List<StatBean> resultList = new ArrayList<StatBean>();
		try {
			int start = (currentPage-1) * pageSize;
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, pageSize);
			rs = ps.executeQuery();
			while(rs.next()){
				StatBean bean = new StatBean();
				bean.setUserName(rs.getString("chrUserName"));
				bean.setRealName(rs.getString("chrRealName"));
				bean.setCount(rs.getInt("cnt"));
				resultList.add(bean);
			}
			//设置结果列表
			page.setResultList(resultList);
			//设置当前页码
			page.setCurrentPage(currentPage);
			page.setPageSize(pageSize);
			rs.close();
			ps.close();
			ps = conn.prepareStatement(countSql);
			rs = ps.executeQuery();
			int cnt = 0;
			if(rs.next()){
				cnt = rs.getInt("cnt");
			}
			//设置记录总数
			page.setTotalCount(cnt);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return page;
	}
	
	/**
	 * 用户下载代码化统计列表
	 * @param userid
	 * @param currentPage
	 * @return
	 */
	public Page<StatBean> downloadXmlList(String userName,int currentPage,int type){
		Page<StatBean> page = new Page<StatBean>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql ="select user.chrUserName as userName,user.chrRealName as realName,log.dtVisitTime,log.chrVisitIP from ipr_user user,ipr_download_xml_logs log where user.chrUserName=log.chrUserName and log.chrUserName=? limit ?,?";
		String countSql = "select count(1) as cnt from ipr_user user,ipr_download_xml_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?";
		//按照月份统计
		if(type==1){
			sql = "select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y-%m') as visitTime from ipr_user user,ipr_download_xml_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime order by visitTime desc";
			countSql = "select count(1) cnt from (select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y-%m') as visitTime from ipr_user user,ipr_download_xml_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime) t";
		//按照年份统计
		}else if(type==2){
			sql = "select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y') as visitTime from ipr_user user,ipr_download_xml_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime order by visitTime desc";
			countSql = "select count(1) cnt from (select realName,count(1) cnt,visitTime from(select user.chrRealName as realName,DATE_FORMAT(log.dtVisitTime,'%Y') as visitTime from ipr_user user,ipr_download_xml_logs log where user.chrUserName=log.chrUserName and log.chrUserName=?) r group by r.realName, r.visitTime) t";
		}
		List<StatBean> resultList = new ArrayList<StatBean>();
		try {
			int start = (currentPage-1) * pageSize;
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, userName);
			//不是按记录统计的则需要设置分页
			if(type!=1 && type!=2){
				ps.setInt(2, start);
				ps.setInt(3, pageSize);
			}
			rs = ps.executeQuery();
			while(rs.next()){
				StatBean bean = new StatBean();
				bean.setUserName(userName);
				String vTime = rs.getString("visitTime");
				if(type==1){
					vTime = vTime.replace("-", "年") + "月";
				}else if(type==2){
					vTime += "年";
				}
				bean.setStrTime(vTime);
				bean.setRealName(rs.getString("realName"));
				bean.setCount(rs.getInt("cnt"));
				resultList.add(bean);
			}
			//设置结果列表
			page.setResultList(resultList);
			//设置每页显示记录数量
			page.setPageSize(pageSize);
			//设置当前页码
			page.setCurrentPage(currentPage);
			rs.close();
			ps.close();
			ps = conn.prepareStatement(countSql);
			ps.setString(1, userName);
			rs = ps.executeQuery();
			int totalCount = 0; 
			if(rs.next()){
				totalCount = rs.getInt("cnt");
			}
			page.setTotalCount(totalCount);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return page;
	}
	
	/**
	 * 用户下载代码化量总体概览
	 * @param currentPage
	 * @return
	 */
	public Page<StatBean> downloadXmlGroupList(int currentPage){
		Page<StatBean> page = new Page<StatBean>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql ="select u.chrUserName,u.chrRealName, (case when r.cnt is null then 0 else r.cnt end) cnt from ipr_user u left join (select chrUserName,count(1) cnt from ipr_download_xml_logs group by chrUserName order by cnt) r on u.chrUserName=r.chrUserName order by cnt desc limit ?,?";
		String countSql = "select count(1) as cnt from ipr_user";
		List<StatBean> resultList = new ArrayList<StatBean>();
		try {
			int start = (currentPage-1) * pageSize;
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, pageSize);
			rs = ps.executeQuery();
			while(rs.next()){
				StatBean bean = new StatBean();
				bean.setUserName(rs.getString("chrUserName"));
				bean.setRealName(rs.getString("chrRealName"));
				bean.setCount(rs.getInt("cnt"));
				resultList.add(bean);
			}
			//设置结果列表
			page.setResultList(resultList);
			//设置当前页码
			page.setCurrentPage(currentPage);
			page.setPageSize(pageSize);
			rs.close();
			ps.close();
			ps = conn.prepareStatement(countSql);
			rs = ps.executeQuery();
			int cnt = 0;
			if(rs.next()){
				cnt = rs.getInt("cnt");
			}
			//设置记录总数
			page.setTotalCount(cnt);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return page;
	}
	
	
	
	
	
	
	
	
	
	
	public void downloadZip(List<StatBean> list,String[] titles,HttpServletResponse response){
		try {
			 
			List<String> fileNames = createTempFile(list, titles);
			// 实例初始化
			JspFileDownload jfd = new JspFileDownload();
			// 设定response对象。
			jfd.setResponse(response);
			// 设定下载模式 1 多文件压缩成ZIP文件下载。
			jfd.setDownType(1);
			// 设定显示的文件名
			jfd.setDisFileName(UUID.randomUUID().toString() + ".zip");
			// 设定要下载的文件的路径（数组，绝对路径）
			// String[] s =
			// {"D:\\tools\\develop\\Tomcat6\\webapps\\cniprGZnew\\temp\\111.txt","D:\\tools\\develop\\Tomcat6\\webapps\\cniprGZnew\\temp\\222.txt"};
			jfd.setZipFileNames(fileNames);
			// 设定服务器端生成的zip文件是否保留。 true 删除 false 保留，默认为false
			jfd.setZipDelFlag(true);
			// 设定zip文件暂时保存的路径 （是文件夹）
			jfd.setZipFilePath(tempFilePath);
			// 主处理函数 注意返回值
			jfd.process();
			// 触发监听事件
//			this.fireEvent(new CniprEvent(this, !isGetPages, !isGetPages, patentList,
//					userId, userName, Constant.AUTH_FUNC_ABSTRACT_DOWNLOAD, 0,
//					0, userIp, feeType));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 创建临时文件
	 * @param list
	 * @param titles
	 * @return
	 */
	private List<String> createTempFile(List<StatBean> list,String[] titles){
		ArrayList<String> fileNames = new ArrayList<String>();
		try {
			fileNames.add(createXls(list, titles));
		} catch (RowsExceededException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WriteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return fileNames;
	}
	
	/**
	 * 生成导出的xls文件
	 * @param list
	 * @param titles
	 * @return
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws RowsExceededException 
	 */
	private String createXls(List<StatBean> list,String[] titles) throws IOException, RowsExceededException, WriteException{
		String xlsName = tempFilePath
				+ UUID.randomUUID().toString() + ".xls";
		
		WritableWorkbook book = Workbook.createWorkbook(new File(xlsName));
		int row = 0;
		// 写工作表名字
		WritableSheet sheet = book.createSheet("网站统计", 0);
		// 增加工作表表头
		for (int column = 0; column < titles.length; column++) {
			sheet.addCell(new Label(column, row, titles[column]));
		}
		Map<String,Integer> map = new LinkedHashMap<String, Integer>();
		for (StatBean info : list) {
			row++;
			int col = 0;
			for (String title : titles) {
				book.getSheet(0).addCell(
						new Label(col++, row, info.getInfoByName(title) + " "));
				if(!"时间段".equals(title) && !"用户名".equals(title)){
					Integer c = map.get(title);
					c = c==null? 0 : c;
					map.put(title, c+Integer.parseInt(info.getInfoByName(title)));
				}
			}
		}
		row++;
		int c=0;
		book.getSheet(0).addCell(new Label(0, row, "合计"));
		for(Entry<String, Integer> entry :map.entrySet()){
			book.getSheet(0).addCell(
					new Label(++c, row, entry.getValue() + " "));
		}
		if (book != null) {
			try {
				book.write();
				book.close();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (WriteException e) {
				e.printStackTrace();
			}
		}
		return xlsName;
	}
}
