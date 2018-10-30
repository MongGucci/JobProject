<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta name="viewport" content="initial-scale=1.0">
<style>
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
#map {
	height: 100%;
}
/* Optional: Makes the sample page fill the window. */
html, body {
	height: 70%;
	margin: 0;
	padding: 0;
}
</style>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<div class="container" style="margin-top: 20px;">

	<div class="card" style="width:100%;">
		<div class="card-header">
			<h2 align="center">${list.CONAME}</h2>
			 <div align="right">
			 	<a class="btn btn-outline-secondary" href="${path}/search/schdetail.do?cono=${list.CONO}" role="button">기업보러가기</a>
			 </div>
		</div>
		<div class="card-body">
			<h5 class="card-title"><c:if test="${!empty list.MAGAM}">[마감]</c:if>${list.TITLE}</h5>
			<p class="card-text">${list.CONTENT}</p>
			<div
				style="line-height: 100px; text-align: center">
				<img src="/JobProject/${list.PATH}" style="width: 100%; max-width: 760px; vertical-align: middle" />
			</div>
			<hr/>
			<div>
				- 채용 기간 : ${list.START } - ${list.END} <c:if test="${!empty list.MAGAM}">[마감]</c:if><br /> 
				- 관심 기업으로 ${list.FAVORITE}명 이상이 찜한 선망받는 기업<br /> 
				- ${list.COTYPE}<br />
			</div>
			
			<div id="map" style="height: 600px"></div>
			<script>
				function initMap() {
					var loc = {lat: ${list.LAT}, lng: ${list.LNG}};
					var map = new google.maps.Map(document.getElementById('map'), {
						zoom : 15, center:loc});
					var marker = new google.maps.Marker({position: loc, map: map});
				};
			</script>
			<script
				src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCD8qI5EvQZevGwG3EIOHuKIPwbi9yS-mc&callback=initMap"></script>
		</div>

	</div>
	<hr />
	<div align="right">
		<a tabindex="0" class="btn btn-danger" role="button" data-toggle="popover" 
		data-trigger="focus" title="Dismissible popover" data-content="내가 찜한 공고에 등록되었습니다!" id="pickhire">공고찜하기</a> 
		<a class="btn btn-outline-secondary" href="${path}/recruit/select.do">다시검색하기</a>
	</div>
	
	<script>
	$("#pickhire").on(
			"click",
			function() {
				
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
	
	</script>







</div>

