package com.ije.domain;

import lombok.Data;

@Data
public class AttachFileVO {
	private String uuid; 
	private String fileName; 
	private boolean fileType; 
	private Long gno;
	private String path;
}
