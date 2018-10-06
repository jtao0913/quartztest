package com.cnipr.cniprgz.authority.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import com.cnipr.cniprgz.db.DBPoolAccessor;

/**
 * 检查用户IP是否在允许范围内
 * @author 赵亮
 * @date 2012-01-04
 *
 */
public class IPCheckUtils {

	/**
	 * 将IP转化为long型数字
	 * @param ip
	 * @return
	 * @throws Exception
	 */
	public static long ip2long(String ip) throws Exception{
		if(ip==null){
			throw new Exception();
		}
		try{
            String as[] = splitString(ip, ".");
            long l = 0L;
            for(int i = 0; i < as.length; i++){
                long l1 = (long)Math.pow(256D, as.length - i - 1);
                Integer integer = new Integer(as[i]);
                l += l1 * integer.longValue();
            }
            return l;
        } catch(Exception exception) {
            throw new Exception("#将IP'" + ip + "'转换成整数时出现异常#IPCheckUtils.ip2long#");
        }
	}
	
	@SuppressWarnings("unchecked")
	public static String[] splitString(String s, String s1) throws Exception{
		if(s == null)
			throw new Exception("#父字符串为空#IPCheckUtils.splitString#");
		if(s1 == null)
			throw new Exception("#分隔符为空#IPCheckUtils.splitString#");
		int i = 0;
		Vector vector = new Vector();
		
		try{
	        for(int j = s.indexOf(s1); j != -1; j = s.indexOf(s1, i)){
	            vector.add(s.substring(i, j));
	            i = j + s1.length();
	        }

	        if(i != 0){
	        	vector.add(s.substring(i));
	        }
	        if(vector.size() > 0){
	        	String as[] = new String[vector.size()];
            	vector.copyInto(as);
            	return as;
	        } else {
	        	String as1[] = new String[1];
	        	as1[0] = s;
	        	return as1;
	        }
		}
	    catch(Exception exception) {
	        throw new Exception("#以分隔符'" + s1 + "'分割字符串'" + s + "'时出现异常#IPCheckUtils.splitString#" + exception.getMessage());
	    }
	}
	
	/**
	 * 将long型数字转化为ip地址
	 * @param num
	 * @return
	 * @throws Exception
	 */
	public static String long2ip(long num) throws Exception{
		if(num <= 0L)
        throw new Exception("#需要转换值'" + num + "'非法#IPCheckUtils.long2ip#");
		try {
	        String s = "";
	        long l1 = 0L;
	        for(int i = 4; i > 0; i--){
	            long l2 = (long)Math.pow(256D, i - 1);
	            long l3 = (num - l1) / l2;
	            l1 = l3 * l2 + l1;
	            if(i != 4){
	            	s = s + ".";
	            }
	            s = s + String.valueOf(l3);
	        }
	        return s;
		}catch(Exception exception){
			throw new Exception("#将整数'" + num + "'转换成IP地址时出现异常#IPCheckUtils.long2ip#");
		}
	}
	
	public static boolean checkIPAddress(String userName, String remoteAddress){
		try {			 
			long num = ip2long(remoteAddress);
			boolean flag = checkAddressScope(userName,num);
			return flag;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	private static boolean checkAddressScope(String userName,long num){
		boolean ret = true;
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement _pstmt = null;
		ResultSet rs = null;
		ResultSet _rs = null;
		String sql = "select * from ipr_ipaddress where chrUserName='" + userName + "' and intBeginIP=" + num;
		try {
			conn = DBPoolAccessor.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
//			if(rs.next()){
//				sql = "select * from ipr_ipaddress where chrUserName='" + userName + "' and intBeginIP<=" + num +" and intEndIP>=" + num;
//				_pstmt = conn.prepareStatement(sql);
//				_rs = _pstmt.executeQuery();
//				if(_rs.next()){
//					ret = true;
//				}else{
//					ret = false;
//				}				
//			}else {
//				ret = true;
//			}
			if(rs.next()){
				ret = true;//此访问IP属于被拦截IP
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return ret;
	} 
	
	/**
	 * 取得用户的限制IP
	 * @param userName
	 * @return
	 */
	public static String getUserLimitIP(String userName){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select intBeginIP,intEndIP from ipr_ipaddress where chrUserName='" + userName + "'";
		StringBuilder builder = new StringBuilder();
		try {
			conn = DBPoolAccessor.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				long iBegin = rs.getLong("intBeginIP");
				long iEnd = rs.getLong("intEndIP");
				builder.append(long2ip(iBegin))
					.append("~")
					.append(long2ip(iEnd))
					.append(";");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		String resultStr = builder.toString();
		if(resultStr.endsWith(";")){
			resultStr = resultStr.substring(0,resultStr.length()-1);
		}
		if("".equals(resultStr)){
			resultStr = "%";
		}
		return resultStr;
	} 
	
	/**
	 * 保存用户限制的IP
	 * @param userName
	 * @param limitIP
	 */
	public static void setUserLimitIP(String userName, String limitIP){
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into ipr_ipaddress(chrUserName,intBeginIP,intEndIP) values(?,?,?)";
		try {
			if("%".equals(limitIP.trim())){
				//不限制直接返回
				return;
			}
			if(limitIP!=null && !"".equals(limitIP)){
			conn = DBPoolAccessor.getConnection();
			/**** 删除已有的信息  ****/
			pstmt = conn.prepareStatement("delete from ipr_ipaddress where chrUserName='" + userName + "'");
			pstmt.executeUpdate();
			pstmt.close();
			
			/***** 添加新的IP信息 **************/
			//替换全交的分号
			limitIP.replace("；", ";");
			String[] ipArray = splitString(limitIP,";");
			for(String ip : ipArray){
				ip = ip.trim();
				String start = "";
				String end = "";
				if(ip.indexOf("~")>-1){
					start = ip.substring(0,ip.indexOf("~"));
					end = ip.substring(ip.indexOf("~")+1);
				}else{
					start = ip.trim();
					end = ip.trim();
				}
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userName);
				pstmt.setLong(2, ip2long(start.trim()));
				pstmt.setLong(3, ip2long(end.trim()));
				pstmt.executeUpdate();
				pstmt.close();
			}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public static void main(String[] args) {
		try {
			System.out.println(ip2long("192.168.3.101"));
			System.out.println(ip2long("192.168.3.102"));
			System.out.println(ip2long("162.168.3.102"));
			System.out.println(ip2long("127.0.0.1"));
			System.out.println(long2ip(3232236389l));
			System.out.println(long2ip(3232236390l));
			System.out.println(long2ip(2728919910l));
			
			setUserLimitIP("guest","192.168.3.100~192.168.3.200;127.0.0.1~127.0.0.1;59.151.93.10~59.151.93.150");
			String s = getUserLimitIP("guest");
			System.out.println(s);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}
