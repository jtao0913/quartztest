package com.cnipr.cniprgz.commons.page;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.cnipr.cniprgz.db.DBPoolAccessor;


public class PageSearchSupporter {

	private int pageRowSize = 50;

	public PageSearchSupporter() {

	}

	/**
	 * ת��ԴSQLΪ��total size��SQL
	 * 
	 * @param sourceSql
	 * @return
	 */
	public static String getCountSql(String sourceSql) {
		return "select count(1) from (" + sourceSql + ") temp";
	}

	/**
	 * ������ҳ��
	 * 
	 * @param countRowNum
	 *            �ܼ�¼��
	 * @param pageSize
	 *            ÿҳ��¼��
	 * @return
	 */
	public static int accountTotalPageNumber(int countRowNum, int pageSize)
			throws IllegalArgumentException {
		if (pageSize < 1)
			throw new IllegalArgumentException(
					"Note:pageSize must be more than 1!");
		int totalpage = 0;
		if (countRowNum % pageSize == 0) {
			totalpage = countRowNum / pageSize;
		} else {
			totalpage = countRowNum / pageSize + 1;
		}
		if (totalpage < 1)
			totalpage = 1;
		return totalpage;
	}

	public static int accountBeginRowNum(int pageNo, int pageSize) {
		return (pageNo - 1) * pageSize + 1;
	}

	public int accountBeginRowNum(int pageNo) {
		return accountBeginRowNum(pageNo, this.pageRowSize);
	}

	/**
	 * ������ҳ��
	 * 
	 * @param countRowNum
	 *            �ܼ�¼��
	 * @return
	 */

	public int accountTotalPageNumber(int countRowNum ) {
		return accountTotalPageNumber(countRowNum, this.pageRowSize);
	}

	/**
	 * Access method for the pageRowSize property.
	 * 
	 * @return the current value of the pageRowSize property
	 */
	public int getPageRowSize() {
		return pageRowSize;
	}

	/**
	 * Sets the value of the pageRowSize property.
	 * 
	 * @param aPageRowSize
	 *            the new value of the pageRowSize property
	 */
	public void setPageRowSize(int aPageRowSize) {
		pageRowSize = aPageRowSize;
	}

	/**ת��ԴSQLΪ��ҳ��ѯ��SQL
	 * @param sql
	 * @param pageNo
	 * @return String
	 */
	public String getPageSearchSql(String sourceSql, int pageNo, int pageSize) {
		 
		int offset = (pageNo - 1) * pageSize;
		
		// mysql
		return sourceSql + " limit " + offset + " , " + pageSize;
		
		// oracle
//		int offset = (pageNo - 1) * pageSize + 1;
//		int count = pageSize;
//		int endRownumber = offset + count;
//		return "select * from (select rownum as numrow,d.* from (" + sourceSql
//				+ ") d) tempTable where numrow>=" + offset + " and numrow<" + endRownumber;
		
	}
	
	/**
	 * @param sourceSql
	 * @return int
	 */
	public int getCount(String sourceSql) throws SQLException,Exception {
		int count = 0;
		Connection conn = null;

		try {
			conn = DBPoolAccessor.getConnection();
			count = this.getCount(conn, sourceSql);
		} catch (SQLException ex) {
			ex.printStackTrace();
			throw ex;
		} catch (Exception e) {			
			e.printStackTrace();
			throw e;
		} finally {
			conn.close();
		}

		return count;
	}

	/**
	 * @param conn
	 * @param sourceSql
	 * @return int
	 */
	public int getCount(Connection conn, String sourceSql) throws SQLException {
		String countSql = getCountSql(sourceSql);
		Statement stem = conn.createStatement();
		ResultSet rs = stem.executeQuery(countSql);
		rs.next();
		int count = rs.getInt(1);
		rs.close();
		stem.close();
		return count;
	}

	/**
	 * ����ҳ�����
	 * 
	 * @param pageNo
	 * @param rowsize
	 * @return
	 */
	@SuppressWarnings("static-access")
	public static PageBaseInfo accountPageinfo(int pageNo, int totalrownum, int pageSize) {
		PageSearchSupporter pa = new PageSearchSupporter();
		PageBaseInfo dto = new PageBaseInfo();
		if (pageNo < 1)
			pageNo = 1;

		dto.setCurPageNo(pageNo);
		dto.setCountRownum(totalrownum);
		dto.setCountPagenum(accountTotalPageNumber(totalrownum,pageSize));
		dto.setCurRowNo(pa.accountBeginRowNum(pageNo,pageSize));
		return dto;
	}

	/**
	 * ����ҳ�����
	 * 
	 * @param pageNo
	 * @param rowsize
	 * @return
	 */
	public PageBaseInfo accountPageinfo(Connection conn, int pageNo, int pageSize,
			String sourceSql) throws SQLException {
		int totalrownum = this.getCount(conn, sourceSql);
		return accountPageinfo(pageNo, totalrownum, pageSize);
	}

}
