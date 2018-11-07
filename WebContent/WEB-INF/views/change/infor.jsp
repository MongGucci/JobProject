<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
<hr>
		<form class="form-signin"
		action="${pageContext.servletContext.contextPath }/pwchange.do" method="post">
		<%-- 본인 아이디 띄우기 --%>
		<p style="font-size: small;">
			사용자 아이디 ☞ 
			<%=session.getAttribute("userId") %>
		</p>
	
		<br>
		<%-- 찝한 기업  --%>
		<p style="font-size: small;">
			해당 사용자 계정의 찜한 기업.<br/><br>
			<c:forEach var="i" items="${r }">
				<a href="${pageContext.servletContext.contextPath }/recruit/jobpost.do?hino=${i.HINO}">
				 ${i.TITLE  }</a><br>
				
			 </c:forEach>
		</p>
		<br>
		<%-- 내가쓴 기업 후기--%>
		<p style="font-size: small;">
			내가 쓴 후기들  <br/><br>
			<c:forEach var="a" items="${p }">
			GOOD  ☞  ${a.GOOD }<br> BAD  ☞   ${a.BAD }<br><br>
			</c:forEach>
		</p>
		<%--내가 쓴 자소서 --%>
		<p style="font-size: small;">
			내가 쓴자소서  <br/><br>
			<c:forEach var="b" items="${j}">
					${b.TITLE }<br> 
			</c:forEach>
		</p>
		<br>
		<%-- 내가  댓글, --%>
		<p style="font-size: small;">
			내가 쓴 댓글  <br/><br>
			<c:forEach var="c" items="${g }">
				${c.REPLY}<br>
			</c:forEach>
		</p>
		<button class="btn btn-lg btn-warning btn-block" type="submit"  style="width: 300px;">
			비밀번호 변경</button>
			</form>
		<br><br><br>