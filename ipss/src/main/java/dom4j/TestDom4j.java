package dom4j;

import java.io.File;
import java.util.Iterator;
import java.util.List;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

class DocumentID{
	public String getCountry() {
		return Country;
	}
	public void setCountry(String country) {
		Country = country;
	}
	public String getNumber() {
		return Number;
	}
	public void setNumber(String number) {
		Number = number;
	}
	public String getKind() {
		return Kind;
	}
	public void setKind(String kind) {
		Kind = kind;
	}
	public String getDate() {
		return Date;
	}
	public void setDate(String date) {
		Date = date;
	}
	private String Country;
	private String Number;
	private String Kind;//A
	private String Date;
}

class PublicationInfo{
	private DocumentID documentID;

	public DocumentID getDocumentID() {
		return documentID;
	}

	public void setDocumentID(DocumentID documentID) {
		this.documentID = documentID;
	}
}

class BibliographicData{
	private PublicationInfo publicationInfo;

	public PublicationInfo getPublicationInfo() {
		return publicationInfo;
	}

	public void setPublicationInfo(PublicationInfo publicationInfo) {
		this.publicationInfo = publicationInfo;
	}
}

class PatentDocument{
	private BibliographicData bibliographicData;

	public BibliographicData getBibliographicData() {
		return bibliographicData;
	}

	public void setBibliographicData(BibliographicData bibliographicData) {
		this.bibliographicData = bibliographicData;
	}
}

class Documents{
	private PatentDocument patentDocument;

	public PatentDocument getPatentDocument() {
		return patentDocument;
	}

	public void setPatentDocument(PatentDocument patentDocument) {
		this.patentDocument = patentDocument;
	}
}

public class TestDom4j {
/*
	<Documents fileName="CN2017106717144A.XML" quantity="1" schemaVersion="V1.1.0" producer="ipph" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="\DTDS\ipphdb-documents.xsd">
	  <PatentDocument sequence="1" status="create">
	    <BibliographicData>
	      <PublicationInfo sequence="1" dataFormat="ipph">
	        <DocumentID>
	          <Country>CN</Country>
	          <Number>2017106717144</Number>
	          <Kind>A</Kind>
	          <Date>20170531</Date>
	        </DocumentID>
	      </PublicationInfo>
*/
	
	
	public static void main(String[] args) throws Exception {
		SAXReader sr = new SAXReader();
		Document document = sr.read(new File("src/main/java/dom4j/CN2017106717144A.XML"));
		Element root = document.getRootElement();
		List<Element> elementList = root.elements();
//		List<Documents> bookList = new ArrayList();
		for (Element e : elementList) {
/*			Book book = new Book();
			book.setTitle(e.elementText("title"));
			book.setAuthor(e.elementText("author"));
			book.setYear(e.elementText("year"));
			book.setPrice(e.elementText("price"));
			book.setCategory(e.attributeValue("category"));
			bookList.add(book);*/
			
//			Documents documents = (Documents)e;
			System.out.println(e.getQName());
			
			
			PatentDocument patentDocument = (PatentDocument)e;
			
			
/*			PatentDocument patentDocument = new PatentDocument();
			patentDocument.setBibliographicData(bibliographicData);
			
			System.out.println(
					patentDocument.getBibliographicData().getPublicationInfo().getDocumentID().getCountry());
*/	
			
		}
		
/*		for (Book book : bookList) {
			System.out.println("title:"+book.getTitle()+"\t category:"+book.getCategory()+"\t author:"+book.getAuthor()+"\t year:"+book.getYear()+"\t price:"+book.getPrice());
		}*/
		

	}
	
	   public void listNodes(Element node) {  
	        System.out.println("当前节点的名称：：" + node.getName());  
	        // 获取当前节点的所有属性节点  
	        List<Attribute> list = node.attributes();  
	        // 遍历属性节点  
	        for (Attribute attr : list) {  
	            System.out.println(attr.getText() + "-----" + attr.getName()  
	                    + "---" + attr.getValue());  
	        }  

	        if (!(node.getTextTrim().equals(""))) {  
	            System.out.println("文本内容：：：：" + node.getText());  
	        }  

	        // 当前节点下面子节点迭代器  
	        Iterator<Element> it = node.elementIterator();  
	        // 遍历  
	        while (it.hasNext()) {  
	            // 获取某个子节点对象  
	            Element e = it.next();  
	            // 对子节点进行遍历  
	            listNodes(e);  
	        }  
	    }  

}
