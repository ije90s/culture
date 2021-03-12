package com.ije.security;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml","file:src\\main\\webapp\\WEB-INF\\spring\\security-context.xml" })
@Log4j
public class MemberTests {

	@Autowired
	private PasswordEncoder pw; 
	
	@Autowired
	private DataSource ds; 
	
	@Test
	public void testInsertMember() {
		String sql = "insert into tb_member(mno, id, pw, name) values(seq_member.nextval, ?, ?, ?)"; 
		
		for(int i=0;i<100;i++) {
			Connection con = null; 
			PreparedStatement pstmt = null; 
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql); 
				
				pstmt.setString(2, pw.encode("pw"+i));
				
				if(i < 80) {
					pstmt.setString(1, "user"+i);
					pstmt.setString(3, "일반사용자"+i);
				}else if(i<90) {
					pstmt.setString(1, "manager"+i);
					pstmt.setString(3, "운영자"+i);
				}else {
					pstmt.setString(1, "admin"+i);
					pstmt.setString(3, "관리자"+i);
				}
				pstmt.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if(pstmt!=null){ try {pstmt.close();}catch(Exception e) {} }  
				if(con!=null){ try {con.close();}catch(Exception e) {} }  
			}
		}
	}
	
	@Test
	public void testInsertAuth() {
		String sql = "insert into tb_member_auth(auth, mno) values (?,?)"; 
		
		for(int i=101;i<=200;i++) {
			Connection con = null; 
			PreparedStatement ps = null; 
			
			try {
				con = ds.getConnection();
				ps = con.prepareStatement(sql); 
				
				if(i < 181) {
					ps.setString(1, "ROLE_USER");
					ps.setInt(2, i);
				}else if(i < 191) {
					ps.setString(1, "ROLE_MEMBER");
					ps.setInt(2, i);
				}else {
					ps.setString(1, "ROLE_ADMIN");
					ps.setInt(2, i);
				}
				ps.executeUpdate(); 
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				if(ps!=null){ try {ps.close();}catch(Exception e) {} }  
				if(con!=null){ try {con.close();}catch(Exception e) {} }  
			}
		}
	}
}
