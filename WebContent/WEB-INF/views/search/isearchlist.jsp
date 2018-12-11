
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<link href="${path}/css/index.css" rel="stylesheet">
<style>
#body {
	color: #434e6e;
}
span:hover {
	color: white;
}
#searchdiv {
	border: 1px solid #434e6e;
	margin: 20px;
	background-color: white;
	padding: 10px;
	font-family: 'Nanum Gothic', sans-serif;
}
#cnt {
	font-size: 20pt;
	text-align: center;
}
#hirename {
	font-size: 17pt;
	font-weight: bolder;
	padding-top: 30px;
}
#hireinfo {
	font-size: 12pt;
}
#detail {
	margin: 5px;
}
#jaso {
	font-size: 13pt;
	margin-top: 10px;
}
#jaso:hover {
	cursor: pointer;
}
img {
	width: 140px;
}
#hirename:hover {
	cursor: pointer;
}
#searchdiv:hover {
	background-color: #434e6e;
	color: white;
}
#cnt {
	font-size: 13pt;
	text-align: center;
}
</style>
<div class="container" style="margin-top: 20px;">
	<h4 style="font-size: 20pt; color : #434e6e;">'${keyword}'에 대한 검색결과 입니다.</h4>

	<p style="margin-top: 20px; margin-left: 20px; color :#434e6e; font-weight: boler;"><b>기업정보</b></p>
	<c:if test="${empty company}">  <a style="margin-top: 20px; margin-left: 20px;"> 검색 결과가 없습니다. </a></c:if>
	<c:forEach begin="0" end= "4" var="l" items="${company}" varStatus="status">
		<div id="searchdiv">
			<div class="ui grid">
	
				<div class="four wide column" id="cnt" style="width: 100%;">
					<img src="${path}${l.LOGO}">
				</div>
				<div class="twelve wide column">
	
					<div class="ui grid">
	
						<div class="four wide column" id="hirename"
							onclick="location.href='${path}/search/schdetail.do?cono=${l.CONO}'">${l.CONAME }</div>
						<div class="eight wide column" id="hireinfo">
							<div style="width: 100%" id="detail">
								<b>${l.TITLE }</b>
							</div>
							<div style="width: 100%" id="detail">
								<small>${l.INDUSTRY }</small>
							</div>
							<div style="width: 100%" id="detail">${l.COTYPE }</div>
						</div>
						<div class="four wide column" align="left">
							<div id="jaso" onclick="hino(this)" data-value="${e.HINO}">
										<i class="building icon"></i>${l.BIG } ${l.SMALL }
							</div>
						</div>
	
					</div>
					</div>
			</div>
		</div>
	</c:forEach>
	<a href="${path }/search/searchpost.do?search=${keyword }" style="margin-top: 20px; margin-left: 20px; color : #434e6e; font-weight: boler;"><b>+더보기</b></a>
	<hr/>
	
	
	<p style="margin-top: 20px; margin-left: 20px; color:#434e6e; font-weight: boler;"><b>합격자소서</b></p>
	<c:if test="${empty passjaso}">  <a style="margin-top: 20px; margin-left: 20px;"> 검색 결과가 없습니다. </a></c:if>
	<c:forEach begin="1" end= "5" var="l" items="${passjaso}"  varStatus="status">
	<div id="searchdiv" align="left"
		onclick="location.href='${path}/essayBoard/passEssayDetail.do?passno=${l.PASSNO}'">
		<div class="ui grid">

			<div class="four wide column" id="cnt">
				<img src="${path}${l.LOGO}">
			</div>
			<div class="twelve wide column">
				<div class="ui grid">

					<div class="four wide column" id="hirename">${l.CONAME }</div>
					<div class="twelve wide column" id="hireinfo">
						<div style="width: 100%" id="detail">
							<b>${l.TITLE }</b>
						</div>
						<div style="width: 100%" id="detail">
							<small>${l.CATE}</small>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</c:forEach>
	<hr/>
	
	<p style="margin-top: 20px; margin-left: 20px; color :#434e6e; font-weight: boler;"><b>자소서 게시판</b></p>
	<c:if test="${empty sharejaso}">  <a style="margin-top: 20px; margin-left: 20px;"> 검색 결과가 없습니다. </a> </c:if>
	<c:forEach var="l" items="${sharejaso}"  varStatus="status">
	<div id="searchdiv" align="left"
		onclick="location.href='${path}/essayBoard/essayBoardDetail.do?no=${l.NO}'">
		<div class="ui grid" id="list">

			<div class="one wide column" id="cnt" style="padding-top: 30px;">
				${l.NO }</div>
			<div class="eight wide column"
				style="padding-top: 30px; font-weight: bolder;">${l.TITLE}</div>
			<div class="four wide column" id="cnt" style="text-align: center;">

				<div style="width: 100%" id="detail">
					<b>${l.WRITER}</b>
				</div>
				<div style="width: 100%" id="detail">
					<small>${l.CATE}</small>
				</div>
				<div style="width: 100%; font-size: 10pt;" id="detail">${l.WRITEDATE}</div>
			</div>
			<div class="three wide column" id="cnt">

				<div align="left">
					<i class="heart icon" style="color: #F14444;"></i>${l.HITS}
				</div>
				<div align="left" style="margin-top: 10px;">
					<i class="eye icon" style="color: #707374;"></i>${l.GOOD}
				</div>
			</div>
		</div>
	</div>
	</c:forEach>
	<hr/>
	
	<p style="margin-top: 20px; margin-left: 20px; color : #434e6e; font-weight: boler;"><b>채용공고</b></p>
	
	<c:if test="${empty hire}"> <a style="margin-top: 20px; margin-left: 20px;"> 검색 결과가 없습니다. </a></c:if>
	<c:forEach begin="0" end= "4" var="l" items="${hire}"  varStatus="status">
	<div id="searchdiv">

		<div class="ui grid" id="list">

			<div class="four wide column" id="cnt">
				<img src="${path}${l.LOGO}">
			</div>
			<div class="twelve wide column">
				<div class="ui grid" >
									
					<div class="four wide column" id="hirename" onclick="location.href='${path}/recruit/jobpost.do?hino=${l.HINO}'">${l.NAME }</div>
					<div class="eight wide column" id="hireinfo">
						<div style="width: 100%" id="detail" >${l.TITLE}</div>
						<div style="width: 100%" id="detail">
							<small><fmt:formatDate pattern="yyyy-MM-dd" 
								value="${l.STARTDATE}" />-<fmt:formatDate pattern="yyyy-MM-dd" 
								value="${l.ENDDATE}" /></small></div>
						<div style="width: 100%" id="detail">${l.COTYPE }</div>
					</div>
					<div class="four wide column" align="left" ><div style="padding-top: 10px; font-size: 13pt; font-weight: bolder;">${l.DDAY }</div>
						<div  align="left" style="margin-top: 7px;" ><i class="building icon"></i>${l.BIG} ${l.SMALL}</div>
							<div align="left" style="margin-top: 7px;"><i class="eye icon" style="color:#707374;"></i>${l.HITS}</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	</c:forEach>
	<a href="${path }/search/onlyhire.do?keyword=${keyword }" style="margin-top: 20px; margin-left: 20px; color : #434e6e; font-weight: boler;"><b>+더보기</b></a>
	<hr/>

</div>


