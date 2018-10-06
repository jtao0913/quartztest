package xml5;

import java.util.List;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name="Documents")
public class Documents {    
    PatentDocument patentDocument;//所有学生信息的集合
    
    @XmlElement(name = "PatentDocument")  
    public PatentDocument getPatentDocument() {
        return patentDocument;
    }
    
    public void setPatentDocument(PatentDocument patentDocument) {
        this.patentDocument = patentDocument;
    }
    
}