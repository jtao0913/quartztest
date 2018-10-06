package tools.thread;

import java.awt.image.RenderedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.Timer;
import java.util.TimerTask;

import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;

import com.sun.media.jai.codec.FileSeekableStream;
import com.sun.media.jai.codec.ImageCodec;
import com.sun.media.jai.codec.ImageDecoder;
import com.sun.media.jai.codec.SeekableStream;

class Timer_Trans extends TimerTask {
	public static void writelogs(String content){
		try {
//			D:\ben\morningreport
		     File file = new File("H:\\monitor.txt");
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
//        System.out.println(file.getName().toLowerCase().replace(".tif", ""));
//        System.out.println(file.getName().toLowerCase());

        try
        {
            RenderedImage page = decoder.decodeAsRenderedImage(0);
            File fileObj = new File(file.getParentFile().getPath().replace("I", "H") + "/" + file.getName().toLowerCase().replace(".tif", "") + ".png");
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
    
	public static float countTime(long begin,long end){
		float total_seceond = 0;
		try {
//			long sss = end - begin;
//			System.out.println(sss);
			total_seceond = (end - begin)/1000.00F;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		System.out.println(total_seceond);
		return total_seceond;
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
    
	final static void showAllFiles(File dir) throws Exception {
		File[] fs = dir.listFiles();
		for (int i = 0; i < fs.length; i++) {
			System.out.println(fs[i].getAbsolutePath());
			if(fs[i].isFile()){
				if(fs[i].getName().endsWith(".TIF")){
					readTiff(fs[i].getAbsolutePath());
				}
			}
			if (fs[i].isDirectory()) {
				try {
					createDir(fs[i].getAbsolutePath().replace("I", "H"));
					showAllFiles(fs[i]);
				} catch (Exception e) {
				}
			}
		}
	}
	
	String rootfolder = null;
	public Timer_Trans(String rootfolder){
		this.rootfolder = rootfolder;
	}
	
	public void run() {
		try{
			showAllFiles(new File(rootfolder));
		}catch(Exception ex){}
	}
}

public class TransTIF2PNG_ {	

	String rootfolder = null;
	public TransTIF2PNG_(String rootfolder){
		this.rootfolder = rootfolder;
	}
	
	public static void main1(String[] args) {
		Timer timer = new Timer();

		try {			
			timer.schedule(new Timer_Trans("I:\\BOOKSS\\FM\\2014\\20140101"), 1 * 1000, 300 * 1000);
			timer.schedule(new Timer_Trans("I:\\BOOKSS\\FM\\2014\\20140108"), 5 * 1000, 300 * 1000);
			timer.schedule(new Timer_Trans("I:\\BOOKSS\\FM\\2014\\20140115"), 10 * 1000, 300 * 1000);
			timer.schedule(new Timer_Trans("I:\\BOOKSS\\FM\\2014\\20140122"), 15 * 1000, 300 * 1000);
			timer.schedule(new Timer_Trans("I:\\BOOKSS\\FM\\2014\\20140129"), 20 * 1000, 300 * 1000);
			
		} catch (Exception ex) {
			timer.cancel();
		}
	}

	public static void main(String[] args) throws InterruptedException {
		// TODO Auto-generated method stub
		Timer  timer=new Timer();
		MyTask myTask_1=new MyTask("I:\\BOOKSS\\FM\\2014\\20140101");
		timer.schedule(myTask_1, 1000, 2000);
        
		MyTask myTask_2=new MyTask("I:\\BOOKSS\\FM\\2014\\20140108");
		timer.schedule(myTask_2, 2000, 5000);

	}

}
