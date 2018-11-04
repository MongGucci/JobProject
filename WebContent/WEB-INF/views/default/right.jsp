<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="accordion" role="tablist">
  <div class="card">
    <div class="card-header" role="tab" id="headingOne" style="background-color: #434e6e;">
      <h5 class="mb-0">
        <a data-toggle="collapse" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
          전체채팅
        </a>
      </h5>
    </div>

    <div  id="collapseOne" class="collapse show" role="tabpanel" aria-labelledby="headingOne" data-parent="#accordion">
      <div class="card-body">
     		<div style="width:100%; margin-left:1px; max-height:300px; overflow-y: scroll; boarder=1px solid darkgray;" id="chatView" >
				<c:forEach var="obj" items="${chathistory}">
				  	<div class="alert alert-secondary" role="alert" style="padding:3px; margin-bottom:3px;">
				  		${obj.nick} : ${obj.text} (${obj.senddate})
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
      </div>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header" role="tab" id="headingOne" style="background-color: #434e6e;">
      <h5 class="mb-0">
        <a data-toggle="collapse" href="#collapseOne" aria-expanded="false" aria-controls="collapseTwo">
          부서채팅
        </a>
      </h5>
    </div>

    <div  id="collapseOne" class="collapse show" role="tabpanel" aria-labelledby="headingOne" data-parent="#accordion">
      <div class="card-body">
     		<div style="width:100%; margin-left:1px; max-height:300px; overflow-y: scroll; boarder=1px solid darkgray;" id="dchatView" >

			</div>
  
     		<div class="input-group mb-3">
			  <div class="input-group-prepend">
			    <span class="input-group-text" id="basic-addon1">CHAT</span>
			  </div>
			  <input type="text" class="form-control" aria-describedby="basic-addon1"
			  	id="input" >
				</div>
      </div>
    </div>
  </div>
 
</div>    
    




<script>

	var chatws = new WebSocket("ws://"+location.host+"${pageContext.servletContext.contextPath}/chat.do");
	
	chatws.onmessage= function(evt) {
		console.log(evt.data);
		var obj = JSON.parse(evt.data);
		switch(obj.mode) {
		
		case "all":
			allHandle(obj);
			break;
		}
	} 
	
	var allHandle = function(obj) {
		var txt = obj.text;
		var html = "<div class=\"alert alert-secondary\" role=\"alert\" style=\"padding:3px; margin-bottom:3px;\">";
		html += obj.nick+" : "+ obj.text;
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

