package com.fudax.sqcs.file.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fudax.sqcs.file.dao.FileInfoDAO;
import com.fudax.sqcs.file.service.FileInfoService;
import com.fudax.sqcs.utils.StringBufferUtils;

@Service
public class FileInfoServiceImpl implements FileInfoService {
	@Autowired
	private FileInfoDAO fileInfoDAO;

	public List<LinkedHashMap<String, String>> getAttach(String oper_seq) {
		List<LinkedHashMap<String, String>> attachList = fileInfoDAO.getAttach(oper_seq);
		StringBufferUtils.timeStampFormat(attachList);
		return attachList;
	}

	public int addAttach(LinkedHashMap<String, String> LinkedHashMap) {
		int addAttachCount = fileInfoDAO.addAttach(LinkedHashMap);
		return addAttachCount;
	}

	public int delAttach(String file_id) {
		int delAttachCount = fileInfoDAO.delAttach(file_id);
		return delAttachCount;
	}

	public String getStoreById(String file_id) {
		String storePath = fileInfoDAO.getStoreById(file_id);
		return storePath;
	}

	public String getNameById(String file_id) {
		String fileName = fileInfoDAO.getNameById(file_id);
		return fileName;
	}

}
