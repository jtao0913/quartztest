package com.cnipr.cniprgz.func.download;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletResponse;
/*
* vogoalAPI 1.0
* Auther SinNeR@blueidea.com
* by vogoal.com
* mail: vogoals@hotmail.com
*/
/**
* JSP FILE DOWNLOAD SUPPORT
* 
* @author SinNeR
* @version 1.0
*/
public class JspFileDownload {
    /** request object */
    private HttpServletResponse response = null;
    /** file type: -1 un-setting; 0 normal file; 1 zip file ;2 stream*/
    private int fileType = -1;
    
    /** file name to be displayed */
    private String disFileName = null;
    
    /** zip file path */
    private String zipFilePath = null;
    
    /** file to be zipped */
    private List<String> zipFileNames = null;
    
    private boolean zipDelFlag = false;
    
    /** file to be downloaded */
    private String downFileName = null;
    
//    private boolean isXMLDownload = false;
    
    private String rootPath = "";
    
    /** error code 0 */
    private static final int PROCESS_OK = 0;
    
    /** error code 1 */
    private static final int RESPONSE_IS_NULL = 1;
    
    /** error code 2 */
    private static final int UNSET_DOWNLOADTYPE = 2;
    
    /** error code 3 */
    private static final int UNSET_DIS_FILE_NAME = 3;
    
    /** error code 4 */
    private static final int UNSET_DOWN_FILE_NAME = 4;
    
    /** error code 9 */
    private static final int IO_EXCEPTION = 9;
    
    /**
     * set response object
     * @param response response Object
     */
    public void setResponse(HttpServletResponse response){
        this.response = response;
    }
    
    /**
     * set file type 0 normal file; 1 zip file ;2 stream
     * @param fileType
     */
    public void setDownType(int fileType){
        this.fileType = fileType;
    }
    
    /**
     * set display file name
     * @param fileName
     */
    public void setDisFileName(String fileName){
        this.disFileName = fileName;
    }
    
    /**
     * set zip file path
     * @param fileNames
     */
    public void setZipFilePath( String path ){
        this.zipFilePath = path;
    }
    
    public void setZipDelFlag(boolean b){
        this.zipDelFlag = b;
    }
    
    /**
     * set zip file names
     * @param fileNames
     */
    public void setZipFileNames(List<String> fileNames){
        this.zipFileNames = fileNames;
    }
    
    /**
     * set download file name
     * @param fileName
     */
    public void setDownFileName(String fileName){
        this.downFileName = fileName;
    }
    
    /**
     * set file content
     * @param fileContent
     */
    public int setFileContent(String fileContent){    
        try{    
            byte[] buffs = fileContent.getBytes("UTF-8");
            response.getOutputStream().write(buffs);
        }catch(IOException e){
            return IO_EXCEPTION;
        }
        return PROCESS_OK;
    }
    
    /**
     * set file content
     * @param fileContent
     */
    public int setFileContent(byte[] fileContent){
        try{
            response.getOutputStream().write(fileContent);
        }catch(IOException e){
            return IO_EXCEPTION;
        }
        return PROCESS_OK;
    }
    
    /**
     * set file content end
     *
     */
    public int setFileContentEnd(){
        try{
            response.getOutputStream().close();
        }catch(IOException e){
            return IO_EXCEPTION;
        }
        return PROCESS_OK;
    }
    
    /**
     * main process
     * @return
     */
    public int process(){
        int status = PROCESS_OK;
        
        status = preCheck();
        if ( status != PROCESS_OK )
            return status;
        
        String fileName = disFileName;
        
        response.setContentType("APPLICATION/OCTET-STREAM"); 
        response.setHeader("Content-Disposition","attachment;filename=\"" + fileName + "\"");
        int BUFSIZE = 1024 * 8;        
        int rtnPos = 0;
        byte[] buffs = new byte[ BUFSIZE ];
        FileInputStream inStream = null;
        ZipOutputStream zos = null;
        InputStream is = null;
        String filepath = null;
        try{
          
            if ( fileType == 0 || fileType == 1){
                if ( fileType == 0 ){
                    filepath = downFileName;   
                }else{
                    filepath = zipFilePath + fileName;
                    List<String> fileToZip = zipFileNames;
                                    
                    zos=new ZipOutputStream(new FileOutputStream(filepath));

                    ZipEntry ze=null;
                    byte[] buf=new byte[BUFSIZE];
                    int readLen=0;
                    
//                    if (isXMLDownload) {
//                    	addDirectory(zos, "test", f);
//                    }
                    
                    for (String fn : fileToZip){
                        File f= new File(fn);
                        
                        if (f.isDirectory()) {
                        	addDirectory(zos, rootPath, f);
                        	continue;
                        } 
        
                        ze=new ZipEntry(rootPath + f.getName());
                        ze.setSize(f.length());
                        ze.setTime(f.lastModified());
        
                        zos.putNextEntry(ze);
                        is=new BufferedInputStream(new FileInputStream(f));
                        while ((readLen=is.read(buf, 0, BUFSIZE))!=-1) {
                            zos.write(buf, 0, readLen);
                        }
                        is.close();
                        f.delete();
                    }
                    zos.close();
                }
           
                inStream =new FileInputStream(filepath);   
   
                while((rtnPos=inStream.read(buffs)) >0) {
                    response.getOutputStream().write(buffs,0,rtnPos);
                }
                response.getOutputStream().close();   
                inStream.close();
            }
            if ( zipDelFlag ){
                File fToDel = new File(filepath);
                fToDel.delete();
            }
        }catch(IOException e){
            return IO_EXCEPTION;
        }catch(Exception ex){
            ex.printStackTrace();
        }finally{
            try{
                if ( inStream != null ){
                    inStream.close();
                    inStream = null;
                }
                if ( zos != null ){
                    zos.close();
                    zos = null;
                }
                if ( is != null ){
                    is.close();
                    is = null;
                }
            }catch (IOException e){
            }
        }
        return status;
    }
    
    /**
     * pre check.
     * @return
     */
    private int preCheck(){
        
        if ( response == null )
            return RESPONSE_IS_NULL;
            
        if ( disFileName == null || disFileName.trim().length() == 0 )
            return UNSET_DIS_FILE_NAME;
        if ( fileType == -1 )
            return UNSET_DOWNLOADTYPE;
        else if ( fileType == 0 ){
            if ( downFileName == null || downFileName.trim().length() == 0 )
                return UNSET_DOWN_FILE_NAME;
            else{
                if ( !isFile( downFileName ) )
                    return UNSET_DOWN_FILE_NAME;
            }
            
        }else if ( fileType == 1 ){
            if ( zipFilePath == null || zipFilePath.length() == 0 )
                return UNSET_DOWN_FILE_NAME;
            else{
                if ( !isDirect(zipFilePath) )
                    return UNSET_DOWN_FILE_NAME;
            }
            if ( zipFileNames == null || zipFileNames.size() == 0 )
                return UNSET_DOWN_FILE_NAME;
            else{
                for ( int i=0;i<zipFileNames.size();i++ ){
                    if ( zipFileNames.get(i) == null || zipFileNames.get(i).trim().length() == 0 )
                        return UNSET_DOWN_FILE_NAME;
//                    else{
//                        if ( !isFile( zipFileNames.get(i) ) )
//                            return UNSET_DOWN_FILE_NAME;
//                    }
                }
            }
        }else if ( fileType == 2 ){
            //doing nothing
        }else{
            return UNSET_DOWNLOADTYPE;
        }
        return PROCESS_OK;
    }
    
    private boolean isFile(String fileName){
        File f = new File(fileName);
        if (!f.exists() || !f.isFile())
            return false;
        return true;
    }
    
    private boolean isDirect(String filePath){
        File f = new File(filePath);
        if (!f.exists() || !f.isDirectory())
            return false;
        return true;
    }
    
    /**
     * 压缩文件夹
     * 
     * @param zipOutput
     * @param path
     * @param input
     * @throws IOException
     */
    private static void addDirectory(ZipOutputStream zipOutput, String path,
            File input)
            throws IOException
    {
        File[] subFiles = input.listFiles(new FileFilter()
        {
            public boolean accept(File pathname)
            {
                return true;
            }
        });

        for (int i = 0; i < subFiles.length; i++)
        {
            if (subFiles[i].isFile())
                addFile(zipOutput,
                        (path.trim().length() == 0 ? "" : path )
                                + input.getName(), subFiles[i]);
            else
                addDirectory(zipOutput, (path.trim().length() == 0 ? "" : path)
                        + input.getName() + "/", subFiles[i]);
        }
    }

    /**
     * 压缩文件
     * 
     * @param zipOutput
     * @param path
     * @param file
     * @throws IOException
     */
    private static void addFile(ZipOutputStream zipOutput, String path,
            File file)
            throws IOException
    {
//        System.out.println("正在压缩文件：" + file.getAbsolutePath());

        ZipEntry zipEntry = new ZipEntry((path.trim().length() == 0 ? "" : path
                + "/")
                + file.getName());
        zipEntry.setComment(file.getAbsolutePath());

        zipOutput.putNextEntry(zipEntry);

        FileInputStream ins = new FileInputStream(file);

        byte[] tmp = new byte[1024];
        int len = 0;

        while ((len = ins.read(tmp)) != -1)
        {
            zipOutput.write(tmp, 0, len);
        }
        ins.close();

        zipOutput.closeEntry();
    }

//	public boolean isXMLDownload() {
//		return isXMLDownload;
//	}
//
//	public void setXMLDownload(boolean isXMLDownload) {
//		this.isXMLDownload = isXMLDownload;
//	}

	public String getRootPath() {
		return rootPath;
	}

	public void setRootPath(String rootPath) {
		this.rootPath = rootPath;
	}


}
