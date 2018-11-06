<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />


<h4>${coname}</h4>
<div style="height: 520px; overflow-y: scroll; " id="chatView">
<c:forEach var="e" items="${chatlog}">
<div class="alert alert-secondary" role="alert" style="padding:3px; margin-bottom:3px;">
${e.nick} : ${e.text}
</div>
</c:forEach>
	
</div>



<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">CHAT</span>
  </div>
  <input type="text" class="form-control" aria-describedby="basic-addon1" id="input">
</div>
<script type="text/javascript">

	$('#chatView').scrollTop($('#chatView')[0].scrollHeight - $('#chatView')[0].clientHeight);

		var cows = new WebSocket("ws://" + location.host + "${path}/chat.do");
		ws.onmessage = function(evt) { //매개변수설정하면
		console.log(evt.data);
		var obj = JSON.parse(evt.data);
		switch(obj.mode) {
		case "company":
			companyHandle(obj);
			break;
		}
	} 
	
	var companyHandle = function(obj) {
		var txt = obj.text;
		var html = "<div class=\"alert alert-secondary\" role=\"alert\" style=\"padding:3px; margin-bottom:3px;\">";
		html += obj.nick + " : "+ obj.text;
		html +="</div>";
		document.getElementById("chatView").innerHTML += html;
		document.getElementById("chatView").scrollTop = 
			document.getElementById("chatView").scrollHeight; 
	}
	
	
	document.getElementById("input").onchange= function() {
		console.log(this.value);
		var msg = {
			"mode":"company",
			"text":this.value,
			"cono": "${cono}"
		};
		cows.send(JSON.stringify(msg));
		this.value="";
	};
	
	
	
	
</script>
