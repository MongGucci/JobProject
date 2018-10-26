<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essay.css" rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/css/tableboder.css">
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
<style type="text/css">
.line {
	border-bottom: 1px solid black;
}
</style>
<hr />
<body style="text-align: center;">
	<img alt="" src="${pageContext.servletContext.contextPath }${dt.LOGO }"
		style="float: left;">???재민아 여기에 뭐쓸라구?
	<h3>${dt.CONAME }</h3>
	<small>가족친화</small>
	<br>
	<a href="${dt.HOMEPAGE }">${dt.HOMEPAGE }</a>
	<br>
	<br>
	<c:if test = "${!empty ok }">
		<script>
			alert("관심 기업으로 등록되었습니다.");
		</script>
	</c:if>
	<form
		action="${pageContext.servletContext.contextPath }/search/schbtn.do"
		id="f"></form>
	<button class="alert alert-warning" style="height: 50px;" id="bt">+
		관심 기업등록</button>
	<hr />
	<table style="margin: auto">
		<tr>
			<td>대표자 : ${dt.CEO } &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 기업 형태
				: ${dt.COTYPE }</td>
		</tr>
		<tr>
			<td>매출액 : ${dt.SALES }천만원
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 사원수 :
				${dt.WORKERS }명</td>
		</tr>
		<tr>
			<td>업종 : ${dt.INDUSTRY } &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 초봉 :
				${dt.FIRST }만원</td>
		</tr>
		<tr>
			<td>위치 : ${dt.BIG }&nbsp;${dt.SMALL }</td>
		</tr>
	</table>
	<hr />
	<div>
		<h4> 이 기업의 진행중인 채용공고</h4>
		
	
	</div>
	
	
	<hr />
	<div> 
		<h4> reviews </h4>
		이미 이 유저가 리뷰를 남긴적 있으면 리뷰입력란은 안뜨게!
		로그인 하지 않은 유저에겐 평균 별점만 뜨게!
		
	</div>
	
	<hr />
	<div>
		<h4> 이 기업에 대한 후기를 남겨주세요! </h4>
		<form action="${path}/recruit/review.do" method="get">
		  <input type="hidden" name="star" id="star" value="1"/>
		  <div class="form-group">
		    <label for="exampleInputEmail1">좋은점</label>
		    <input required name="good" type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="이 기업에 대한 긍정적인 의견이 있으신가요?">
		  </div>
		  <div class="form-group">
		    <label for="exampleInputPassword1">안좋은점</label>
		    <input required name="bad" type="text" class="form-control" id="exampleInputPassword1" placeholder="이 기업에 대한 부정적인 의견이 있으신가요?">
		  </div>
		  <div class="form-check" >
		    <div  id="starR" class="starRev">
			  <span class="starR on" id="1">별1</span>
			  <span class="starR" id="2">별2</span>
			  <span class="starR" id="3">별3</span>
			  <span class="starR" id="4">별4</span>
			  <span class="starR" id="5">별5</span>
			</div>
		  </div>
		  <button type="submit" class="btn btn-primary" style="margin-top: 20px; ">Submit</button>
		</form>
	<script>
	$('.starRev span').click(function(){
		  $(this).parent().children('span').removeClass('on');
		  $(this).addClass('on').prevAll('span').addClass('on');
		  $("#star").val($(this).attr("id"));
		  return false;
		});
	
	
	</script>
	</div>
	
	
	
	
	
	
	
	<p class="mt-5 mb-3 text-muted">&copy; 2018 JOB'A CORP</p>
	<c:choose>
		<c:when test="${userId eq null}">
			<script>
				$("#bt").on("click", function() {
					var t = window.confirm("로그인 인증이 필요합니다.\n로그인 하시겠습니까?");
					if (t) {
						$("#f").trigger("submit");
					}
				});
			</script>
		</c:when>
		<c:otherwise>
			<script>
				$("#bt").on("click", function() {
					$("#f").trigger("submit");
				});
			</script>
		</c:otherwise>
	</c:choose>
</body>