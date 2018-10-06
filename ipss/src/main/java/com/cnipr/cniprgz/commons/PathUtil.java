package com.cnipr.cniprgz.commons;

import java.net.URL;
 

public class PathUtil {
	
	public static String getAbsoluteClassPath(){
		 URL url = PathUtil.class.getResource("/");
		 return url.getPath();
	}
	
	public static String getAbsoluteWebPath(){ 
		 return getAbsoluteClassPath().replace("/classes", "").replace("/WEB-INF", "");
	}
}
