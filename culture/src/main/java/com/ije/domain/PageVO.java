package com.ije.domain;

import lombok.Data;

@Data
public class PageVO {
	private int start, end; 
	private boolean pre, next;
	
	private Criteria cri; 
	private int total; 
	
	
	public PageVO(Criteria cri, int total) {
		this.cri=cri;
		this.total=total; 
		
		this.end = (int) Math.ceil(cri.getPageNum()/10.0)*10;
		this.start = end-9; 
		
		int realEnd = (int) Math.ceil((total*1.0)/cri.getAmount());
		
		if(realEnd < end) {
			this.end=realEnd; 
		}
		
		this.pre = this.start > 1; 
		this.next = this.end < realEnd;
	}
}
