package com.cnipr.cniprgz.func.download;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Vector;

import com.cnipr.cniprgz.commons.Util;
import com.cnipr.cniprgz.log.CniprLogger;


/**
 * <p>
 * Title: HttpGet
 * </p>
 * <p>
 * Description: 将指定的HTTP网络资源在本地以文件形式存放
 * </p>
 * <p>
 * Copyright: Copyright (c) 2009
 * </p>
 * <p>
 * Company: cnipr
 * </p>
 * 
 * @author lq
 * @version 1.0
 */
public class HttpGet {

	private static int BUFFER_SIZE = 8096;// 缓冲区大小

	private Vector<String> vDownLoad = new Vector<String>();// URL列表

	private Vector<String> vFileList = new Vector<String>();// 下载后的保存文件名列表
	
	private String rootPath = "";

	/**
	 * 构造方法
	 */
	public HttpGet() {
	}

	/**
	 * 清除下载列表
	 */
	public void resetList() {
		vDownLoad.clear();
		vFileList.clear();
	}

	/**
	 * 增加下载列表项
	 * 
	 * @param url
	 *            String
	 * @param filename
	 *            String
	 */
	public void addItem(String url, String filename) {
		vDownLoad.add(url);
		vFileList.add(filename);
	}

	/**
	 * 根据列表下载资源
	 */
	public void downLoadByList() {
		String url = null;
		String filename = null;
		// 按列表顺序保存资源
		for (int i = 0; i < vDownLoad.size(); i++) {
			url = (String) vDownLoad.get(i);
			filename = (String) vFileList.get(i);
			saveToFile(url, rootPath + filename);
		}

		// FileServerLogger.LogDebug("下载完成!!!");
	}

	/**
	 * 将HTTP资源另存为文件
	 * 
	 * @param destUrl
	 *            String
	 * @param fileName
	 *            String
	 * @throws Exception
	 */
	public void saveToFile(String destUrl, String fileName) {
		FileOutputStream fos = null;
		BufferedInputStream bis = null;
		HttpURLConnection httpUrl = null;
		URL url = null;
		byte[] buf = new byte[BUFFER_SIZE];
		int size = 0;

		int tryCount = 0;
		while (tryCount < 3) {

			// 建立链接
			try {
				url = new URL(destUrl);
				httpUrl = (HttpURLConnection) url.openConnection();
				httpUrl.setRequestProperty("Use-Contrl", "LIPTIFACTIVEX");
				httpUrl.setRequestProperty("Use-Agent", "LIDOWN");
				httpUrl.setRequestProperty("Check-Code", Util.getCheckCode());
//				httpUrl.setRequestProperty("Liuser-Name", DataAccess
//						.getProperty("Liuser-Name"));
				httpUrl.setRequestProperty("Connection", "Keep-Alive");
				httpUrl.setRequestProperty("Cache-Control", "no-cache");

				// 读取超时设置
				httpUrl.setReadTimeout(10000);
				httpUrl.setConnectTimeout(60000);
				// 连接指定的资源
				httpUrl.connect();
				// 获取网络输入流
				bis = new BufferedInputStream(httpUrl.getInputStream());
				// 建立文件
				fos = new FileOutputStream(fileName);
				CniprLogger.LogDebug("正在获取链接[" + destUrl
						+ "]的内容...\n将其保存为文件[" + fileName + "]");
				// 保存文件
				while ((size = bis.read(buf)) != -1) {
					fos.write(buf, 0, size);
				}
				break;
			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				if (tryCount == 2) {
					CniprLogger.LogError(e.getMessage() + " 资源不存在");
				} else {
					try {
						Thread.sleep(3000);
					} catch (InterruptedException e1) {
						e1.printStackTrace();
					}
				}
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
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				tryCount++;
			}
		}

	}

	// /**
	// * 将HTTP资源另存为文件
	// *
	// * @param destUrl
	// * String
	// * @param fileName
	// * String
	// * @throws Exception
	// */
	// public void saveToFile(String destUrl, String fileName) {
	// FileOutputStream fos = null;
	// BufferedInputStream bis = null;
	// HttpURLConnection httpUrl = null;
	// URL url = null;
	// byte[] buf = new byte[BUFFER_SIZE];
	// int size = 0;
	// // 建立链接
	// try {
	// url = new URL(destUrl);
	// httpUrl = (HttpURLConnection) url.openConnection();
	// httpUrl.setRequestProperty("Use-Contrl", "LIPTIFACTIVEX");
	// httpUrl.setRequestProperty("Use-Agent", "LIREAD");
	// httpUrl.setRequestProperty("Check-Code", Tools.getCheckCode());
	// httpUrl.setRequestProperty("LIUSER-NAME", "cnipr_group");
	//			
	// httpUrl.setRequestProperty("User-Agent", "PatiV");
	// httpUrl.setRequestProperty("Livisitor-Ip", "192.168.3.81");
	// httpUrl.setRequestProperty("Lipatent-Mac", "00-16-96-0B-25-9E");
	// httpUrl.setRequestProperty("Lipatent-No", "CN200810072982.X");
	//			
	//			
	//			
	// // 读取超时设置
	// httpUrl.setReadTimeout(10000);
	// httpUrl.setConnectTimeout(60000);
	// // 连接指定的资源
	// httpUrl.connect();
	// Map map = httpUrl.getHeaderFields();
	// // 获取网络输入流
	// bis = new BufferedInputStream(httpUrl.getInputStream());
	// // 建立文件
	// fos = new FileOutputStream(fileName);
	// // FileServerLogger.LogDebug("正在获取链接[" + destUrl +
	// // "]的内容...\n将其保存为文件["
	// // + fileName + "]");
	// // 保存文件
	// while ((size = bis.read(buf)) != -1) {
	// fos.write(buf, 0, size);
	// }
	// } catch (MalformedURLException e) {
	// e.printStackTrace();
	// } catch (IOException e) {
	// FileServerLogger.LogError(e.getMessage() + " 资源不存在");
	// } finally {
	// try {
	// if (fos != null) {
	// fos.close();
	// }
	//
	// if (bis != null) {
	// bis.close();
	// }
	//
	// if (httpUrl != null) {
	// httpUrl.disconnect();
	// }
	// } catch (IOException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// }
	// }
	//
	// }

	/**
	 * 设置代理服务器
	 * 
	 * @param proxy
	 *            String
	 * @param proxyPort
	 *            String
	 */
	public void setProxyServer(String proxy, String proxyPort) {
		// 设置代理服务器
		System.getProperties().put("proxySet", "true");
		System.getProperties().put("proxyHost", proxy);
		System.getProperties().put("proxyPort", proxyPort);
	}

	/**
	 * 设置认证用户名与密码
	 * 
	 * @param uid
	 *            String
	 * @param pwd
	 *            String
	 */
	public void setAuthenticator(String uid, String pwd) {
		// Authenticator.setDefault(new MyAuthenticator(uid, pwd));
	}

	/**
	 * 主方法(用于测试)
	 * 
	 * 
	 * @param argv
	 *            String[]
	 */
	public static void main(String argv[]) {
		HttpGet oInstance = new HttpGet();
		try {
			// 增加下载列表
			// String str = String.format("%06d", 1);
			for (int i = 1; i <= 6; i++) {
				// oInstance
				// .addItem(
				// "http://search.cnipr.com:8080/books/FM/2009/20090506/200810072982.X/"
				// + String.format("%06d", i) + ".tif",
				// "./" + String.format("%06d", i) + ".tif");

				

			}
			oInstance
			.addItem(
					"http://pic.cnipr.com:8080/XmlData/fm/19850910/85100676/85100676.tif",
					"E:/temp/2.tif");
			// oInstance.addItem(
			// "http://helpexamples.com/flash/video/cuepoints.flv",
			// "./cuepoints.flv");
			// oInstance.addItem("http://www.ebook.com/java/网络编程003.zip",
			// "./网络编程3.zip");
			// oInstance.addItem("http://www.ebook.com/java/网络编程004.zip",
			// "./网络编程4.zip");
			// oInstance.addItem("http://www.ebook.com/java/网络编程005.zip",
			// "./网络编程5.zip");
			// oInstance.addItem("http://www.ebook.com/java/网络编程006.zip",
			// "./网络编程6.zip");
			// oInstance.addItem("http://www.ebook.com/java/网络编程007.zip",
			// "./网络编程7.zip");
			// 开始下载
			oInstance.downLoadByList();
		} catch (Exception err) {
			System.out.println(err.getMessage());
		}
	}

	public Vector<String> getVFileList() {
		return vFileList;
	}

	public void setRootPath(String rootPath) {
		this.rootPath = rootPath;
	}
}
