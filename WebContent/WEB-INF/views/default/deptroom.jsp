<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div
	class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h2">GROUPWARE</h1>
	<div class="btn-toolbar mb-2 mb-md-0">
		<div class="btn-group mr-2">
			<button class="btn btn-sm btn-outline-secondary">${sessionScope.user.NAME }</button>
			<button class="btn btn-sm btn-outline-secondary">${sessionScope.user.DNAME }
				${sessionScope.user.PNAME }</button>
		</div>
		<button class="btn btn-sm btn-outline-secondary dropdown-toggle">
			<span data-feather="calendar"></span> ${sessionScope.userId }
		</button>
	</div>
</div>

<h4>Chat Room <small></small></h4>
<div style="height: 520px; overflow-y: scroll; " id="chatView">
	
</div>
<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">CHAT</span>
  </div>
  <input type="text" class="form-control" aria-describedby="basic-addon1"
  	id="input" >
</div>
<script>
	var deptchatws = new WebSocket("ws://"+location.host+"${pageContext.servletContext.contextPath}/deptchat.do");
	
	chatws.onmessage= function(evt) {
		console.log(evt.data);
		var obj = JSON.parse(evt.data);
		switch(obj.mode) {
		
		case "dept":
			deptHandle(obj);
			break;
		
		}
		
	} 
	
	var deptHandle = function(obj) {
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
			"mode":"dept",
			"text":this.value		
		};
		chatws.send(JSON.stringify(msg));
		this.value="";
	};
	
	
	
	
</script>



