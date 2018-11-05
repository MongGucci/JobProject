<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 <div class="dropdown show" style="margin-top: 15px;">
  <a class="btn btn-secondary dropdown-toggle"  href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    최근 본 채용공고
  </a>

  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
    <a class="dropdown-item" href="#">Action</a>
    <a class="dropdown-item" href="#">Another action</a>
    <a class="dropdown-item" href="#">Something else here</a>
  </div>
</div> 

<div id="page">
	<hr/>
	<span style="font-weight: bolder;">전체채팅</span>
	<hr/>
	<div class="list-group" style="width:90%;">
  		 <a href="${path }/recruit/enterchat.do" class="list-group-item list-group-item-action">전체채팅</a>
	</div>
	<hr/>
	<span style="font-weight: bolder;">내가 찜한 기업채팅</span>
	<hr/>
	<div class="list-group" style="width:90%;">
		<c:forEach var="r" items="${chatrooms}">
  			 <a href="${path }/recruit/enterchat.do" class="list-group-item list-group-item-action">${r.CONAME}</a>
  		</c:forEach>
	</div>

</div>



