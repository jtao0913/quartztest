package com.cnipr.cniprgz.func;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;

import com.cnipr.cniprgz.commons.DataAccess;

public class FamilyFunc {

	public static void main(String[] args) {
		String FamilyURL = DataAccess.getProperty("FamilyURL");
		
		java.io.InputStream l_urlStream;
		String sCurrentLine = "";
		try {
			java.net.URL l_url = new java.net.URL(FamilyURL + 
					"an=AP19990001432");
			HttpURLConnection l_connection = (HttpURLConnection) l_url
					.openConnection();

			l_connection.setRequestMethod("POST");
			l_urlStream = l_connection.getInputStream();

			java.io.BufferedReader l_reader = new java.io.BufferedReader(
					new java.io.InputStreamReader(l_urlStream, "gb2312"));

			if ((sCurrentLine = l_reader.readLine()) != null) {
				System.out.println(sCurrentLine);
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static String getFamily(String strAN){
		String strFamily = "";
		
		String FamilyURL = DataAccess.getProperty("FamilyURL");
		
		java.io.InputStream l_urlStream;
		String sCurrentLine = "";
		try {
			java.net.URL l_url = new java.net.URL(FamilyURL + "an="+strAN);
			HttpURLConnection l_connection = (HttpURLConnection) l_url.openConnection();

			l_connection.setRequestMethod("POST");
			l_urlStream = l_connection.getInputStream();

			java.io.BufferedReader l_reader = new java.io.BufferedReader(new java.io.InputStreamReader(l_urlStream, "gb2312"));

			if ((sCurrentLine = l_reader.readLine()) != null) {
//				System.out.println(sCurrentLine);
				strFamily = sCurrentLine;
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return strFamily;
	}
}
