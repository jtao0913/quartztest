package tools;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.cnipr.cniprgz.db.DBPoolAccessor;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public class NationalEconomicCode {

	public NationalEconomicCode() {
		// TODO Auto-generated constructor stub
	}

	public static void writeholidaylogs(String content){
		try {
//			D:\ben\morningreport
		     File file = new File("C:\\gmjj.trs");
		     FileOutputStream fos = new FileOutputStream(file,true);
		     OutputStreamWriter osw = new OutputStreamWriter(fos,"UTF-8");
		     BufferedWriter bw = new BufferedWriter(osw);
		     
		     bw.write(content);
		     bw.newLine();
		     
		     bw.flush();
		     bw.close();
		     osw.close();
		     fos.close();
		}
		catch (FileNotFoundException e1) {
			e1.printStackTrace();
		} catch (IOException e2) {
			e2.printStackTrace();
		}
	}
	
	public boolean addGMJJ(String class_A,String class_2,String class_3,String class_4,String codename, String ipc) {
		boolean result = false;
		String str = "<REC>\r\n" + 
				"<class_A>="+class_A+"\r\n" + 
				"<class_2>="+class_2+"\r\n" + 
				"<class_3>="+class_3+"\r\n" + 
				"<class_4>="+class_4+"\r\n" + 
				"<codename>="+codename+"\r\n" + 
				"<ipc>="+ipc.replace("*", "")+"\r\n";
		
		writeholidaylogs(str);
		
		return result;
	}
	
	private void addGMJJ_mysql(String class_A,String class_2,String class_3,String class_4, String codename, String ipc) {
		String result = "insert into ipr_gmjj(class_A,class_2,class_3,class_4, codename, ipc) "
				+ "values ('"+class_A+"','"+class_2+"','"+class_3+"','"+class_4+"','"+ codename+"','"+ ipc+"');";
		
		writeholidaylogs(result);
		
/*		boolean result = false;

		Connection conn = null;
		PreparedStatement ps = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement("insert into ipr_gmjj(class_A,class_2,class_3,class_4, codename, ipc) "
					+ "values ('"+class_A+"','"+class_2+"','"+class_3+"','"+class_4+"','"+ codename+"','"+ ipc+"')");
			int rs = ps.executeUpdate();
			if (rs == 1) {
				result = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;*/
	}

	private int update1(String code) {
		int result = 0;

		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement("update national_economic_code set has_child = 1 where code = ?");
//			ps.setString(1, Memo);
			ps.setString(1, code);
			result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
		return result;
	}
	
	private int update2(String code) {//011---01
		//根据011得到父节点01
		//先找到01的id
		//然后把011的intParentID设置为01的id
		int result = 0;
		
		if(code.length()<3) {
			return 0;
		}
		
		int parentid = 0;
		
		String parentcode = code.substring(0, code.length()-1);
		
		Connection conn = DBPoolAccessor.getConnection();
		// PreparedStatement PrePareStmtUpdate = null;
		PreparedStatement PrePareStmtQuery = null;
		PreparedStatement ps = null;
		
		ResultSet rs = null;
		try {
			String strSQL = "";
			
//			national_economic_code(code, codename, ipc) 
			strSQL = "select id from national_economic_code where code='"+parentcode+"'";
			PrePareStmtQuery = conn.prepareStatement(strSQL);
			rs = PrePareStmtQuery.executeQuery();

			if (rs.next()) {
//				System.out.println(rs.getString("code") + "--" + rs.getString("codename"));				
				parentid = rs.getInt("id");
			}
			
//			int result = 0;
			ps = conn.prepareStatement("update national_economic_code set intParentID = "+parentid+" where code = ?");
//			ps.setString(1, Memo);
			ps.setString(1, code);
			result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
		
//		Connection conn = null;
//		
//		try {
//			conn = DBPoolAccessor.getConnection();
//			ps = conn.prepareStatement("update national_economic_code set has_child = 1 where code = ?");
////			ps.setString(1, Memo);
//			ps.setString(1, code);
//			result = ps.executeUpdate();
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			DBPoolAccessor.closeAll(null, ps, conn);
//		}
		return result;
	}

	private int select1() {
		NationalEconomicCode nec = new NationalEconomicCode();
		int result = 0;

		String code = "";
		Connection conn = DBPoolAccessor.getConnection();
		// PreparedStatement PrePareStmtUpdate = null;
		PreparedStatement PrePareStmtQuery = null;
		ResultSet rs = null;
		try {
			String strSQL = "";
			
//			national_economic_code(code, codename, ipc) 
			strSQL = "select id, code, codename, ipc from national_economic_code where has_child=1";
			PrePareStmtQuery = conn.prepareStatement(strSQL);
			rs = PrePareStmtQuery.executeQuery();

			while (rs.next()) {
				System.out.println(rs.getString("code") + "--" + rs.getString("codename"));
				code = rs.getString("code") ;
				
				if(rs.getString("ipc")!=null&&!rs.getString("ipc").equals("")) {
					if(code!=null&&code.length()==4) {
						nec.update1(code.substring(0, 3)); 
						nec.update1(code.substring(0, 2)); 
					}
				}
				
			}
			PrePareStmtQuery.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, PrePareStmtQuery, conn);
		}

		return result;
	}
	
	private int select2() {
		NationalEconomicCode nec = new NationalEconomicCode();
		int result = 0;

		String code = "";
		Connection conn = DBPoolAccessor.getConnection();
		// PreparedStatement PrePareStmtUpdate = null;
		PreparedStatement PrePareStmtQuery = null;
		ResultSet rs = null;
		try {
			String strSQL = "";
			
//			national_economic_code(code, codename, ipc) 
			strSQL = "select id, code, codename, ipc from national_economic_code";
			PrePareStmtQuery = conn.prepareStatement(strSQL);
			rs = PrePareStmtQuery.executeQuery();

			while (rs.next()) {
				System.out.println(rs.getString("code") + "--" + rs.getString("codename"));
				code = rs.getString("code") ;
				
//				intParentID
				
				if(code.length()>2) {
//					if(code!=null&&code.length()==4) {						
//						nec.update1(code.substring(0, 2)); 
//					}
					nec.update2(code); 
				}
				
			}
			PrePareStmtQuery.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, PrePareStmtQuery, conn);
		}

		return result;
	}

	private void getGMJJfromExcel() throws Exception {
		NationalEconomicCode nec = new NationalEconomicCode();

		String gmjj_code_1 = "";
		String gmjj_code_2 = "";
		String gmjj_code_3 = "";
		String gmjj_code_4 = "";
		String gmjj_code = "";
		String gmjj_name = "";

		String _gmjj_code = "";
		String _gmjj_name = "";
//		 String gmjj_2 = "";
//		 String gmjj_3 = "";
//		 String gmjj_4 = "";
		String ipc = "";
		String _ipc = "";
//		String IPC_content = "";

		HSSFWorkbook workbook = new HSSFWorkbook(new FileInputStream(new File("C:\\国际专利分类与国民经济行业分类参照关系表（试行版）.xls")));
		try {
			HSSFSheet sheet = null;

			// System.out.println(workbook.getNumberOfSheets());

			// for (int i = 3; i < workbook.getNumberOfSheets(); i++)
			{// 获取每个Sheet表
				sheet = workbook.getSheetAt(0);
				for (int j = 2; j < sheet.getPhysicalNumberOfRows(); j++) {// 获取每行
					HSSFRow row = sheet.getRow(j);
					// for (int k = 0; k < row.getPhysicalNumberOfCells(); k++)
					{// 获取每个单元格
						// System.out.print(j + "--" + k + "--" + row.getCell(k) + "\t");

						// gmjj_code =
						// (row.getCell(0).toString()==null||row.getCell(0).toString().trim().equals(""))?gmjj_code:row.getCell(0).toString();
						// gmjj_name =
						// (row.getCell(1).toString()==null||row.getCell(1).toString().trim().equals(""))?gmjj_name:row.getCell(1).toString();

						gmjj_code = row.getCell(0).toString();
						gmjj_name = row.getCell(1).toString();

						// if(!ipc.equals("")){
						// ipc+=",";
						// }
						ipc = row.getCell(2).toString();

						System.out.println(gmjj_code);
						System.out.println(gmjj_name);
						System.out.println(ipc);

						if (gmjj_code.length() == 1 || gmjj_code.length() == 2 || gmjj_code.length() == 3) {
//							nec.addGMJJ(gmjj_code, gmjj_name, "");	
							if(gmjj_code.length() == 1) {
								gmjj_code_1 = gmjj_code;
								addGMJJ_mysql(gmjj_code,"","","",	"", "");
							}
							if(gmjj_code.length() == 2) {
								gmjj_code_2 = gmjj_code;
								addGMJJ_mysql(gmjj_code_1,gmjj_code_2,"","",	"", "");
							}
							if(gmjj_code.length() == 3) {
								gmjj_code_3 = gmjj_code;
								addGMJJ_mysql(gmjj_code_1,gmjj_code_2,gmjj_code_3,"",	"", "");
							}
/*							if(gmjj_code.length() == 4) {
								gmjj_code_4 = gmjj_code;
								addGMJJ(gmjj_code,"","","",	gmjj_name, ipc);
							}*/
						}

						if (gmjj_code.length() == 4) {
							if (_gmjj_code.length() > 0 && _gmjj_name.length() > 0 && _ipc.length() > 0) {
//								nec.addGMJJ(_gmjj_code, _gmjj_name, _ipc);								
//								addGMJJ(String class_A,String class_2,String class_3,String class_4,	String codename, String ipc) 
								gmjj_code_4 = _gmjj_code;
//								addGMJJ(gmjj_code_1,gmjj_code_2,gmjj_code_3,gmjj_code_4, _gmjj_name, _ipc);
								_ipc = _ipc.replace("*", "");
								addGMJJ_mysql(gmjj_code_1,gmjj_code_4.substring(0, 2),gmjj_code_4.substring(0, 3),gmjj_code_4, _gmjj_name, _ipc);
							}
							_ipc = "";
							_gmjj_code = gmjj_code;
							_gmjj_name = gmjj_name;
						}

						if (gmjj_code.length() == 0 && ipc.length() > 0) {
							if (!_ipc.equals("")) {
								_ipc += ";";
							}
							_ipc += ipc;
						}

					}
					System.out.println();
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (workbook != null) {
				workbook.close();
			}
		}
	}

	public static void main(String[] args) throws Exception {
		NationalEconomicCode nec = new NationalEconomicCode();

		nec.getGMJJfromExcel();
//		nec.select1();
//		nec.select2();
	}

}
