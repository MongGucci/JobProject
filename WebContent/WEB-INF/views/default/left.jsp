<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<div>
	<div id="alert" style="font-size: .75em; width: 100%;"></div>
	<c:choose>
		<c:when test="${!empty today or !empty three }">
			내가 찜한 기업에 대한 정보입니다.
		</c:when>
		<c:otherwise>
			기업을 찜하면 그 기업의 공고 알림을 제공해드려요!<br/>
			<a href="${path}/search/search.do">원하는 기업을 찜해주세요!</a>
		</c:otherwise>
	</c:choose>
	<c:if test="${!empty today}">
	<div style="font-size: .75em; width: 100%;" >
	
		  <ul class="list-group list-group-flush">
		  <b style="font-size:11pt;">[오늘 마감하는 채용공고]</b>
		  	<c:forEach var="h" items="${today}">
		  		<li class="list-group-item"> <a href="${path}/recruit/jobpost.do?hino=${h.HINO}" > ${h.TITLE} /공고보러가기</a></li>
		  	</c:forEach>
		  </ul>
	</div>
	</c:if>
	<c:if test="${!empty three}">
	<div style="font-size: .75em; width: 100%;" >
	
		  <ul class="list-group list-group-flush">
		  <b style="font-size:11pt;">[3일 남은 채용공고]</b>
		  	<c:forEach var="h" items="${three}">
		  		<li class="list-group-item"> <a href="${path}/recruit/jobpost.do?hino=${h.HINO}" > ${h.TITLE} /공고보러가기</a></li>
		  	</c:forEach>
		  </ul>
	</div>
	</c:if>
</div>
<script type="text/javascript">
	
	var ws = new WebSocket("ws://" + location.host + "${path}/conn.do");
	console.log("안녕");
	ws.onmessage = function(evt) { //매개변수설정하면
		//받은 메세지에 관련된 객체를 넘겨주면서 콜이 일어나고
		console.log(evt.data);
		var obj = JSON.parse(evt.data);

		switch (obj.mode) {
		case "reply":
			replyAlertHandle(obj);
			break;
	
		}
	};

	var replyAlertHandle = function(obj) {

		var html = "<div class=\"alert alert-warning alert-dismissible fade show\" role=\"alert\">";
		html += "<strong>" + obj.msg + "</strong><a href=\"${path}/essayBoard/essayBoardDetail.do?no="+obj.link+">보러가기</a>";
		
		html += "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">";
		html += "<span aria-hidden=\"true\">&times;</span>";
		html += "</button>";
		html += "</div>";

		document.getElementById("alert").innerHTML += html;
	};
	
<<<<<<< HEAD
	
=======
>>>>>>> branch 'master' of https://github.com/MongGucci/JobProject.git
</script>
