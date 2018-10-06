package xml5;

import java.util.List;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

public class PatentDocument {
	public PatentDocument(){}
	
    BibliographicData bibliographicData;//所有学生信息的集合
    
    @XmlElement(name = "BibliographicData")  
    public BibliographicData getBibliographicData() {
        return bibliographicData;
    }
    
    public void setBibliographicData(BibliographicData bibliographicData) {
        this.bibliographicData = bibliographicData;
    }
/*	
    String name;//姓名
    String sex;//性别
    int number;//学号
    String className;//班级
    List<String> hobby;//爱好
        
    public PatentDocument(String name,String sex,int number,
            String className,List<String> hobby) {
        this.name = name;
        this.sex = sex;
        this.number = number;
        this.className = className;
        this.hobby = hobby;
    }
    
    @XmlAttribute(name="name")  
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    
    @XmlAttribute(name="sex")  
    public String getSex() {
        return sex;
    }
    public void setSex(String sex) {
        this.sex = sex;
    }
    
    @XmlAttribute(name="number")  
    public int getNumber() {
        return number;
    }
    public void setNumber(int number) {
        this.number = number;
    }
    
    @XmlElement(name="className")  
    public String getClassName() {
        return className;
    }
    public void setClassName(String className) {
        this.className = className;
    }
    
    @XmlElementWrapper(name="hobbys")
    @XmlElement(name = "hobby")
    public List<String> getHobby() {
        return hobby;
    }
    public void setHobby(List<String> hobby) {
        this.hobby = hobby;
    }
*/   
}