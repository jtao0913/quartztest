package tools;

public class TryCatchTest {
	
	public void test() throws Exception {
		try{
//			System.out.println(1/0); 
			Long l = 1222234L;
			int i = Integer.valueOf(l.toString());
			System.out.println(i); 
		} catch (Exception e) {
			throw new Exception(e.getMessage());
		} finally {
			System.out.println("in finally");
		}
		
		return ;
	}
	
	public static void main(String[] args) {
		TryCatchTest t = new TryCatchTest();
		try {
			t.test();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
