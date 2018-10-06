package tools.thread;

import java.io.File;
import java.util.TimerTask;

public class MyTask1 extends TimerTask {

	

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

//	public void run() {
//		try{
//			System.out.println("task111111");
//		}catch(Exception ex){}
//	}
	
	
	String rootfolder = null;
	public MyTask1(String rootfolder){
		this.rootfolder = rootfolder;
	}
	
	public void run() {
		try{
			System.out.println(rootfolder);
			Thread.currentThread().sleep(10 * 2 * 1000);//此线程延迟5分钟
		}catch(Exception ex){}
	}
}
