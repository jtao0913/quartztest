package com.cnipr.cniprgz.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cnipr.cniprgz.commons.VerifyCodeUtils11111;

public class AuthImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String verifyCode = VerifyCodeUtils11111.generateVerifyCode(4);
//		Map<String, Object> codeMap = CodeUtil.generateCodeAndPic();

//		将四位数字的验证码保存到Session中。
		HttpSession session = request.getSession();
		session.setAttribute("verifyCode", verifyCode.toLowerCase());

//		System.out.println("verifyCode="+session.getAttribute("verifyCode"));
		
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
			int w = 200, h = 80;
			VerifyCodeUtils11111.outputImage(w, h, response.getOutputStream(), verifyCode);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
