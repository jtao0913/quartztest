package tools.test1;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

import com.cnipr.cniprgz.db.DBPoolAccessor;

public class Filedo {

	public static void main1(String[] args) {
		String path = "C:\\aaa";
		File file = new File(path);
		
		FileOutputStream fos;
		OutputStreamWriter osw;   
		BufferedWriter bw = null;
		
		try {
			fos = new FileOutputStream("C:\\aaa\\aaa.txt");
			osw = new OutputStreamWriter(fos,"UTF8");   
			bw = new BufferedWriter(osw);
		} catch (Exception e) {
			e.printStackTrace();
		}

		String[] tempList = file.list();
		File oriFile = null;
		for (int i = 0; i < tempList.length; i++) {
/*			if (path.endsWith(File.separator)) {
				oriFile = new File(path + tempList[i]);
			} else {
				oriFile = new File(path + File.separator + tempList[i]);
			}*/
			
			if(tempList[i].equals("aaa.txt")) {
				continue;
			}
			
			oriFile = new File(path + File.separator + tempList[i]);
			
//			File f1 = new File("D:\\other\\other_1.trs");
//			File f2 = new File("D:\\other\\xxxx.trs");
//			String GB = "";//国别
			String line = "";
						
			try {
				FileInputStream fis = new FileInputStream(oriFile.getAbsolutePath());   
				InputStreamReader isr = new InputStreamReader(fis, "UTF8");   
				BufferedReader br = new BufferedReader(isr);
				
//				FileOutputStream fos = new FileOutputStream("D:\\others_\\"+oriFile.getName());
//				OutputStreamWriter osw = new OutputStreamWriter(fos,"GBK");   
//				BufferedWriter bw = new BufferedWriter(osw);
				
				String patentInfo = "";
				
//				FileReader reader = new FileReader(f1);
//				FileWriter writer = new FileWriter(f2);
//				
//				BufferedReader br = new BufferedReader(reader);
//				BufferedWriter bw = new BufferedWriter(writer);
				
//				<REC>
				
				while ((line = br.readLine()) != null) {
					System.out.println(line);
										
					bw.write(line);
					bw.newLine();
					bw.flush();//在后面填上这句，没这句你只是将数据写入io缓存，并没有写入文件，加上这句就可以了
				}
				br.close();
//				bw.close();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
			}
		}
		


		
	}
	
	private static boolean equals(String str) {
		boolean contain = false;
		
		String line = "";
		try {
			FileInputStream fis = new FileInputStream("C:\\aaa\\aaaa.txt");   
			InputStreamReader isr = new InputStreamReader(fis, "UTF8");   
			BufferedReader br = new BufferedReader(isr);
						
			while ((line = br.readLine()) != null) {
//				System.out.println(line);
				
				if(line.equals(str)) {
					contain=true;
					break;
				}
			}
			br.close();
//			bw.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {}
		
		return contain;
	}
	
	public static void main(String[] args) {
		String path = "C:\\aaa";
		File file = new File(path);
		
		FileOutputStream fos;
		OutputStreamWriter osw;   
		BufferedWriter bw = null;
		
		try {
			fos = new FileOutputStream("C:\\aaa\\bbb.trs");
//			osw = new OutputStreamWriter(fos,"UTF8");
			osw = new OutputStreamWriter(fos,"GBK");   
			bw = new BufferedWriter(osw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String line = "";
		
		try {
			FileInputStream fis = new FileInputStream("C:\\aaa\\bb.txt");   
			InputStreamReader isr = new InputStreamReader(fis, "UTF8");   
			BufferedReader br = new BufferedReader(isr);
			
//			FileOutputStream fos = new FileOutputStream("D:\\others_\\"+oriFile.getName());
//			OutputStreamWriter osw = new OutputStreamWriter(fos,"GBK");   
//			BufferedWriter bw = new BufferedWriter(osw);
			
//			FileReader reader = new FileReader(f1);
//			FileWriter writer = new FileWriter(f2);
//			
//			BufferedReader br = new BufferedReader(reader);
//			BufferedWriter bw = new BufferedWriter(writer);
			
//			<REC>
			
			while ((line = br.readLine()) != null) {
				System.out.println(line);
//				bw.write("insert into aaa (keyword) value ('"+line.trim()+"');");
				bw.write("<REC>\r\n");
				bw.write("<keyword>="+line.trim());
				bw.newLine();
				bw.flush();
				
/*				if(!equals(line))
				{									
					bw.write(line);
					bw.newLine();
					bw.flush();//在后面填上这句，没这句你只是将数据写入io缓存，并没有写入文件，加上这句就可以了
				}*/
			}
			br.close();
//			bw.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
		}
		/////////////////////////////////////////////////////////////////////////////////
		
		
	}

}
