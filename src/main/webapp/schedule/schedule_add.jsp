<%@page import="vo.EmployeeVO"%>
<%@page import="vo.ScheduleVO"%>
<%@page import="dao.ScheduleDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	

	Object obj = session.getAttribute("vo");
	int eNumber = 0;

	if(obj != null){
		EmployeeVO vo = (EmployeeVO)obj;
		eNumber = vo.geteNumber();
		
		String contents = request.getParameter("contents");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		out.println("contents : " + contents);
		out.println("start_date : " + start_date);
		out.println("end_date : " + end_date);
		out.println("enumber : " + eNumber);
		ScheduleDAO dao = new ScheduleDAO();
		dao.addSchedule(contents, start_date, end_date, eNumber);
		
	}
%>
