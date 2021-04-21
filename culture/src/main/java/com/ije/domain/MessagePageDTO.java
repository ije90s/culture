package com.ije.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@Getter
@AllArgsConstructor
public class MessagePageDTO {
	private int msgCnt; 
	private List<MessageVO> list; 
}
