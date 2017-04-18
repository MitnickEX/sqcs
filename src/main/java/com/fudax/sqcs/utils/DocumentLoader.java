package com.fudax.sqcs.utils;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;

public class DocumentLoader {
	private String charSet = "UTF-8";
	private String fileName;

	/**
	 * @param fileName
	 */
	public DocumentLoader(String fileName) {
		this.fileName = fileName;
	}

	/**
	 * set the java file reading encoding.
	 * 
	 * @param encode
	 */
	public void setReadCharSet(String encode) {
		this.charSet = encode;
	}

	/**
	 * get the java file reading encoding.
	 * 
	 * @return the charset of the java files.
	 */
	public String getReadCharSet() {
		return this.charSet;
	}

	/**
	 * read xml file content.
	 * 
	 * @param fileName
	 * @return the file string text of your xml file.
	 * @throws Exception
	 **/
	public String loadDocument() throws Exception {
		File file = new File(fileName);
		ByteArrayOutputStream buff = new ByteArrayOutputStream();
		InputStream iStream;
		iStream = new FileInputStream(file);

		byte[] bytes = new byte[4096];
		int len = iStream.read(bytes);
		while (len > 0) {
			buff.write(bytes, 0, len);
			len = iStream.read(bytes);
		}
		iStream.close();
		return new String(buff.toByteArray(), charSet);
	}

	/**
	 * load your xml files, parse and return document object.
	 * 
	 * @return the document of your xml file, loaded as domfactory
	 * @throws Exception
	 **/
	public Document loadXMLDocument() {
		if (!new File(fileName).exists()) {
			return null;
		}
		String context = null;
		try {
			context = loadDocument();
			if (context.getBytes().length <= 10) {
				return null;
			}
			DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
			domFactory.setValidating(false);
			// domFactory.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd",
			// false);
			domFactory.setNamespaceAware(true);
			domFactory.setIgnoringElementContentWhitespace(true);
			DocumentBuilder builder = domFactory.newDocumentBuilder();
			return builder.parse(fileName);
		} catch (Exception e) {
			System.err.println("incorrect xml file format : " + fileName);
		}
		return null;
	}
}