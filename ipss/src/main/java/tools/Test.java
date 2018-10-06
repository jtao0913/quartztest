package tools;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Test {
	private static int count(String str, String des) {
		int cnt = 0;
		int offset = 0;

		while ((offset = str.indexOf(des, offset)) != -1) {
			offset = offset + des.length();
			cnt++;
		}
		// System.out.println(cnt);

		return cnt;
	}

	private static String processExpression(String str) {
		boolean b = true;
		while (b) {
			str = str.trim();
			if (str.startsWith("(") && str.endsWith(")")) {
				String _str = str.substring(1, str.length() - 1);// 先剥掉最左边和最右边的括号
				if (count(_str, "(") == count(_str, ")")) {
					String _tmp = "";
					for (int j = 0; j < _str.length(); j++) {// 从字符串左边开始捋着，要求从始至终左括号数量>=（大于等于）右括号数量
						_tmp = _str.substring(0, j + 1);
						if (count(_tmp, "(") < count(_tmp, ")")) {
							b = false;
							break;
						}
					}
				}

				if (b) {
					str = _str;
				}
			} else {
				b = false;
			}
		}

		return str;
	}

	public static void main1(String[] args) {
		// String FMR = "ssss ggg 332";
		// FMR = FMR.replaceAll("[ ]+", " ");
		// System.out.println(FMR);

		// System.out.println( ((Integer.parseInt(sss))*0.8).);
		// Float f = new Float((Integer.parseInt(sss))*0.8);
		// int i = f.intValue();

		// String sss = "760";
		// System.out.println((new Float((Integer.parseInt(sss))*0.8)).intValue());

		String strWhere = "名称=((计算机 or 方法))";
		strWhere = "名称=(计算机 or 方法)";
		strWhere = "名称=((计算机 or 方法))";
		strWhere = "名称=((计算机 or 方法)) or 摘要=电动车";

		// String str = processExpression(strWhere);
		// System.out.println(str);

		Pattern pt = Pattern.compile("[\u4e00-\u9fa5,（）\\+]+[=]{1}");
		Matcher match = pt.matcher(strWhere);
		while (match.find()) {
			System.out.println(match.group());
		}
	}

	public static void main2(String[] args) {
		String expContent = "申请日=2016";

		if (expContent.indexOf("公开（公告）日|申请日|颁证日|进入国家日期") > -1) {
			System.out.println("OK");
		}
		// 公开（公告）日
		// 申请日
		// 颁证日
		// 进入国家日期
	}

	public static void main3(String[] args) {
		/*
		 * String strWhere = "B63B35/32";
		 * 
		 * Pattern pt =
		 * Pattern.compile("[A-H]{1}[0-9]{2}[A-H]{1}[0-9]{1,2}/[0-9]{2,3}"); Matcher
		 * match = pt.matcher(strWhere); while (match.find()) {
		 * System.out.println(match.group()); }
		 */
		String _tmp = "H01Q1/32*";
		// System.out.println(_tmp.replace("*", "").charAt(0));
		boolean b_analyse = false;
		String fieldname = "";

		if (Character.isLetter(_tmp.replace("*", "").charAt(0))) {
			_tmp = _tmp.replace("*", "");

			if (_tmp.length() == 1) {
				fieldname = "IPC部";
				b_analyse = true;
			} else if (_tmp.length() == 3) {
				fieldname = "IPC大类";
				b_analyse = true;
			} else if (_tmp.length() == 4) {
				fieldname = "IPC小类";
				b_analyse = true;
			} else if (_tmp.length() == 5 || _tmp.length() == 6) {
				Pattern _pt = Pattern.compile("[A-H]{1}[0-9]{2}[A-H]{1}[0-9]{1,2}");
				Matcher _match = _pt.matcher(_tmp);
				if (_match.find()) {
					// System.out.println(_match.group());
					fieldname = "IPC大组";
					b_analyse = true;
				}
			} else if (_tmp.length() >= 8 && _tmp.length() <= 10) {
				Pattern _pt = Pattern.compile("[A-H]{1}[0-9]{2}[A-H]{1}[0-9]{1,2}/[0-9]{2,3}");
				Matcher _match = _pt.matcher(_tmp);
				if (_match.find()) {
					System.out.println(_match.group());
					fieldname = "IPC分类号";
					b_analyse = true;
				}
			}

		}

	}
	
	private static void writelogs(String content){
		try {
//			D:\ben\morningreport
		     File file = new File("F:\\xxx.txt");
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
	
	private static String getAddr(String province_addrcode) {
		String province = "";
		Connection conn = DBPoolAccessor.getConnection();
		PreparedStatement PrePareStmtQuery = null;
		ResultSet rs = null;
		try {
			String strSQL = "";			
//			select * from ipr_address where intParentID=0
			strSQL = "select chrAddrCode,chrExpression from ipr_address where chrAddrCode="+province_addrcode;
			PrePareStmtQuery = conn.prepareStatement(strSQL);
			rs = PrePareStmtQuery.executeQuery();

			if (rs.next()) {
				System.out.println(rs.getString("chrExpression"));
				province = rs.getString("chrExpression");
//				120112
				
			}
			PrePareStmtQuery.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, PrePareStmtQuery, conn);
		}
		
		return province;
	}
	
	public static void main(String[] args) {
		String duplicateDistrict = ",南山区,向阳区,和平区,城中区,城关区,城区,宝山区,市中区,新华区,新城区,普陀区,朝阳区,桥东区,桥西区,永定区,江北区,河东区,海州区,白云区,矿区,西安区,西湖区,通州区,郊区,铁东区,铁西区,长安区,青山区,鼓楼区,龙华区,";
		Connection conn = DBPoolAccessor.getConnection();
		PreparedStatement PrePareStmtQuery = null;
		ResultSet rs = null;
		try {
			String strSQL = "";			
//			select * from ipr_address where intParentID=0
			strSQL = "select * from ipr_address where intType!=1";
			PrePareStmtQuery = conn.prepareStatement(strSQL);
			rs = PrePareStmtQuery.executeQuery();

			while (rs.next()) {
				System.out.println(rs.getString("chrAddrCode"));
				
//				120112
				String sql = "";
				if(rs.getInt("intType")==2) {
					sql = "update ipr_address set chrExpression='市级行政="+rs.getString("chrName")+"' where intID="+rs.getInt("intID")+";";
				}else if(rs.getInt("intType")==3) {					
					if(duplicateDistrict.indexOf(","+rs.getString("chrName")+",")>-1) {
						String province = getAddr(rs.getString("chrAddrCode").substring(0, 2)+"0000");
						sql = "update ipr_address set chrExpression='"+province+" and 县区行政="+rs.getString("chrName")+"' where intID="+rs.getInt("intID")+";";
					}else {
						sql = "update ipr_address set chrExpression='县区行政="+rs.getString("chrName")+"' where intID="+rs.getInt("intID")+";";
					}
				} 
				
//				String sql = "update ipr_address set chrExpression='"+province+" and "+rs.getString("chrExpression")+"' where intID="+rs.getInt("intID")+";";
				writelogs(sql);
			}
			PrePareStmtQuery.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, PrePareStmtQuery, conn);
		}

	}
}