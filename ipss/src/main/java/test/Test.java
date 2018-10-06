package test;

import java.util.*;

public class Test {

	public static void main(String[] args) {
		String str = "ITRM910664(D0)";
		str = "CANDAT0000007F";
		str = "HK179(A)";
		str = "HK19810000001";
		str = "IT1995MI00196U";
		str = "DE102005032588(A1)";
		str = "JPD710782";
		String str1="";
		String str2="";
		String str3="";
		String str4="";
		String str5="";
		String str6="";
		String str7="";
		String des="";
		char a[]=str.toCharArray();
		String last=str.substring(a.length-1);
		str1=str.substring(2);
		//19870121647U
		if(last.indexOf(")")>-1){
			String b[]=str.split("\\(");
			str5=b[0];
			str7=str1.replace("(","").replace(")","");
			System.out.println("str7="+str7);
		}else if(last.matches("[a-zA-Z]+")){
			str5=str.substring(0,a.length-1);
		}/*else{
			str5=str.substring(0,a.length);
		}*/
		System.out.println("str5=" + str5);
		str3=str.replace("(","").replace(")","");
		//RM910664D0
		System.out.println("str1="+str1);
		System.out.println("str3="+str3);
		for(int i=0;i<a.length;i++){
			
			if(a[i]>='0' && a[i]<='9'){
				str4=str.substring(i);
				String c[]=str4.split("\\(");
				char d[]=str4.toCharArray();
				System.out.println("str4="+str4);
				if(last.indexOf(")")>-1){
					str2=c[0];
				}else if(last.matches("[a-zA-Z]+")){
					str2=str4.substring(0,d.length-1);
				}else{
					str2=str4.substring(0,d.length);
				}
				System.out.println("str2="+str2);
				break;
			}
			
	    }
		str6=str4.replace("(","").replace(")","");
		System.out.println("str6="+str6);
		
		if(str.indexOf("(")>-1){
//			des =str+" "+ str1 +" " + str2 + " " + str3 +" " + str4 + " " +str5 + " "+str6;
			des =str1 +" " + str2 + " " + str3 +" " + str4 + " " +str5 + " "+str6+" "+str7;
		}else{
//			des =str+" "+str1+" "+str2 + " " + str4;
			des =str1+" "+str2 + " " + str4+" "+str5;
		}
		//////////////////////////////////////////////
		String[] arr = des.split(" ");
		des = "";
		Set set = new HashSet();
		for(int i=0;i<arr.length;i++)
		{
			set.add(arr[i]);
		}
		Iterator<String> iter = set.iterator();
		while(iter.hasNext())
		{
//			iter.next();
//			System.out.println(iter.next());
			des += iter.next()+" ";
		}
		//////////////////////////////////////////////
		des = str + " " + des;
		System.out.println(des.trim());
	}
	
	public static void main2(String[] args) 
	{
		String an = "CN201580063671.5";
		String all = "";
	
//    	String prefix = "";
    	String body = an.replace("CN", "").replace("cn", "").replace("ZL", "").replace("zl", "");
    	System.out.println("body=" + body);
    	String suffix = "";
    	
    	if(body.indexOf(".")>-1) {
    		suffix = body.substring(body.indexOf(".")+1);
    		System.out.println("suffix=" + suffix);
    		body = body.substring(0,body.indexOf("."));
    		System.out.println("body=" + body);
    	}
    	
//    	CN201220372059.X
//		CN201220372059X
    	String an1 = ("CN" + body + "" + suffix).trim();
    	System.out.println("an1=" + an1);
//		CN201220372059
    	String an2 = ("CN" + body).trim();
    	System.out.println("an2=" + an2);
//		ZL201220372059.X
    	String an3 = ("ZL" + body + "." + suffix).trim();
    	System.out.println("an3=" + an3);
//		ZL201220372059X
    	String an4 = ("ZL" + body + "" + suffix).trim();
    	System.out.println("an4=" + an4);
//		ZL201220372059
    	String an5 = ("ZL" + body).trim();
    	System.out.println("an5=" + an5);
//		201220372059.X
    	String an6 = (body + "." + suffix).trim();
//		201220372059X
    	System.out.println("an6=" + an6);
    	String an7 = (body + suffix).trim();
//		201220372059
    	System.out.println("an7=" + an7);
    	String an8 = body.trim();
    	System.out.println("an8=" + an8);
    	if(suffix.equals(""))
    	{
    		all = an2 + " " + an5 + " " +an8;
    	}else {
    		all = an + " " + an1 + " " + an2 + " " +an3 + " " +an4 + " " +an5 + " " +an6 + " " +an7 + " " +an8;
    	}
    	System.out.println(all);
	}

}
