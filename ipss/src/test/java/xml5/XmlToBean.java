package xml5;

import java.io.File;
import java.io.IOException;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

public class XmlToBean {
    /**
     * xml文件配置转换为对象
     * @param xmlPath	xml文件路径
     * @param load java对象.Class
     * @return java对象
     * @throws JAXBException    
     * @throws IOException
     */
    public static Object xmlToBean(String xmlPath,Class<?> load) throws JAXBException, IOException{
        JAXBContext context = JAXBContext.newInstance(load);  
        Unmarshaller unmarshaller = context.createUnmarshaller(); 
//        unmarshaller.setValidating(false);
        Object object = unmarshaller.unmarshal(new File(xmlPath));
        return object;
    }
    
    public static void main(String[] args) throws IOException, JAXBException {
        String xmlPath =  "src/test/java/xml5/CN2017106717144A.XML";
        Object object = XmlToBean.xmlToBean(xmlPath,Documents.class);
        Documents documents = (Documents)object;
        PatentDocument patentDocument = documents.getPatentDocument();
        
//        for(int i=0;i<patentDocumentList.size();i++){
//        	System.out.println(patentDocumentList.get(i).getBibliographicData().getPublicationInfo().get(index));
//        }
/*        for(int i=0;i<studentList.size();i++){
            System.out.println(studentList.get(i).name);
            System.out.println(studentList.get(i).sex);
            System.out.println(studentList.get(i).number);
            System.out.println(studentList.get(i).className);
            for(String str :studentList.get(i).hobby){
                System.out.print(str+" ");
            }
            System.out.println("-------------");
        }*/
        
        System.out.println("-------------");
    }
}