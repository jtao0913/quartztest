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

public class FiledoByNation {

	public static void main(String[] args) {
		String path = "D:\\others";
		File file = new File(path);

		String[] tempList = file.list();
		File oriFile = null;
		for (int i = 0; i < tempList.length; i++) {
			if (path.endsWith(File.separator)) {
				oriFile = new File(path + tempList[i]);
			} else {
				oriFile = new File(path + File.separator + tempList[i]);
			}
			
//			File f1 = new File("D:\\other\\other_1.trs");
//			File f2 = new File("D:\\other\\xxxx.trs");
			String GB = "";//国别
			String line = "";
			
			FileOutputStream fos;
			OutputStreamWriter osw;   
			BufferedWriter bw = null;
			
			try {
				FileInputStream fis = new FileInputStream(oriFile.getAbsolutePath());   
				InputStreamReader isr = new InputStreamReader(fis, "GBK");   
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
				int n=0;
				while ((line = br.readLine()) != null) {
					System.out.println(line);
					
					if(line.startsWith("<专利号>=")){
						GB = line.substring(6, 8);
					}
					
					if(n==0||!line.startsWith("<REC>")){
						patentInfo += line+"\r\n";
					}
					
					if(n>0&&line.startsWith("<REC>")){
						fos = new FileOutputStream("D:\\others_\\"+GB+".trs",true);
						osw = new OutputStreamWriter(fos,"GBK");//UTF8   
						bw = new BufferedWriter(osw);
						
						bw.write(patentInfo);
						bw.newLine();
						bw.flush();//在后面填上这句，没这句你只是将数据写入io缓存，并没有写入文件，加上这句就可以了
						
						patentInfo = line + "\r\n";
					}					

					n++;
				}
				br.close();
				bw.close();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				try{
					bw.close();
				}catch(Exception ex){
					
				}
			}
		}
		
		

		
		
		
		
	}
}
