<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div style="width:100%; margin :10px; overflow-y: scroll; boarder=1px solid darkgray;" id="chatView" >
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

	var deptchatws = new WebSocket("ws://"+location.host+"${pageContext.servletContext.contextPath}/chat.do");
	
	chatws.onmessage= function(evt) {
		console.log(evt.data);
		var obj = JSON.parse(evt.data);
		switch(obj.mode) {
		
		case "all":
			allHandle(obj);
			break;
	} 
	
	var allHandle = function(obj) {
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
			"mode":"all",
			"text":this.value		
		};
		chatws.send(JSON.stringify(msg));
		this.value="";
	};
	
	
	
	
</script>