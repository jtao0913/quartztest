package com.cnipr.cniprgz.servlet;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cnipr.cniprgz.commons.VerifyCodeUtils11111;
import com.cnipr.corebiz.search.entity.PatentInfo;

public class PatentDetailImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

//	VerifyCodeUtils.outputImage(w, h, response.getOutputStream(), content);
//	int w, int h, OutputStream os, String code
	
//	private static void outputImage(String str, Font font, File outFile,Integer width, Integer height) throws Exception { 
	private static void outputImage(int width, int height, OutputStream os, String code) throws Exception { 
		    // 创建图片 
			Font font = new Font("微软雅黑", Font.PLAIN, 40);
		    BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_BGR); 
		    Graphics g = image.getGraphics(); 
		    g.setClip(0, 0, width, height); 
//		    g.setColor(Color.black);//#e6f2f0 
		    g.fillRect(0, 0, width, height);// 先用黑色填充整张图片,也就是背景 
		    g.setColor(Color.black);// 在换成黑色 
		    g.setFont(font);// 设置画笔字体 
		    /** 用于获得垂直居中y */
		    Rectangle clip = g.getClipBounds(); 
		    FontMetrics fm = g.getFontMetrics(font); 
		    int ascent = fm.getAscent(); 
		    int descent = fm.getDescent(); 
		    int y = (clip.height - (ascent + descent)) / 2 + ascent;
		    
		    g.drawString(code, 0, y);
		    
		    /*
		    for (int i = 0; i < 6; i++) {// 256 340 0 680 
		      g.drawString(str, i * 680, y);// 画出字符串 
		    }
		    */
		    
		    g.dispose(); 
//		    ImageIO.write(image, "png", outFile);// 输出png图片 
		    ImageIO.write(image, "jpg", os);
			os.close();
	}
	  
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		Map<String, Object> codeMap = CodeUtil.generateCodeAndPic();

		String item = request.getParameter("item");
		
//		将四位数字的验证码保存到Session中。
		HttpSession session = request.getSession();
		PatentInfo patentInfo = (PatentInfo)session.getAttribute("patentInfo");
//		System.out.println("verifyCode="+session.getAttribute("verifyCode"));
		
		String content = "";
		if(item!=null) {
			if(item.equalsIgnoreCase("an")) {
				content = patentInfo.getAn();
			}
			if(item.equalsIgnoreCase("pa")) {
				content = patentInfo.getPa();
			}
		}else {
			content = patentInfo.getAn();
		}
		
//		禁止图像缓存。
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", -1);
		
		response.setContentType("image/jpeg");

//		将图像输出到Servlet输出流中。
		ServletOutputStream sos;
		try {
			// sos = response.getOutputStream();
			// ImageIO.write((RenderedImage) codeMap.get("codePic"), "jpeg", sos);
			// sos.close();//ImageIO.write(image, "jpg", os);

			// 生成图片
			int w = 500, h = 80;
			outputImage(w, h, response.getOutputStream(), content);
		} catch (Exception ex) {
			// TODO Auto-generated catch block
			ex.printStackTrace();
		}
	}

}
