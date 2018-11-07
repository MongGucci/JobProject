<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!--  <div class="dropdown show" style="margin-top: 15px;">
  <a class="btn btn-secondary dropdown-toggle"  role="button" id="recentcookie" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    최근 본 채용공고
  </a>
  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink" id ="hilist">
    
  </div>
</div>  -->

<style>

jjim:hover {
	background-color:#434e6e; 
}

</style>
<div id="page" style="margin-top: 20px;" >
	
	<div  style="font-weight: bolder; background-color:#434e6e; color: white;padding: 20px; width:90%">
	전체채팅
	</div>
	
	<div class="list-group" style="width:90%;">
  		 <a href="${path }/chat/allchat.do" class="list-group-item list-group-item-action">전체채팅 <br/><small></small></a>
	</div>
	
	<div  style="font-weight: bolder; background-color:#434e6e; color: white;padding: 20px; width:90%">
	기업채팅
	</div>
	
	<div class="list-group" style="width:90%;">
		<c:forEach var="r" items="${chatrooms}">
  			 <a href="${path }/chat/cochat.do?cono=${r.CONO}" class="list-group-item list-group-item-action">${r.CONAME}</a>
  		</c:forEach>
	</div>

</div>

<script>
$("#location").on(
		"change",
		function() {
			var big = $("#location").val();
			console.log("val:" + big);
			var param = {
				"big" : big
			};
			$.post("${path}/recruit/selectajax.do", param).done(
					function(rst) {
						var html = "";
						for (var i = 0; i < rst.length; i++) {
							html += "<option value=\""+rst[i].SMALL+"\">"
									+ rst[i].SMALL + "</option><br/>";
							//console.log(small[i].SMALL);
						}
						$("#smalls").html(html);
					});
		});
		
/* $("#recentcookie").on(
		"click",
		function() {
			
			$.get("${path}/recruit/recenthireajax.do").done(
					function(rst) {
						var html = "";
						console.log(rst);
						for (var i = 0; i < rst.length; i++) {
							console.log(rst[i].HINO+"/"+rst[i].NAME);
							html+= "<a class=\"dropdown-item\" href=\"${path}/recruit/jobpost.do?hino="+rst[i].HINO+"\">"+rst[i].NAME+"</a>";
							
						}
						$("#hilist").html(html);
					});
		}); 		
		 */
</script>