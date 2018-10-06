package tools;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

class ValueComparator implements Comparator<String> {
	Map<String, Integer> base;
	// 这里需要将要比较的map集合传进来
	public ValueComparator(Map<String, Integer> base) {
		this.base = base;
	}
	// Note: this comparator imposes orderings that are inconsistent with equals.
	// 比较的时候，传入的两个参数应该是map的两个key，根据上面传入的要比较的集合base，可以获取到key对应的value，然后按照value进行比较
	public int compare(String a, String b) {
		if (base.get(a) >= base.get(b)) {
			return -1;
		} else {
			return 1;
		} // returning 0 would merge keys
	}
}

public class Testing {

	public static void main1(String[] args) {

		HashMap<String, Integer> map = new HashMap<String, Integer>();
		ValueComparator bvc = new ValueComparator(map);
		TreeMap<String, Integer> sorted_map = new TreeMap<String, Integer>(bvc);
		
		map.put("A", 99);
		map.put("B", 60);
		map.put("C", 63);
		map.put("D", 67);

		System.out.println("unsorted map: " + map);
		
		sorted_map.putAll(map);

		System.out.println("results: " + sorted_map);
	}

	private static void moveFilder(String str1) {
//		String str1 = "D:\\Develop\\workspace-oxygen\\jdk10\\_src\\java.activation";
		String str2 = "D:\\Develop\\workspace-oxygen\\jdk10\\src";
		
		File movefolders=new File(str1);
		File[] movefoldersList=movefolders.listFiles();   
		for(int k=0;k<movefoldersList.length;k++){   
		    if(movefoldersList[k].isDirectory()){   
		        ArrayList<String> folderList=new ArrayList<String>();   
		        folderList.add(movefoldersList[k].getPath());   
		        ArrayList<String> folderList2=new ArrayList<String>();   
		        folderList2.add(str2+"/"+movefoldersList[k].getName());   
		        for(int j=0;j<folderList.size();j++){   
		             (new File(folderList2.get(j))).mkdirs(); //如果文件夹不存在 则建立新文件夹   
		             File folders=new File(folderList.get(j));   
		             String[] file=folders.list();   
		             File temp=null;   
		             try {   
		                 for (int i = 0; i < file.length; i++) {   
		                     if(folderList.get(j).endsWith(File.separator)){   
		                         temp=new File(folderList.get(j)+"/"+file[i]);   
		                     }   
		                     else{   
		                         temp=new File(folderList.get(j)+"/"+File.separator+file[i]);   
		                     }   
//		                     FileInputStream input = new FileInputStream(temp);   
		                     if(temp.isFile()){   
		                         FileInputStream input = new FileInputStream(temp);   
		                         FileOutputStream output = new FileOutputStream(folderList2.get(j) + "/" + (temp.getName()).toString());   
		                         byte[] b = new byte[5120];   
		                         int len;   
		                         while ( (len = input.read(b)) != -1) {   
		                             output.write(b, 0, len);   
		                         }   
		                         output.flush();   
		                         output.close();   
		                         input.close();   
		                         temp.delete();   
		                     }   
		                     if(temp.isDirectory()){//如果是子文件夹   
		                         folderList.add(folderList.get(j)+"/"+file[i]);   
		                         folderList2.add(folderList2.get(j)+"/"+file[i]);   
		                     }   
		                 }   
		             }   
		             catch (Exception e) {   
		                 System.out.println("复制整个文件夹内容操作出错");   
		                 e.printStackTrace();   
		             }   
		        }   
		        movefoldersList[k].delete();   
		    }   
		}   
	}
	
	public static void main(String[] args) {
		String str1 = "D:\\Develop\\workspace-oxygen\\jdk10\\_src\\";
		File movefolders=new File(str1);   
		File[] movefoldersList=movefolders.listFiles();   
		for(int k=0;k<movefoldersList.length;k++){
			moveFilder(movefoldersList[k].getAbsolutePath());
		}
	}

}

