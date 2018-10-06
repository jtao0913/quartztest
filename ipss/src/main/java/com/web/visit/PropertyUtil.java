package com.web.visit;

import java.io.*;
import java.net.*;
import java.util.*;

public class PropertyUtil   
{
    private File propertiesFile;
    private static Map propetyManager = new HashMap();
    private static Object managerLock = new Object();
    private PropertyUtil(String filename)
    {
        propertiesFile = null;
        setPropertyFile(filename);
    }
    private PropertyUtil(String absoluteFilepath,String filename)
    {
        propertiesFile = null;
        setPropertyFile( absoluteFilepath, filename);
    }

    public static PropertyUtil getInstance(String propertyFileName)
    {
        return new PropertyUtil(propertyFileName);
    }
    public static PropertyUtil getInstance(String absoluteFilepath,String filename)
    {
        return new PropertyUtil(absoluteFilepath,filename);
    }

    public void setPropertyFile(String absoluteFilepath,String filename)
    {
        try
        {
            propertiesFile = new File(absoluteFilepath+"/"+filename);
            if(propertiesFile.exists()==false)
            	throw new Exception("propertiesFile is not exist:"+absoluteFilepath+"/"+filename);
            System.out.println("Propertes file absolute path:\n"+absoluteFilepath+"/"+filename);
        }
        catch(Exception e)
        {
            System.out.println("error");
        }
    }
    
    public void setPropertyFile(String filename)
    {
        try
        {
            propertiesFile = new File((new URI(getClass().getResource(filename).getPath())).getPath());
            //System.out.println("Propertes file path:\n"+(new URI(getClass().getResource(filename).getPath())).getPath());
        }
        catch(URISyntaxException e)
        {
            System.out.println("error");
        }
    }

    private void loadProps(Properties prop)  throws  Exception
    {
        if(prop != null)
            prop.clear();
        InputStream in = null;
        try
        {
            in = new FileInputStream(propertiesFile);
            prop.load(in);
        }
        catch(Exception e)
        {
            String error = "Error reading the properties file: " + propertiesFile + " in PropMan.loadProps()n" + e;
            throw new Exception(error);
        }
        finally
        {
            try
            {
                in.close();
            }
            catch(Exception e) { }
        }
        return;
    }

    private Properties getProperties()        throws Exception
    {
        Properties prop = (Properties)propetyManager.get(propertiesFile);
        if(prop == null)
            synchronized(managerLock)
            {
                if(prop == null)
                {
                    prop = new Properties();
                    loadProps(prop);
                }
            }
        return prop;
    }

    public String getProperty(String name)
    {
        return getProperty(name, null);
    }

    public String getProperty(String name, String defaultString)
    {
        try
        {
            return getProperties().getProperty(name);
        }
        catch(Exception e)
        {}
        return defaultString;
    }

    public void setProperty(String name, String value)
    {
        Properties prop = null;
        try
        {
            prop = getProperties();
            if(prop == null)
                prop = new Properties();
        }
        catch(Exception e)
        {
            prop = new Properties();
        }
        prop.setProperty(name, value);
        propetyManager.put(propertiesFile, prop);
    }

    public void deleteProperty(String name)
    {
        try
        {
            Properties prop = getProperties();
            prop.remove(name);
            propetyManager.put(propertiesFile, prop);
        }
        catch(Exception e)
        {
        }
    }

    public void saveProperty() throws Exception
    {
        OutputStream out = null;
        try
        {
            if(!propertiesFile.exists())
                propertiesFile.createNewFile();
            out = new FileOutputStream(propertiesFile);
            ((Properties)propetyManager.get(propertiesFile)).store(out, propertiesFile.getPath());
        }
        catch(Exception ioe)
        {
            String errorMessage = "There was an error writing properties to " + propertiesFile + ". " ;
            throw new Exception(errorMessage, ioe);
        }
        finally
        {
            try
            {
                out.close();
            }
            catch(Exception e) { }
        }
        return;
    }

    public void putProperty(String name, String value)
    {
        Properties prop = null;
        try
        {
            prop = getProperties();
            if(prop == null)
                prop = new Properties();
        }
        catch(Exception e)
        {
            prop = new Properties();
        }
        prop.put(name, value);
        propetyManager.put(propertiesFile, prop);
    }

    public Enumeration propertyNames()
    {
        try
        {
            return getProperties().propertyNames();
        }
        catch(Exception e)
        {
            return ((Properties)propetyManager.get(propertiesFile)).propertyNames();
        }
    }

    public boolean propertyFileIsReadable()
    {
        try
        {
            return propertiesFile.canRead();
        }
        catch(Exception e)
        {
            return false;
        }
    }

    public boolean propertyFileIsWritable()
    {
        return propertiesFile.isFile() && propertiesFile.canWrite();
    }

    public boolean propertyFileExists()
    {
        return propertiesFile.exists() && propertiesFile.isFile();
    }

    public void reloadProps()         throws Exception
    {
        loadProps(getProperties());
    }
}

