package com.ije.handler;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.ije.mapper.MessageMapper;

import lombok.extern.log4j.Log4j;

public class EchoHandler extends TextWebSocketHandler {

	@Autowired
	private MessageMapper mapper;
	
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>(); 
	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessions.add(session);
		session.sendMessage(new TextMessage("chkMsg : "+mapper.getCountByTarget(session.getPrincipal().getName())));
		System.out.println("연결됨 : "+session.getPrincipal().getName());
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessions.remove(session); 
		System.out.println("끊김 : "+session.getPrincipal().getName());
	}	
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("받음"+message); 
		for(WebSocketSession sess : sessions) {
			sess.sendMessage(new TextMessage(session.getId()+":"+message.getPayload()));	
		}
	}
}
