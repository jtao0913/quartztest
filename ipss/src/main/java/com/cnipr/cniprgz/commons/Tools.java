package com.cnipr.cniprgz.commons;
import java.util.Vector;
import java.util.GregorianCalendar;
import java.sql.*;


public class Tools
{
    public Tools() 
    {}

    public static String dealblank(String str)
    {
        while(str.indexOf("��")!=-1)
        {
          str=str.substring(0,str.indexOf("��"))+str.substring(str.indexOf("��")+1,str.length());
        }
        while(str.indexOf(" ")!=-1)
        {
          str=str.substring(0,str.indexOf(" "))+str.substring(str.indexOf(" ")+1,str.length());
        }
        return str;
   }

    public static String dealSingleQuot(String str)
    {
        String str1="";
        while(str.indexOf("'")!=-1)
        {
            str1=str1+str.substring(0,str.indexOf("'")+1)+"'";
            str=str.substring(str.indexOf("'")+1,str.length());
        }
        str1=str1+str;
        return str1;
    }
    
    public static String dealComma(String str)
    {
        String str1="";
        while(str.indexOf("��")!=-1)
        {
            str1=str1+str.substring(0,str.indexOf("��"))+";";
            str=str.substring(str.indexOf("��")+1,str.length());
        }
        str1=str1+str;
        return str1;
    }
    
    public static String dealLine(String str)
    {
        String str1="";
        while(str.indexOf("��")!=-1)
        {
            str1=str1+str.substring(0,str.indexOf("��"))+"-";
            str=str.substring(str.indexOf("��")+1,str.length());
        }
        str1=str1+str;
        return str1;
    }
    
    public static long ip2long(String s) throws Exception
    {
        if(s == null)
            throw new Exception("");
        try
        {
            String as[] = splitString(s, ".");
            long l = 0L;
            for(int i = 0; i < as.length; i++)
            {
                long l1 = (long)Math.pow(256D, as.length - i - 1);
                Integer integer = new Integer(as[i]);
                l += l1 * integer.longValue();
            }

            return l;
        }
        catch(Exception e)
        {
            return -1;
        }
    }

    public static String long2ip(long l) throws Exception
    {
        if(l <= 0L)
            throw new Exception("");
        try
        {
            String s = "";
            long l1 = 0L;
            for(int i = 4; i > 0; i--)
            {
                long l2 = (long)Math.pow(256D, i - 1);
                long l3 = (l - l1) / l2;
                l1 = l3 * l2 + l1;
                if(i != 4)
                    s = s + ".";
                s = s + String.valueOf(l3);
            }

            return s;
        }
        catch(Exception exception)
        {
            return null;
        }
    }
    
    public static String[] splitString(String s, String s1)
        throws Exception
    {
        if(s == null)
            throw new Exception("");
        if(s1 == null)
            throw new Exception("");
        boolean flag = true;
        int i = 0;
        Vector vector = new Vector();
        try
        {
            for(int j = s.indexOf(s1); j != -1; j = s.indexOf(s1, i))
            {
                vector.add(s.substring(i, j));
                i = j + s1.length();
            }

            if(i != 0)
                vector.add(s.substring(i));
            if(vector.size() > 0)
            {
                String as[] = new String[vector.size()];
                vector.copyInto(as);
                return as;
            } else
            {
                String as1[] = new String[1];
                as1[0] = s;
                return as1;
            }
        }
        catch(Exception exception)
        {
            return null;
        }
    }
    
    public static String encrypt(boolean flag, String s) throws Exception
    {
        if(s.equals(""))
            return "";
        String s1;
        if(flag)
        {
            char ac[] = encryptCore(flag, s);
            String s2 = new String();
            s1 = new String();
            for(int j = 0; j < ac.length; j++)
            {
                char c = ac[j];
                String s3 = String.valueOf(c);
                if(j == 0)
                    s1 = s3;
                else
                    s1 = s1 + "^" + s3;
            }

        } else
        {
            int k = 1;
            String s5 = s;
            String s4;
            try
            {
                s4 = getSubItem(s5, k, "^");
            }
            catch(Exception wasexception)
            {
                throw wasexception;
            }
            char ac1[] = new char[256];
            for(; s4 != null && !s4.equals("null"); s4 = getSubItem(s5, ++k, "^"))
            {
                int i = Integer.parseInt(s4);
                ac1[k - 1] = (char)i;
            }

            if(k == 1)
            {
                s1 = null;
            } else
            {
                String s6 = new String(ac1, 0, --k);
                char ac2[] = encryptCore(flag, s6);
                s1 = new String(ac2, 0, ac2.length - 1);
            }
        }
        return s1;
    }

    private static char[] encryptCore(boolean flag, String s)
    {
        GregorianCalendar gregoriancalendar = new GregorianCalendar();
        int i = s.length();
        char ac[];
        int i4;
        byte byte0;
        if(flag)
        {
            byte0 = 1;
            ac = new char[i + 1];
            i4 = gregoriancalendar.get(12);
            if(i4 < 30)
                i4 += 30;
        } else
        {
            byte0 = -1;
            ac = new char[i];
            char c = s.charAt(i - 1);
            i4 = c;
            i--;
        }
        int l;
        if(i > i4)
            l = i;
        else
            l = i4 + i;
        int i1 = byte0 * (l - 52);
        int j1 = byte0 * (l - 33);
        int k1 = byte0 * (l - 4);
        int l1 = byte0 * (l - 7);
        int i2 = byte0 * (l - 19);
        int j2 = byte0 * (l - 21);
        int k2 = byte0 * (l - 43);
        int l2 = byte0 * (l - 58);
        int i3 = byte0 * (l - 11);
        int j3 = byte0 * (l - 43);
        int k3 = byte0 * (l - 2);
        int l3 = byte0 * (l - 9);
        l = byte0 * l;
        char ac1[] = s.toCharArray();
        int j;
        for(j = 0; j < i; j++)
        {
            int k = j % 13;
            if(ac1[j] > '\u0100')
                ac1[j] = (char)(ac1[j] - 65280);
            switch(k)
            {
            case 0: // '\0'
                ac[j] = (char)(ac1[j] + l);
                break;

            case 1: // '\001'
                ac[j] = (char)(ac1[j] + i1);
                break;

            case 2: // '\002'
                ac[j] = (char)(ac1[j] + j1);
                break;

            case 3: // '\003'
                ac[j] = (char)(ac1[j] + k1);
                break;

            case 4: // '\004'
                ac[j] = (char)(ac1[j] + l1);
                break;

            case 5: // '\005'
                ac[j] = (char)(ac1[j] + i2);
                break;

            case 6: // '\006'
                ac[j] = (char)(ac1[j] + j2);
                break;

            case 7: // '\007'
                ac[j] = (char)(ac1[j] + k2);
                break;

            case 8: // '\b'
                ac[j] = (char)(ac1[j] + l2);
                break;

            case 9: // '\t'
                ac[j] = (char)(ac1[j] + i3);
                break;

            case 10: // '\n'
                ac[j] = (char)(ac1[j] + j3);
                break;

            case 11: // '\013'
                ac[j] = (char)(ac1[j] + k3);
                break;

            case 12: // '\f'
                ac[j] = (char)(ac1[j] + l3);
                break;

            default:
                ac[j] = (char)(ac1[j] + l2);
                break;
            }
            if(ac1[j] > '\177')
                ac1[j] = (char)(256 - ac1[j]);
        }

        if(flag)
            ac[j++] = (char)i4;
        return ac;
    }

    public static String getSubItem(String s, int i, String s1) throws Exception
    {
        if(s == null)
            throw new Exception("XXX#���ַ�Ϊ��#PTools.getSubItem#");
        if(s1 == null)
            throw new Exception("XXX#�ָ���Ϊ��#PTools.getSubItem#");
        if(i <= 0)
            return "";
        boolean flag;
        int j = 0; flag = false;
        int l = 1;
        try
        {
            int k;
            do
            {
                k = s.indexOf(s1, j);
                if(l == i)
                {
                    String s2;
                    if(k != -1)
                        s2 = s.substring(j, k);
                    else
                        s2 = s.substring(j);
                    return s2;
                }
                j = k + s1.length();
                l++;
            } while(k != -1);
            return null;
        }
        catch(Exception exception)
        {
            throw new Exception("XXX#�ڻ�ø��ַ�'" + s + "'��'" + s1 + "'�ָ��ĵ�'" + i + "'���Ӵ�ʱ�����쳣#PTools.getSubItem#" + exception.getMessage());
        }
    }
    
    public static void zeroBlock(byte block[], int off, int len)
    {
        for(int i = off; i < off + len; i++)
            block[i] = 0;

    }

    public static void zeroBlock(byte block[])
    {
        zeroBlock(block, 0, block.length);
    }

    public static void randomBlock(byte block[], int off, int len)
    {
        for(int i = off; i < off + len; i++)
            block[i] = (byte)(int)(Math.random() * 256D);

    }

    public static void randomBlock(byte block[])
    {
        randomBlock(block, 0, block.length);
    }

    public static void xorBlock(byte a[], int aOff, byte b[], int bOff, byte dst[], int dstOff, int len)
    {
        for(int i = 0; i < len; i++)
            dst[dstOff + i] = (byte)(a[aOff + i] ^ b[bOff + i]);

    }

    public static void xorBlock(byte a[], byte b[], byte dst[])
    {
        xorBlock(a, 0, b, 0, dst, 0, a.length);
    }

    public static void copyBlock(byte src[], int srcOff, byte dst[], int dstOff, int len)
    {
        for(int i = 0; i < len; i++)
            dst[dstOff + i] = src[srcOff + i];

    }

    public static void copyBlock(byte src[], byte dst[])
    {
        copyBlock(src, 0, dst, 0, src.length);
    }

    public static boolean equalsBlock(byte a[], int aOff, byte b[], int bOff, int len)
    {
        for(int i = 0; i < len; i++)
            if(a[aOff + i] != b[bOff + i])
                return false;

        return true;
    }

    public static boolean equalsBlock(byte a[], byte b[])
    {
        return equalsBlock(a, 0, b, 0, a.length);
    }

    public static void fillBlock(byte block[], int blockOff, byte b, int len)
    {
        for(int i = blockOff; i < blockOff + len; i++)
            block[i] = b;

    }

    public static void fillBlock(byte block[], byte b)
    {
        fillBlock(block, 0, b, block.length);
    }

    public static void squashBytesToInts(byte inBytes[], int inOff, int outInts[], int outOff, int intLen)
    {
        for(int i = 0; i < intLen; i++)
            outInts[outOff + i] = (inBytes[inOff + i * 4] & 0xff) << 24 | (inBytes[inOff + i * 4 + 1] & 0xff) << 16 | (inBytes[inOff + i * 4 + 2] & 0xff) << 8 | inBytes[inOff + i * 4 + 3] & 0xff;

    }

    public static void spreadIntsToBytes(int inInts[], int inOff, byte outBytes[], int outOff, int intLen)
    {
        for(int i = 0; i < intLen; i++)
        {
            outBytes[outOff + i * 4] = (byte)(inInts[inOff + i] >>> 24 & 0xff);
            outBytes[outOff + i * 4 + 1] = (byte)(inInts[inOff + i] >>> 16 & 0xff);
            outBytes[outOff + i * 4 + 2] = (byte)(inInts[inOff + i] >>> 8 & 0xff);
            outBytes[outOff + i * 4 + 3] = (byte)(inInts[inOff + i] & 0xff);
        }

    }

    public static void squashBytesToIntsLittle(byte inBytes[], int inOff, int outInts[], int outOff, int intLen)
    {
        for(int i = 0; i < intLen; i++)
            outInts[outOff + i] = inBytes[inOff + i * 4] & 0xff | (inBytes[inOff + i * 4 + 1] & 0xff) << 8 | (inBytes[inOff + i * 4 + 2] & 0xff) << 16 | (inBytes[inOff + i * 4 + 3] & 0xff) << 24;

    }

    public static void spreadIntsToBytesLittle(int inInts[], int inOff, byte outBytes[], int outOff, int intLen)
    {
        for(int i = 0; i < intLen; i++)
        {
            outBytes[outOff + i * 4] = (byte)(inInts[inOff + i] & 0xff);
            outBytes[outOff + i * 4 + 1] = (byte)(inInts[inOff + i] >>> 8 & 0xff);
            outBytes[outOff + i * 4 + 2] = (byte)(inInts[inOff + i] >>> 16 & 0xff);
            outBytes[outOff + i * 4 + 3] = (byte)(inInts[inOff + i] >>> 24 & 0xff);
        }

    }

    public static void squashBytesToShorts(byte inBytes[], int inOff, int outShorts[], int outOff, int shortLen)
    {
        for(int i = 0; i < shortLen; i++)
            outShorts[outOff + i] = (inBytes[inOff + i * 2] & 0xff) << 8 | inBytes[inOff + i * 2 + 1] & 0xff;

    }

    public static void spreadShortsToBytes(int inShorts[], int inOff, byte outBytes[], int outOff, int shortLen)
    {
        for(int i = 0; i < shortLen; i++)
        {
            outBytes[outOff + i * 2] = (byte)(inShorts[inOff + i] >>> 8 & 0xff);
            outBytes[outOff + i * 2 + 1] = (byte)(inShorts[inOff + i] & 0xff);
        }

    }

    public static void squashBytesToShortsLittle(byte inBytes[], int inOff, int outShorts[], int outOff, int shortLen)
    {
        for(int i = 0; i < shortLen; i++)
            outShorts[outOff + i] = inBytes[inOff + i * 2] & 0xff | (inBytes[inOff + i * 2 + 1] & 0xff) << 8;

    }

    public static void spreadShortsToBytesLittle(int inShorts[], int inOff, byte outBytes[], int outOff, int shortLen)
    {
        for(int i = 0; i < shortLen; i++)
        {
            outBytes[outOff + i * 2] = (byte)(inShorts[inOff + i] & 0xff);
            outBytes[outOff + i * 2 + 1] = (byte)(inShorts[inOff + i] >>> 8 & 0xff);
        }

    }

    public static String toStringBlock(byte block[], int off, int len)
    {
        String hexits = "0123456789abcdef";
        StringBuffer buf = new StringBuffer();
        for(int i = off; i < off + len; i++)
        {
            buf.append(hexits.charAt(block[i] >>> 4 & 0xf));
            buf.append(hexits.charAt(block[i] & 0xf));
        }

        return "[" + buf + "]";
    }

    public static String toStringBlock(byte block[])
    {
        return toStringBlock(block, 0, block.length);
    }

}
