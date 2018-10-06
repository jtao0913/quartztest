package tools;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.cnipr.corebiz.search.entity.PatentInfo;


public class jsonTest {
	 /** *//**
     * 从json对象集合表达式中得到一个java对象列表
     * @param jsonString
     * @param pojoClass
     * @return
     */
    @SuppressWarnings("unchecked")
	public static List getList4Json(String jsonString, Class pojoClass){
        
        JSONArray jsonArray = JSONArray.fromObject(jsonString);
        JSONObject jsonObject;
        Object pojoValue;
        
        List list = new ArrayList();
        for ( int i = 0 ; i<jsonArray.size(); i++){
            
            jsonObject = jsonArray.getJSONObject(i);
            pojoValue = JSONObject.toBean(jsonObject,pojoClass);
            list.add(pojoValue);
            
        }
        return list;

    }

	
	@SuppressWarnings("unchecked")
	public static void main(String[] args){
		String s = "[{an:'12321321',sectionName:'sdfsfsd',ti:'aaaaa',pic:'"
					+ "re32',pa:'werwe',countryCode:'q'},{an:'2222',sectionName:'3333',ti:'bbbb',pic:'"
					+ "re32',pa:'werwe',countryCode:'q'}]";
		List<PatentInfo> i = jsonTest.getList4Json(s, PatentInfo.class);
		for (PatentInfo p : i) {
			System.out.println(p.getAn());
		}
	}
}
