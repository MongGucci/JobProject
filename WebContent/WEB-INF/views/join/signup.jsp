<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${path}/semantic/semantic.css">

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<script src="${path}/semantic/semantic.js"></script>
<link href="${path}/css/index.css" rel="stylesheet">
<link href="${path}/css/default.css" rel="stylesheet">
<title>JOB GO</title>
</head>
<body style="background-color: rgba(182, 183, 185, 0.25);">
	<div class="container-fluid" style="margin-top: 20px;">
		<div
			style="font-size: 50pt; color: #4F6994; margin: 50px; text-align: center; font-weight:bolder; font-family: 'Patua One', cursive;" onclick="javascript:location.href='${path}/job/index.do'">JOB
			GO</div>
		<div class="ui page  grid">

			<div class="row">
				<div class="four wide column"></div>
				<div class="eight wide column">
					<form class="ui fluid form" action="${path}/join/join.do"
						method="post">
						<div class="inline field" style="margin-bottom: 30px;">
							<label style="font-size: 15pt; color: #465674"><i
								class="user icon" style="font-size: 15pt; color: gray;"></i>아이디</label>
							<input type="text" name="id" placeholder="아이디(4~19자 영어,숫자 포함)"
								style="width: 100%; height: 50px; border: 1px solid #174374;"
								onchange="iid(this)" required class="c">
							<div class="ui pointing green basic label" id="idmsg"
								style="display: none; font-size: 11pt;"></div>
							<div class="ui pointing red basic label" id="iderror"
								style="display: none; font-size: 11pt;"></div>

						</div>


						<div class="inline field" style="margin-bottom: 30px;">
							<label style="font-size: 15pt; color: #465674"><i
								class="user icon" style="font-size: 15pt; color: gray;"></i>비밀번호</label>
							<input type="password" onchange="ipw(this)" name="pass"
								placeholder="비밀번호(4~19 영어,숫자 포함)"
								style="width: 100%; height: 50px; border: 1px solid #174374;"
								required>
							<div class="ui pointing green basic label" id="pwmsg"
								style="display: none; font-size: 11pt;"></div>
							<div class="ui left pointing red basic label" id="pwerror"
								style="display: none; font-size: 11pt;"></div>

						</div>

						<div class="inline field" style="margin-bottom: 30px;">
							<label style="font-size: 15pt; color: #465674"><i
								class="user icon" style="font-size: 15pt; color: gray;"></i>이름</label> <input
								type="text" name="name" placeholder="이름을 입력해주세요."
								style="width: 100%; height: 50px; border: 1px solid #174374;"
								required>

						</div>

						<div class="inline field" style="margin-bottom: 30px;">
							<label style="font-size: 15pt; color: #465674"><i
								class="user icon" style="font-size: 15pt; color: gray;"></i>나이</label> <input
								type="text" name="age" placeholder="나이를 입력해주세요."
								style="width: 100%; height: 50px; border: 1px solid #174374;"
								required>

						</div>

						<div class="inline field" style="margin-bottom: 30px;">
							<label style="font-size: 15pt; color: #465674"><i
								class="female icon" style="font-size: 15pt; color: gray;"></i><i
								class="male icon" style="font-size: 15pt; color: gray;"></i>성별</label> <select
								class="ui dropdown"
								style="width: 100%; height: 50px; border: 1px solid #174374;">
								<option value="">성별</option>
								<option value="M">남자</option>
								<option value="F">여자</option>
							</select>
						</div>


						<div style="margin-bottom: 30px;">
						<label style="font-size: 15pt; color:#465674;  font-weight: bolder;"><i class="star icon" style="font-size: 15pt; color: gray;"></i>관심 분야</label><br>
							<c:forEach var="i" items="${map}">
								<div class="ui checkbox"
									style="width: 200px; color: navy; font-size: 15pt;">

									<input type="checkbox" value="${i.CATENAME }"
										onchange="gc(this)" name="job"> <label
										style="color: #465674;font-weight: bolder;">${i.CATENAME }</label>

								</div>
								
							</c:forEach>
						</div>




						<div class="inline field" style="margin-bottom: 30px;">
						<label style="font-size: 15pt; color: #465674"><i
								class="user icon" style="font-size: 15pt; color: gray;"></i>닉네임</label> 
							<input type="text" name="nick" placeholder="닉네임(4~10 영어,한글 포함)"
								onchange="nkn(this)"
								style="width: 100%; height: 50px; border: 1px solid #174374;"
								required>
							<div class="ui pointing green basic label" id="nickmsg"
								style="display: none; font-size: 11pt;"></div>
							<div class="ui pointing red basic label" id="nickerror"
								style="display: none; font-size: 11pt;"></div>
						</div>

						<div class="inline field" >
							<label style="font-size: 15pt; color: #465674"><i
								class="at icon" style="font-size: 15pt; color: gray;"></i>이메일</label> <input
								type="text" type="email" onchange="em(this)" name="email"
								id="email" aria-descrivedby="emailHelp"
								placeholder="Sample@example.com"
								style="width: 100%; height: 50px; border: 1px solid #174374;"
								required>
							<div class="ui pointing green basic label" id="emmsg"
								style="display: none; font-size: 11pt;"></div>
							<div class="ui pointing red basic label" id="emerror"
								style="display: none; font-size: 11pt;"></div>
						</div>


						<div class="inline field" align="right" style="margin-bottom: 30px;">
							<button type="button" class="ui inverted secondary button"
								id="emailauth" disabled="disabled" style="font-family: 'Song Myung', serif;">인증번호 전송</button>
						</div>


						<div class="inline field">
							<input type="text" name="confirm" id="confirm" name="name"
								placeholder="인증키를 입력하세요." disabled="disabled"
								style="width: 100%; height: 50px;" required>

						</div>


						<div class="inline field" align="right">
							<button type="button" class="ui inverted secondary button"
								id="confirmok" disabled="disabled" style="font-family: 'Song Myung', serif;">인증하기</button>
						</div>
						<small id="checked1"></small><br>




						<div class="inline field">
							<label style="font-size: 15pt; color: #465674"><i
								class="mobile alternate icon"
								style="font-size: 15pt; color: gray;"></i>핸드폰 번호</label> <input
								type="text" onchange="phn(this)" name="phone"
								placeholder="XXX-XXXX-XXXX"
								style="width: 100%; height: 50px; border: 1px solid #174374;"
								required>
							<div class="ui pointing green basic label" id="phmsg"
								style="display: none; font-size: 11pt;"></div>
							<div class="ui pointing red basic label" id="pherror"
								style="display: none; font-size: 11pt;"></div>
						</div>
						<div align="right">

							<button class="ui grey button" id="btnsubmit" disabled="disabled" style="font-size: 15pt; background-color:#4F6994; font-family: 'Song Myung', serif;">회원
								가입</button>
						</div>
						<p>JOB GO ㏇</p>

					</form>

				</div>
				<div class="three wide column"></div>


			</div>
		</div>




		<%-----------------------------------------------------------------------css 변경전 --%>

	</div>
	<script>
		var iid = function(b) {
			var id = b.value;
			console.log("id :" + id);
			var r = /^[a-z0-9]{4,19}$/;
			if (r.test(id)) {
				var req = new XMLHttpRequest();

				req.open("get", "joinajax.do?id=" + id, true);
				req.onreadystatechange = function() {
					if (this.readyState == 4) {
						var m = JSON.parse(this.responseText);
						console.log(m);

						if (m.pass == "on") {
							console.log("1");
							$('#iderror').show();
							$('#iderror').html("이미 사용중인 아이디입니다.");
							$('#idmsg').hide();

							document.getElementById("iderror").innerHTML = "이미 사용중인 아이디입니다.";

						} else {
							console.log("2");

							$('#idmsg').show();
							$('#idmsg').html("아주 멋진 아이디에요.");
							$('#iderror').hide();

						}
					}
				}
				req.send();
			} else {
				document.getElementsByTagName("span")[0].innerHTML = "아이디는 영문숫자혼용 4~12자로 설정바랍니다.";
				document.getElementsByTagName("span")[0].style.color = "red";
			}
		};

		var ipw = function(b) {
			var p1 = new RegExp("^[a-z0-9]{4,19}$");
			var pw = b.value;
			console.log("pass : " + pw);
			if (pw.match(p1) != null) {

				$('#pwmsg').show();
				$('#pwmsg').html("유효한 비밀번호입니다.");
				$('#pwerror').hide();

			} else {

				$('#pwerror').show();
				$('#pwerror').html("유효하지 않은 비밀번호입니다.");
				$('#pwmsg').hide();

			}
		};

		var nkn = function(n) {
			var n1 = new RegExp("^[가-힣a-zA-Z]{3,10}$");
			var nk = n.value;
			console.log("nick : " + nk);
			if (nk.match(n1) != null) {
				$('#nickmsg').show();
				$('#nickmsg').html("유효한 닉네임입니다.");
				$('#nickerror').hide();

			} else {

				$('#nickerror').show();
				$('#nickerror').html("유효하지 않은 닉네임입니다.");
				$('#nickmsg').hide();

			}
		};

		var em = function(e) {
			var e1 = new RegExp(
					"^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$");
			var em = e.value;
			console.log("email : " + em);
			if (em.match(e1) != null) {

				$('#emmsg').show();
				$('#emmsg').html("유효한 이메일 입니다.");
				$('#emerror').hide();

				$("#emailauth").prop("disabled", false);

			} else {

				$('#emerror').show();
				$('#emerror').html("유효하지 않은 이메일 입니다.");
				$('#emmsg').hide();

			}
		}

		var ckn = function(k) {
			var k1 = txt;
			var cknb = k.value;
			console.log("인증번호 : " + cknb);
			if (cknb.match(k1) != null) {
				document.getElementsByTagName("span")[4].innerHTML = "<small>정확이 입력하셨습니다.</small>";
				document.getElementsByTagName("span")[4].style.color = "blue";

			} else {
				document.getElementsByTagName("span")[4].innerHTML = "<small>잘못 입력 하셨습니다..</small>";
				document.getElementsByTagName("span")[4].style.color = "red";

			}
		};

		var phn = function(s) {
			var s1 = new RegExp("^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$");
			var ph = s.value;
			console.log("핸드폰 번호 : " + ph);
			if (ph.match(s1) != null) {
				$('#phmsg').show();
				$('#phmsg').html("유효한 핸드폰 번호입니다.");
				$('#pherror').hide();

			} else {
				$('#pherror').show();
				$('#pherror').html("유효하지 않은 핸드폰 번호입니다.");
				$('#phmsg').hide();

			}
		};

		var ct = new Array();
		var gc = function(target) {
			if (target.checked) {
				if (ct.length < 3) {
					ct.push(target.value);
				} else {
					window.alert("최대 3개 까지 선택 가능 합니다.");
					target.checked = false;
				}
			} else {
				var idx = ct.indexOf(target.value);
				ct.splice(idx, 1);
			}
		}

		$("#emailauth")
				.on(
						"click",
						function() {
							var param = {
								"email" : $(email).val()
							};
							$("#confirm").prop("disabled", false);
							$("#confirmok").prop("disabled", false);
							$
									.post(
											"${pageContext.servletContext.contextPath}/join/mail.do",
											param)
									.done(
											function(rst) {
												document
														.getElementById("checked").innerHTML = "전송";
												document
														.getElementById("checked").style.color = "green";
												document
														.getElementById("checked1").innerHTML = "";
											});

						});

		$("#confirmok")
				.on(
						"click",
						function() {
							var param = {
								"confirmkey" : $("#confirm").val()
							};
							$
									.post(
											"${pageContext.servletContext.contextPath}/join/emailauth.do",
											param)
									.done(
											function(rst) {
												console.log(rst);
												if (rst.includes("true") == true) {
													document
															.getElementById("checked1").innerHTML = "인증완료";
													document
															.getElementById("checked1").style.color = "green";
													$("#mail").prop("readonly",
															true);
													$("#emailauth").prop(
															"disabled", true);
													$("#confirm").prop(
															"disabled", true);
													$("#confirmok").prop(
															"disabled", true);
													$("#btnsubmit").prop(
															"disabled", false);
												} else {
													document
															.getElementById("checked1").innerHTML = "인증실패";
													document
															.getElementById("checked1").style.color = "red";
													$("#confirm").prop(
															"disabled", true);
													$("#confirmok").prop(
															"disabled", true);
													document
															.getElementById("emailauth").innerHTML = "재전송";
													document
															.getElementById("checked").innerHTML = "";
												}
											});
						});
	</script>
</body>
</html>
