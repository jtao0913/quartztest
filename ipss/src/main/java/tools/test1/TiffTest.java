package tools.test1;

import java.awt.image.RenderedImage;

import java.io.ByteArrayInputStream;

import java.io.ByteArrayOutputStream;

import java.io.File;

import java.io.FileInputStream;

import java.io.FileNotFoundException;

import java.io.FileOutputStream;

import java.io.IOException;

import java.io.InputStream;

import javax.imageio.ImageIO;

import javax.media.jai.JAI;

import javax.media.jai.RenderedOp;

import org.junit.Test;

import com.sun.media.jai.codec.ImageCodec;

import com.sun.media.jai.codec.ImageDecoder;

import com.sun.media.jai.codec.ImageEncoder;

import com.sun.media.jai.codec.JPEGEncodeParam;

public class TiffTest {

	@Test
	public void testTif2JPG2() {

		try {

			String filename = "F:\\Downloads\\CCITT_2.TIF";

			String jpegFileName = "F:\\Downloads\\CCITT_2.JPG";

			RenderedOp source = JAI.create("fileload", filename);

			FileOutputStream stream = null;

			stream = new FileOutputStream(jpegFileName);

			com.sun.media.jai.codec.JPEGEncodeParam JPEGparam = new

			com.sun.media.jai.codec.JPEGEncodeParam();

			ImageEncoder encoder =

			ImageCodec.createImageEncoder("jpeg", stream, JPEGparam);

			encoder.encode(source);

		} catch (Exception e) {

			e.printStackTrace();

		}

	}

	@Test
	public void testTif2JPG3() {

		try {

			String filename = "F:\\Downloads\\CCITT_2.TIF";

			String jpegFileName = "F:\\Downloads\\CCITT_2.JPG";

			FileOutputStream stream = null;

			stream = new FileOutputStream(jpegFileName);

			byte[] b = getBytesFromFile(new File(filename));

			InputStream bais = new ByteArrayInputStream(b);

			ImageDecoder decoder = ImageCodec.createImageDecoder("tiff", bais,
					null);

			RenderedImage ri = decoder.decodeAsRenderedImage();

			// RenderedOp source = JAI.create("TIFF", bais);

			ByteArrayOutputStream baos = new ByteArrayOutputStream();

			JPEGEncodeParam JPEGparam = new JPEGEncodeParam();

			JPEGparam.setQuality(Float.MIN_VALUE);

			ImageEncoder encoder = ImageCodec.createImageEncoder("jpeg", baos,
					JPEGparam);

			encoder.encode(ri);

			byte[] byteArray = baos.toByteArray();

			FileOutputStream fos = new FileOutputStream(new File(jpegFileName));

			fos.write(byteArray);

		} catch (Exception e) {

			e.printStackTrace();

		}

	}

	@Test
	public void testTif2JPG4() {

		try {

			String filename = "F:\\Downloads\\CCITT_2.TIF";

			String jpegFileName = "F:\\Downloads\\CCITT_2.JPG";

			FileOutputStream stream = null;

			stream = new FileOutputStream(jpegFileName);

			byte[] b = getBytesFromFile(new File(filename));

			InputStream bais = new ByteArrayInputStream(b);

			ImageDecoder decoder = ImageCodec.createImageDecoder("tiff", bais,
					null);

			RenderedImage ri = decoder.decodeAsRenderedImage();

			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

			ImageIO.write(ri, "JPEG", outputStream);

			stream.write(outputStream.toByteArray());

		} catch (Exception e) {

			e.printStackTrace();

		}

	}

	// Returns the contents of the file in a byte array.

	public static byte[] getBytesFromFile(File file) throws IOException {

		InputStream is = new FileInputStream(file);

		// Get the size of the file

		long length = file.length();

		// You cannot create an array using a long type.

		// It needs to be an int type.

		// Before converting to an int type, check

		// to ensure that file is not larger than Integer.MAX_VALUE.

		if (length > Integer.MAX_VALUE) {

			throw new IllegalArgumentException(
					"File is too big, can't support.");

		}

		// Create the byte array to hold the data

		byte[] bytes = new byte[(int) length];

		// Read in the bytes

		int offset = 0;

		int numRead = 0;

		while (offset < bytes.length

		&& (numRead = is.read(bytes, offset, bytes.length - offset)) >= 0) {

			offset += numRead;

		}

		// Ensure all the bytes have been read in

		if (offset < bytes.length) {

			throw new IOException("Could not completely read file "
					+ file.getName());

		}

		// Close the input stream and return bytes

		is.close();

		return bytes;

	}

}