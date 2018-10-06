package com.cnipr.cniprgz.commons;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.springframework.stereotype.Component;

import com.cnipr.util.Endecrypt;
import com.cnipr.util.localMAC;

@Component
public class HttpToolsI implements HttpTools{
	
	private static int readTimeOut = 60*1000*5;
	
	@Override
	public String crossDomainContentByStream(String urlPath,String params,String charset,String type) {
		String result = "";
		BufferedReader br = null;
		URL url = null;
		try {
			url = new URL(urlPath);
			HttpURLConnection connection = (HttpURLConnection) url
					.openConnection();
			connection.setDoOutput(true);
			connection.setDoInput(true);
			connection.setRequestMethod(type);
			connection.setRequestProperty("Content-Type", "text/plain; charset="+charset);
			connection.setReadTimeout(readTimeOut);
			connection.setConnectTimeout(10000);
			connection.connect();
			if(params != null && !"".equals(params)){
				OutputStreamWriter out = new OutputStreamWriter(
						connection.getOutputStream(), charset);
				out.write(params);
				out.flush();
				out.close();
			}
			if(connection.getResponseCode() == 200){
				br = new BufferedReader(new InputStreamReader(
						connection.getInputStream(), charset));
				StringBuffer resBuffer = new StringBuffer();
				String resTemp = "";
				while ((resTemp = br.readLine()) != null) {
					resBuffer.append(resTemp);
				}
				result = resBuffer.toString();
			}
		} catch (MalformedURLException e) {
		} catch (IOException e) {
		} finally{
			if(br!=null){
				try {
					br.close();
				} catch (IOException e) {
				}
			}
		}
		return result;
	}
	
	public String crossDomainByHttpPost(String url,MutlMap params,String charset){
		String result = "";
		HttpClient httpClient = new HttpClient();
		PostMethod postMethod = new PostMethod(url);
		postMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, charset);
		httpClient.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, readTimeOut);
		if(params!=null && params.size()>0){
			postMethod.setRequestBody(params.toNameValuePair());
		}
		BufferedReader br = null;
		try {
			int statusCode = httpClient.executeMethod(postMethod);
			if (statusCode == HttpStatus.SC_OK) {
				br = new BufferedReader(new InputStreamReader(
						postMethod.getResponseBodyAsStream(), charset));
				StringBuffer resBuffer = new StringBuffer();
				String resTemp = "";
				while ((resTemp = br.readLine()) != null) {
					resBuffer.append(resTemp);
				}
				result = resBuffer.toString();
			}
		} catch (HttpException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if(br!=null){
				try {
					br.close();
				} catch (IOException e) {
				}
			}
		}
		return result;
	}
	
	public String crossDomainByHttpPost(String url,NameValuePair[] params,String charset){
		String result = "";
		HttpClient httpClient = new HttpClient();
		PostMethod postMethod = new PostMethod(url);
		postMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, charset);
		httpClient.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, readTimeOut);
		if(params != null){
			postMethod.setRequestBody(params);
		}
		BufferedReader br = null;
		try {
			int statusCode = httpClient.executeMethod(postMethod);
			if (statusCode == HttpStatus.SC_OK) {
				br = new BufferedReader(new InputStreamReader(
						postMethod.getResponseBodyAsStream(), charset));
				StringBuffer resBuffer = new StringBuffer();
				String resTemp = "";
				while ((resTemp = br.readLine()) != null) {
					resBuffer.append(resTemp);
				}
				result = resBuffer.toString();
			}
		} catch (HttpException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if(br!=null){
				try {
					br.close();
				} catch (IOException e) {
				}
			}
		}
		return result;
	}
	
//	(downloadServer, serverUrl, fileSavePath ,i)
	public boolean downloadPNGToFile(String downloadServer, String serverUrl,String filePath,int pageno){
		FileOutputStream fos = null;
		BufferedInputStream bis = null;
		HttpURLConnection httpUrl = null;
		URL url = null;
		byte[] buf = new byte[1024];
		int size = 0;
		int tryCount = 0;
		while (tryCount < 3) {
			// 建立链接
			try {
				/////////////////////////////////////////////////////////
				String mac = localMAC.getLocalMac();
//				String _strUrl = DataAccess.getProperty("PicServerURL") + strUrl + "/" + strCurPage;				
				Endecrypt crypt = new Endecrypt();
//				F48E38A1264C@/SD/2016/20160210/201310406669.6
				String oldString = mac + "@" + serverUrl.toUpperCase().replace("/BOOKS", "");				
				String SPKEY = "cniprPNG";
//				System.out.println("1、分配的SPKEY为:  " + SPKEY);
//				System.out.println("2、的内容为:  " + oldString);
				String reValue = crypt.get3DESEncrypt(oldString, SPKEY);
				/////////////////////////////////////////////////////////
				
				url = new URL(downloadServer + "/imgpub/showpage.do?path=" + reValue + "&pageno=" + pageno + "&type=1");
				httpUrl = (HttpURLConnection) url.openConnection();
				httpUrl.setRequestProperty("Use-Contrl", "LIPTIFACTIVEX");
				httpUrl.setRequestProperty("Use-Agent", "LIDOWN");
				httpUrl.setRequestProperty("Check-Code", getCheckCode());
				httpUrl.setRequestProperty("Connection", "Keep-Alive");
				httpUrl.setRequestProperty("Cache-Control", "no-cache");

				// 读取超时设置
				httpUrl.setReadTimeout(readTimeOut);
				httpUrl.setConnectTimeout(60000);
				// 连接指定的资源
				httpUrl.connect();
				// 获取网络输入流
				bis = new BufferedInputStream(httpUrl.getInputStream());
				// 建立文件
				fos = new FileOutputStream(filePath);
				// 保存文件
				while ((size = bis.read(buf)) != -1) {
					fos.write(buf, 0, size);
				}
				break;
			} catch (MalformedURLException e) {
				e.printStackTrace();
				return false;
			} catch (IOException e) {
				if (tryCount == 2) {
				} else {
					try {
						Thread.sleep(3000);
					} catch (InterruptedException e1) {
						e1.printStackTrace();
					}
				}
				return false;
			} finally {
				try {
					if (fos != null) {
						fos.close();
					}
					if (bis != null) {
						bis.close();
					}
					if (httpUrl != null) {
						httpUrl.disconnect();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
				tryCount++;
			}
		}
		
		return true;
	}
	
	public boolean downloadTiffJpgToFile(String serverUrl, String filePath){
		FileOutputStream fos = null;
		BufferedInputStream bis = null;
		HttpURLConnection httpUrl = null;
		URL url = null;
		byte[] buf = new byte[1024];
		int size = 0;
		int tryCount = 0;
		
//		String str = String.format("%06d", pageno);
		
		while (tryCount < 3) {
			// 建立链接
			try {
				url = new URL(serverUrl);
				httpUrl = (HttpURLConnection) url.openConnection();
				httpUrl.setRequestProperty("Use-Contrl", "LIPTIFACTIVEX");
				httpUrl.setRequestProperty("Use-Agent", "LIDOWN");
				httpUrl.setRequestProperty("Check-Code", getCheckCode());
				httpUrl.setRequestProperty("Connection", "Keep-Alive");
				httpUrl.setRequestProperty("Cache-Control", "no-cache");

				// 读取超时设置
				httpUrl.setReadTimeout(readTimeOut);
				httpUrl.setConnectTimeout(60000);
				// 连接指定的资源
				httpUrl.connect();
				// 获取网络输入流
				bis = new BufferedInputStream(httpUrl.getInputStream());
				// 建立文件
				fos = new FileOutputStream(filePath);
				// 保存文件
				while ((size = bis.read(buf)) != -1) {
					fos.write(buf, 0, size);
				}
				
//				fos.close();
//				bis.close();
				
				break;
			} catch (MalformedURLException e) {
				e.printStackTrace();
				return false;
			} catch (IOException e) {
				if (tryCount == 2) {
				} else {
					try {
						Thread.sleep(3000);
					} catch (InterruptedException e1) {
						e1.printStackTrace();
					}
				}
				return false;
			} finally {
				try {
					if (fos != null) {
						fos.close();
					}
					if (bis != null) {
						bis.close();
					}
					if (httpUrl != null) {
						httpUrl.disconnect();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
				tryCount++;
			}
		}
		
		return true;
	}
	
	static String getCheckCode() {
		java.util.Date dt = new java.util.Date();
		java.text.SimpleDateFormat sformat1 = new java.text.SimpleDateFormat(
				"yyyy-MM-dd-HH-mm-ss");
		String sSearchTime1 = sformat1.format(dt);
		String[] st = new String[6];
		st = sSearchTime1.split("-");
		int os = Integer.parseInt(st[0]) + Integer.parseInt(st[1])
				+ Integer.parseInt(st[2]) + Integer.parseInt(st[3])
				+ Integer.parseInt(st[4]) + Integer.parseInt(st[5]);
		String checkCode = String.valueOf(os);

		return checkCode;
	}

	@Override
	public String getCrossDomainContentByGet(String urlPath, String charset) {
		String result = "";
		URL url = null;
		BufferedReader br = null;
		try {
			url = new URL(urlPath);
			br = new BufferedReader(new InputStreamReader(url.openStream(),
					charset));
			StringBuffer resBuffer = new StringBuffer();
			String resTemp = "";
			while ((resTemp = br.readLine()) != null) {
				resBuffer.append(resTemp);
			}
			result = resBuffer.toString();
		} catch (MalformedURLException e) {
		} catch (IOException e) {
		} finally {
			try {
				if (br != null) {
					br.close();
				}
			} catch (IOException e) {
			}
		}
		return result;
	}
}
