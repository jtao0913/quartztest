package xml5;

import javax.xml.bind.annotation.XmlElement;

public class DocumentID {
	public DocumentID(){}

    String Country;
    String Number;
    String Kind;
    String Date;
    
    public DocumentID(String Country,String Number,String Kind,String Date) {
        this.Country = Country;
        this.Number = Number;
        this.Kind = Kind;
        this.Date = Date;
    }
    
    @XmlElement(name="Country")  
    public String getCountry() {
        return Country;
    }
    public void setCountry(String Country) {
        this.Country = Country;
    }
    
    @XmlElement(name="Number")  
    public String getNumber() {
        return Number;
    }
    public void setNumber(String Number) {
        this.Number = Number;
    }       
        
    @XmlElement(name="Kind")  
    public String getKind() {
        return Kind;
    }
    public void setKind(String Kind) {
        this.Kind = Kind;
    }
    
    @XmlElement(name="Date")  
    public String getDate() {
        return Date;
    }
    public void setDate(String Date) {
        this.Date = Date;
    }
    
    ////////////////////////////////////////////////////

/*    
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