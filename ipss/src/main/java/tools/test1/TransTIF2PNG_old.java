package tools.test1;
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

import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;

import com.sun.media.jai.codec.FileSeekableStream;
import com.sun.media.jai.codec.ImageCodec;
import com.sun.media.jai.codec.ImageDecoder;
import com.sun.media.jai.codec.SeekableStream;

public class TransTIF2PNG_old {

	public static void writelogs(String content){
		try {
//			D:\ben\morningreport
		     File file = new File("H:\\BOOKS\\monitor.txt");
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
        
//        System.out.println(file.getName().toLowerCase().replace(".tif", ""));
//        System.out.println(file.getName().toLowerCase());

        try
        {
            RenderedImage page = decoder.decodeAsRenderedImage(0);
            File fileObj = new File(file.getParentFile().getPath().replace("Z:\\", "H:\\BOOKS\\") + "/" + file.getName().toLowerCase().replace(".tif", "") + ".png");
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
					createDir(fs[i].getAbsolutePath().replace("Z:\\", "H:\\BOOKS\\"));
					showAllFiles(fs[i]);
				} catch (Exception e) {
				}
			}
		}
	}

	public static void main(String[] args) {
		try{
			showAllFiles(new File("Z:\\XX"));
		}catch(Exception ex){}
	}

}
