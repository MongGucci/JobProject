<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/index.css" rel="stylesheet">

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
<body style="text-align: center;">
<div class="container" style="margin-top: 40px;" id="body">

<div >
	<span style="color : #434e6e; font-weight: bolder; font-size: x-large;">'${coname}'으로 찾으신 기업정보 검색 결과입니다!</span>
</div>
<div  style="margin-top: 40px;">
	<c:forEach var="l" items="${sli }"  varStatus="status">
			<div id= "hirediv">
				<div class="ui grid" >

					<div class="four wide column" id="cnt" style="width: 100%;" ><img src="${path}${l.LOGO}"></div>
					<div class="twelve wide column">

						<div class="ui grid" >

							<div class="four wide column" id="hirename" onclick="location.href='${path}/search/schdetail.do?cono=${l.CONO}'">
							<c:choose>
								<c:when test = "${fn:containsIgnoreCase(${l.CONAME}, ${coname})}"><a style="font-weight: bolder; color: red;">${l.CONAME }</a></c:when> 
								<c:otherwise>${l.CONAME }</c:otherwise>
							</c:choose>
							</div>
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
</body>