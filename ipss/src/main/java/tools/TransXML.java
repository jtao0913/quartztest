package tools;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

public class TransXML {	
//	private static final String source = "/home/folder1";
//	private static final String logs = "/home/folder1/monitor.txt";
	
	private static String ReStartSourceFolder = "";
	private static boolean starttrans = false;
	private static String break_year = "";
	private static String break_pd = "";
	private static String break_an = "";
	private static String break_type = "";
	
	private static final String source = "D:\\CN\\INVENTION\\";//按右边的格式：年\月\××××
	private static final String logs = "D:\\CN\\INVENTION\\monitor.txt";
	
//	private static final String source = "/books/INVENTION/";//按右边的格式：年\月\××××
//	private static final String logs = "/books/INVENTION/monitor.txt";
	
    static class StopMsgException extends RuntimeException {
		private static final long serialVersionUID = 1L;
	}
    
	public static float countTime(long begin,long end){
		float total_seceond = 0;
		try {
			long sss = end - begin;
//			System.out.println(sss);
			total_seceond = (end - begin)/1000.00F;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		System.out.println(total_seceond);
		return total_seceond;
	}
	
	private static String readCurrentFolder() {
		String currentfolder = "";
		try {
			InputStreamReader isr = null;
			BufferedReader reader = null;

			isr = new InputStreamReader(new FileInputStream(logs), "GBK");
			reader = new BufferedReader(isr);

			currentfolder = reader.readLine();

			reader.close();
			isr.close();
		} catch (Exception ex) {
		}

		return currentfolder;
	}
		
	public static void writelogs(String content){
		try {
//			File file = new File(logs);
//		    FileOutputStream fos = new FileOutputStream(file,true);
//		    OutputStreamWriter osw = new OutputStreamWriter(fos);
//		    BufferedWriter bw = new BufferedWriter(osw);
//		     
//		    bw.write(content);
//		    bw.newLine();
//		    
//		    bw.flush();
//		    bw.close();
//		    osw.close();
//		    fos.close();
		    ///////////////////////////////////////////////////

			File file = new File(logs);
			FileWriter fw = new FileWriter(file, false); // 设置成true就是追加
			fw.write(content);
//			fw.write("\r\n");
//			fw.write("ffd");
			fw.close();		     
		}
		catch (FileNotFoundException e1) {
			e1.printStackTrace();
		} catch (IOException e2) {
			e2.printStackTrace();
		}
	}
    
	private static int countslash(String str){
		String[] arr = str.split("\\\\");
		return arr.length;
	}
	
	private static boolean testXML(String xmlfile){
		boolean isModified = false;
		
	    InputStreamReader isr = null;
	    BufferedReader reader = null;

	    OutputStreamWriter osw = null;
	    BufferedWriter bw = null;
	    try
	    {
//	    	FileOutputStream fos = null;
//	        fos = new FileOutputStream(xmlfile);	        
//	        osw = new OutputStreamWriter(fos, "UTF8");
//	        bw = new BufferedWriter(osw);

	        isr = new InputStreamReader(new FileInputStream(xmlfile), "UTF8");
	        reader = new BufferedReader(isr);

	        String temp = reader.readLine();
	        while (temp != null) {
//	          System.out.println(temp);

	          if (temp.startsWith("<business:PatentVerdict")) {
	        	  isModified = true;
	        	  break;
	          }

	          temp = reader.readLine();
	        }
	      
			reader.close();
			isr.close();
	    }
	    catch (Exception ex)
	    {
	      ex.printStackTrace();
	    }
		return isModified;
	}
	
	private static void modifyXML(String xmlfile,String desxmlfile){
//		System.out.println(xmlfile);
		
	    InputStreamReader isr = null;
	    BufferedReader reader = null;

	    OutputStreamWriter osw = null;
	    BufferedWriter bw = null;
	    try
	    {
	    	FileOutputStream fos = null;
	        fos = new FileOutputStream(desxmlfile);	        
	        osw = new OutputStreamWriter(fos, "UTF8");
	        bw = new BufferedWriter(osw);

	        isr = new InputStreamReader(new FileInputStream(xmlfile), "UTF8");
	        reader = new BufferedReader(isr);

	        String temp = reader.readLine();
	        while (temp != null) {
//	          System.out.println(temp);

	          String _temp = "";
	          
	          if (temp.indexOf("business:PatentVerdict")>-1) {
//	        	  把根节点PatentVerdict替换成PatentDocumentAndRelated
	        	  _temp = temp.replace("business:PatentVerdict", "business:PatentDocumentAndRelated");
	          }else{
	        	  _temp = temp;
	          }
	          
	          if (_temp.indexOf("../../../../../Appendix_D_V-2-02-20120614/PatentVerdict/Elements/PatentVerdictElements.xsd")>-1) {
//	        	  把根节点PatentVerdict替换成PatentDocumentAndRelated
	        	  _temp = _temp.replace("../../../../../Appendix_D_V-2-02-20120614/PatentVerdict/Elements/PatentVerdictElements.xsd", 
	        			  "../../../../../../Appendix_D_V-2-02-20120614/PatentDocument/Elements/OtherElements.xsd");
	          }
	          _temp = _temp + "\r\n";
	          bw.write(_temp, 0, _temp.length());

	          temp = reader.readLine();
	        }
	        bw.flush();
	        bw.close();
	      
			reader.close();
			isr.close();
	    }
	    catch (Exception ex)
	    {
	      ex.printStackTrace();
	    }
	}
	
	final static void showAllFiles(File dir, String currentfolder) throws Exception {
		if(ReStartSourceFolder.equals("")){
			starttrans = true;
		}
		
		File[] fs = dir.listFiles();
		for (int i = 0; i < fs.length; i++) {
			System.out.println(fs[i].getAbsolutePath());
			if(fs[i].isFile()){
				if(fs[i].getName().toUpperCase().endsWith(".XML")){
//					writelogs(fs[i].getParentFile().getName());
					writelogs(fs[i].getParentFile().getAbsolutePath().replace(source, ""));					
					
					if(testXML(fs[i].getAbsolutePath())){
						System.out.println(fs[i].getAbsolutePath());
						System.out.println(fs[i].getParentFile());
						
						fs[i].renameTo(new File( fs[i].getParentFile().getAbsolutePath() + "\\_" + fs[i].getName()));
						
						modifyXML(fs[i].getParentFile().getAbsolutePath() + "\\_" + fs[i].getName(),
								  fs[i].getParentFile().getAbsolutePath() + "\\" + fs[i].getName());
						
						(new File(fs[i].getParentFile().getAbsolutePath() + "\\_" + fs[i].getName())).delete();
					}
				}
			}
			if (fs[i].isDirectory()) {
				
				if(!starttrans){
					String currentPath = fs[i].getAbsolutePath().substring(source.length());
					String current_year = currentPath.substring(0,4);
					if(currentPath.length()>4){
						current_year = currentPath.substring(0,4);
					}
					String current_pd = "";
					if(currentPath.length()>6){
						current_pd = currentPath.substring(5,13);
					}
					String current_an = "";
					if(currentPath.length()>15){
						current_an = currentPath.substring(14, 66);
					}
					
					if(!break_year.equals("")&&break_year.length()==4 && 
						current_pd.length()==0 && Integer.parseInt(current_year)<Integer.parseInt(break_year)){
						continue;
					}
					if(!break_year.equals("") && break_year.length()==4 &&
					   !break_pd.equals("") && break_pd.length()==8 &&
					   current_pd.length()==8 && Integer.parseInt(current_pd)<Integer.parseInt(break_pd)){
						continue;
					}
					if(!break_year.equals("") && break_year.length()==4 &&
					   !break_pd.equals("") && break_pd.length()==8 &&
					   current_pd.length()==8 && Integer.parseInt(current_pd)==Integer.parseInt(break_pd) &&
					   break_an.length()>0 && current_an.length()>0 && !break_an.equals(current_an))					
					{
						continue;
					}
				}

				if(!starttrans&&(new File(source + ReStartSourceFolder)).getAbsolutePath().equals(fs[i].getAbsolutePath())){
					starttrans = true;
				}
				
				try {
//					createDir(fs[i].getAbsolutePath().replace("I", "H"));
					showAllFiles(fs[i] ,currentfolder);
				} catch (Exception e) {}
			}
		}
	}
	
	public static void main(String[] args) {
		String currentfolder = readCurrentFolder();
		
		if (currentfolder.equals("")) {
			//aim目标文件夹没有或无内容
			starttrans = true;
			ReStartSourceFolder = "";
//			ReStartSourceFolder = source;
//			ReStartSourceFolder = ReStartSourceFolder.substring(source.length());
		}else{
			ReStartSourceFolder = currentfolder;
//			ReStartSourceFolder = ReStartSourceFolder.substring(source.length());
			
//			ReStartSourceFolder = ReStartSourceFolder.substring(source.length());//2000\20000607\98805127.3\000017.png
			if(ReStartSourceFolder.length()>=4){
				break_year = ReStartSourceFolder.substring(0,4);
			}
			if(ReStartSourceFolder.length()>=13){
				break_pd = ReStartSourceFolder.substring(5,13);
			}
			
//			System.out.println(countslash(ReStartSourceFolder));
//			2013\20131106\CN112012000010533CN00001033845610ACLAZH20131106CN00R\CLA_DES_DRA\CN112012000010533CN00001033845610ACLAZH20131106CN00R.XML
			
			if(ReStartSourceFolder.indexOf("\\")>0&&countslash(ReStartSourceFolder)==4){
				break_an = ReStartSourceFolder.substring(14,66);
				break_type = ReStartSourceFolder.substring(67,78);
			}			
			
		}
		/*************************************************************************************/

		
		
		
		
		try{			
			showAllFiles(new File(source), currentfolder);			
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
}
