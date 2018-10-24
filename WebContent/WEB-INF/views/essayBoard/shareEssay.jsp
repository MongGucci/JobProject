<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essayBoard.css" rel="stylesheet">
<div class="container" style="margin-top: 20px;">
	<div align="right">
		<a class="btn btn-dark" href="${path}/essayBoard/essayBoard.do"
			role="button">게시판 목록</a>
	</div>

	<form action="${path}/essayBoard/shareEssay.do" method="post"
		enctype="multipart/form-data">



		<div class="row">
			<div class="col-10">
				<label for="exampleFormControlInput1">TITLE</label> <input
					type="text" class="form-control" id="exampleFormControlInput1"
					name="title" placeholder="제목">
			</div>

			<div class="col-2">
				<label for="exampleFormControlInput1">직군</label> <select
					class="form-control" name="job" required="required">
					<option>직군</option>
					<c:forEach var="e" items="${list}">
						<option value="${e.CATENAME}">${e.CATENAME}</option>
					</c:forEach>

				</select>
			</div>
		</div>
		<div class="form-group">
			<label for="exampleFormControlInput1">FILE</label> <input type="file"
				name="attach" placeholder="첨부파일">
		</div>
		<div class="form-group">
			<label for="exampleFormControlTextarea1">CONTENT</label>
			<textarea class="form-control" id="exampleFormControlTextarea1"
				name="content" rows="3" placeholder="보내는 내용"></textarea>
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



		<div align="right">
			<button class="btn btn-dark">올리기</button>
		</div>
	</form>
</div>