<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<h4>전체채팅방</h4>
<div style="height: 520px; overflow-y: scroll; " id="chatView">
	 <c:forEach var="obj" items="${chathistory}">
  
  	<div class="alert alert-secondary" role="alert" style="padding:3px; margin-bottom:3px;">
  		${obj.id} : ${obj.text}
  	</div>
  </c:forEach>
</div>
<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">CHAT</span>
  </div>
  <input type="text" class="form-control" aria-describedby="basic-addon1"
  	id="input" >
</div>
<script>
	var chatws = new WebSocket("ws://"+location.host+"${pageContext.servletContext.contextPath}/chat.do");
	
	chatws.onmessage= function(evt) {
		console.log(evt.data);
		var obj = JSON.parse(evt.data);
		switch(obj.mode) {
		case "public":
			publicHandle(obj);
			break;
		}
	} 
	
	var publicHandle = function(obj) {
		var txt = obj.text;
		var html = "<div class=\"alert alert-secondary\" role=\"alert\" style=\"padding:3px; margin-bottom:3px;\">";
		html += obj.talker+" : "+ obj.text;
		html +="</div>";
		document.getElementById("chatView").innerHTML += html;
		document.getElementById("chatView").scrollTop +=  document.getElementById("chatView").scrollHeight; 
	}
 	
	
	document.getElementById("input").onchange= function() {
		console.log(this.value);
		var msg = {
			"mode":"public",
			"text":this.value		
		};
		chatws.send(JSON.stringify(msg));
		this.value="";
	};
	
</script>