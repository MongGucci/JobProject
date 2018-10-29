<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essay.css" rel="stylesheet">
<div class="container" style="margin-top: 20px;">
	<h1>자기소개서 수정</h1>
	<form action="${path}/essay/essayChange.do" method="post">
		<input type="hidden" name="no" value="${myEssay.JASONO}">
		<div class="row">
			<div class="col-10">
				<textarea class="form-control" rows="1" name="title"
					placeholder="제목을 입력해주세요">${myEssay.TITLE}</textarea>
			</div>

			<div class="col-2">
				<select class="form-control" name="job">
					<option>직군</option>
					<c:forEach var="e" items="${list}">
						<option value="${e.CATENAME}">${e.CATENAME}</option>
					</c:forEach>

				</select>
			</div>
		</div>
		<div class="form-group">
			<label><span id="question">Q1.</span></label>
			<textarea class="form-control" id="exampleFormControlTextarea1"
				rows="1" name="Q1" placeholder="질문을 입력해주세요">${myEssay.Q1}</textarea>
		</div>
		<div class="form-group">

			<textarea class="form-control" id="exampleFormControlTextarea1"
				rows="5" name="A1">${myEssay.A1}</textarea>
		</div>
		<div class="form-group">
			<label><span id="question">Q2.</span></label>
			<textarea class="form-control" id="exampleFormControlTextarea1"
				rows="1" name="Q2" placeholder="질문을 입력해주세요">${myEssay.Q2}</textarea>
		</div>
		<div class="form-group">

			<textarea class="form-control" id="exampleFormControlTextarea1"
				rows="5" name="A2">${myEssay.A2}</textarea>
		</div>
		<div class="form-group">
			<label><span id="question">Q3.</span></label>
			<textarea class="form-control" id="exampleFormControlTextarea1"
				rows="1" name="Q3" placeholder="질문을 입력해주세요">${myEssay.Q3}</textarea>
		</div>
		<div class="form-group">

			<textarea class="form-control" id="exampleFormControlTextarea1"
				rows="5" name="A3">${myEssay.A3}</textarea>
		</div>
		<div class="form-group">
			<label><span id="question">Q4.</span></label>
			<textarea class="form-control" id="exampleFormControlTextarea1"
				rows="1" name="Q4" placeholder="질문을 입력해주세요">${myEssay.Q4}</textarea>
		</div>
		<div class="form-group">

			<textarea class="form-control" id="exampleFormControlTextarea1"
				rows="5" name="A4">${myEssay.A4}</textarea>
		</div>
		<div align="right">
			<h6>마지막 수정일 : ${myEssay.LASTDATE}</h6>
		</div>
		<div id="button" align="right">
			<button type="submit" class="btn btn-dark btn-lg">수정하기</button>
		</div>
	</form>
</div>