package com.ije.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml","file:src\\main\\webapp\\WEB-INF\\spring\\appServlet\\servlet-context.xml"})
@Log4j
public class CultureContollerTests {

	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc; 
	
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build(); 
	}
	
	@Test
	public void testList() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/culture/list"))
				.andReturn()
				.getModelAndView()
				.getModelMap()
				);
	}
	
	@Test
	public void testGet() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/culture/get")
				.param("cno", "3"))
				.andReturn()
				.getModelAndView().getModelMap()
				);
	}
	
	@Test
	public void testRegister() throws Exception {
		String returnPage = mockMvc.perform(MockMvcRequestBuilders.post("/culture/register")
				.param("cdate", "2021-01-02")
				.param("kind", "2")
				.param("title", "화면단 테스트")
				.param("content", "화면단 테스트")
				.param("rank", "2")
				).andReturn().getModelAndView().getViewName(); 
		log.info(returnPage);
	}
	
	@Test
	public void testModify() throws Exception {
		String returnPage = mockMvc.perform(MockMvcRequestBuilders.post("/culture/modify")
				.param("cno", "3")
				.param("cdate", "2021-01-02")
				.param("kind", "2")
				.param("title", "화면단 테스트")
				.param("content", "화면단 업데이트 테스트")
				.param("rank", "2")
				).andReturn().getModelAndView().getViewName(); 
		log.info(returnPage);
	}
	
	@Test
	public void testRemove() throws Exception {
		String returnPage = mockMvc.perform(MockMvcRequestBuilders.post("/culture/remove")
				.param("cno", "21")
				).andReturn().getModelAndView().getViewName();
		
		log.info(returnPage);
	}
	
	@Test
	public void testPaging() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/culture/list")
				.param("amount", "10")
				.param("pageNum", "3")
				).andReturn().getModelAndView().getModelMap());
	}
}
