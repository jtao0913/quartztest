package com.cnipr.monitor;

import java.io.File;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

public class MonitorThread extends HttpServlet {
	
	private static final long serialVersionUID = 1252730706437749089L;

	public static float countTime(long begin,long end){
		float total_seceond = 0;
		try {
			long sss = end - begin;
			System.out.println(sss);
			total_seceond = (end - begin)/1000.00F;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return total_seceond;
	}

    public static void delFolder(String folderPath) {
        try {
           delAllFile(folderPath); //删除完里面所有内容
           String filePath = folderPath;
           filePath = filePath.toString();
           java.io.File myFilePath = new java.io.File(filePath);
           myFilePath.delete(); //删除空文件夹
        } catch (Exception e) {
          e.printStackTrace(); 
        }
   }
   
  //删除指定文件夹下所有文件
   //param path 文件夹完整绝对路径
      public static boolean delAllFile(String path) {
          boolean flag = false;
          File file = new File(path);
          if (!file.exists()) {
            return flag;
          }
          if (!file.isDirectory()) {
            return flag;
          }
          String[] tempList = file.list();
          File temp = null;
          for (int i = 0; i < tempList.length; i++) {
             if (path.endsWith(File.separator)) {
                temp = new File(path + tempList[i]);
             } else {
                 temp = new File(path + File.separator + tempList[i]);
             }
             if (temp.isFile()) {
                temp.delete();
             }
             if (temp.isDirectory()) {
                delAllFile(path + "/" + tempList[i]);//先删除文件夹里面的文件
                delFolder(path + "/" + tempList[i]);//再删除空文件夹
                flag = true;
             }
          }
          return flag;
        }
	
	public void init(ServletConfig servletconfig) throws ServletException {
		System.out.println("monitorthread.....run().........");
		Timer timer = new Timer();
		
		try {
			timer.schedule(new Timer_Morning_06AM(), 5 * 1000, 180 * 1000);			
			timer.schedule(new Timer_MondayMorning_06AM(), 5 * 1000, 180 * 1000);
			
		} catch (Exception ex) {
			timer.cancel();
		}
	}
}

class Timer_Morning_06AM extends TimerTask {
	public void run() {
		try {
//			File directory = new File(".");
//			System.out.println(directory.getCanonicalPath()); //得到的是C:\test			
//			System.out.println(this.getClass().getClassLoader().getResource("/").getPath());
			
//			File directory = new File("");//设定为当前文件夹			
//		    System.out.println(directory.getCanonicalPath());//获取标准的路径
//		    System.out.println(directory.getAbsolutePath());//获取绝对路径
			
			Calendar calendar = Calendar.getInstance();
	        calendar.set(Calendar.HOUR_OF_DAY, 5);
	        calendar.set(Calendar.MINUTE, 50);
	        calendar.set(Calendar.SECOND, 0);
	        Date date_0550 = calendar.getTime();	        
	        
	        calendar.set(Calendar.HOUR_OF_DAY, 6);
	        calendar.set(Calendar.MINUTE, 0);
	        calendar.set(Calendar.SECOND, 0);	        
	        Date date_0600 = calendar.getTime();
	        
			Date date = new Date();
			if(date.after(date_0550)&&date.before(date_0600))
			{
				System.out.println("new 每日清理temp文件夹..............");
				
				String tempfilefolder = this.getClass().getClassLoader().getResource("../../tempfile").getPath();
				System.out.println(tempfilefolder);
				
				MonitorThread.delAllFile(tempfilefolder);				
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}

class Timer_MondayMorning_06AM extends TimerTask {
	public void run() {
		try {
//			File directory = new File(".");
//			System.out.println(directory.getCanonicalPath()); //得到的是C:\test			
//			System.out.println(this.getClass().getClassLoader().getResource("/").getPath());
			
//			File directory = new File("");//设定为当前文件夹			
//		    System.out.println(directory.getCanonicalPath());//获取标准的路径
//		    System.out.println(directory.getAbsolutePath());//获取绝对路径
			
			Calendar calendar = Calendar.getInstance();
			
			calendar.set(Calendar.DAY_OF_WEEK, 2);
	        calendar.set(Calendar.HOUR_OF_DAY, 5);
	        calendar.set(Calendar.MINUTE, 50);
	        calendar.set(Calendar.SECOND, 0);
	        Date date_0550 = calendar.getTime();	        
	        
	        calendar.set(Calendar.DAY_OF_WEEK, 2);
	        calendar.set(Calendar.HOUR_OF_DAY, 6);
	        calendar.set(Calendar.MINUTE, 0);
	        calendar.set(Calendar.SECOND, 0);	        
	        Date date_0600 = calendar.getTime();
	        
			Date date = new Date();
			if(date.after(date_0550)&&date.before(date_0600))
			{
				System.out.println("new 每周一早上清理pngtempfiles文件夹..............");
				
				String tempfilefolder = this.getClass().getClassLoader().getResource("../../pngtempfiles").getPath();
				System.out.println(tempfilefolder);
				
				MonitorThread.delAllFile(tempfilefolder);				
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
