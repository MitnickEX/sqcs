package com.fudax.sqcs.utils;

import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;

public class ReadProperties {
	private File config;

	/**
	 * @param filePath
	 */
	public ReadProperties(String filePath) {
		if (filePath == null) {
			throw new RuntimeException("the config file path can not be null!");
		}
		this.config = new File(filePath);
		if (!this.config.exists()) {
			throw new RuntimeException("the config file does not exist!");
		}
	}

	/**
	 * @param key
	 * @return
	 */
	public String readValue(String key) {
		Properties properties = new Properties();
		try {
			properties.load(new FileInputStream(config));
			if (properties.containsKey(key)) {
				return properties.getProperty(key);
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}
