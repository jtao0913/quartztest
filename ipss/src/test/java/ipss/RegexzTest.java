package ipss;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexzTest {

	public static void main1(String[] args) {
		String str = "名称=('variable struc%' or members) and 申请人=('CANON INC') and 分类号=('A61%' or '24-%')";
		str = "名称=(\"variable struc%\" or members) and 申请人=('CANON INC') and 分类号=('A61%' or '24-%')";
		
		Pattern pattern = Pattern.compile("(['\"])(?:(?!\\1).)*?\\1");
		Matcher match = pattern.matcher(str);
/*		while (match.find()) {
			System.out.println(match.group());
		}*/
		
		while (match.find()) {
			String ori = match.group();
            String result = ori.replace(" ", "￥");
//            System.out.println(result);
//			System.out.println(str.replace(ori, result));
			str = str.replace(ori, result);			
        }

		System.out.println(str);
	}
	
	public static void main(String[] args) {
		String str = "名称=('variable struc%' or members) and 申请人=('CANON INC') and 分类号=('A61%' or '24-%')";
		str = "名称=(\"variable struc%\" or members) and 申请人=('CANON INC') and 分类号=('A61%' or '24-%')";
		
		RegexzTest rt = new RegexzTest();
		System.out.println(rt.processSingleQuotes(str));
		
	}
	
	private String processSingleQuotes(String str){
//		String ret = str;
		
		Pattern pattern = Pattern.compile("(['\"])(?:(?!\\1).)*?\\1");
		Matcher match = pattern.matcher(str);
/*		while (match.find()) {
			System.out.println(match.group());
		}*/
		
		while (match.find()) {
			String ori = match.group();
            String result = ori.replace(" ", "￥");
//            System.out.println(result);
//			System.out.println(str.replace(ori, result));
			str = str.replace(ori, result);			
        }
		
		return str;
	}

}
