package test;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.client.methods.RequestBuilder;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;


public class Monitor {


	public static String getInputStream(InputStream inStream){
		return getInputStream(inStream,"UTF-8");
	}
	
	public static String getInputStream(InputStream inStream,String encoding) {
		String strContent = "";
		StringBuilder builder = new StringBuilder();
		try {
			BufferedReader reader = new BufferedReader(new InputStreamReader(inStream,encoding));
			String line = null;
			
			while ((line = reader.readLine()) != null) {
				builder.append(line);
				builder.append("\n"); // appende a new line
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				inStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		strContent = builder.toString();
		return strContent;
	}
	
	public int call_patviewer(String username,String password) throws Exception {
		int ret = -1;
		
		String siteurl = "http://www.patviewer.com";
		
		if(username==null||username.equals("")){username="guest";}
		if(password==null||password.equals("")){password="123456";}
		////////////////////////////////////////  访问网站首页   ////////////////////////////////////		
        URL url = null;
        URLConnection URLconnection = null;
        HttpURLConnection httpConnection = null;

        try
        {
            url = new URL(siteurl);
            URLconnection = url.openConnection();
            URLconnection.setConnectTimeout(10000);
            URLconnection.setReadTimeout(10000);
            URLconnection.setAllowUserInteraction(false);         
            URLconnection.setDoOutput(true);
            
            httpConnection = (HttpURLConnection)URLconnection;
            int responseCode = httpConnection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                ret = 1;
            }else{
            	ret = -1;
            }
        }
        catch (MalformedURLException e)
        {        	ret = -1;
            e.printStackTrace();
        }
        catch (IOException e)
        {
        	ret = -1;
            e.printStackTrace();
        }
        catch (Exception e)
        {
        	ret = -1;
            e.printStackTrace();
        }
        finally
        {
            try
            {
            	httpConnection.disconnect();
            }
            catch (Exception ex)
            {
                ex.printStackTrace();
            }
        }
        
        ////////////////////////////////////////  登录   ////////////////////////////////////
        if(ret==1){
			BasicCookieStore cookieStore = new BasicCookieStore();
			CloseableHttpClient httpclient = null;
			try {				
				httpclient = HttpClients.custom().setDefaultCookieStore(cookieStore).build();
				
				HttpUriRequest loginrequest = RequestBuilder.post()
						.setUri(new URI(siteurl + "/login.do?method=login"))
						.addParameter("username",username)
						.addParameter("password",password)
						.addParameter("url","zljs/index.jsp")
						.addParameter("rootId","")
						.addParameter("isCorpLogin","")
						.addParameter("errorurl","error.jsp")
						.addParameter("NickName","").build();

				
				RequestConfig config = RequestConfig.custom()
			    .setSocketTimeout(60000)
			    .setConnectTimeout(60000)
			    .build();
				
				httpclient = HttpClients.custom().setDefaultCookieStore(cookieStore).setDefaultRequestConfig(config).build();
				
				CloseableHttpResponse responselogin = null;
				
				try {
					responselogin = httpclient.execute(loginrequest);
					HttpEntity entity = responselogin.getEntity();
	
					String HTMLContent = getInputStream(entity.getContent());
					System.out.println(HTMLContent);
					if(HTMLContent.indexOf("success##")>-1){
	//					System.out.println("正常登录......");
						ret = 2;
					}else{
						ret = -2;
					}
					
					EntityUtils.consume(entity);
				}catch(java.net.SocketTimeoutException e){
					ret = -2;
				}catch(java.net.SocketException e){
					ret = -2;
				}
				catch(Exception e){
					ret = -2;
				}
				finally {
					responselogin.close();
				}
				
				if(ret==2){
					CloseableHttpResponse response = null;
					CloseableHttpClient client = null;
					try{
			        //创建一个httpclient对象
			        client = HttpClients.custom().setDefaultCookieStore(cookieStore).setDefaultRequestConfig(config).build();
			        //创建一个post对象
			        HttpPost post = new HttpPost(new URI(siteurl + "/toJsonOverView.do?method=overviewSearch&area=cn"));
			        //创建一个Entity，模拟表单数据
			        List<NameValuePair> formList = new ArrayList<NameValuePair>();
			        //添加表单数据
			        formList.add(new BasicNameValuePair("strWhere", "申请号='CN200510010185.5'"));
			        formList.add(new BasicNameValuePair("area", "cn"));
			        formList.add(new BasicNameValuePair("strChannels", "14"));
			        formList.add(new BasicNameValuePair("strSources", "fmzl_ft"));//strSources
			        formList.add(new BasicNameValuePair("language", "cn"));
			        formList.add(new BasicNameValuePair("searchType", "2"));

			        //包装成一个Entity对象
			        StringEntity _entity = new UrlEncodedFormEntity(formList, "utf-8");
			        //设置请求的内容
			        post.setEntity(_entity);
			        //设置请求的报文头部的编码
			        post.setHeader(
			            new BasicHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8"));
			        //设置期望服务端返回的编码
			        post.setHeader(new BasicHeader("Accept", "text/plain;charset=utf-8"));
			        //执行post请求
			        response = client.execute(post);

			        //获取响应码
			        int statusCode = response.getStatusLine().getStatusCode();
			        if (statusCode == 200) {
			            //获取数据
			            String HTMLContent = EntityUtils.toString(response.getEntity());
			            //输出
//			            writeholidaylogs(HTMLContent);
			            System.out.println("请求成功,请求返回内容为: " + HTMLContent);
			            
						if(
//								HTMLContent.indexOf("发明专利(1)")>-1&&
								HTMLContent.indexOf("动物性发泡混凝土墙体砌块")>-1){
//							System.out.println("正常检索......");
							ret = 3;
						}else{
							ret = -3;
						}
			        } else {
			            //输出
			            System.out.println("请求失败,错误码为: " + statusCode);
			        }

			        //关闭response和client
			        response.close();
			        client.close();
					}catch(java.net.SocketTimeoutException e){
						ret = -3;
					}catch(java.net.SocketException e){
						ret = -3;
					}catch(Exception e){
						ret = -3;
					}
					finally {
						response.close();
						client.close();
					}
					
					
					
					
/*					
//					String strWhere = URLEncoder.encode("申请(专利)号='CN200510010185.5'", "UTF-8");
					String strWhere = "申请号='CN200510010185.5'";
//					String strWhere = "_id=1332E48FB3239DADDCEA3D07DD629ABA";
					
//					requestBuilder.addHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
					HttpUriRequest searchrequest = RequestBuilder.post()
//					.setUri(new URI(siteurl + "/search.do?method=detailSearch"))
					.addHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8")
					.addHeader(new BasicHeader("Accept", "text/plain;charset=UTF-8"))
					.setUri(new URI(siteurl + "/overviewSearch.do?method=overviewSearch&area=cn"))
//					.addParameter("index", "0")
					.addParameter("area","cn")
//					.addParameter("searchKind","tableSearch")
					.addParameter("strChannels","14")
//					.addParameter("strSynonymous","")
//					.addParameter("pageIndex","")
//					.addParameter("secondOrFilter","")
//					.addParameter("filterChannel","")
					.addParameter("strSources", "fmzl_ft")												
//					.addParameter("strSortMethod", "RELEVANCE")
//					.addParameter("strDefautCols", "主权项, 名称, 摘要")
//					.addParameter("strDefautCols", "")
//					.addParameter("strStat", "")
//					.addParameter("iOption", "2")
//					.addParameter("iHitPointType", "115")
//					.addParameter("bContinue" , "")
//					.addParameter("trsLastWhere", strWhere)
					.addParameter("strWhere", strWhere).build();
					//an='CN200510010185.5'

					CloseableHttpResponse response2 = null;
					try {
//						RequestConfig config = RequestConfig.custom()
//					    .setSocketTimeout(5000)
//					    .setConnectTimeout(5000)
//					    .build();
						
						httpclient = HttpClients.custom().setDefaultCookieStore(cookieStore).setDefaultRequestConfig(config).build();
						
						response2 = httpclient.execute(searchrequest);
						
						HttpEntity entity = response2.getEntity();
	
						String HTMLContent = LocalSite.getInputStream(entity.getContent());
						System.out.println(HTMLContent);
						//反应堆控制棒用对孔式水力步进缸
//						if(HTMLContent.indexOf("动物性发泡混凝土墙体砌块")>-1){
						if(HTMLContent.indexOf("发明专利(1)")>-1&&HTMLContent.indexOf("动物性发泡混凝土墙体砌块")>-1){
//							System.out.println("正常检索......");
							ret = 3;
						}else{
							shorterrorinfo += "##specific content is not included in the research result##\r\n";
							errorinfo += "##specific content is not included in the research result##\r\n" + HTMLContent;
							ret = -3;
						}
		//				System.out.println("Login form get: " + response2.getStatusLine());
						EntityUtils.consume(entity);
		
					}catch(java.net.SocketTimeoutException e){
						shorterrorinfo += shorterrorinfo+"\r\n" + e.toString();
						errorinfo += e.toString()+"\r\n"+MonitorThread.generateErrinfo(e.getStackTrace());
						ret = -3;
					}catch(java.net.SocketException e){
						shorterrorinfo += shorterrorinfo+"\r\n" + e.toString();
						errorinfo += e.toString()+"\r\n"+MonitorThread.generateErrinfo(e.getStackTrace());
						ret = -3;
					}catch(Exception e){
						shorterrorinfo += shorterrorinfo+"\r\n" + e.toString();
						errorinfo += e.toString()+"\r\n"+MonitorThread.generateErrinfo(e.getStackTrace());
						ret = -3;
					}
					finally {
						response2.close();
					}
*/					
					try{
				        //创建一个httpclient对象
				        client = HttpClients.custom().setDefaultCookieStore(cookieStore).setDefaultRequestConfig(config).build();
				        //创建一个post对象
				        HttpPost post = new HttpPost(new URI(siteurl + "/detailSearch.do?method=detailSearch&area=cn"));
				        //创建一个Entity，模拟表单数据
				        List<NameValuePair> formList = new ArrayList<NameValuePair>();
				        //添加表单数据
				        formList.add(new BasicNameValuePair("strWhere", "申请号='CN200510010185.5'"));
				        formList.add(new BasicNameValuePair("area", "cn"));
				        formList.add(new BasicNameValuePair("strChannels", "14"));
				        formList.add(new BasicNameValuePair("strSources", "fmzl_ft"));
				        formList.add(new BasicNameValuePair("area", "cn"));

				        //包装成一个Entity对象
				        StringEntity _entity = new UrlEncodedFormEntity(formList, "utf-8");
				        //设置请求的内容
				        post.setEntity(_entity);
				        //设置请求的报文头部的编码
				        post.setHeader(
				            new BasicHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8"));
				        //设置期望服务端返回的编码
				        post.setHeader(new BasicHeader("Accept", "text/plain;charset=utf-8"));
				        //执行post请求
				        response = client.execute(post);

				        //获取响应码
				        int statusCode = response.getStatusLine().getStatusCode();
				        if (statusCode == 200) {
				            //获取数据
				            String HTMLContent = EntityUtils.toString(response.getEntity());
				            //输出
				            System.out.println("请求成功,请求返回内容为: " + HTMLContent);
				            
							if(
//									HTMLContent.indexOf("发明专利(1)")>-1&&
									HTMLContent.indexOf("动物性发泡混凝土墙体砌块")>-1){
//								System.out.println("正常检索......");
								ret = 3;
							}else{
								ret = -3;
							}
				        } else {
				            //输出
				            System.out.println("请求失败,错误码为: " + statusCode);
				        }

				        //关闭response和client
				        response.close();
				        client.close();
						}catch(java.net.SocketTimeoutException e){
							ret = -3;
						}catch(java.net.SocketException e){
							ret = -3;
						}catch(Exception e){
							ret = -3;
						}
						finally {
							response.close();
							client.close();
						}
					
					////////////////////////////////////////20150430检索细览   ////////////////////////////////////
/*					HttpUriRequest detailsearchrequest = RequestBuilder.post()
//					http://59.151.93.248/cniprSLY/search.do?method=detailSearch
					.setUri(new URI(siteurl + "/detailSearch.do?method=detailSearch"))
					.addParameter("index", "0")
					.addParameter("area","cn")
					.addParameter("searchKind","tableSearch")
					.addParameter("strChannels","14,15,16")
					.addParameter("strSynonymous","")
					.addParameter("pageIndex","")
					.addParameter("secondOrFilter","")
					.addParameter("filterChannel","")
					.addParameter("strSources", "fmzl_ft")												
					.addParameter("strSortMethod", "RELEVANCE")
//					.addParameter("strDefautCols", "主权项, 名称, 摘要")
					.addParameter("strDefautCols", "")
					.addParameter("strStat", "")
					.addParameter("iOption", "2")
					.addParameter("iHitPointType", "115")
					.addParameter("bContinue" , "")
					.addParameter("trsLastWhere", "an='CN200510010185.5'")
					.addParameter("strWhere", "an='CN200510010185.5'").build();
					//an='CN200510010185.5'
	
					CloseableHttpResponse detailresponse2 = null;
					try {
					
//						RequestConfig config = RequestConfig.custom()
//					    .setSocketTimeout(5000)
//					    .setConnectTimeout(5000)
//					    .build();
						
						httpclient = HttpClients.custom().setDefaultCookieStore(cookieStore).setDefaultRequestConfig(config).build();
						
						detailresponse2 = httpclient.execute(detailsearchrequest);
						
						HttpEntity entity = detailresponse2.getEntity();
	
						String HTMLContent = LocalSite.getInputStream(entity.getContent());
						System.out.println(HTMLContent);
						//反应堆控制棒用对孔式水力步进缸
//						if(HTMLContent.indexOf("动物性发泡混凝土墙体砌块")>-1||(userid==30212&&HTMLContent.indexOf("发明专利[1]")>-1)){
						if(HTMLContent.indexOf("动物性发泡混凝土墙体砌块")>-1&&HTMLContent.indexOf("此次检索共命中 1")>-1){ 
//							System.out.println("正常检索......");
							ret = 3;
						}else{
							shorterrorinfo += "detailsearcherror:";
							errorinfo += "detailsearcherror:" + HTMLContent;
							ret = -3;
						}
		//				System.out.println("Login form get: " + response2.getStatusLine());
						EntityUtils.consume(entity);
		
					}catch(java.net.SocketTimeoutException e){
						shorterrorinfo += shorterrorinfo+"\r\n" + e.toString();
						errorinfo += "detailsearcherror:" + e.toString()+"\r\n"+MonitorThread.generateErrinfo(e.getStackTrace());
						ret = -3;
					}catch(java.net.SocketException e){
						shorterrorinfo += shorterrorinfo+"\r\n" + e.toString();
						errorinfo += "detailsearcherror:" + e.toString()+"\r\n"+MonitorThread.generateErrinfo(e.getStackTrace());
						ret = -3;
					}
					catch(Exception e){
						shorterrorinfo += shorterrorinfo+"\r\n" + e.toString();
						errorinfo += "detailsearcherror:" + e.toString()+"\r\n"+MonitorThread.generateErrinfo(e.getStackTrace());
						ret = -3;
					}
					finally {
						detailresponse2.close();
					}*/
					//////////////////////////////////////////////////////////////////////////
					
					HttpGet httpgetLogout = null;		
					CloseableHttpResponse responseLogout = null;
					try {
						//http://59.151.97.105:8080/cniprBZ/logoff.do?method=logoff&temp=0.395294454884466
						httpgetLogout = new HttpGet(siteurl + "/logoff.do?method=logoff&temp="+(int)(Math.random()*100));					
						responseLogout = httpclient.execute(httpgetLogout);
						
						HttpEntity entity = responseLogout.getEntity();
		
						String HTMLContent = getInputStream(entity.getContent());
//						System.out.println(HTMLContent);
						if(HTMLContent.indexOf("已经退出")>-1){
//							System.out.println("正常退出......");
						}
		
		//				System.out.println("Login form get: " + responseLogout.getStatusLine());
						EntityUtils.consume(entity);
		//				System.out.println("Initial set of cookies:");
		//				List<Cookie> cookies = cookieStore.getCookies();
		//				if (cookies.isEmpty()) {
		//					System.out.println("None");
		//				} else {
		//					for (int i = 0; i < cookies.size(); i++) {
		//						System.out.println("- " + cookies.get(i).toString());
		//					}
		//				}
					}catch(Exception e){
						ret = -3;
					} finally {
						responseLogout.close();
					}
				}				
			} finally {
				httpclient.close();
			}		
        }
		
		return ret;
	}
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
