package tools.thread;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.File;
import java.io.IOException;
import java.util.Arrays;



import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;

import com.sun.media.jai.codec.FileSeekableStream;
import com.sun.media.jai.codec.ImageCodec;
import com.sun.media.jai.codec.ImageDecoder;
import com.sun.media.jai.codec.SeekableStream;

public class TransTIF2PNG {
//	private static final String source = "Z:\\XX\\";
//	private static final String aim = "H:\\BOOKS\\XX\\";
//	private static final String logs = "H:\\BOOKS\\monitor.txt";
	
	private static final String source = "Y:\\BOOKS\\XX\\";
	private static final String aim = "H:\\BOOKS\\XX\\";
	private static final String logs = "H:\\BOOKS\\monitor.txt";
	
	static boolean starttrans = false;
	
	private static String ReStartSourceFolder = "";
	private static String break_year = "";
	private static String break_pd = "";
	private static String break_an = "";
	
	private static String ReStartAimFolder = "";
	private static boolean b_tran = false;
	
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
	
	public static void writelogs(String content){
		try {
		     File file = new File(logs);
		     FileOutputStream fos = new FileOutputStream(file,true);
		     OutputStreamWriter osw = new OutputStreamWriter(fos);
		     BufferedWriter bw = new BufferedWriter(osw);
		     
		     bw.write(content);
		     bw.newLine();
		     
		     bw.flush();
		     bw.close();
		     osw.close();
		     fos.close();
		}
		catch (FileNotFoundException e1) {
			e1.printStackTrace();
		} catch (IOException e2) {
			e2.printStackTrace();
		}
	}
	
    public static void readTiff(String fileName)throws IOException{
        File file = new File(fileName);
        SeekableStream seekableStream = new FileSeekableStream(file);
        ImageDecoder decoder = ImageCodec.createImageDecoder("tiff", seekableStream, null);
        
        long begin = System.currentTimeMillis();
        
        try
        {
            RenderedImage page = decoder.decodeAsRenderedImage(0);
//          File fileObj = new File(file.getParentFile().getPath().replace("Z:\\", "H:\\BOOKS\\") + "/" + file.getName().toLowerCase().replace(".tif", "") + ".png");
            File fileObj = new File(file.getParentFile().getPath().replace(source, aim) + "/" + file.getName().toLowerCase().replace(".tif", "") + ".png");
//          System.out.println("Saving " + fileObj.getCanonicalPath());
            ParameterBlock parBlock = new ParameterBlock();
            parBlock.addSource(page);
            parBlock.add(fileObj.toString());
            parBlock.add("png");
            RenderedOp renderedOp = JAI.create("filestore",parBlock);
            renderedOp.dispose();
        }catch(Exception ex){
//        	java.io.IOException: Illegal page requested from a TIFF file.
//        	System.out.println("TIF转PNG图片失败.........");
        	writelogs(fileName);
        	ex.printStackTrace();
        }
        
        long end = System.currentTimeMillis();
        
        countTime(begin,end);
     }
    
    public static boolean createDir(String destDirName) {
        File dir = new File(destDirName);  
        if (dir.exists()) {  
//            System.out.println("创建目录" + destDirName + "失败，目标目录已经存在");
            return false;  
        }
        if (!destDirName.endsWith(File.separator)) {  
            destDirName = destDirName + File.separator;  
        }
        //创建目录
        if (dir.mkdirs()) {  
//            System.out.println("创建目录" + destDirName + "成功！");  
            return true;
        } else {
//            System.out.println("创建目录" + destDirName + "失败！");
            return false;  
        }
    }
    
	public static void findAimLastFolder(File dir) {
		if(!dir.exists())    
		{
			dir.mkdirs(); 
		} 
		
		File[] fs = dir.listFiles();
		if(fs.length==0&&ReStartAimFolder.equals("")){
			ReStartAimFolder = aim;
		}
		
		for (int i = fs.length-1; i >= 0; i--) {
			System.out.println(fs[i].getAbsolutePath());
			ReStartAimFolder = fs[i].getAbsolutePath();
			
			if(fs[i].isFile()){
				if(fs[i].getName().toUpperCase().endsWith(".PNG")){
					throw new StopMsgException();
				}
			}
			if (fs[i].isDirectory()) {
				try {
//					createDir(fs[i].getAbsolutePath().replace(source, aim));
					findAimLastFolder(fs[i]);
				}
				catch (StopMsgException e) {throw new StopMsgException();}
				catch (Exception e) {}
			}
		}
	}
    
	public static void showAllFiles(File dir) throws Exception {
		if(ReStartSourceFolder.equals(source)){
			starttrans = true;
		}
		
		File[] fs = dir.listFiles();
		
		for (int i = 0; i < fs.length; i++) {
			System.out.println(fs[i].getAbsolutePath());
//			if(fs[i].getAbsolutePath().equals("I:\\BOOKS\\FM\\2000\\20000607")){
//				System.out.println("");
//			}
			
			if(fs[i].isFile()
//					&&fs[i].toString().equals(ReStartSourceFolder)
					){
				if(fs[i].getName().toUpperCase().endsWith(".TIF")){
					readTiff(fs[i].getAbsolutePath());
				}
			}
			
			if (fs[i].isDirectory()){
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
					if(currentPath.length()>15){current_an = currentPath.substring(14);}
					
					if(!break_year.equals("")&&break_year.length()==4 && current_pd.length()==0 && Integer.parseInt(current_year)<Integer.parseInt(break_year)){
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
					File aimfolder = new File(fs[i].getAbsolutePath().replace(source, aim));
					if(!aimfolder.exists()){
						createDir(aimfolder.getAbsolutePath());
					}
					showAllFiles(fs[i]);
				} catch (Exception e) {}
			}
		}
	}
	
	private static int countslash(String str){
		String[] arr = str.split("\\\\");
		return arr.length;
	}
	
	public static void main(String[] args) {
		try{
			if (!(new File(aim)).exists()||(new File(aim)).listFiles().length==0) {
				//aim目标文件夹没有或无内容
				starttrans = true;
				ReStartSourceFolder = source;
			}else{			
		        try {
		        	findAimLastFolder(new File(aim));
		        } catch (StopMsgException e) {
		        	System.out.println(e);
		        }
				
				System.out.println("ReStartAimFolder = "+ReStartAimFolder);			
				ReStartSourceFolder = ReStartAimFolder.replace(aim , source);
				if(ReStartSourceFolder.toLowerCase().endsWith(".png")){
					ReStartSourceFolder = (new File(ReStartSourceFolder)).getParentFile().getAbsolutePath();
				}
				
				System.out.println("ReStartSourceFolder = " + ReStartSourceFolder);
			}
			/*************************************************************************************/
			
//			ReStartSourceFolder = I:\BOOKS\FM\2000\20000607\98805127.3\000017.png
			ReStartSourceFolder = ReStartSourceFolder.substring(source.length());//2000\20000607\98805127.3\000017.png
			if(ReStartSourceFolder.length()>=4){
				break_year = ReStartSourceFolder.substring(0,4);
			}
			if(ReStartSourceFolder.length()>=13){
				break_pd = ReStartSourceFolder.substring(5,13);
			}
			if(ReStartSourceFolder.indexOf("\\")>0&&countslash(ReStartSourceFolder)==3){
				break_an = ReStartSourceFolder.substring(14);
			}
			showAllFiles(new File(source));
			
		}catch(Exception ex){ex.printStackTrace();}
	}
}
