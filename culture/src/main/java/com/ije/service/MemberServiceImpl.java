package com.ije.service;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ije.domain.AttachVO;
import com.ije.domain.Criteria;
import com.ije.domain.MemberVO;
import com.ije.domain.UnjoinVO;
import com.ije.mapper.AttachMapper;
import com.ije.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	private final MemberMapper mapper; 
	private final AttachMapper attachMapper; 
	private final PasswordEncoder pass; 
	
	@Override
	public void register(MemberVO vo) {
		log.info("회원 등록하기");
		List<MemberVO> ins = new ArrayList<>(); 
		ins.add(vo); 
		mapper.insert(ins);
	}

	@Override
	public MemberVO read(String id) {
		log.info("아이디 체크하기 : "+id);
		return mapper.read(id);
	}

	@Override
	public int modify(MemberVO upt) {
		log.info("회원정보 변경 : "+upt);	
		return mapper.update(upt);
	}

	@Transactional
	@Override
	public void modifyPhoto(MemberVO vo) {
		log.info("사진 번경......................");
		attachMapper.deleteByMno(vo.getMno());
		
		if(vo.getAttachList()!=null && vo.getAttachList().size() >0) {
			vo.getAttachList().forEach(attach ->{
				attach.setCno(0L);
				attach.setBno(0L);
				attach.setMno(vo.getMno());
				attachMapper.insert(vo.getAttachList());
			});
		}
	}

	@Override
	public List<AttachVO> getAttach(Long mno) {
		// TODO Auto-generated method stub
		return attachMapper.findByMno(mno);
	}

	@Override
	public MemberVO read2(Long mno) {
		// TODO Auto-generated method stub
		return mapper.get(mno);
	}

	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return mapper.delete(id);
	}

	@Override
	public void deletePhoto(Long mno) {
		log.info("사진 삭제......................");
		attachMapper.deleteByMno(mno);	
	}

	@Override
	public List<MemberVO> getList(Criteria cri) {
		log.info("멤버회원출력......................");
		return mapper.getList(cri);
	}

	@Override
	public int getCount(Criteria cri) {
		return mapper.getCount(cri);
	}

	@Override
	public MemberVO findById(String name, String email) {
		// TODO Auto-generated method stub
		return mapper.findById(name, email);
	}

	@Override
	public void sendEmail(MemberVO vo) throws Exception {

		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com"; //지메일이용시 smtp.gmail.com
		String hostSMTPid = "관리자메일";
		String hostSMTPpwd = "관리자비밀번호";

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "관리자이메일";
		String fromName = "관리자";
		String subject = "";
		String msg = "";

	
		subject = "문화일기 임시 비밀번호 입니다.";
		msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
		msg += "<h3 style='color: blue;'>";
		msg += vo.getId() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
		msg += "<p>임시 비밀번호 : ";
		msg += vo.getPw() + "</p></div>";
		
		mapper.updatePw(vo.getId(), pass.encode(vo.getPw()));

		// 받는 사람 E-Mail 주소
		String mail = vo.getEmail();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSL(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(587); //지메일 465

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setTLS(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}		
	}

	@Override
	public void findPw(HttpServletResponse resp, MemberVO vo) throws Exception {
		resp.setContentType("text/html;charset=utf-8");
		MemberVO ck = mapper.read(vo.getId()); 
		PrintWriter out = resp.getWriter();
		// 가입된 아이디가 없으면
		if(mapper.read(vo.getId()) == null) {
			out.print("등록되지 않은 아이디입니다.");
			out.close();
		}
		// 가입된 이메일이 아니면
		else if(!vo.getEmail().equals(ck.getEmail())) {
			out.print("등록되지 않은 이메일입니다.");
			out.close();
		}else {
			// 임시 비밀번호 생성
			String pw = "";
			for (int i = 0; i < 12; i++) {
				pw += (char) ((Math.random() * 26) + 97);
			}
			vo.setPw(pw);
			
			// 비밀번호 변경 메일 발송
			sendEmail(vo);

			out.print("이메일로 임시 비밀번호를 발송하였습니다.");
			out.close();
		}
		
	}



}
