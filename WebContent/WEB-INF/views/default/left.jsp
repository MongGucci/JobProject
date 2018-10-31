<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<div>
	<div id="alert" style="font-size: .75em; width: 100%;"></div>
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
		case "deadline3":
			deadline3AlertHandle(obj);
			break;
		case "submittoday":
			submittodayAlertHandle(obj);
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
	}
	
	
</script>
