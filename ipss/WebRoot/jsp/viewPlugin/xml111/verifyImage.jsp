<%@ page contentType="image/jpeg" errorPage="/error.jsp"%>

<%@ page import="java.awt.*"%>
<%@ page import="java.awt.image.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.imageio.*"%>
<%@ page import="java.io.PrintWriter"%>

<%!   
  Color   getRandColor(int   fc,int   bc){//给定范围获得随机颜色   
                  Random   random   =   new   Random();   
                  if(fc>255)   fc=255;   
                  if(bc>255)   bc=255;   
                  int   r=fc+random.nextInt(bc-fc);   
                  int   g=fc+random.nextInt(bc-fc);   
                  int   b=fc+random.nextInt(bc-fc);   
                  return   new   Color(r,g,b);   
                  }   
%>   
<%   
//设置页面不缓存   
  response.setHeader("Pragma","No-cache");   
  response.setHeader("Cache-Control","no-cache");   
  response.setDateHeader("Expires",   0);   

try{    
//在内存中创建图象   
  int width=64,height=20;   
  BufferedImage image = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);   
    
//获取图形上下文   
  Graphics g = image.getGraphics();   
    
//生成随机类   
  Random random = new Random();
  
//设定背景色   
  g.setColor(getRandColor(200,250));   
  g.fillRect(0,0,width,height);   
    
//设定字体   
  g.setFont(new Font("Times New Roman",Font.PLAIN,18));   
    
//画边框   
//g.setColor(new   Color());   
//g.drawRect(0,0,width-1,height-1);   
    
//随机产生155条干扰线，使图象中的认证码不易被其它程序探测到   
//g.setColor(getRandColor(150,200));
g.setColor(getRandColor(150,155));
for(int i=0;i<150;i++){   
	int x = random.nextInt(width);   
	int y = random.nextInt(height);   
	int xl = random.nextInt(12);   
	int yl = random.nextInt(12);   
	g.drawLine(x,y,x+xl,y+yl);   
}   


String[] arrRand={"0","A","1","B","C","2","D","E","F","3","G","4","H","5","I","J","K","L","6","M","N","O","7","P","Q","R","S","8","T","U","V","W","X","Y","9","Z"};
//System.out.println(arrRand.length);
//取随机产生的认证码(4位数字)   
String sRand="";
for(int i=0;i<4;i++){   
	int intRand=random.nextInt(arrRand.length);
	sRand+=arrRand[intRand];
//将认证码显示到图象中
	int int1=random.nextInt(100);
	int int2=random.nextInt(100);
	int int3=random.nextInt(100);
/*
System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
System.out.println(int1);
System.out.println(int2);
System.out.println(int3);
System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
*/
	g.setColor(new Color(20+int1,20+int2,20+int3));   
//调用函数出来的颜色相同，可能是因为种子太接近，所以只能直接生成
	g.drawString(arrRand[intRand],13*i+6,16);   
}
//System.out.println(sRand);
//out.println(sRand);
//将认证码存入SESSION   
  session.setAttribute("rand",sRand);   
    
//图象生效   
  g.dispose();   
    
//输出图象到页面   
  ImageIO.write(image,"JPEG",response.getOutputStream());

	out.clear();
	out = pageContext.pushBody();
}catch(Exception ex){
	ex.printStackTrace();
}
%>