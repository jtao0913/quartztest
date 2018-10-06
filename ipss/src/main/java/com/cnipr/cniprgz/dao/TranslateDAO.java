package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Hashtable;

import com.cnipr.cniprgz.db.DBPoolAccessor;

public class TranslateDAO {

	public static Hashtable<String, String> buildTranslateParam() {

		Hashtable<String, String> hashtable1 = new Hashtable<String,String>();
		String chrLibName = "";
		String chrClass = "";
		int i1 = 0;
		
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet resultset = null;
	
			try {
				conn = DBPoolAccessor.getConnection();
				ps = conn.prepareStatement("select * from ipr_param_translate");
				resultset = ps.executeQuery();
				while (resultset.next()) {
					chrLibName = resultset.getString("chrLibName");
					chrClass = resultset.getString("chrClass");
					hashtable1.put(chrClass, chrLibName);
					i1++;
				}
	
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				DBPoolAccessor.closeAll(resultset, ps, conn);
			}
		
		return hashtable1;
	}
}
