package com.cnipr.cniprgz.commons;

import org.apache.commons.httpclient.NameValuePair;

public interface HttpTools {
	
	/**
	 * @param urlPath
	 * @param params
	 * @param charset
	 * @param type
	 * @return
	 */
	public String crossDomainContentByStream(String urlPath,String params,String charset,String type);
	
	/**
	 * @param url     请求的路径
	 * @param params  请求的参数,参数类型是数组MutlMap,可以存放重复key的Map结构
	 * @param charset 请求的编码格式
	 * @return
	 * 
	 * @function      采用第三方jar包的方式模拟post提交请求
	 */
	public String crossDomainByHttpPost(String url,MutlMap params,String charset);
	
	/**
	 * 
	 * @param serverUrl TIFF服务地址
	 * @param filePath  TIFF文件地址,
	 * @return
	 * @function		下载TIFF图指定的接口	
	 */
	public boolean downloadTiffJpgToFile(String serverUrl,String filePath);
	
	/**
	 * 
	 * @param urlPath  请求的路径
	 * @param charset  请求的编码格式
	 * @return
	 * @function	        采用流的方式直接请求连接
	 */
	public String getCrossDomainContentByGet(String urlPath, String charset);
	
	/**
	 * 
	 * @param url     请求的路径
	 * @param params  请求的参数,参数类型是数组NameValuePair
	 * @param charset 请求的编码格式
	 * @return
	 * @function	     采用第三方jar包的方式模拟post提交请求
	 */
	public String crossDomainByHttpPost(String url,NameValuePair[] params,String charset);
	
}
