package com.cnipr.cniprgz.commons;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.Serializable;
import java.util.Random;

import javax.imageio.ImageIO;

import org.apache.commons.lang3.RandomUtils;

import com.alibaba.druid.util.Base64;

/**
 *  
 * @ClassName: ValidateCodeUtil
 * @Description: 验证码生成工具类
 * @author chenhx
 * @date 2017年11月14日 上午11:00:07
 */
public class ValidateCodeUtil {  
    private static Validate validate = null;                  //验证码类，用于最后返回此对象，包含验证码图片base64和真值
    private static Random random = new Random();              //随机类，用于生成随机参数
    private static String randString = "0123456789abcdefghijkmnpqrtyABCDEFGHIJLMNQRTY";//随机生成字符串的取值范围  
    
    private static int width = 130;     //图片宽度  
    private static int height = 20;    //图片高度  
    private static int StringNum = 4;  //字符的数量  
    private static int lineSize = 40;  //干扰线数量  
      

    //将构造函数私有化 禁止new创建
    private ValidateCodeUtil() {
		super();
	}

    /** 
     * 获取随机字符,并返回字符的String格式 
     * @param index (指定位置) 
     * @return 
     */  
    private static String getRandomChar(int index) {  
        //获取指定位置index的字符，并转换成字符串表示形式  
        return String.valueOf(randString.charAt(index));  
    }  
    /**
     * 获取随机指定区间的随机数 
     * @param min (指定最小数) 
     * @param max (指定最大数) 
     * @return 
     */
    private static int getRandomNum(int min,int max) { 
    	return RandomUtils.nextInt(min, max);
    }  
      
    /** 
     * 获得字体 
     * @return 
     */  
    private static Font getFont() {  
        return new Font("Fixedsys", Font.CENTER_BASELINE, 25);  //名称、样式、磅值  
    }  
      
    /** 
     * 获得颜色 
     * @param fc 
     * @param bc 
     * @return 
     */  
    private static Color getRandColor(int frontColor, int backColor) {  
        if(frontColor > 255)  
            frontColor = 255;  
        if(backColor > 255)  
            backColor = 255;  
          
        int red = frontColor + random.nextInt(backColor - frontColor - 16);  
        int green = frontColor + random.nextInt(backColor - frontColor -14);  
        int blue = frontColor + random.nextInt(backColor - frontColor -18);  
        return new Color(red, green, blue);  
    }  
      
    /** 
     * 绘制字符串,返回绘制的字符串 
     * @param g 
     * @param randomString 
     * @param i 
     * @return 
     */  
    private static String drawString(Graphics g, String randomString, int i) { 
    	Graphics2D g2d = (Graphics2D) g;
    	g2d.setFont(getFont());   //设置字体  
    	g2d.setColor(new Color(random.nextFloat(), random.nextFloat(), random.nextFloat()));//设置颜色  
        String randChar = String.valueOf(getRandomChar(random.nextInt(randString.length())));  
        randomString += randChar;   //组装  
        int rot = getRandomNum(5,10);
        g2d.translate(random.nextInt(3), random.nextInt(3)); 
        g2d.rotate(rot * Math.PI / 180);
        g2d.drawString(randChar, 13*i, 20);   
        g2d.rotate(-rot * Math.PI / 180);
        return randomString;  
    }  
      
    /** 
     * 绘制干扰线 
     * @param g 
     */  
    private static void drawLine(Graphics g) {  
        //起点(x,y)  偏移量x1、y1  
        int x = random.nextInt(width);  
        int y = random.nextInt(height);  
        int xl = random.nextInt(13);  
        int yl = random.nextInt(15);  
        g.setColor(new Color(random.nextFloat(), random.nextFloat(), random.nextFloat()));
        g.drawLine(x, y, x + xl, y + yl);  
    }  

    public static Validate getBase64(String str,boolean b_bg) {  
    	validate = validate==null?new Validate():validate;
    	
		Font font = new Font("微软雅黑", Font.PLAIN, 13);
		
		if(b_bg) {	    	
			font = new Font("微软雅黑", Font.PLAIN, 13);
	    }else {
	    	font = new Font("微软雅黑", Font.PLAIN, 12);
	    }
		
//		"微软雅黑",Microsoft YaHei,"Helvetica Neue", Helvetica, Arial, sans-serif
		
	    BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_BGR);
	    Graphics g = image.getGraphics();
	    
	    if(b_bg) {
	    	Color c = new Color(230, 242, 240);
	    	g.setColor(c);// 设置背景色
	    }
	    //
		
		g.fillRect(0, 0, width, height);
	    
	    g.setClip(0, 0, width, height);	    
//	    g.setColor(Color.black);//#e6f2f0 
	    g.fillRect(0, 0, width, height);// 先用黑色填充整张图片,也就是背景 
	    
	    if(b_bg) {	    	
	    	g.setColor(Color.black);// 在换成黑色 
	    }else {
	    	Color c = new Color(52,152,219);
	    	g.setColor(c);//
	    }
	    
	    g.setFont(font);// 设置画笔字体 
	    /** 用于获得垂直居中y */
	    Rectangle clip = g.getClipBounds(); 
	    FontMetrics fm = g.getFontMetrics(font); 
	    int ascent = fm.getAscent(); 
	    int descent = fm.getDescent();
	    int y = (clip.height - (ascent + descent)) / 2 + ascent;
	    
	    validate.setValue(str);
	    
	    g.drawString(str, 0, y);

        ByteArrayOutputStream bs = null;
        try {  
            bs = new ByteArrayOutputStream();
            ImageIO.write(image, "gif", bs);//将绘制得图片输出到流  
            String imgsrc = Base64.byteArrayToBase64(bs.toByteArray());
            validate.setBase64Str(imgsrc);
        } catch (Exception e) {  
            e.printStackTrace();  
        } finally {  
        	try {
				bs.close();
			} catch (IOException e) {
				e.printStackTrace();
			}finally{
				bs = null;
			}
        }
        return validate;
    }
    
    
    /**
     * 
     * @ClassName: Validate
     * @Description: 验证码类
     * @author chenhx
     * @date 2017年11月14日 上午11:35:34
     */
    public static class Validate implements Serializable{
    	private static final long serialVersionUID = 1L;
    	private String Base64Str;		//Base64 值
    	private String value;			//验证码值
    	
    	public String getBase64Str() {
    		return Base64Str;
    	}
    	public void setBase64Str(String base64Str) {
    		Base64Str = base64Str;
    	}
    	public String getValue() {
    		return value;
    	}
    	public void setValue(String value) {
    		this.value = value;
    	}
    }
    
	public static void main(String[] args) {
		Validate v = ValidateCodeUtil.getBase64("CN201810170097.9",true);		
		String code = v.getValue().toUpperCase();
		System.out.println(code);
		
		String base64code = v.getBase64Str();
		System.out.println(base64code);
	}
}  

