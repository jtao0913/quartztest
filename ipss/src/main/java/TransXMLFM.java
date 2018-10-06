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

public class TransXMLFM {	
//	private static final String source = "/home/folder1";
//	private static final String logs = "/home/folder1/monitor.txt";
	
	private static String ReStartSourceFolder = "";
	private static boolean starttrans = false;
	private static String break_year = "";
	private static String break_pd = "";
	private static String break_an = "";
	private static String break_type = "";
	
//	private static final String source = "D:\\CN\\INVENTION\\";
//	private static final String logs = "D:\\CN\\INVENTION\\monitor.txt";
	
	private static final String source = "/nasdata2/标准化数据/中国发明公开全文文本数据/CN/Unexamined_patent_for_invention/";
	private static final String logs =   "/nasdata2/标准化数据/中国发明公开全文文本数据/CN/Unexamined_patent_for_invention/monitor.txt";
	private static final String DES_modifylogs =   "/nasdata2/标准化数据/中国发明公开全文文本数据/CN/Unexamined_patent_for_invention/modifymonitor_DES.txt";
	private static final String DRA_modifylogs =   "/nasdata2/标准化数据/中国发明公开全文文本数据/CN/Unexamined_patent_for_invention/modifymonitor_DRA.txt";
	
//	private static final String source = "/nasdata2/标准化数据/中国发明授权公告全文文本数据/CN/Granted_patent_for_invention/";
//	private static final String logs =   "/nasdata2/标准化数据/中国发明授权公告全文文本数据/CN/Granted_patent_for_invention/monitor.txt";
//	private static final String DES_modifylogs =   "/nasdata2/标准化数据/中国发明授权公告全文文本数据/CN/Granted_patent_for_invention/modifymonitor_DES.txt";
//	private static final String DRA_modifylogs =   "/nasdata2/标准化数据/中国发明授权公告全文文本数据/CN/Granted_patent_for_invention/modifymonitor_DRA.txt";
	
//	private static final String source = "/nasdata2/标准化数据/中国实用新型授权公告全文文本数据/CN/Utility_model/";
//	private static final String logs =   "/nasdata2/标准化数据/中国实用新型授权公告全文文本数据/CN/Utility_model/monitor.txt";
//	private static final String DES_modifylogs =   "/nasdata2/标准化数据/中国实用新型授权公告全文文本数据/CN/Utility_model/modifymonitor_DES.txt";
//	private static final String DRA_modifylogs =   "/nasdata2/标准化数据/中国实用新型授权公告全文文本数据/CN/Utility_model/modifymonitor_DRA.txt";
	
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
//		System.out.println(total_seceond);
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
			FileWriter fw = new FileWriter(file, false);
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
	
	public static void modify_writelogs(String XML_type,String content){
		try {
			File file = null;
			
			if(XML_type.equals("DES")){
				file = new File(DES_modifylogs);
			}else if(XML_type.equals("DRA")){
				file = new File(DRA_modifylogs);
			}
			
		    FileOutputStream fos = new FileOutputStream(file,true);
		    OutputStreamWriter osw = new OutputStreamWriter(fos);
		    BufferedWriter bw = new BufferedWriter(osw);
		     
		    bw.write(content);
		    bw.newLine();
		    
		    bw.flush();
		    bw.close();
		    osw.close();
		    fos.close();
		    ///////////////////////////////////////////////////
		    /*
			File file = new File(logs);
			FileWriter fw = new FileWriter(file, false);
			fw.write(content);
//			fw.write("\r\n");
//			fw.write("ffd");
			fw.close();
			*/
		}
		catch (FileNotFoundException e1) {
			e1.printStackTrace();
		} catch (IOException e2) {
			e2.printStackTrace();
		}
	}
    
	private static int countslash(String str){
//		String[] arr = str.split("\\\\");
		String[] arr = str.split("/");
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
	        	  _temp = temp.replace("business:PatentVerdict", "business:PatentDocumentAndRelated");
	          }else{
	        	  _temp = temp;
	          }
	          
	          if (_temp.indexOf("../../../../../Appendix_D_V-2-02-20120614/PatentVerdict/Elements/PatentVerdictElements.xsd")>-1) {
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
			
//			System.out.println(fs[i].getAbsolutePath());
			
			if(fs[i].isFile()){
				if(fs[i].getName().toUpperCase().endsWith(".XML")){
					
					System.out.println(fs[i].getAbsolutePath());
					
//					writelogs(fs[i].getParentFile().getName());
					writelogs(fs[i].getParentFile().getAbsolutePath().replace(source, ""));
					
					if(testXML(fs[i].getAbsolutePath())){
						
						
						System.out.println(fs[i].getAbsolutePath());
//						System.out.println(fs[i].getParentFile());
						/*
						fs[i].renameTo(new File( fs[i].getParentFile().getAbsolutePath() + "/_" + fs[i].getName()));
						
						modifyXML(fs[i].getParentFile().getAbsolutePath() + "/_" + fs[i].getName(),
								  fs[i].getParentFile().getAbsolutePath() + "/" + fs[i].getName());
						
						(new File(fs[i].getParentFile().getAbsolutePath() + "/_" + fs[i].getName())).delete();
						*/						
						
						String XML_type = "";
						if(fs[i].getName().toUpperCase().indexOf("CLA")>-1){
							XML_type = "CLA";
						}else if(fs[i].getName().toUpperCase().indexOf("DES")>-1){
							XML_type = "DES";
						}else if(fs[i].getName().toUpperCase().indexOf("DRA")>-1){
							XML_type = "DRA";
						}
						

						fs[i].renameTo(new File( fs[i].getParentFile().getAbsolutePath() + "/original_"+XML_type+".XML"));
						
						modifyXML(fs[i].getParentFile().getAbsolutePath() + "/original_"+XML_type+".XML", fs[i].getParentFile().getAbsolutePath() + "/" + fs[i].getName());
						
						modify_writelogs(XML_type , fs[i].getParentFile().getAbsolutePath().replace(source, ""));
						
					}
				}
			}
			if (fs[i].isDirectory()) {
				
				if(!starttrans){
					String currentPath = fs[i].getAbsolutePath().substring(source.length());
					
					System.out.println("################ currentPath = "+currentPath);
					
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
						current_an = currentPath.substring(14, 26);
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
//		/nasdata2/标准化数据/中国发明公开全文文本数据/CN/Unexamined_patent_for_invention/2014/20140122
//		2014/20140122/CN103534078A/CLA_DES_DRA
		
//		String currentfolder = "2014/20140122/CN103534078A/CLA_DES_DRA";
		
		System.out.println("currentfolder = "+currentfolder);
		
		if (currentfolder.equals("")) {
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
			
			if(ReStartSourceFolder.indexOf("/")>0&&countslash(ReStartSourceFolder)==4){
//				break_an = ReStartSourceFolder.substring(14,66);
//				break_type = ReStartSourceFolder.substring(67,78);
				
				break_an = ReStartSourceFolder.substring(14,26);
				break_type = ReStartSourceFolder.substring(27,38);
			}			
		}		

		System.out.println("=======================================");
		try{			
			showAllFiles(new File(source), currentfolder);
		}catch(Exception ex){
			ex.printStackTrace();
		}		
	}
}
