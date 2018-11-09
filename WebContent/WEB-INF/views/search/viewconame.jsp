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
html, body {
   height: 70%;
   margin: 0;
   padding: 0;
}
</style>
<img alt="" src="${pageContext.servletContext.contextPath }${dt.LOGO }"
      style="float: center;">
<hr />
<div class="container" style="margin-top: 20px; text-align: center;">
   <h3>${dt.CONAME }</h3>
   <small>가족친화</small> <br> <a href="${dt.HOMEPAGE }">${dt.HOMEPAGE }</a>
   <br> <br>
	<!-- 여기다가 -->
	<c:choose>
		<c:when test="${empty comjjim }">
			 <button class="alert alert-warning" style="height: 50px;" id="btn" data-toggle="modal"
			 data-target="#comjjimModal">+ 관심 기업등록</button> 
			 <button  class="alert alert-warning" style="height: 50px;" id="btn" data-toggle="modal"
			 data-target="#comjjimModal">기업 채팅 참여하기</button> 
			 <c:if test="${!empty recommend }">
			 <br/><div class="ui top pointing red basic label" id="pherror"
								style=" font-size: 11pt;">이 기업의 채팅방에 참여하고 싶다면 기업을 찜해주세요!</div></c:if>
		</c:when>
		<c:otherwise>
			  <button class="alert alert-secondary" style="height: 50px;" id="btn" data-toggle="modal"
               data-target="#comjjimModal" disabled="disabled" >이미 등록된 관심 기업</button>
		</c:otherwise>
	</c:choose>
	<c:if test="${empty userId }">
		<div class="modal fade" id="comjjimModal" tabindex="-1" role="dialog"
				aria-labelledby="exampleModalLabel" aria-hidden="true"></div>
	</c:if>
	<c:choose>
		<c:when test="${!empty userId }">
			<script>
				$("#btn").on("click", function() {
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
									$("#btn").attr("disabled", true);
									$("#btn").html("이미 등록된 관심 기업")
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
	<hr />
		관심 기업 등록<br> <b style="font-size: 20pt; color: blue;">${saram.CNT }</b>명
   <hr />
   <br>
	 <table style = "margin : auto; width: 50%; text-align: left; float: left; border-right:1px black solid;">
	 <tr>
		 <td >대표자 : ${dt.CEO }</td>
	 	 <td>기업 형태 : ${dt.COTYPE }</td>
	</tr>
	<tr>
		 <td>매출액 : ${dt.SALES }천만원</td>
		 <td>사원수 : ${dt.WORKERS }명</td>
	</tr>
	<tr>
		<td>업종 : ${dt.INDUSTRY }</td>
		<td>초봉 : ${dt.FIRST }만원</td>
	</tr>
	<tr>
		<td>위치 : ${dt.BIG } ${dt.SMALL }</td>
		<td></td>
	</tr>
	</table>
	<div id="donutchart" style="width: 350px; height: 100px; float: right;"></div>
	<div style="clear: both;"></div>
	<hr>
	<div id="agechart" style="width: 785px; height: 250px;"></div>
   <hr />
  <div id="map" style="height: 400px"></div>
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
 
   <div>
      <hr/>
      <h4> 이 기업의 진행중인 채용공고</h4>
      <c:forEach var="h" items="${hiring}">
         <br/>${h.CONAME} - ${h.TITLE }  (<fmt:formatDate pattern="yyyy-MM-dd" 
         value="${h.STARTDATE}" />-<fmt:formatDate pattern="yyyy-MM-dd" 
         value="${h.ENDDATE}" />) <a href="${path}/recruit/jobpost.do?hino=${h.HINO}">보러 가기</a>
      </c:forEach>   



   </div>


   <hr />
   <div>

      <c:choose>
      <c:when test="${empty sessionScope.userId}">
      <h4>reviews</h4>
      이 기업은 평균 <span class="starR on"></span>${avg} 점 입니다! 더 많은 정보를 보고싶다면 <a href="${path}/login.do">로그인</a>을 해주세요!
      </c:when>
      <c:otherwise>
         <c:choose>
            <c:when test="${empty youwrote}">
               <h4>이 기업에 대한 후기를 남겨주세요!</h4>
            <form action="${path}/recruit/review.do" method="post">
               <input name="cono" value="${dt.CONO }" hidden=""/>
               <input type="hidden" name="star" id="star" value="1" />
               <div class="form-group">
                  <label for="exampleInputEmail1">좋은점</label> <input required
                     name="good" type="text" class="form-control"
                     id="exampleInputEmail1" aria-describedby="emailHelp"
                     placeholder="이 기업에 대한 긍정적인 의견이 있으신가요?">
               </div>
               <div class="form-group">
                  <label for="exampleInputPassword1">안좋은점</label> <input required
                     name="bad" type="text" class="form-control"
                     id="exampleInputPassword1" placeholder="이 기업에 대한 부정적인 의견이 있으신가요?">
               </div>
               <div class="form-check">
                  <div id="starR" class="starRev">
                     <span class="starR on" id="1">별1</span> <span class="starR"
                        id="2">별2</span> <span class="starR" id="3">별3</span> <span
                        class="starR" id="4">별4</span> <span class="starR" id="5">별5</span>
                  </div>
               </div>
               <button type="submit" class="btn btn-primary"
                  style="margin-top: 20px;">Submit</button>
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
               <hr/>
               
               <div style = "text-align: left;">
               <c:forEach var="r" items="${reviews}">
		<c:forEach var ="i" begin="1" end="${r.STAR }"><i style="font-size: 15pt; color: orange;"class="star icon"></i></c:forEach><br>
        <span style="color: blue;">장점</span> : ${r.GOOD} <br/>
        <span style="color: red;">단점 </span>: ${r.BAD }<br/>
                 <hr/>
                </c:forEach>
            
               </div>
            
            </c:when>
         </c:choose>
      
      </c:otherwise>
      </c:choose>
   </div>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      console.log(${result});
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
      console.log(${agetext});
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['','연령'],
          ${agetext}
        ]);
        
        var options = {
          chart: {
            title: '관심 기업 연령',
            width: 600,
            height: 400,
            bar: {groupWidth: "95%"},
            legend: { position: "none" },
          },
          bars: 'horizontal' // Required for Material Bar Charts.
        };

        var chart = new google.charts.Bar(document.getElementById('agechart'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
    </script>
    





   <p class="mt-5 mb-3 text-muted">&copy; 2018 JOB'A CORP</p>
  

</div>

