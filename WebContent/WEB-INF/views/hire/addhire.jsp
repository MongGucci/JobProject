<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>JOB GO</title>
<div style="text-align: center;">
<h1>채용 정보 공고</h1>
<form action="${pageContext.servletContext.contextPath }/hire/addhire.do" method="post" enctype="multipart/form-data">
		채용 제목 : <input type="text" name = "title" style="width: 200px; height: 28px;" id = "title"><br><br>
		채용 내용 : <input type = "text" name = "content" style="width: 300px; height: 28px;" id = "content"><br><br>
	
		시 작 일 : <input type="date" class="form-control" name = "startdate" style="width: 200px; height: 28px;" id = "start"><br><br>
		마 감 일 : <input type="date" class="form-control" name = "enddate" style="width: 200px; height: 28px;" id = "end"><br><br>
		회사 이름 : <input type="text" name = "name" style="width: 200px; height: 28px;" id = "name"><br><br>
	
		회사 직무 : <select name = "jobcate" id = "jobcate" style="width: 200px; height: 28px;">
					<option value="">선택해주세요</option>
					<c:forEach var = "j" items="${alljob }">
						<option value = "${j.CATENAME }">${j.CATENAME }</option>
					</c:forEach>
				</select><br><Br>
		채용 인원 : <select name = "recruitnum" id = "recruitnum" style="width: 200px; height: 28px;">
					<c:forEach var="m" begin="0" end="50" step="1">
							<option value="${m }">${m }명</option>
					</c:forEach>
				</select><br><br>
		이 메 일 : <input type="text" name = "email" style="width: 200px; height: 28px;" id = "email"><br><br>
		
		채 용 직 : <select name = "hireshape" id = "hireshape" style="width: 200px; height: 28px;">
					<option value="">선택해주세요</option>
					<c:forEach var = "h" items="${allshape }">
						<option value = "${h.SHAPE }">${h.SHAPE }</option>
					</c:forEach>
				</select><br><br>
		채용 정보 : <input type = "file" name ="path"> <br><br>
		<button type="submit">채용 공고 등록</button>
</form>
</div>
