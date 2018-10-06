package tools.thread;

import java.util.Timer;

public class ThreadTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Timer  timer=new Timer();
		MyTask1 myTask_1=new MyTask1("111111111111");
		timer.schedule(myTask_1, 1000, 2000);
		
		
		MyTask1 myTask_2=new MyTask1("222222222222");
		timer.schedule(myTask_2, 1000, 2000);
	}

}
