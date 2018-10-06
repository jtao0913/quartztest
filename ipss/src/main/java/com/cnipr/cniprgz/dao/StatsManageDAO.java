package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import com.cnipr.cniprgz.db.DBPoolAccessor;

public class StatsManageDAO {

	int intCount = 0;

	public static void main(String[] args) {
//		StatsManageDAO statsmanage = new StatsManageDAO();
		// String[][] arr=statsmanage.getUserStatistic("2004-01-01 00:00:00",
		// "2007-12-02 23:59:59", "", "1", 1, 20, 1, 1,true);
		// String[][] arr1=statsmanage.getAreaStatistic("2004-01-01 00:00:00",
		// "2007-12-02 23:59:59");

//		String[][] arr1 = statsmanage.getTimeStatistic("2007-01-01 00:00:00",
//				"2008-01-02 23:59:59", "all", "", "year", 20, 1, 1, false);
	}

	public StatsManageDAO() {
	}

	public String[][] getUserStatistic(String time_from, String time_to,
			String userName, String selscope, int paixu, int CountPerPage,
			int pageNumber, int adminID, boolean b_download) {

		int i = 0;
		String[][] arrUserStatistic = null;
		String strSQL = "";
		String[] arrUserName = null;

		Connection conn = DBPoolAccessor.getConnection();
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;
		try {
			
			/** ******************************************************************************** */
			if (selscope != null && !selscope.equals("all")) {
				strSQL = "select chrUserName from ipr_user where intAdministerID="
						+ selscope;
				if (userName != null && !userName.trim().equals("")) {
					strSQL += " and chrUserName like '" + userName + "%' ";
				}
				strSQL += " order by chrUserName";

				// System.out.println(strSQL);

				PrePareStmt = conn.prepareStatement(strSQL);
				rs = PrePareStmt.executeQuery();

				if (rs.last()) {
					arrUserName = new String[rs.getRow()];
				}
				rs.beforeFirst();
				while (rs.next()) {
					arrUserName[i] = rs.getString("chrUserName");
					i++;
				}
			} else {
				strSQL = "select chrUserName from ipr_user";
				if (userName != null && !userName.trim().equals("")) {
					strSQL += " where chrUserName like '" + userName + "%' ";
				}
				strSQL += " order by chrUserName";

				// System.out.println(strSQL);

				PrePareStmt = conn.prepareStatement(strSQL);
				rs = PrePareStmt.executeQuery();
				if (rs.last()) {
					arrUserName = new String[rs.getRow()];
				}

				rs.beforeFirst();
				while (rs.next()) {
					arrUserName[i] = rs.getString("chrUserName");
					i++;
				}
				rs.close();
				PrePareStmt.close();
			}
			/** ******************************************************************************** */
			if (paixu != 0) {
				strSQL = "select ipr_user.chrUserName x,count(*) countSUM from ipr_all_logs,ipr_user where intGrantID in ";
				if (paixu == 1) {
					strSQL += "(64,73,82,91)";
				}
				if (paixu == 2) {
					strSQL += "(65,74,83,92)";
				}
				if (paixu == 3) {
					strSQL += "(96,105,114,123,132,141,150,159)";
				}
				if (paixu == 4) {
					strSQL += "(97,106,115,124,133,142,151,160)";
				}
				if (userName != null && !userName.trim().equals("")) {
					strSQL += " and ipr_user.chrUserName like '" + userName
							+ "%' ";
				}

				if (!selscope.equals("all")) {
					strSQL += " and ipr_user.intAdministerID=" + selscope;
				}

				strSQL += " and ipr_user.chrUserName=ipr_all_logs.chrUserName";
				strSQL += " and dtVisitTime<='" + time_to
						+ "' and dtVisitTime>='" + time_from + "'";
				strSQL += " group by ipr_user.chrUserName order by countSUM desc";

				// System.out.println(strSQL);

				arrUserName = rowCountSort(arrUserName, strSQL);
			}

			int start = 0;
			int end = 0;

			if (b_download) {
				start = 0;
				end = arrUserName.length;
			} else {
				if (arrUserName.length % CountPerPage != 0) {
					setIntCount(arrUserName.length / CountPerPage + 1);
				} else {
					setIntCount(arrUserName.length / CountPerPage);
				}
				/** ******************************************************************************** */
				if (pageNumber < (arrUserName.length / CountPerPage + 1)
						|| arrUserName.length % CountPerPage == 0) {
					start = (pageNumber - 1) * CountPerPage;
					end = pageNumber * CountPerPage;
				} else {
					start = (pageNumber - 1) * CountPerPage;
					end = arrUserName.length;
				}
			}
			// (pageNumber-1)*CountPerPage+","+CountPerPage;
			/**
			 * *************************************** 根据用户名取得4项操作的具体值
			 * ************************************************
			 */
			arrUserStatistic = new String[end - start][5];
			for (int j = start; j < end; j++) {
				strSQL = "select ipr_all_logs.chrUserName zong,"
						+ "(select count(*) from ipr_all_logs where (intGrantID in (64,73,82,91)) and chrUserName=zong) count1,"
						+ "(select count(*) from ipr_all_logs where (intGrantID in (65,74,83,92)) and chrUserName=zong) count2,"
						+ "(select count(*) from ipr_all_logs where (intGrantID in (96,105,114,123,132,141,150,159)) and chrUserName=zong) count3,"
						+ "(select count(*) from ipr_all_logs where (intGrantID in (97,106,115,124,133,142,151,160)) and chrUserName=zong) count4"
						+ " from ipr_all_logs" + " where chrUserName='"
						+ arrUserName[j] + "'" + " and dtVisitTime<='"
						+ time_to + "' and dtVisitTime>='" + time_from + "'"
						+ " group by zong";

				if (paixu == 0) {
					strSQL += " order by chrUserName";
				} else if (paixu == 1) {
					strSQL += " order by count1";
				} else if (paixu == 2) {
					strSQL += " order by count2";
				} else if (paixu == 3) {
					strSQL += " order by count3";
				} else if (paixu == 4) {
					strSQL += " order by count4";
				}

				PrePareStmt = conn.prepareStatement(strSQL);
				rs = PrePareStmt.executeQuery();
				if (rs.next()) {
					arrUserStatistic[j - start][0] = arrUserName[j];
					arrUserStatistic[j - start][1] = rs.getInt("count1") + "";
					arrUserStatistic[j - start][2] = rs.getInt("count2") + "";
					arrUserStatistic[j - start][3] = rs.getInt("count3") + "";
					arrUserStatistic[j - start][4] = rs.getInt("count4") + "";
				} else {
					arrUserStatistic[j - start][0] = arrUserName[j];
					arrUserStatistic[j - start][1] = "0";
					arrUserStatistic[j - start][2] = "0";
					arrUserStatistic[j - start][3] = "0";
					arrUserStatistic[j - start][4] = "0";
				}
			}
			/** ******************************************************************************** */
		} catch (Exception ex) {
			ex.printStackTrace();
		} 
		return arrUserStatistic;
	}

	public String[][] getAreaStatistic(String time_from, String time_to) {
		/*
		 * System.out.println("time_from="+time_from);
		 * System.out.println("time_to="+time_to);
		 * System.out.println("userName="+userName);
		 * System.out.println("selscope="+selscope);
		 * System.out.println("paixu="+paixu);
		 * System.out.println("CountPerPage="+CountPerPage);
		 * System.out.println("pageNumber="+pageNumber);
		 * System.out.println("admin="+adminID);
		 */

		int i = 0;
		String[][] arrAreaStatistic = null;
		String strSQL = "";
		Connection conn = DBPoolAccessor.getConnection();
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;
		PreparedStatement PrePareStmt1 = null;
		ResultSet rs1 = null;
		PreparedStatement PrePareStmt2 = null;
		ResultSet rs2 = null;
		try {
			
			/** ******************************************************************************** */
			strSQL = "select intUserID p_userID,chrUserName,"
					+ "(select count(*) from ipr_user where intAdministerID=p_userID) c_count"
					+ " from ipr_user where intAdministerState=1";

			PrePareStmt = conn.prepareStatement(strSQL);
			rs = PrePareStmt.executeQuery();
			if (rs.last()) {
				arrAreaStatistic = new String[rs.getRow()][6];
			}

			rs.beforeFirst();
			while (rs.next()) {
				arrAreaStatistic[i][0] = rs.getString("chrUserName");
				arrAreaStatistic[i][1] = rs.getInt("c_count") + "";

				int p_userID = rs.getInt("p_userID");
				strSQL = "select chrUserName from ipr_user where intAdministerID="
						+ p_userID;
				PrePareStmt1 = conn.prepareStatement(strSQL);
				rs1 = PrePareStmt1.executeQuery();
				String c_userNames = "(";
				while (rs1.next()) {
					c_userNames += "'" + rs1.getString("chrUserName") + "',";
				}
				if (c_userNames.length() > 2) {// 说明此管理员有子用户
					c_userNames = c_userNames.substring(0,
							c_userNames.length() - 1)
							+ ")";
					/**
					 * ****************************** 中国专利打印
					 * **********************************
					 */
					strSQL = "select count(*) count_tifprint from ipr_all_logs where (intGrantID in (64,73,82,91)) and chrUserName in "
							+ c_userNames;
					strSQL += " and dtVisitTime<='" + time_to
							+ "' and dtVisitTime>='" + time_from + "'";
					PrePareStmt2 = conn.prepareStatement(strSQL);
					rs2 = PrePareStmt2.executeQuery();
					if (rs2.next()) {
						arrAreaStatistic[i][2] = rs2.getInt("count_tifprint")
								+ "";
					}
					rs2.close();
					PrePareStmt2.close();
					/**
					 * ****************************** 中国专利下载
					 * **********************************
					 */
					strSQL = "select count(*) count_tifdownload from ipr_all_logs where (intGrantID in (65,74,83,92)) and chrUserName in "
							+ c_userNames;
					strSQL += " and dtVisitTime<='" + time_to
							+ "' and dtVisitTime>='" + time_from + "'";
					PrePareStmt2 = conn.prepareStatement(strSQL);
					rs2 = PrePareStmt2.executeQuery();
					if (rs2.next()) {
						arrAreaStatistic[i][3] = rs2
								.getInt("count_tifdownload")
								+ "";
					}
					rs2.close();
					PrePareStmt2.close();
					/**
					 * ****************************** 国外专利打印
					 * **********************************
					 */
					strSQL = "select count(*) count_abprint from ipr_all_logs where (intGrantID in (96,105,114,123,132,141,150,159)) and chrUserName in "
							+ c_userNames;
					strSQL += " and dtVisitTime<='" + time_to
							+ "' and dtVisitTime>='" + time_from + "'";
					PrePareStmt2 = conn.prepareStatement(strSQL);
					rs2 = PrePareStmt2.executeQuery();
					if (rs2.next()) {
						arrAreaStatistic[i][4] = rs2.getInt("count_abprint")
								+ "";
					}
					rs2.close();
					PrePareStmt2.close();
					/**
					 * ****************************** 国外专利下载
					 * **********************************
					 */
					strSQL = "select count(*) count_abdownload from ipr_all_logs where (intGrantID in (97,106,115,124,133,142,151,160)) and chrUserName in "
							+ c_userNames;
					strSQL += " and dtVisitTime<='" + time_to
							+ "' and dtVisitTime>='" + time_from + "'";
					PrePareStmt2 = conn.prepareStatement(strSQL);
					rs2 = PrePareStmt2.executeQuery();
					if (rs2.next()) {
						arrAreaStatistic[i][5] = rs2.getInt("count_abdownload")
								+ "";
					}
					rs2.close();
					PrePareStmt2.close();
				} else {
					arrAreaStatistic[i][2] = "0";
					arrAreaStatistic[i][3] = "0";
					arrAreaStatistic[i][4] = "0";
					arrAreaStatistic[i][5] = "0";
				}

				i++;
			}
		} catch (Exception ex) {
		} 
		return arrAreaStatistic;
	}

	public String[][] getTimeStatistic(String time_from, String time_to,
			String selectScope, String all_area_user, String time_span,
			int CountPerPage, int pageNumber, int adminID, boolean b_download) {

		String[][] arrTimeStatistic = null;
		String strSQL = "";

		String strAreaUsers = "";// 如果选择了区域，那么strAreaUsers的内容将是('cnipr','ben','zhu')
		String[] arrDate = null;
		Connection conn = DBPoolAccessor.getConnection();
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;
		try {

			String strTime = "";
			if (time_span.equals("year")) {
				strTime = "year(dtVisitTime)";

				arrDate = getDateArray(time_from, time_to, 1);
			}
			if (time_span.equals("month")) {
				strTime = "Concat(year(dtVisitTime),\"-\",month(dtVisitTime))";
				arrDate = getDateArray(time_from, time_to, 2);
			}
			if (time_span.equals("day")) {
				strTime = "Concat(year(dtVisitTime),\"-\",month(dtVisitTime),\"-\",day(dtVisitTime))";
				arrDate = getDateArray(time_from, time_to, 3);
			}

			int start = 0;
			int end = 0;
			if (pageNumber < (arrDate.length / CountPerPage + 1)
					|| arrDate.length % CountPerPage == 0) {
				start = (pageNumber - 1) * CountPerPage;
				end = pageNumber * CountPerPage;
			} else {
				start = (pageNumber - 1) * CountPerPage;
				end = arrDate.length;
			}

			if (b_download) {
				start = 0;
				end = arrDate.length;
			}
			/** ********************************************************************************************************* */
			if (arrDate.length % CountPerPage != 0) {
				setIntCount(arrDate.length / CountPerPage + 1);
			} else {
				setIntCount(arrDate.length / CountPerPage);
			}
			// (pageNumber-1)*CountPerPage+","+CountPerPage;
			String strDate = "(";
			/**
			 * *************************************** 根据用户名取得4项操作的具体值
			 * ************************************************
			 */
			arrTimeStatistic = new String[end - start][5];
			String[] arrTemp = new String[end - start];
			String[] arrTempValue = new String[end - start];
			for (int j = start; j < end; j++) {
				strDate += "'" + arrDate[j] + "',";
				arrTimeStatistic[j - start][0] = arrDate[j];
				arrTimeStatistic[j - start][1] = "0";
				arrTimeStatistic[j - start][2] = "0";
				arrTimeStatistic[j - start][3] = "0";
				arrTimeStatistic[j - start][4] = "0";

				arrTemp[j - start] = arrDate[j];
			}
			if (strDate.length() > 2) {
				strDate = strDate.substring(0, strDate.length() - 1) + ")";
			}
			/** ***************************************************************************************************************** */
			if (selectScope.equals("area") || selectScope.equals("user")) {
				if (selectScope.equals("area")) {
					strSQL = "select chrUserName from ipr_user where intAdministerID="
							+ all_area_user;
				}
				if (selectScope.equals("user")) {
					strSQL = "select chrUserName from ipr_user where intUserID="
							+ all_area_user;
				}
				PrePareStmt = conn.prepareStatement(strSQL);
				rs = PrePareStmt.executeQuery();
				strAreaUsers = "(";
				while (rs.next()) {
					strAreaUsers += "'" + rs.getString("chrUserName") + "',";
				}
				if (strAreaUsers.length() > 2) {// 说明此管理员有子用户
					strAreaUsers = strAreaUsers.substring(0, strAreaUsers
							.length() - 1)
							+ ")";
				} else {
					for (int j = start; j < end; j++) {
						arrTimeStatistic[j - start][0] = arrDate[j];
						arrTimeStatistic[j - start][1] = "0";
						arrTimeStatistic[j - start][2] = "0";
						arrTimeStatistic[j - start][3] = "0";
						arrTimeStatistic[j - start][4] = "0";
					}
				}
			}
			/** ***************************************************************************************************************** */
			// arrTimeStatistic[i][0]=rs2.getInt("count_tifprint")+"";
			/**
			 * ****************************** 中国专利打印
			 * **********************************
			 */
			strSQL = "select distinct("
					+ strTime
					+ ") x,count(*) countSUM from ipr_all_logs where (intGrantID in (64,73,82,91))";
			if (selectScope.equals("area") || selectScope.equals("user")) {
				strSQL += " and chrUserName in " + strAreaUsers;
			}
			strSQL += " and " + strTime + " in " + strDate;
			strSQL += " group by " + strTime;

			arrTempValue = rowCount(arrTemp, strSQL);
			for (int j = start; j < end; j++) {
				arrTimeStatistic[j - start][1] = arrTempValue[j - start];
			}
			/**
			 * ****************************** 中国专利下载
			 * **********************************
			 */
			strSQL = "select distinct("
					+ strTime
					+ ") x,count(*) countSUM from ipr_all_logs where (intGrantID in (65,74,83,92))";
			if (selectScope.equals("area") || selectScope.equals("user")) {
				strSQL += " and chrUserName in " + strAreaUsers;
			}
			strSQL += " and " + strTime + " in " + strDate;
			strSQL += " group by " + strTime;

			arrTempValue = rowCount(arrTemp, strSQL);
			for (int j = start; j < end; j++) {
				arrTimeStatistic[j - start][2] = arrTempValue[j - start];
			}
			/**
			 * ****************************** 国外专利打印
			 * **********************************
			 */
			strSQL = "select distinct("
					+ strTime
					+ ") x,count(*) countSUM from ipr_all_logs where (intGrantID in (96,105,114,123,132,141,150,159))";
			if (selectScope.equals("area") || selectScope.equals("user")) {
				strSQL += " and chrUserName in " + strAreaUsers;
			}
			strSQL += " and " + strTime + " in " + strDate;
			strSQL += " group by " + strTime;

			arrTempValue = rowCount(arrTemp, strSQL);
			for (int j = start; j < end; j++) {
				arrTimeStatistic[j - start][3] = arrTempValue[j - start];
			}
			/**
			 * ****************************** 国外专利下载
			 * **********************************
			 */
			strSQL = "select distinct("
					+ strTime
					+ ") x,count(*) countSUM from ipr_all_logs where (intGrantID in (97,106,115,124,133,142,151,160))";
			if (selectScope.equals("area") || selectScope.equals("user")) {
				strSQL += " and chrUserName in " + strAreaUsers;
			}
			strSQL += " and " + strTime + " in " + strDate;
			strSQL += " group by " + strTime;

			arrTempValue = rowCount(arrTemp, strSQL);
			for (int j = start; j < end; j++) {
				arrTimeStatistic[j - start][4] = arrTempValue[j - start];
			}
			// strAreaUsers
			/** ************************************************************************* */
		} catch (Exception ex) {
			ex.printStackTrace();
		}  
		return arrTimeStatistic;
	}

	public int getIntCount() {
		return intCount;
	}

	public void setIntCount(int intCount) {
		this.intCount = intCount;
	}

	@SuppressWarnings({ "static-access", "unchecked" })
	public static String[] getDateArray(String startDate, String endDate,
			int y_m_d) {
		String[] arr = null;
		ArrayList al = new ArrayList();
		try {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date date1 = formatter.parse(startDate);
			Date date2 = formatter.parse(endDate);

			java.util.Calendar c = java.util.Calendar.getInstance();
			c.setTime(date1);

			boolean b = true;
			while (b) {
				int year = c.get(java.util.Calendar.YEAR);
				int month = c.get(java.util.Calendar.MONTH) + 1;
				int day = c.get(java.util.Calendar.DATE);

				Date date = formatter.parse(year + "-" + month + "-" + day);

				if ((date2.getTime() - date.getTime()) >= 0) {

					if (y_m_d == 1) {
						al.add(year + "");
					}
					if (y_m_d == 2) {
						al.add(year + "-" + month);
					}
					if (y_m_d == 3) {
						al.add(year + "-" + month + "-" + day);
					}
				} else {
					b = false;
				}

				if (y_m_d == 1) {
					c.add(c.YEAR, 1);
				}
				if (y_m_d == 2) {
					c.add(c.MONTH, 1);
				}
				if (y_m_d == 3) {
					c.add(c.DATE, 1);
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		// Object[] arr1=al.
		arr = new String[al.size()];
		for (int i = 0; i < al.size(); i++) {
			arr[i] = (String) al.get(i);
		}
		return arr;
	}

	private String[] rowCount(String[] arrValueX, String strSQL) {

		String[] arr = new String[arrValueX.length];
		Connection conn = null;
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;
		try {
			conn = DBPoolAccessor.getConnection();

			PrePareStmt = conn.prepareStatement(strSQL);
			rs = PrePareStmt.executeQuery();

			for (int i = 0; i < arrValueX.length; i++) {
				arr[i] = "0";
			}
			boolean b = false;
			String x = "";
			while (rs.next()) {
				x = rs.getString("x");
				b = false;
				for (int i = 0; i < arr.length && !b; i++) {

					if (x.equals(arrValueX[i])) {
						b = true;
						arr[i] = rs.getInt("countSUM") + "";
					}
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (PrePareStmt != null) {
					PrePareStmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return arr;
	}

	@SuppressWarnings("unchecked")
	private String[] rowCountSort(String[] arrValueX, String strSQL) {

		String[] arr = new String[arrValueX.length];

		java.util.ArrayList aList = new java.util.ArrayList();

		for (int i = 0; i < arrValueX.length; i++) {
			aList.add(arrValueX[i]);
			// System.out.println(i+"="+arrValueX[i]);
		}

		Connection conn = null;
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;
		try {
			conn = DBPoolAccessor.getConnection();

			PrePareStmt = conn.prepareStatement(strSQL);
			rs = PrePareStmt.executeQuery();
			/*
			 * if(rs.last()) { arr=new String[rs.getRow()][2]; }
			 * rs.beforeFirst();
			 */
			for (int i = 0; i < arrValueX.length; i++) {
				arr[i] = "0";
			}
			String x = "";

			int m = 0;

			int j = 0;
			while (rs.next()) {
				x = rs.getString("x");
				arr[j] = x;
				if (aList.contains(x)) {
					aList.remove(x);
					m++;
				}
				j++;
			}

			// System.out.println("j="+j);
			// System.out.println("m="+m);
			// j--;
			for (int i = 0; i < aList.size(); i++) {
				arr[j] = (String) aList.get(i);
				j++;
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {

			try {
				if (rs != null) {
					rs.close();
				}
				if (PrePareStmt != null) {
					PrePareStmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		return arr;
	}
}
