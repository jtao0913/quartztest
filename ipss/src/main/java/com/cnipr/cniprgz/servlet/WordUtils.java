package com.cnipr.cniprgz.servlet;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import freemarker.template.Configuration;
import freemarker.template.Template;

public class WordUtils {
    private static Configuration configuration = null;  
    private static final String templateFolder = WordUtils.class.getClassLoader().getResource("../../").getPath() + "WEB-INF/templates/";  
    static {  
        configuration = new Configuration();  
        configuration.setDefaultEncoding("utf-8");  
        try {  
            configuration.setDirectoryForTemplateLoading(new File(templateFolder));  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
   }  
  
    private WordUtils() {  
        throw new AssertionError();  
    }  
  
    public static void exportMillCertificateWord(HttpServletRequest request, HttpServletResponse response, Map map,String title,String ftlFile) throws IOException {  
        Template freemarkerTemplate = configuration.getTemplate(ftlFile);  
        File file = null;  
        InputStream fin = null;  
        ServletOutputStream out = null;  
        try {  
            file = createDoc(map,freemarkerTemplate);  
            fin = new FileInputStream(file);  
  
            response.setCharacterEncoding("utf-8");  
            response.setContentType("application/msword");  
            String fileName = title + ".doc";  
            response.setHeader("Content-Disposition", "attachment;filename="  
                    .concat(String.valueOf(URLEncoder.encode(fileName, "UTF-8"))));  
  
            out = response.getOutputStream();  
            byte[] buffer = new byte[512]; 
            int bytesToRead = -1;  
            while((bytesToRead = fin.read(buffer)) != -1) {  
                out.write(buffer, 0, bytesToRead);  
            }  
        } finally {  
            if(fin != null) fin.close();  
            if(out != null) out.close();  
            if(file != null) file.delete();
        }  
    }  
  
    private static File createDoc(Map<?, ?> dataMap, Template template) {  
        String name =  "sellPlan.doc";  
        File f = new File(name);  
        Template t = template;  
        try {  
            Writer w = new OutputStreamWriter(new FileOutputStream(f), "utf-8");  
            t.process(dataMap, w);  
            w.close();  
        } catch (Exception ex) {  
            ex.printStackTrace();  
            throw new RuntimeException(ex);  
        }  
        return f;  
    }  
}
