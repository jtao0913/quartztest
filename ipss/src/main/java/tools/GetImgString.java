package tools;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class GetImgString {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String regEx = "<IMG [^~]*?>";
		String ss = "一种含有四氟乙烯、乙烯三元共聚物的生产" +
"方法，本法在四氟乙烯-乙烯溶液沉淀聚合体系"+
"中，用过碳酸酯作引发剂，1,2,2-三氯，1,2,"+
"2-三氟乙烷作介质。选用分子式为CnR<SUB>2n+2</SUB>的"+
"化合物作气相链调节剂控制共聚物分子量。其中"+
"n＝0，1或2，R＝H，Cl或F。分子式为CF<SUB>2</SUB>"+
"XOCF<SUB>2</SUB>X′或"+
"<Img SRC=\"" +
"85100468_AB" +
"_0.GIF\" " +
"WIDTH=245 HEIGHT=102>"+
"的化合物作第三单"+
"体，其中X＝X′＝Cl或F，R＝CF<SUB>3</SUB>或CH<SUB>3</SUB>，"+
"R′＝CF<SUB>3</SUB>，CH<SUB>3</SUB>或H，R″＝H或F。共聚物内"+
"单体克分子组成为四氟乙烯60-40％，乙烯40-"+
"60％，第三单体为前二者总和的0.1-10％。";
		Pattern p=Pattern.compile(regEx, Pattern.CASE_INSENSITIVE); 

		Matcher m=p.matcher(ss); 

		boolean rs=m.find();
	//	m.
		System.out.println(rs);
		
		for(int i=0;i<=m.groupCount();i++){ 
			
			String imgString = m.group(i);

			System.out.println(imgString);
			
			String regEx2 = "SRC=\"([^\"]+)\"";   
			Pattern p2=Pattern.compile(regEx2, Pattern.CASE_INSENSITIVE); 
			Matcher m2 = p2.matcher(imgString); 
			boolean rs2=m2.find();
			//	m.
			System.out.println("rs2 : "+rs2);
			for(int j=0;j<=m2.groupCount();j++){ 
				String srcString = m2.group(j);

				System.out.println(srcString);
			}
			
			System.out.println(ss.replace(imgString, "")); 
		} 
	}

}
