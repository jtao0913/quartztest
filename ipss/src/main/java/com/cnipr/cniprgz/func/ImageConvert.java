package com.cnipr.cniprgz.func;

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

public class ImageConvert {

    public static RenderedImage[] readMultiPageTiff(String fileName)throws IOException{
           File file = new File(fileName);
           SeekableStream seekableStream = new FileSeekableStream(file);
           ImageDecoder decoder = ImageCodec.createImageDecoder("tiff", seekableStream, null);
           int numPages = decoder.getNumPages();
           RenderedImage image[]= new RenderedImage[numPages];
           int count = 0;
           for(int i=0;i<decoder.getNumPages();i++){
               image[i] = decoder.decodeAsRenderedImage(i);
               count++;
           }

           String newFolderName;
           String s3 = fileName;
           String [] temp = null;
           temp = s3.split("\\.");

           int j;
               j = 0;
               do{
                     newFolderName = temp[j];
                     String spoonFeeding = newFolderName;
                     File f = new File(spoonFeeding);
                     f.mkdirs();
                     j++;
               }while (j<1);

           for (int i = 0; i < count; i++) {
               RenderedImage page = decoder.decodeAsRenderedImage(i);
               File fileObj = new File(newFolderName+"/" + (i+1) + ".png");
               System.out.println("Saving " + fileObj.getCanonicalPath());
               ParameterBlock parBlock = new ParameterBlock();
               parBlock.addSource(page);
               parBlock.add(fileObj.toString());
               parBlock.add("png");
               RenderedOp renderedOp = JAI.create("filestore",parBlock);
               renderedOp.dispose();
           }
           return image;
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
            File fileObj = new File(file.getParentFile().getPath() + "/" + file.getName().toLowerCase().replace(".tif", "") + ".png");
//          System.out.println("Saving " + fileObj.getCanonicalPath());
            ParameterBlock parBlock = new ParameterBlock();
            parBlock.addSource(page);
            parBlock.add(fileObj.toString());
            parBlock.add("png");
            RenderedOp renderedOp = JAI.create("filestore",parBlock);
            renderedOp.dispose();
        }catch(IOException ex){
//        	java.io.IOException: Illegal page requested from a TIFF file.
//        	System.out.println("TIF转PNG图片失败.........");
        	ex.printStackTrace();
        }
     }
}
