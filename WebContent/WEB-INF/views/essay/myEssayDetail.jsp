<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essayBoard.css" rel="stylesheet">
<div class="container" style="margin: 20px;">

	<div class="card" style="width:100%;">

		<div class="card-body">
			<h5 class="card-title">${essay.TITLE}</h5>
		</div>
	</div>
	
	<div class="accordion" id="accordionExample" >
		<!-- 싹긁어와서 바꿔버리기 -->

		<div id="accordion" role="tablist">
			<c:if test="${!empty essay.Q1}">
				<div class="card">
					<div class="card-header" role="tab" id="headingOne">
						<h5 class="mb-0">
							<span style="font-size: 20pt;">Q1.</span> <a
								data-toggle="collapse" href="#collapseOne" aria-expanded="true"
								aria-controls="collapseOne">${essay.Q1}</a>
						</h5>
					</div>

					<div id="collapseOne" class="collapse show" role="tabpanel"
						aria-labelledby="headingOne" data-parent="#accordion">
						<div class="card-body">${essay.A1}</div>
					</div>
				</div>
			</c:if>

			<c:if test="${!empty essay.Q2}">
				<div class="card">
					<div class="card-header" role="tab" id="headingTwo">
						<h5 class="mb-0">
							<span style="font-size: 20pt;">Q2. </span> <a
								data-toggle="collapse" href="#collapseTwo" aria-expanded="true"
								aria-controls="collapseTwo">${essay.Q2}</a>
						</h5>
					</div>

					<div id="collapseTwo" class="collapse show" role="tabpanel"
						aria-labelledby="headingTwo" data-parent="#accordion">
						<div class="card-body">${essay.A2}</div>

					</div>
				</div>
			</c:if>
			<c:if test="${!empty essay.Q3}">
				<div class="card">
					<div class="card-header" role="tab" id="headingThree">
						<h5 class="mb-0">
							<span style="font-size: 20pt;">Q3. </span> <a
								data-toggle="collapse" href="#collapseThree"
								aria-expanded="true" aria-controls="collapseThree">${essay.Q3}</a>
						</h5>
					</div>

					<div id="collapseThree" class="collapse show" role="tabpanel"
						aria-labelledby="headingThree" data-parent="#accordion">
						<div class="card-body">${essay.A3}</div>
					</div>
				</div>
			</c:if>
			<c:if test="${!empty essay.Q4}">
				<div class="card">
					<div class="card-header" role="tab" id="headingFour">
						<h5 class="mb-0">
							<span style="font-size: 20pt;">Q4. </span> <a
								data-toggle="collapse" href="#collapseFour" aria-expanded="true"
								aria-controls="collapseFour">${essay.Q4}</a>
						</h5>
					</div>

					<div id="collapseFour" class="collapse show" role="tabpanel"
						aria-labelledby="headingFour" data-parent="#accordion">
						<div class="card-body">${essay.A4}</div>
					</div>
				</div>
			</c:if>
		</div>
	</div>
</div>

