<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essayBoard.css" rel="stylesheet">
<div class="container" style="margin-top: 20px;">

	<div class="card">

		<div class="card-body">
			<h5 class="card-title">${essay.TITLE}</h5>
			<h6 class="card-subtitle mb-2 text-muted">작성자 : ${essay.WRITER}</h6>
			<p class="card-text">${essay.CONTENT}</p>

			<c:if test="${!empty essay.PATH}">
				<a href="<c:url value="${essay.PATH}"/>" class="btn btn-primary"
					download>다운로드 : ${essay.FILE}</a>
			</c:if>

		</div>
	</div>



	<div class="accordion" id="accordionExample">
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

	<c:choose>
		<c:when test="${empty like}">
			<div style="margin-top: 15px;" align="right">
				<button type="button" class="btn btn-warning" data-toggle="modal"
					id="likebtn" data-target="#exampleModal">LIKE</button>
			</div>
		</c:when>
		<c:otherwise>
			<div style="margin-top: 15px;" align="right">
				<button type="button" class="btn btn-warning" data-toggle="modal"
					id="likebtn" data-target="#exampleModal" disabled="disabled">DONE</button>
			</div>
		</c:otherwise>
	</c:choose>

	<c:if test="${empty userId}">
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true"></div>
	</c:if>


	<c:choose>
		<c:when test="${!empty userId}">

			<script>
				$("#likebtn")
						.on(
								"click",
								function() {
									var id = "${userId}";
									console.log(id);

									var no = "${essay.NO}";

									var param = {
										"no" : no
									};

									$
											.post(
													"${path}/essayBoard/essayLikeAjax.do",
													param).done(
													function(rst) {
														console.log(rst);
														if (rst.like) {
															$("#likebtn").attr(
																	"disabled",
																	true);
															$("#likebtn").html(
																	"DONE");
														}

													});

								});
			</script>
		</c:when>
		<c:otherwise>
			<script>
				var html = "";
				html = "<div class=\"modal-dialog\" role=\"document\">"
						+ "<div class=\"modal-content\"><div class=\"modal-header\">"
						+ "<h5 class=\"modal-title\" id=\"exampleModalLabel\">JOB GO</h5>"
						+ "<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">"
						+ "<span aria-hidden=\"true\">&times;</span></button></div><div class=\"modal-body\">로그인을 원츄</div>"
						+ "<div class=\"modal-footer\"><button type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\">Close</button>"
						+ "<a href=\"${path}/login.do\"><button type=\"button\" class=\"btn btn-primary\">로그인 하러가기</button></a></div></div></div>";

				$("#exampleModal").html(html);
			</script>

		</c:otherwise>
	</c:choose>

	<%-- ===============================댓글 시작=====================================  --%>


	<div style="border: 1px solid gray; margin-top: 20px;">

		<c:forEach var="e" items="${reply}">
			<c:if test="${empty e.PARENTNO}">
				<div class="form-group" style="margin: 20px;">
					<c:choose>
						<c:when test="${e.FLAG eq 'A'}">
							<div>
								<p>관리자에 의해 삭제된 댓글입니다.</p>
							</div>
						</c:when>
						<c:when test="${e.FLAG eq 'W'}">
							<div>
								<p>작성자에 의해 삭제된 게시글입니다.</p>
							</div>
						</c:when>
						<c:otherwise>
							<div>
								<p>${e.WRITER} : ${e.REPLY }</p>
							</div>
						</c:otherwise>

					</c:choose>

				</div>
				<c:forEach var="h" items="${reply}">
					<c:if test="${e.NO eq h.PARENTNO}">
						<c:choose>
							<c:when test="${h.FLAG eq 'A'}">
								<div style="margin: 20px; margin-left: 30px;">
									<p>┗ ${h.WRITER} : 관리자에 의해 삭제된 댓글입니다.</p>
								</div>
							</c:when>
							<c:when test="${h.FLAG eq 'W'}">
								<div style="margin: 20px; margin-left: 30px;">
									<p>┗ ${h.WRITER} : 작성자에 의해 삭제된 게시글입니다.</p>
								</div>
							</c:when>
							<c:otherwise>
								<div style="margin: 20px; margin-left: 30px;">
									<p>┗ ${h.WRITER} : ${h.REPLY }</p>
								</div>
							</c:otherwise>

						</c:choose>

					</c:if>
				</c:forEach>
				<%-- ===============================답글 버튼=====================================  --%>
				<div align="right" style="margin: 20px;">
					<button class="comment"
						style="border: none; background-color: rgba(0, 0, 0, 0);">답글달기</button>
					<a href="${path}/essayBoard/reply.do?handle=delete&no=${e.NO}">
						<button style="border: none; background-color: rgba(0, 0, 0, 0);">삭제하기</button>
					</a>
					<form action="${path}/essayBoard/replyComment.do" method="post" style="display: none;">
						<input type="hidden" name="parent" value="${e.NO}"> <input
							type="hidden" name="replyid" value="${e.WRITER}"> <input
							type="hidden" name="jasono" value="${e.JASONO}">
						<div id="commentArea" style="margin: 20px; "
							class="form-group">
							<label>답글</label>
							<textarea class="form-control" name="reply" rows="3"></textarea>
							<div align="right" style="margin-top: 10px;">
								<button>답글달기</button>
							</div>
						</div>
					</form>
				</div>
				<%-- ===============================답글 보내기=====================================  --%>
			</c:if>

		</c:forEach>
		<hr>
		<%-- ===============================댓글 다는곳=====================================  --%>
		<form action="${path}/essayBoard/reply.do" method="post">
			<input type="hidden" name="jasono" value="${essay.NO}"> <input
				type="hidden" name="replyid" value="${essay.WRITER}">
			<div class="form-group" style="margin: 20px;">
				<label for="exampleFormControlTextarea1">댓글</label>
				<textarea class="form-control" id="exampleFormControlTextarea1"
					name="reply" rows="3"></textarea>
				<div align="right" style="margin-top: 10px;">
					<button>댓글달기</button>
				</div>
			</div>

		</form>
	</div>
	<%-- ===============================댓글 끝=====================================  --%>
</div>
<script>
	$(".comment").on("click", function() {
		$(this).next().next().toggle();
	});
</script>
