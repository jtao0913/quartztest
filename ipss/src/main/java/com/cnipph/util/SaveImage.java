package com.cnipph.util;

import java.net.URL;

import java.net.MalformedURLException;

import java.io.IOException;

import java.io.FileNotFoundException;

import java.io.BufferedInputStream;

import java.io.FileOutputStream;

import java.io.File;public class SaveImage {

    /**

     * @param args

     */

    public static String getImageFromURL(String httpUrl,String savePath) {

       // TODO Auto-generated method stub 

       URL url;

       BufferedInputStream in;

       FileOutputStream file;

       String fileName = httpUrl.substring(httpUrl.lastIndexOf("/") + 1); 
       
       try {

           System.out.println("获取网络图片");

          
         

           url = new URL(httpUrl);

           in = new BufferedInputStream(url.openStream());
           File dir = new File(savePath);
           if(dir.exists()==false)
        	   dir.mkdirs();
           file = new FileOutputStream(new File(savePath + fileName));
           
           int t;

           while ((t = in.read()) != -1) {

              file.write(t);

           }

           file.close();

           in.close();

           System.out.println("图片获取成功");
           
           
           
       } catch (MalformedURLException e) {

           e.printStackTrace();

       } catch (FileNotFoundException e) {

           e.printStackTrace();

       } catch (IOException e) {

           e.printStackTrace();

       }
	
       return savePath + fileName;

    }

} 