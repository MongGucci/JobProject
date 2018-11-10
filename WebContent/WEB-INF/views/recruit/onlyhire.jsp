<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essayBoard.css" rel="stylesheet">

<style>


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
padding-top:40px;
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
width: 100px;

}
#hirename:hover{
cursor: pointer;

}
.current {
  color: green;
}

#pagin li {
  display: inline-block;
}
</style>
<div class="container" style="margin-top: 20px;">
	<h4 style="font-size: 20pt; color : #434e6e;">'${keyword}'에 대한 채용공고 검색결과 입니다.</h4>
	<c:forEach var="l" items="${lists}"  varStatus="status">
					
					<div id= "hirediv">
						<div class="ui grid" >

							<div class="four wide column" id="cnt" style="width: 100%;" ><img src="${path}${l.LOGO}"></div>
							<div class="twelve wide column">

								<div class="ui grid" >
									
									<div class="four wide column" id="hirename" onclick="location.href='${path}/recruit/jobpost.do?hino=${l.HINO}'">${l.NAME }</div>
									<div class="eight wide column" id="hireinfo">
										<div style="width: 100%" id="detail" >${l.TITLE}</div>
										<div style="width: 100%" id="detail">
										<small><fmt:formatDate pattern="yyyy-MM-dd" 
									         value="${l.STARTDATE}" />-<fmt:formatDate pattern="yyyy-MM-dd" 
									         value="${l.ENDDATE}" />
									    </small></div>
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
</div>





















