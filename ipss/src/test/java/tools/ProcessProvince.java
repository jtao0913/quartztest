package tools;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.IprNavtableInfo;
import com.cnipr.cniprgz.log.CniprLogger;
import com.trs.Tools;
import com.trs.was.WASException;

public class ProcessProvince {

	private int getParentId(String addrCode, int intType){
		int intID = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(
					"SELECT intID FROM ipr_address where chrAddrCode='"+addrCode+"' and intType="+intType);
			rs = ps.executeQuery();
			if (rs.next()) {
				intID = rs.getInt("intID");
			}
		} catch (Exception e) {
			CniprLogger.LogError("MenuDAO -> getMenuInfo error : " + e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return intID;
	}
	
	public IprNavtableInfo getAddr(String addrId) {
		IprNavtableInfo iprNavtableInfo = null;

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
/*
		id,province,city,district,provinceCode,cityCode,districtCode,alias
*/
		String province="";
		String city="";
		String district="";
		String provinceCode="";
		String cityCode="";
		String districtCode="";
		String alias="";
		int type = 0;//1:省;2:市;3:区县;
		
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(
					"SELECT id,province,city,district,provinceCode,cityCode,districtCode,alias FROM admincode2citycode");
			rs = ps.executeQuery();
			while (rs.next()) {
				province=rs.getString("province");
				city=rs.getString("city");
				district=rs.getString("district");
				
				
				if(province.equals("青海省")) {
					System.out.println();
				}
				if(district.equals("同仁县")) {
					System.out.println();
				}
				
				provinceCode=rs.getString("provinceCode");
				cityCode=rs.getString("cityCode");
				districtCode=rs.getString("districtCode");
				alias=rs.getString("alias");
				
				System.out.println(province+"---"+city+"---"+district);
				
				if(province.equals(city)&&city.equals(district)) {
					int newid = insertInfo(0, province, districtCode, alias,1);//省、直辖市、自治区
					
					if(province.endsWith("市")) {
						insertInfo(newid, city, districtCode, alias,2);
					}
				}else if(!province.equals(city)&&city.equals(district)){
					int parentid = getParentId(provinceCode,1);
					insertInfo(parentid, city, districtCode, alias,2);//市
				}else if(!province.equals(city)&&!city.equals(district)){
					int parentid = getParentId(cityCode,2);
					insertInfo(parentid, district, districtCode, alias,3);//区县
				}else if(province.equals(city)&&province.endsWith("市")&&!city.equals(district)){
					int parentid = getParentId(provinceCode,2);
					insertInfo(parentid, district, districtCode, alias,3);//区县
				}
			}
		} catch (Exception e) {
			CniprLogger.LogError("MenuDAO -> getMenuInfo error : " + e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return iprNavtableInfo;
	}

	public int insertInfo(int intParentID, String chrName, String chrAddrCode, String chrAlias,int intType)
			throws WASException {		
		
		if(chrName.equals("埇桥区")) {
			System.out.println();
		}
		
		int maxcodeID = 0;

		Connection conn = DBPoolAccessor.getConnection();
		PreparedStatement PrePareStmtUpdate = null;
		PreparedStatement PrePareStmtQuery = null;
		ResultSet rs = null;
		try {			
			String strSQL = "";
			strSQL = "select max(intID) maxcode from ipr_address";
			PrePareStmtQuery = conn.prepareStatement(strSQL);
			rs = PrePareStmtQuery.executeQuery();

			while (rs.next()) {
				maxcodeID = rs.getInt("maxcode") + 1;
			}
			PrePareStmtQuery.close();

			strSQL = "insert into ipr_address(intID,intParentID,chrName,chrAddrCode,chrAlias,intType) values("
					+ maxcodeID+ ","+intParentID + ",'" + chrName.trim() + "','" + chrAddrCode.trim() + "','"
					+ chrAlias.trim() + "'," + intType + ")";

//			Tools.writelog(strSQL);

			PrePareStmtUpdate = conn.prepareStatement(strSQL);
			PrePareStmtUpdate.executeUpdate();
			PrePareStmtUpdate.close();
		} catch (SQLException ex) {
			ex.printStackTrace();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				rs.close();
				PrePareStmtUpdate.close();
				PrePareStmtQuery.close();
				if (!conn.isClosed())
					// DBConnect.closeConnection(conn);
					DBPoolAccessor.closeAll(rs, PrePareStmtUpdate, conn);
				DBPoolAccessor.closeAll(rs, PrePareStmtQuery, conn);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return maxcodeID;
	}

	public static void main(String[] args) {
		ProcessProvince processProvince = new ProcessProvince();
		processProvince.getAddr("");
		
	}

}
