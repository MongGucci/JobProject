<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<link href="${path}/css/default.css" rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/css/tableboder.css">

<style type="text/css">
.line {
	border-bottom: 1px solid black;
}
</style>
<style>
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
#map {
	height: 100%;
}
/* Optional: Makes the sample page fill the window. */
#down {
	background-color: rgba(0, 0, 0, 0);
	border: 1px solid #434e6e;
	color: #434e6e;
	padding: 10px;
	font-size: 10pt;
	border-radius: 5%;
}

#down:hover {
	background-color: #434e6e;
	color: white;
	padding: 10px;
	font-size: 10pt;
	border-radius: 5%;
}
html, body {
color:#434e6e;
	height: 70%;
	margin: 0;
	padding: 0;
}

#company {
	border: 1px solid #434e6e;
	
	margin: 20px;
	background-color: white;
	padding: 10px;
	font-family: 'Nanum Gothic', sans-serif;
}


#detail {
	margin-top: 5px;
}

#other {
	height: 100px;
}
</style>

<hr />
<div class="container" style="margin-top: 20px; text-align: center;">


	<div id="company" style=" margin-botton :50px;">
		<%--  기업정보 상단 div --%>

		<div class="ui grid" style="text-align: center;" >
			<div class="four wide column">
				<img src="${pageContext.servletContext.contextPath }${list.LOGO }">
			</div>
			<div class="eight wide column" style="padding: 50px 0px;">
				<div style="font-size: 17pt; font-weight: bolder;"><a 
					href="${path}/search/schdetail.do?cono=${list.CONO}">${list.CONAME }</a></div>
				<div style="margin-top: 10px;">
					<a href="${list.HOMEPAGE }">${list.HOMEPAGE }</a>
				</div>
				<div><i class="eye icon" style="color:#707374;">${list.HITS}</i></div>
			</div>
			<div class="four wide column" align="left" style="padding: 50px 0px;">
			
					<c:choose>
						
						<c:when test="${empty jjim }">
							<button type="button" class="btn" data-toggle="modal" style="background-color: white;"
								id="pickhire" data-target="#jjimModal"><i class="heart outline icon" style="color: #F14444;"></i><b style="color:#434e6e;">공고찜하기</b></button>
							<a href="${path }/chat/cochat.do?cono=${list.CONO}">
							<button type="button" class="btn " data-toggle="modal" style="background-color: white;">
								<i class="building icon" style="color: #434e6e;"></i><b style="color:#434e6e;">기업 채팅</b>
							</button></a>				
						</c:when>
						
						<c:otherwise>
							<button type="button" class="btn" data-toggle="modal" style="background-color: white;"
								id="pickhire" data-target="#jjimModal" disabled="disabled"><i class="heart outline icon" style="color: #F14444;"></i><b style="color:#434e6e;">공고 찜 완료</b></button>
							<%-- <a class="btn btn-outline-secondary"
								href="${pageContext.servletContext.contextPath}/recruit/select.do">다시검색하기</a> --%>
							<a href="${path }/chat/cochat.do?cono=${list.CONO}">
							<button type="button" class="btn " data-toggle="modal" style="background-color: white;">
								<i class="building icon" style="color: #434e6e;"></i><b style="color:#434e6e;">기업 채팅</b>
							</button></a>	
						</c:otherwise>
					
					</c:choose>
			
				
				<c:if test="${empty userId }">
					<div class="modal fade" id="jjimModal" tabindex="-1" role="dialog"
						aria-labelledby="exampleModalLabel" aria-hidden="true"></div>
				</c:if>
				<c:choose>
					<c:when test="${!empty userId }">
						<script>
			               $("#pickhire").on("click", function() {
			                  var id = "${userId}";
			                  console.log(id);
			                  
			                  var hino = "${list.HINO}";
			                  
			                  var param = {
			                        "hino" : hino
			                  };
			                  $.post("${path}/recruit/hirejjimAjax.do",param).done(
			                        function(rst) {
			                           console.log(param);
			                           console.log(rst);
			                           if(rst.jjim) {
			                              $("#pickhire").attr("disabled", true);
			                              $("#pickhire").html("공고 찜 완료")
			                           }
			                        });
			               })
			            </script>
					</c:when>
					<c:otherwise>
						<script>
			            var html = "";
			            html = "<div class=\"modal-dialog\" role=\"document\" style=\"text-align: left\">"
			                  + "<div class=\"modal-content\"><div class=\"modal-header\">"
			                  + "<h5 class=\"modal-title\" id=\"exampleModalLabel\">JOB GO</h5>"
			                  + "<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">"
			                  + "<span aria-hidden=\"true\">&times;</span></button></div><div class=\"modal-body\">로그인을 원츄</div>"
			                  + "<div class=\"modal-footer\"><button type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\">Close</button>"
			                  + "<a href=\"${path}/login.do\"><button type=\"button\" class=\"btn btn-primary\">로그인 하러가기</button></a></div></div></div>";
			            $("#jjimModal").html(html);
			         </script>
			
					</c:otherwise>
				</c:choose>


			</div>
		</div>
		

		
		<%---------------------------------------- 채용공고 시작 --------------------------------------------%>
		<div style="margin-top: 30px;">
			<p style="font-size: 15pt; font-weight: bolder;">
				<i class="calendar outline icon"></i>채용공고
			</p>
			<div style="margin-bottom: 20px;"> ${list.CONTENT} </div>
			
			
			<div style="line-height: 100px; text-align: center">
				<img src="${list.PATH}"
					style="width: 100%; max-width: 760px; vertical-align: middle" />
			</div>
				
		</div>

	

	<%--  기업정보 상단 div --%>
		<div class="ui grid" align="left"
			style="font-size: 15pt; padding-top: 20px; font-weight: bolder; padding-left: 50px; padding-right: 50px;">
			<div class="eight wide column" style="padding: 20px; ">

				<div style="padding-top: 0px;">채용 기간 : ${list.START } - ${list.END}
					<c:if test="${!empty list.MAGAM}">[마감]</c:if>
				</div>
				<div id="detail">
					공고 찜 : ${list.FAVORITE}명 
				</div>
				<div id="detail">사원수 : ${list.WORKERS }명</div>
				<div id="detail">기업 형태 : ${list.COTYPE }</div>

			</div>
			<div class="eight wide column" style="padding: 20px">
				<div style="padding-top: 0px;">업종 : ${list.INDUSTRY }</div>
				<div id="detail">
					초봉 :
					<fmt:formatNumber value="${list.FIRST }" type="number" />
					<small><b>(만원)</b></small>
				</div>
				<div id="detail">위치 : ${list.BIG } ${list.SMALL }</div>
				
			</div>
			<div id="detail" style="padding: 20px">이 기업은 평균 <span class="starR on"></span>${avg}점입니다.</div>

		</div>

		<div align="center" style="margin-top: 30px;">
			<p style="font-size: 15pt; font-weight: bolder;">
				<i class="car icon"></i>회사 위치
			</p>
			<div id="map"  style="height: 300px; width : 80%;"></div>
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

	<p class="mt-5 mb-3 text-muted">&copy; 2018 JOB Go</p>


</div>

