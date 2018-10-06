/**  
 * Package:		com.dpnet.web.servlet
 * Filename:    SystemINIT.java  
 * Description:   
 * Copyright:   Copyright (c)2008  
 * Company:       
 * @author:     YinXu 
 * @version:    1.0  
 * Create at:   Dec 17, 2008 8:49:30 PM  
 *  
 * Modification History:  
 * Date         Author      Version     Description  
 * ------------------------------------------------------------------  
 * Dec 17, 2008   YinXu      1.0         1.0 Version  
 */
package com.cnipr.cniprgz.servlet;

/**
 * ClassName:	SystemINIT
 * Description:	系统初始化
 */ 

 
import java.io.IOException;
import javax.servlet.http.HttpServlet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 
import net.jbase.common.util.StringUtil;
import net.jbase.common.util.xml.SAXHelper; 
 
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;  

import com.cnipr.cniprgz.commons.SetupAccess;
import com.cnipr.cniprgz.commons.SetupConstant;
import com.cnipr.cniprgz.log.Log74INIT;
import com.cnipr.cniprgz.task.LawWarnTimer;
 
  
 

/**
 * 系统初始化
 * 
 * <pre>执行信息的步骤如下 : </pre>
 * <ol>
 * 		<li>初始化xml配置文件路径</li>
 * 		<li>设置ServletContext</li>
 * 		<li>
 * 			<pre>载入XML文件，并将解析的数据写入内存</pre>
 * 		</li>
 * 		<li>初始化Freemarker的静态类</li>
 * 		<li>
 * 			读取数据库信息到内存
 *		</li>
 * 		<li>
 * 			初始化JS数据
 *		</li>
 * 		<li>启动定时器</li>
 * <ol>
 * 
 * @author YinXu
 * 
 * @version $Revision: 1.00 $ $Date: 2008/12/17 20:48:14 $
 */
@SuppressWarnings("unchecked")
public class SystemINIT extends HttpServlet {
	
    /** serialVersionUID*/
	private static final long serialVersionUID = -668619040700255644L;
	
	 protected static final Logger logger =  Logger.getLogger(SystemINIT.class); 
 
    
    //Initialize global variables
    public void init() throws ServletException {
    	try {  
			// 7、启动定时器
		 	startTimer();
			
		} catch (Exception exception) {
			logger.error("初始化失败，请检查配置信息");
			logger.error("Init Application has error.", exception);
			// 初始化失败，停止web服务器
			// System.exit(0);
		}
		
    }
    
      

    
    /**
     * 启动定时器
     * 
     */
    private void startTimer(){
    	if(SetupAccess.getProperty(SetupConstant.LAWWARN)!=null && SetupAccess.getProperty(SetupConstant.LAWWARN).equals("1") )
    	{
			logger.info("开始启动定时器....");
			LawWarnTimer it = new LawWarnTimer(getServletContext());
			it.start();
			logger.info("定时器启动完成....");    
    	}
    }
    
    
    //Process the HTTP Get request
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    //Clean up resources
    public void destroy() {
    }
    
}

