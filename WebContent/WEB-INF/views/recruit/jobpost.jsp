<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essayBoard.css" rel="stylesheet">

<div class="container" style="margin-top: 20px;">
	
	<div class="card">
	  <div class="card-header">
	 	<h2 align="center">${list.CONAME}</h2>
	  </div>
	  <div class="card-body">
	    <h5 class="card-title">${list.TITLE}</h5>
	    <p class="card-text">${list.CONTENT} </p>
		<div style="width: 100%; height: 100px; line-height: 100px; text-align: center">
	    	<%-- <img src="/storage/hire/${list.PATH}" style="width: 100%; max-width: 760px; vertical-align: middle" /> --%>
		</div>
	   	<div>
	   		- 채용 기간 : ${list.STARTDATE } - ${list.ENDDATE}<br/>
	   		- 관심 기업으로 ${list.FAVORITE}명 이상이 찜한 선망받는 기업<br/>
	   		- ${list.COTYPE}<br/>
	   	</div>
	  </div>
	  
	</div>
	<hr/>
	<div align="right">
		<a tabindex="0" class="btn btn-lg btn-danger" role="button" data-toggle="popover" data-trigger="focus" title="Dismissible popover" data-content="내가 찜한 공고에 등록되었습니다!">공고 찜하기</a>
		<a class="btn btn-outline-secondary" href="${path}/recruit/select.do">다시검색하기</a>
	</div>
	
</div>


<script>
	$('.popover-dismiss').on('click',function(){
		  var no = ${list.HINO};
		  console.log("no:"+no);
	  });
	//true, false로 응답함
</script>