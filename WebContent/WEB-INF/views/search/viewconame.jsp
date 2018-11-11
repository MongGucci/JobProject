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

img {
	height: 140px;
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


	<div id="company">
		<%--  기업정보 상단 div --%>

		<div class="ui grid" style="text-align: center;">
			<div class="four wide column">
				<img src="${pageContext.servletContext.contextPath }${dt.LOGO }">
			</div>
			<div class="eight wide column" style="padding: 50px 0px;">
				<div style="font-size: 17pt; font-weight: bolder;">${dt.CONAME }</div>
				<div style="margin-top: 10px;">
					<a href="${dt.HOMEPAGE }">${dt.HOMEPAGE }</a>
				</div>
			</div>
			<div class="four wide column" align="left" style="padding: 50px 0px;">
				<c:choose>
					<c:when test="${empty comjjim }">
						<button type="button" class="btn" data-toggle="modal" style="background-color: white;"
								id="pickcom" data-target="#comjjimModal"><i class="heart outline icon" style="color: #F14444;"></i><b style="color:#434e6e;">기업찜하기</b></button>

						<a href="${path }/chat/cochat.do?cono=${dt.CONO}">
							<button type="button" class="btn " data-toggle="modal" style="background-color: white;" data-target="#comjjimModal" id="pickcom">
								<i class="building icon" style="color: #434e6e;"></i><b style="color:#434e6e;">기업 채팅</b>
						</button></a>	
						<c:if test="${!empty recommend }">
							<br />
							<div class="ui top pointing red basic label" id="pherror"
								style="font-size: 11pt; margin-left :2px;">이 기업의 채팅방에 참여하고 싶다면 기업을 찜해주세요!</div>
						</c:if>
					</c:when>
					<c:otherwise>
						<div style="font-size: 13pt;">
							<i class="heart icon" style="color: #F14444;"></i>이미 찜한 관심 기업
						</div>
						<a href="${path }/chat/cochat.do?cono=${dt.CONO}">
							<button type="button" class="btn " data-toggle="modal" style="background-color: white;">
								<i class="building icon" style="color: #434e6e;"></i><b style="color:#434e6e;">기업 채팅</b>
						</button></a>	
					</c:otherwise>
				</c:choose>
				<c:if test="${empty userId }">
					<div class="modal fade" id="comjjimModal" tabindex="-1"
						role="dialog" aria-labelledby="exampleModalLabel"
						aria-hidden="true"></div>
				</c:if>
				<c:choose>
					<c:when test="${!empty userId }">
						<script>
				$("#pickcom").on("click", function() {
					var id = "${userId}";
					console.log(id);
					
					var cono = "${dt.CONO}";
					
					var param = {
							"cono" : cono
					};
					$.post("${path}/search/comjjimAjax.do",param).done(
							function(rst){
								console.log(rst);
								if(rst.comjjim) {
									$("#pickcom").attr("disabled", true);
									$("#pickcom").html("이미 등록된 관심 기업")
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
			$("#comjjimModal").html(html);
			</script>
					</c:otherwise>
				</c:choose>



			</div>
		</div>
		<%--  기업정보 상단 div --%>
		<div class="ui grid" align="left"
			style="font-size: 15pt; padding-top: 20px; font-weight: bolder; padding-left: 50px;">
			<div class="eight wide column" style="padding: 20px;">

				<div style="padding-top: 0px;">대표자 : ${dt.CEO }</div>
				<div id="detail">
					매출액 :
					<fmt:formatNumber value="${dt.SALES }" type="number" />
					<small><b>(천만원)</b></small>
				</div>
				<div id="detail">사원수 : ${dt.WORKERS }명</div>
				<div id="detail">기업 형태 : ${dt.COTYPE }</div>

			</div>
			<div class="eight wide column" style="padding: 20px">
				<div style="padding-top: 0px;">업종 : ${dt.INDUSTRY }</div>
				<div id="detail">
					초봉 :
					<fmt:formatNumber value="${dt.FIRST }" type="number" />
					<small><b>(만원)</b></small>
				</div>
				<div id="detail">위치 : ${dt.BIG } ${dt.SMALL }</div>
			</div>


		</div>

		<div class="ui grid" align="left"
			style="font-size: 15pt; padding-top: 20px; font-weight: bolder; padding-left: 50px;">
			<div class="five wide column" style="padding: 20px;">
				<div id="donutchart"></div>
				<div style="clear: both;"></div>

			</div>
			<div class="eleven wide column">
				<div id="agechart" style="width: 90%;"></div>
			</div>


		</div>

		<div align="center" style="margin-top: 30px;">
			<p style="font-size: 15pt; font-weight: bolder;">
				<i class="car icon"></i>회사 위치
			</p>
			<div id="map"  style="height: 300px; width : 80%;"></div>
			<script>
            function initMap() {
               var loc = {lat: ${dt.LAT}, lng: ${dt.LNG}};
               var map = new google.maps.Map(document.getElementById('map'), {
                  zoom : 15, center:loc});
               var marker = new google.maps.Marker({position: loc, map: map});
            };
         </script>
			<script
				src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCD8qI5EvQZevGwG3EIOHuKIPwbi9yS-mc&callback=initMap"></script>

		</div>
		<%---------------------------------------- 채용공고 시작 --------------------------------------------%>
		<div style="margin-top: 30px;">
			<p style="font-size: 15pt; font-weight: bolder;">
				<i class="calendar outline icon"></i>채용공고
			</p>
			
			<c:choose>
			<c:when test="${empty hiring}">
			<p style="font-size: 13pt; font-weight: bolder;"><i class="times icon"></i>등록된 채용공고가 없습니다.</p>
			</c:when>
			
			<c:otherwise>
			<c:forEach var="l" items="${hiring}">
			<div id="hirediv">
					<div class="ui grid">

						<div class="four wide column" id="cnt"
							style="width: 100%; margin-top: 10px;">
							<img id="other" src="${path}${l.LOGO}">
						</div>
						<div class="twelve wide column">

							<div class="ui grid">

								<div class="four wide column"
									onclick="location.href='${path}/recruit/jobpost.do?hino=${l.HINO}'"
									style="padding: 55px 0px; font-size: 15pt; font-weight: bolder;">${l.NAME }</div>
								<div class="eight wide column" style="padding: 50px 0px;">
									<div style="width: 100%; font-size: 13pt;">${l.TITLE}</div>
									<div style="width: 100%">
										<small><fmt:formatDate pattern="yyyy-MM-dd"
												value="${l.STARTDATE}" />&nbsp;-&nbsp;<fmt:formatDate
												pattern="yyyy-MM-dd" value="${l.ENDDATE}" /> </small>
									</div>
								</div>
								<div class="four wide column" align="left"
									style="padding: 55px 0px; font-size: 15pt;">
									<div>
										<a href="${path}/recruit/jobpost.do?hino=${l.HINO}"><i
											class="hand point right outline icon"></i>보러가기</a>
									</div>
								</div>


							</div>
						</div>

					</div>
				</div>
			</c:forEach>
			</c:otherwise>
			</c:choose>
			
				
		</div>

		<%---------------------------------------- 채용공고끝 --------------------------------------------%>
		<div style="margin-top: 30px;">
			<p style="font-size: 15pt; font-weight: bolder;">
				<i class="bullhorn icon"></i>기업후기
			</p>

			<c:choose>
				<c:when test="${empty sessionScope.userId}">
					<h4>reviews</h4>
      이 기업은 평균 <span class="starR on"></span>${avg} 점 입니다! 더 많은 정보를 보고싶다면 <a
						href="${path}/login.do">로그인</a>을 해주세요!
      </c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${empty youwrote}">
							<h4>이 기업에 대한 후기를 남겨주세요!</h4>
							<form action="${path}/recruit/review.do" method="post">
								<input name="cono" value="${dt.CONO }" hidden="" /> <input
									type="hidden" name="star" id="star" value="1" />
								<div class="form-group" align="center" style="font-size: 13pt; font-weight: bolder;">
									<i class="thumbs up outline icon"></i><label >장점</label> <input required
										name="good" type="text" class="form-control" style="width: 70%;"
										id="exampleInputEmail1" aria-describedby="emailHelp"
										placeholder="이 기업에 대한 긍정적인 의견이 있으신가요?">
								</div>
								<div class="form-group" align="center" style="font-size: 13pt; font-weight: bolder;">
									<i class="thumbs down outline icon"></i><label>단점</label> <input required
										name="bad" type="text" class="form-control"
										id="exampleInputPassword1" style="width: 70%;"
										placeholder="이 기업에 대한 부정적인 의견이 있으신가요?">
								</div>
								<div class="form-check">
									<div id="starR" class="starRev">
										<span class="starR on" id="1">별1</span> <span class="starR"
											id="2">별2</span> <span class="starR" id="3">별3</span> <span
											class="starR" id="4">별4</span> <span class="starR" id="5">별5</span>
									</div>
								</div>
								<button type="submit" id="down" 
									style="margin-top: 20px;">등록하기</button>
							</form>
							<script>
               $('.starRev span').click(function() {
                  $(this).parent().children('span').removeClass('on');
                  $(this).addClass('on').prevAll('span').addClass('on');
                  $("#star").val($(this).attr("id"));
                  return false;
               });
            </script>
						</c:when>
						<c:when test="${!empty youwrote}">
               
               이미 이 기업에 대한 후기를 남기셨네요!
               <hr />

							<div style="text-align: left;">
								<c:forEach var="r" items="${reviews}">

									<div class="ui grid">

										<div class="eight wide column" id="cnt"
											style="width: 100%; margin-top: 10px; text-align: center;">
											<c:forEach var="i" begin="1" end="${r.STAR }">
												<i style="font-size: 15pt; color: orange;" class="star icon"></i>
											</c:forEach>
										</div>
										<div class="four wide column">
											<div style="font-size: 13pt; font-weight: bolder;">
												<i class="thumbs up outline icon"></i>장점
											</div>
											<div>${r.GOOD}</div>
										</div>
										<div class="four wide column">
											<div style="font-size: 13pt; font-weight: bolder;">
												<i class="thumbs down outline icon"></i>단점
											</div>
											<div>${r.BAD }</div>
										</div>
									</div>

								</c:forEach>

							</div>
						</c:when>
					</c:choose>

				</c:otherwise>
			</c:choose>
		</div>

	</div>

	<%--                여기서부터 아님 --%>




	<hr />
	
	<script type="text/javascript"
		src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['남/여', '남여 비율'],
          ${result}
        ]);

        var options = {
          title: '관심 기업 등록 남/여 비율',
          pieHole: 0.3,
         
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
        chart.draw(data, options);
      };
    </script>


	<script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawChart);
   
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['','연령'],
          ${agetext}
        ]);
        
        var options = {
          chart: {
            title: '관심 기업 연령',
            
            bar: {groupWidth: "60%"},
            legend: { position: "none" },
          },
          bars: 'horizontal' // Required for Material Bar Charts.
        };

        var chart = new google.charts.Bar(document.getElementById('agechart'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
    </script>






	<p class="mt-5 mb-3 text-muted">&copy; 2018 JOB Go</p>


</div>

