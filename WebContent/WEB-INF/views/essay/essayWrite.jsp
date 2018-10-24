<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essay.css" rel="stylesheet">
<h1>자기소개서 만들기</h1>
<form action="${path}/essay/essayWrite.do" method="post">
	<div class="row">
		<div class="col-10">
			<textarea class="form-control" rows="1" name="title"
				placeholder="제목을 입력해주세요"></textarea>
		</div>

		<div class="col-2">
    <select class="form-control" name="job">
      <option>직군</option>
      <c:forEach var="e" items="${list}">
       <option value="${e.CATEGORY}">${e.CATEGORY}</option>
      </c:forEach>
      
    </select></div>
	</div>
	<div class="form-group">
		<label><span id="question">Q1.</span></label>
		<textarea class="form-control" id="exampleFormControlTextarea1"
			rows="1" name="Q1" placeholder="질문을 입력해주세요"></textarea>
	</div>
	<div class="form-group">

		<textarea class="form-control" id="exampleFormControlTextarea1"
			rows="5" name="A1"></textarea>
	</div>
	<div class="form-group">
		<label><span id="question">Q2.</span></label>
		<textarea class="form-control" id="exampleFormControlTextarea1"
			rows="1" name="Q2" placeholder="질문을 입력해주세요"></textarea>
	</div>
	<div class="form-group">

		<textarea class="form-control" id="exampleFormControlTextarea1"
			rows="5" name="A2"></textarea>
	</div>
	<div class="form-group">
		<label><span id="question">Q3.</span></label>
		<textarea class="form-control" id="exampleFormControlTextarea1"
			rows="1" name="Q3" placeholder="질문을 입력해주세요"></textarea>
	</div>
	<div class="form-group">

		<textarea class="form-control" id="exampleFormControlTextarea1"
			rows="5" name="A3"></textarea>
	</div>
	<div class="form-group">
		<label><span id="question">Q4.</span></label>
		<textarea class="form-control" id="exampleFormControlTextarea1"
			rows="1" name="Q4" placeholder="질문을 입력해주세요"></textarea>
	</div>
	<div class="form-group">

		<textarea class="form-control" id="exampleFormControlTextarea1"
			rows="5" name="A4"></textarea>
	</div>
	<div id="button" align="right">
		<button type="submit" class="btn btn-dark btn-lg">저장하기</button>
	</div>
</form>



