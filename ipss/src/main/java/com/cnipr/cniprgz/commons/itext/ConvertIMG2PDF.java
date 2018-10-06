package com.cnipr.cniprgz.commons.itext;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.apache.commons.io.IOUtils;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Image;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfCopy;
import com.lowagie.text.pdf.PdfGState;
import com.lowagie.text.pdf.PdfImportedPage;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.pdf.RandomAccessFileOrArray;
import com.lowagie.text.pdf.codec.PngImage;
import com.lowagie.text.pdf.codec.TiffImage;


public class ConvertIMG2PDF {
	
	public static void imageWatermark(String inputPath, String outputPath) throws IOException, DocumentException {		   
	    PdfReader reader = new PdfReader(inputPath);  
	    PdfStamper stamp = new PdfStamper(reader, new FileOutputStream(outputPath));  
	    PdfGState gs1 = new PdfGState();  
	    gs1.setFillOpacity(0.5f);  
	   
//	    Image image = Image.getInstance(IOUtils.toByteArray(new FileInputStream(System.getProperty("user.dir") + "/src/main/webapp/WEB-INF/resources/image/watermark_backgroud.png")));
	    Image image = Image.getInstance(IOUtils.toByteArray(new FileInputStream("C:\\PDF\\456.png")));
	    int n = reader.getNumberOfPages();  
	    for(int i = 1; i <= n; i++) {  
	        PdfContentByte pdfContentByte = stamp.getOverContent(i);
	        pdfContentByte.setGState(gs1);
	        
	        image.setAbsolutePosition(380, 805);
	        pdfContentByte.addImage(image);
	    }
	    
	    stamp.close();  
	    reader.close();  
	}
	
	public static File JPG2PDF(String jpg, String pdf) {
		File pdfFile = null;
		try{
		String imagePath = jpg;
		String pdfPath = pdf;
		
		
		BufferedImage img = ImageIO.read(new File(imagePath));
		FileOutputStream fos = new FileOutputStream(pdfPath);
		Document doc = new Document(null, 0, 0, 0, 0);
		doc.setPageSize(new Rectangle(img.getWidth(), img.getHeight()));
		Image image = Image.getInstance(imagePath);
		PdfWriter.getInstance(doc, fos);
		doc.open();
		doc.add(image);
		doc.close();

		
		
		
		
		
		//////////////////////////////////////////////////////
/*		Document document = new Document();
		try {
			PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(pdf));
			writer.setStrictImageSequence(true);
			Image image;
			document.open();
			RandomAccessFileOrArray ra = new RandomAccessFileOrArray(imgeFilename);
			int pagesTif = TiffImage.getNumberOfPages(ra);
			for (int i = 1; i <= pagesTif; i++) {
				image = TiffImage.getTiffImage(ra, i);
//				image.scaleAbsolute(PageSize.A4.getWidth(), PageSize.A0.getHeight());
				image.scaleAbsolute(2481F/4.135F, 3508F/4.135F);
				
//				image.scaleAbsoluteWidth(620F);
//				image.scaleAbsoluteHeight(875F);
				
				document.setMargins(0, 0, 0, 0);
				document.newPage();
				document.add(image);
			}
			pdfFile = new File(pdf);
			document.close();*/
			
			
		} catch (Exception ex) {
			// do nothing
		}
		return pdfFile;
	}
	
	public static File TIF2PDF(String tif, String pdf) {
		File pdfFile = null;
		String imgeFilename = tif;
		Document document = new Document();
		try {
			PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(pdf));
			writer.setStrictImageSequence(true);
			Image image;
			document.open();
			RandomAccessFileOrArray ra = new RandomAccessFileOrArray(imgeFilename);
			int pagesTif = TiffImage.getNumberOfPages(ra);
			for (int i = 1; i <= pagesTif; i++) {
				image = TiffImage.getTiffImage(ra, i);
//				image.scaleAbsolute(PageSize.A4.getWidth(), PageSize.A0.getHeight());
				image.scaleAbsolute(2481F/4.135F, 3508F/4.135F);
				
//				image.scaleAbsoluteWidth(620F);
//				image.scaleAbsoluteHeight(875F);
				
				document.setMargins(0, 0, 0, 0);
				document.newPage();
				document.add(image);
			}
			pdfFile = new File(pdf);
			document.close();
		} catch (Exception ex) {
			// do nothing
		}
		return pdfFile;
	}
	
	public static void PNG2PDF(String png, String pdf){
		try{
		    //Create Document Object
		    Document convertPngToPdf=new Document();
		    //Create PdfWriter for Document to hold physical file
		    //Change the PDF file path to suit to your needs
		    PdfWriter.getInstance(convertPngToPdf, new FileOutputStream(pdf));
		    convertPngToPdf.open();
		    //Get the PNG image to Convert to PDF
		    //getImage of PngImage class is a static method
		    //Edit the file location to suit to your needs
		    Image convertBmp=PngImage.getImage(png);
		    
		    convertBmp.scaleAbsolute(2481F/4.85F, 3508F/4.85F);
		    convertPngToPdf.setMargins(0, 0, 0, 0);
		    
		    //Add image to Document
		    convertPngToPdf.add(convertBmp);
		    //Close Document
		    convertPngToPdf.close();
//		    System.out.println("Converted and stamped PNG Image in a PDF Document Using iText and Java");		    
		}
		catch (Exception i1){
		    i1.printStackTrace();
		}
	}
	
    public static boolean mergePdfFiles(File[] files,File savepath) 
    { 
        try 
        { 
            Document document = new Document(new PdfReader(files[0].getAbsolutePath()).getPageSize(1));            
            PdfCopy copy = new PdfCopy(document, new FileOutputStream(savepath.getAbsolutePath()));            
            document.open(); 
            for (int i = 0; i < files.length; i++) 
            {              
                PdfReader reader = new PdfReader(files[i].getAbsolutePath());                
                int n = reader.getNumberOfPages();          
                for (int j = 1; j <= n; j++) 
                {                   
                    document.newPage(); 
                    PdfImportedPage page = copy.getImportedPage(reader, j);                    
                    copy.addPage(page); 
                }              
            } 
            document.close(); 
            return true; 
        } 
        catch (IOException e) 
        { 
            e.printStackTrace(); 
            return false; 
        } 
        catch (DocumentException e) 
        { 
            e.printStackTrace(); 
            return false; 
        } 
    } 
	
    public static void main(String[] args) {
//    	TIF2PDF("","");
    	String str = String.format("%05d", 100);
    	System.out.println(str);
    }
    
	public static void main1(String[] args) {
//		convertAndCombine("C:\\CN201210178548.6", "C:\\CN201210178548.6\\CN201210178548.6.pdf");
		
		File tiffolder = new File("C:\\dell\\CN201210178548.6");
		
//		for(int i=0;i<tiffolder.length();i++){
//			convert(tiffolder.getAbsolutePath(), tiffolder.getAbsolutePath() + "CN201210178548.6.pdf");
//		}
		
		FileFilter filter = new FileFilter() {
			@Override
			public boolean accept(File pathname) {
				return pathname.getName().toLowerCase().endsWith(".tif");
			}
		};
		
		FileFilter filterpdf = new FileFilter() {
			@Override
			public boolean accept(File pathname) {
				return pathname.getName().toLowerCase().endsWith(".pdf");
			}
		};
		
//		File pdfFile = null;
		File[] tifs = (tiffolder).listFiles(filter);
		for(int n=0;n<tifs.length;n++){
//			String imgeFilename = tifs[n].getAbsolutePath();
			TIF2PDF(tifs[n].getAbsolutePath(), tifs[n].getAbsolutePath().replace(".TIF", ".tif").replace(".tif", ".pdf"));
		}
		
		File[] pdfs = (tiffolder).listFiles(filterpdf);
		mergePdfFiles(pdfs, new File(tiffolder.getAbsolutePath()+"\\111.pdf"));
		
		try{
			imageWatermark("C:\\dell\\CN201210178548.6\\111.pdf", "C:\\dell\\CN201210178548.6\\333.pdf");
		}catch(Exception ex){
			
		}
	}
	
	public static void main2(String[] args) throws Exception{		
		imageWatermark("C:\\PDF\\111.pdf", "C:\\PDF\\333.pdf");
	}
}