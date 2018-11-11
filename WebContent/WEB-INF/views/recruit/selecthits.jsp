<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<link href="${path}/css/index.css" rel="stylesheet">
<!-- <link href="${path}/css/essayBoard.css" rel="stylesheet"> -->
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
</style>


<div class="container" style="margin-top: 20px;">


	

	<form action="${path}/recruit/selectdetail.do" >

		<div class="row">



			<div class="col">
				<select class="form-control" name="cate" required="required">
					<option value="all">직군</option>
					<c:forEach var="e" items="${cate}">
						<option value="${e.CATENAME}">${e.CATENAME}</option>
					</c:forEach>
				</select>
			</div>

			<div class="col">
				<!-- <select class="form-control" name="big" onchange="getSmall(this.value);" required="required"> -->
				<select class="form-control" name="big" id="location"
					required="required">
					<option value="all">지역(대)</option>
					<c:forEach var="e" items="${big}">
						<option value="${e.BIG}">${e.BIG}</option>
					</c:forEach>
				</select>
			</div>
			<div class="col">

				<select class="form-control" name="small" required="required"
					id="smalls">
					<option value="all">지역(소)</option>
					<option value="${e.SMALL}">${e.SMALL}</option>
				</select>
			</div>
			<div class="col">
				<select class="form-control" name="cotype" required="required">
					<option value="all">기업형태</option>
					<c:forEach var="e" items="${cotype}">
						<option value="${e.COTYPE}">${e.COTYPE}</option>
					</c:forEach>
				</select>
			</div>
			<div class="col">
				<select class="form-control" name="hireshape" required="required">
					<option value="all">고용형태</option>
					<c:forEach var="e" items="${hireshape}">
						<option value="${e.SHAPE}">${e.SHAPE}</option>
					</c:forEach>
				</select>
			</div>


		</div>
		<hr />

		<div align="right">
			<button type="submit" class="btn btn-dark">G O</button>
		</div>

	</form>


	<hr />
	
	<div>
		<div align="right" style="margin-right: 20px;">
			<a href="${path}/recruit/select.do">최신순</a> | <a href="${path}/recruit/select.do?mode=hits">인기순</a> | <a href="${path}/recruit/select.do?mode=end">마감순</a>
		</div>
			
		
	
	<c:forEach var="l" items="${hits}"  varStatus="status">
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

	</div>
<hr/>
<div align="center">
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
						<li class="page-item disabled"><a class="page-link" href="#"
						tabindex="-1">...</a></li>
						<c:forEach var="e" begin="1" end="${startpage}">
						<li class="page-item"><a class="page-link" href="${path}/recruit/select.do?mode=start&page=${e}">${e}</a></li>
						</c:forEach>
						<li class="page-item"><a class="page-link" href="#">...</a></li>
				</ul>
			</nav>
</div>
<script>
	/* var getSmall = function(big){
	   var xhr = new XMLHttpRequest();
	   console.log("big :" +big);
	   
	   xhr.open("post", "${path}/recruit/selectajax.do", true);
	   xhr.onreadystatechange = function(){
	      if(this.readyState==4) {
	         
	         var small =JSON.parse(this.responseText.trim());
	         
	         for(var i=0;i<small.length;i++){
	            document.getElementById("smalls").innerHTML +=
	             "<option value=\""+small[i].SMALL+"\">"+small[i].SMALL+"</option><br/>";
	             console.log(small[i].SMALL);
	
	         }
	      }
	   };
	   var param = big;

	   xhr.send(param);
	   
	}; */

	$('.special.cards .image').dimmer({
		on : 'hover'
	});
	
	
	$("#location").on(
			"change",
			function() {
				var big = $("#location").val();
				console.log("val:" + big);
				var param = {
					"big" : big
				};
				$.post("${path}/recruit/selectajax.do", param).done(
						function(rst) {
							var html = "";
							for (var i = 0; i < rst.length; i++) {
								html += "<option value=\""+rst[i].SMALL+"\">"
										+ rst[i].SMALL + "</option><br/>";
								//console.log(small[i].SMALL);
							}
							$("#smalls").html(html);

						});
			});
</script>



