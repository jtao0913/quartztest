package com.translate;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TranslateServlet extends HttpServlet {

	private static final long serialVersionUID = -3547628240249497125L;

	TranslateThread translateTread = new TranslateThread();
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		String content = request.getParameter("content");
		String task = request.getParameter("task")==null?"getProgress":request.getParameter("task");
		
		String Ret = "";

		if(task.equals("create")) {
//			System.out.println("TranslateServlet  task = 0");			
			
			translateTread.setContents(content);
			new Thread(translateTread).start();
		}else {
//			System.out.println("TranslateServlet  task = 1");			
			Ret = translateTread.getContents();
		}
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		response.setHeader("Cache-Control", "no-cache");
		out.println(Ret);
		out.close();
	}

	private boolean running;
	public boolean Completed;
	private String int_RecordCount;
	private int int_RecordCount_now;

	private String content;
	private int contentNum;

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getContentNum() {
		return contentNum;
	}

	public void setContentNum(int contentNum) {
		this.contentNum = contentNum;
	}

	public boolean bStop = false;

	public void stopThread() {
		bStop = true;
	}

	public TranslateServlet() {
		running = false;
		Completed = false;
	}

	public synchronized void setint_RecordCount(String int_RecordCount) {
		this.int_RecordCount = int_RecordCount;
	}

	public synchronized String getint_RecordCount() {
		return int_RecordCount;
	}

	public synchronized boolean getCompleted() {
		return Completed;
	}

	public synchronized boolean isRunning() {
		return running;
	}

	public synchronized void setRunning(boolean running) {
		this.running = running;
	}

	public synchronized int getPercent() {
		return int_RecordCount_now;
	}

	public static void main(String[] args) {

	}

}