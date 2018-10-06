package tools;

import java.util.Arrays;

public class CncCode {
	public static String enCode(byte[] bsrc)
    {
            String dest = "",str;
            byte bb;
            int num;
            if(bsrc==null)return "";
            for(int ii=0;ii<bsrc.length;ii++)
            {
                    bb=bsrc[ii];
                    if(bb>=0)
                            num=bb;
                    else
                            num=(bb&0x7F)+(1<<7);
                    str=Integer.toHexString(num);
                    if(str.length()<2)str="0"+str;
                    dest+=str.toUpperCase();
            }
            return dest;
    }

    public static byte[] deCode(String src)
    {
            if(src.length()<2)return new byte[0];
            byte[] dest = new byte[src.length()/2];
            byte rb;
            String str;
            Arrays.fill(dest,(byte)0);
            int index=0;
            for(int ii=0;ii<src.length()-1;ii++)
            {
                    str="#"+src.substring(ii,ii+2);
                    rb=(byte)Integer.decode(str).intValue();
                    dest[index++]=rb;
                    ii++;
            }
            return dest;
    }

    public static void main(String[] args){
    	
    }

}
