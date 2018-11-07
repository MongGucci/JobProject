
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<meta charset="UTF-8">
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<style>

#body{
color:#434e6e;
}
span:hover {
	color: white;
}

#hirediv{

border: 1px solid #434e6e;
margin: 20px;
background-color: white;
padding:10px;
 font-family: 'Nanum Gothic', sans-serif;

}
#cnt{
font-size: 20pt;
text-align: center;


}

#hirename{
font-size: 17pt;
font-weight: bolder;
padding-top:30px;
}
#hireinfo{

font-size: 12pt;
}
#detail{

margin:5px;
}
#jaso{

font-size: 13pt; 
margin-top: 10px;
}
#jaso:hover {
	cursor: pointer;
}
img{
width: 140px;

}
#hirename:hover{
cursor: pointer;

}
#hirediv:hover{
background-color: #434e6e;
color: white;

}
</style>

<div class="container" style="margin-top: 20px;" id="body">

	<form class="form-signin"
		action="${pageContext.servletContext.contextPath }/search/search.do"
		method="post">
		<div>


			<h1>기업 검색</h1>
			<p style="color: white;">
				이 기업의 연봉정보,<br> 입사지원서 내기 전에 확인하세요!
			</p>
		</div>
		<div class="ui grid">
			<div class="five wide column"></div>
			<div class="eleven wide column">
				<div class="ui search">
					<div class="ui icon input" style="width: 100%;">
						<input class="prompt" list="some" type="text"
							placeholder="궁금하신 회사의 이름을 입력해주세요." name="search"
							onkeyup="sch(this)"> <i class="search icon"></i>
						<datalist id="some">
							<option></option>
						</datalist>
					</div>
					<div class="results"></div>
				</div>
			</div>
		</div>
	</form>


<div>


<c:forEach var="l" items="${company}"  varStatus="status">
					<div id= "hirediv">
						<div class="ui grid" >

							<div class="four wide column" id="cnt" style="width: 100%;" ><img src="${path}${l.LOGO}"></div>
							<div class="twelve wide column">

								<div class="ui grid" >

									<div class="four wide column" id="hirename" onclick="location.href='${path}/search/schdetail.do?cono=${l.CONO}'">${l.CONAME }</div>
									<div class="eight wide column" id="hireinfo">
										<div style="width: 100%" id="detail" >${e.TITLE}</div>
										<div style="width: 100%" id="detail"><small>${l.INDUSTRY}</small></div>
										<div style="width: 100%" id="detail">${l.COTYPE }</div>
									</div>
									<div class="four wide column" align="left" ><div style="padding-top: 10px; font-size: 13pt; font-weight: bolder;">${e.DDAY}</div><div id="jaso" onclick="hino(this)"
									data-value="${e.HINO}" ><i class="building icon"></i>${l.BIG } ${l.SMALL }</div></div>

								</div>





							</div>

						</div>
					</div>
				</c:forEach>

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
