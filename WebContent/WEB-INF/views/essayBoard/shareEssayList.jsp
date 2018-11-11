<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<style>
tr#list:hover {
	background-color: #FAEBD7;
}

a:active {
	color: orange;
}


style>span:hover {
	color: white;
}

#hirediv {
	border: 1px solid #434e6e;
	margin: 20px;
	background-color: white;
	padding: 20px;
	font-family: 'Nanum Gothic', sans-serif;
}

#hirediv:hover {
	background-color: #434e6e;
	color: white;
}

#passdiv:hover {
	background-color: #434e6e;
	color: white;
}

#passdiv {
	border: 1px solid #434e6e;
	margin: 20px;
	background-color: white;
	padding: 10px;
	font-family: 'Nanum Gothic', sans-serif;
}

#cnt {
	font-size: 13pt;
	text-align: center;
}

#hirename {
	font-size: 15pt;
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

#jobgo {
	font-size: 15pt;
}

#btn {
	background-color: rgba(0, 0, 0, 0);
	border: 1px solid #434e6e;
	color: #434e6e;
	padding: 10px;
	font-size: 11pt;
	border-radius: 5%;
}

#btn:hover {
	background-color: #434e6e;
	color: white;
	padding: 10px;
	font-size: 11pt;
	border-radius: 5%;
	
}

#myessay {
	background-color: rgba(0, 0, 0, 0);
	border: none;
	color: #434e6e;
	padding: 15px;
	font-size: 15pt;
	border-radius: 5%;
}

#myessay:hover {
	background-color: #434e6e;
	color: white;
	padding: 15px;
	font-size: 15pt;
	border-radius: 5%;
}
</style>



<link href="${path}/css/essayBoard.css" rel="stylesheet">
<div class="container" style="margin-top: 20px;">

	<div class="ui grid" align="left" style="margin-left: 10px;">

		<div class="four wide column">
			<a href="${path}/essayBoard/shareEssayList.do?array=recent"><button id="btn" data-value="hire">최신순</button></a>

			<a href="${path}/essayBoard/shareEssayList.do?array=popular"><button id="btn" data-value="pass">인기순</button></a>
		</div>

		<div class="twelve wide column"></div>
	</div>


	<div id="left">
		<c:forEach var="e" items="${essays}" >
			<div id="hirediv" align="left" onclick="location.href='${path}/essayBoard/essayBoardDetail.do?no=${e.NO}'">
				<div class="ui grid" id="list">

					<div class="one wide column" id="cnt" style="padding-top: 30px;">
						${e.NO}
					</div>
					<div class="nine wide column" style="padding-top: 30px; font-weight: bolder;">${e.TITLE}</div>
					<div class="four wide column" id="cnt" style="text-align:center;">

						<div style="width: 100%" id="detail" >
							<b>${e.WRITER}</b>
						</div>
						<div style="width: 100%" id="detail">
							<small>${e.CATE}</small>
						</div>
						<div style="width: 100%; font-size: 10pt;" id="detail">${e.WRITEDATE}</div>
					</div>
					<div class="two wide column" id="cnt" style="padding: 15px 0px;">

						<div align="left"><i class="heart icon" style="color:#F14444;"></i>${e.HITS}</div>
						<div align="left" style="margin-top: 10px;"><i class="eye icon" style="color:#707374;"></i>${e.GOOD}</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>



	<div align="right" style="margin-right: 20px;">
		<a href="${path}/essayBoard/shareEssay.do?array=recent"><button id="btn">글 쓰러가기</button></a>
	</div>
</div>

<script>
	
</script>
