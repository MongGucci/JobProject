
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<meta charset="UTF-8">
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essayBoard.css" rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/css/search.css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/css/button.css">


<div class="container" style="margin-top: 20px;">

	<form class="form-signin"
		action="${pageContext.servletContext.contextPath }/search/search.do"
		method="post">
		<div>


			<h1>기업 검색</h1>
			<p style="color: white;">
				이 기업의 연봉정보,<br> 입사지원서 내기 전에 확인하세요!
			</p>
		</div>
		<div>
			<input type="text" list="some" placeholder="궁금하신 회사의 이름을 입력해주세요."
				name="search" onkeyup="sch(this)" />
			<datalist id="some">
				<option></option>
			</datalist>
			<button type="submit" style="height: 40px;">
				<img class=""
					src="${pageContext.servletContext.contextPath }/image/dop.PNG"
					style="width: 30px; height: 30px; padding: 0px;" border="0" />
			</button>
		</div>
	</form>




	<div align="center">
		<p>실시간 인기검색어</p>

		<table class="table table-hover">
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">기업</th>
					<th scope="col">기업형태</th>
					<th scope="col">산업군</th>
					<th scope="col">위치</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="l" items="${company}">
					<tr class="table"
						onclick="location.href='${path}/search/schdetail.do?cono=${l.CONO}'">
						<th scope="row">${l.CONO }</th>
						<td>${l.CONAME }</td>
						<td>${l.COTYPE }</td>
						<td>${l.INDUSTRY}</td>
						<td>${l.BIG }-${l.SMALL }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>


	
</div>

<script>
	var sch = function(target) {
		var xhr = new XMLHttpRequest();
		var param = target.value;
		console.log("쳐봐 :" + param);
		xhr.open("get", "${path}/search/searchajax.do?coname=" + param, true);
		xhr.onreadystatechange = function() {
			if (this.readyState == 4) {
				var html = "";
				var obj = JSON.parse(this.responseText.trim());
				for (var i = 0; i < obj.length; i++) {
					html += "<option value =" + obj[i].CONAME + ">"
							+ obj[i].CONAME + "</option>";
				}
				document.getElementById("some").innerHTML = html;
			}
		};
		xhr.send(param);
	};
</script>
