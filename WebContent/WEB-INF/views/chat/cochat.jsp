<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />


<hr/>
<div><span style="font-size: x-large; color : #434e6e; font-weight: bolder;">&nbsp;<i class="building icon" style="font-size: x-large; color : #434e6e;"></i>&nbsp; ${coname}</span></div>
<hr/>
<div style="height: 520px; overflow-y: scroll; " id="chatView">
<c:forEach var="e" items="${chatlog}">
<c:choose>

<c:when test="${sessionScope.nick eq e.nick}">
<div class="inline field" align="right" style="margin-bottom: 10px;">
    <div class="ui right pointing red basic label"  style="font-size: 15pt; max-width: 70%;">
     ${e.text}  </div>
    <i class="user icon" style="font-size: 15pt; margin-right: 2px; color: #F14444; " ></i>
  </div>

</c:when>
<c:otherwise>
 <div class="inline field" align="left" style="margin-bottom: 10px;">
 	<i class="user icon" style="font-size: 15pt; margin-left: 2px;"></i>
   <div class="ui left pointing black basic label" style="font-size: 15pt; color :#F4F4F4 ;max-width: 70%;">
      ${e.nick} : ${e.text}
    </div>
   
  </div>
</c:otherwise>
</c:choose>

</c:forEach>
	
</div>



<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1" style="color :#434e6e; font-weight: bolder;">CHAT</span>
  </div>
  <input type="text" class="form-control" aria-describedby="basic-addon1" id="input">
</div>
<script type="text/javascript">

	$('#chatView').scrollTop($('#chatView')[0].scrollHeight - $('#chatView')[0].clientHeight);

		var ws = new WebSocket("ws://" + location.host + "${path}/conn.do");
		console.log("안녕");
		ws.onmessage = function(evt) { //매개변수설정하면
		console.log(evt.data);
		var obj = JSON.parse(evt.data);
		switch(obj.mode) {
		case "com":
			comHandle(obj);
			break;
		}
	} 
	
	var comHandle = function(obj) {
		var txt = obj.text;
		var html ="";
		var mynick = "${sessionScope.nick}";
		console.log(mynick == obj.nick);
		
		if(mynick == obj.nick){
			console.log("ture 라며 ");
			html += "<div class=\"inline field\" align=\"right\" style=\"margin-bottom: 10px;\">";
		    html += "<div class=\"ui right pointing red basic label\" style=\"font-size: 15pt; max-width: 70%; \">";
		     html += obj.text;
		     html+="</div><i class=\"user icon\" style=\"font-size: 15pt; margin-left: 2px; color: #F14444;\"></i></div>"; 
		}else{
			console.log("???");
			html += "<div class=\"inline field\" align=\"left\" style=\"margin-bottom: 10px;\">";
			html += "<i class=\"user icon\" style=\"font-size: 15pt; margin-left: 2px;\"></i>";
		    html += "<div class=\"ui left pointing black basic label\" style=\"font-size: 15pt; max-width: 70%; \">";
		    html += obj.nick +" : "+  obj.text;
		    html += "</div></div>";
		}
		
		document.getElementById("chatView").innerHTML += html;
		document.getElementById("chatView").scrollTop = 
			document.getElementById("chatView").scrollHeight; 
	}
	
	
	document.getElementById("input").onchange= function() {
		console.log(this.value);
		var msg = {
			"mode":"com",
			"text":this.value,
			"cono":"${cono}"
		};
		ws.send(JSON.stringify(msg));
		this.value="";
	};
	
	
	
	
</script>
	