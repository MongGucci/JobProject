<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essayBoard.css" rel="stylesheet">
<!-- <link href="${path}/css/essayBoard.css" rel="stylesheet"> -->

<div class="container" style="margin-top: 20px;">

	<form action="${path}/recruit/selectdetail.do" method="post">
		
		<div class="row">
			<div class="col">
				<select class="form-control" name="cate" required="required">
					<option>직군</option>
					<c:forEach var="e" items="${cate}">
								<option value="${e.CATENAME}">${e.CATENAME}</option>
						</c:forEach>
				</select>
			</div>
			
			<div class="col">
				<!-- <select class="form-control" name="big" onchange="getSmall(this.value);" required="required"> -->
				<select class="form-control" name="big" id="location" required="required">
					<option>지역(대)</option>
					<c:forEach var="e" items="${big}">
							<option value="${e.BIG}">${e.BIG}</option>
						</c:forEach>
				</select>
			</div>
			<div class="col">
			
				<select class="form-control" name="small" required="required" id="smalls">
					<option>지역(소)</option>
					<option value="${e.SMALL}">${e.SMALL}</option>
				</select>
			</div>
			<div class="col">
				<select class="form-control" name="cotype" required="required">
					<option>기업형태</option>
					<c:forEach var="e" items="${cotype}">
							<option value="${e.COTYPE}">${e.COTYPE}</option>
						</c:forEach>
				</select>
			</div>
			<div class="col">
				<select class="form-control" name="hireshape" required="required">
					<option>고용형태</option>
					<c:forEach var="e" items="${hireshape}">
							<option value="${e.SHAPE}">${e.SHAPE}</option>
						</c:forEach>
				</select>
			</div>
			
			
		</div>
		<hr/>
		
		<div align="right">
			<button type="submit" class="btn btn-dark">G O</button>
		</div>
		
	</form>

</div>

<script>
			/* var getSmall = function(big){
				var xhr = new XMLHttpRequest();
				console.log("big :" +big);
				
				xhr.open("post", "${path}/recruit/selectajax.do", true);
				xhr.onreadystatechange = function(){
					if(this.readyState==4) {
						
						var small =JSON.parse(this.responseText.trim());
						
						for(var i=0;i<small.length;i++){
							document.getElementById("smalls").innerHTML +=
							 "<option value=\""+small[i].SMALL+"\">"+small[i].SMALL+"</option><br/>";
							 console.log(small[i].SMALL);
	
						}
					}
				};
				var param = big;

				xhr.send(param);
				
			}; */
			$("#location").on("change",function(){
				var big = $("#location").val();
				console.log("val:"+big);
				var param = {
						"big":big
				};
				$.post("${path}/recruit/selectajax.do",param).done(function(rst){
					var html="";
					for(var i=0;i<rst.length;i++){
						html+=
						 "<option value=\""+rst[i].SMALL+"\">"+rst[i].SMALL+"</option><br/>";
						 //console.log(small[i].SMALL);
					}
					$("#smalls").html(html);
					
				});
			});
			
			
</script>




