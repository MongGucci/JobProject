<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    	<style>
    	
    	tr#list:hover {background-color:#FAEBD7;
	
}
    	</style>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essayBoard.css" rel="stylesheet">
<div class="container" style="margin-top: 20px;">


<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">no</th>
      <th scope="col">제목</th>
      <th scope="col">직군</th>
      <th scope="col">좋아요</th>
      <th scope="col">작성날짜</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach var="e" items="${essays}">
    <tr id="list" onclick="location.href='${path}/essayBoard/essayBoardDetail.do?no=${e.NO}'" >
      <th>${e.NO}</th>
      <td>${e.TITLE}</td>
      <td>${e.CATE}</td>
      <td>${e.HITS}</td>
      <td>${e.WRITEDATE}</td>
    </tr>
    </c:forEach>
  </tbody>
</table>

<div align="right">
<a href="${path}/essayBoard/shareEssay.do"><button class="btn btn-outline-dark">내꺼 공유하기</button></a>
</div>
</div>
