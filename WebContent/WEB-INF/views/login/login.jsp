<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/css/signin.css">
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
	<link href="${path}/css/default.css" rel="stylesheet">
	
<title>JOB Go</title>
</head>
<body class="text-center">
	<form class="form-signin"
		action="${pageContext.servletContext.contextPath }/login.do"
		method="post">
		<div style="text-align: center;">
		<h1 class="h3 mb-3" style="color: #465674; font-size: 30pt; font-weight: bolder;">로그인</h1>
		<p>
			<input type="text" id="inputid" class="form-control" placeholder="아이디"
				required autofocus name="id" style="font-size: 17pt; "> 
		</p>
		<input type="password" id="inputPassword" class="form-control"
			placeholder="비밀번호" name="pass" required  style="font-size: 17pt; ">
		<label class="btn btn-secondary active">
		   <input type="radio" name="remember" value="week" id="option" autocomplete="off"> 로그인 연장하기
		</label>
	<!-- 
		<script>
		$('#option').on('click',function(){
			console.log($('#option').value);
			if($('#option').attr('checked')==true){
				$('#option').attr('checked',false);
			}else{
				$('#option').attr('checked',true);
			}
		});
		</script> -->
		<c:if test="${!empty err }">
			<div class="alert alert-danger" role="alert">정보를 잘못 입력하셨습니다.</div>
		</c:if>
		<div id="naver_id_login"></div>
		<a id="kakao-login-btn"></a>
		
		 <script type="text/javascript">
		  	var naver_id_login = new naver_id_login("9dgqnClc5yOkE1ogkdqL", "milhnbdT6c");
		  	var state = naver_id_login.getUniqState();
		  	naver_id_login.setButton("white", 2,40);
		  	naver_id_login.setDomain("http://127.0.0.1:8080/JobProject/login.do");
		  	naver_id_login.setState(state);
		  	naver_id_login.setPopup();
		  	naver_id_login.init_naver_id_login();
		  </script>
		  
		  <script type='text/javascript'>
		  //<![CDATA[
		    // 사용할 앱의 JavaScript 키를 설정해 주세요.
		    Kakao.init('267d982fce06a799c3db94d8cf2bed7a');
		    // 카카오 로그인 버튼을 생성합니다.
		    Kakao.Auth.createLoginButton({
		      container: '#kakao-login-btn',
		      success: function(authObj) {
		        // 로그인 성공시, API를 호출합니다.
		        Kakao.API.request({
		          url: 'http://192.168.219.126:8080/JobProject/login.do',
		          success: function(res) {
		            alert(JSON.stringify(res));
		          },
		          fail: function(error) {
		            alert(JSON.stringify(error));
		          }
		        });
		      },
		      fail: function(err) {
		        alert(JSON.stringify(err));
		      }
		    });
		  //]]>
		</script>
		<button class="btn btn-lg btn-warning btn-block" type="submit" style="background-color:#465674; color: white; font-size: 20pt; font-weight: bolder;">로그인</button>
		<p class="mt-5 mb-3 text-muted">&copy; 2018 JOB Go CORP</p>
		</div>
	</form>
</body>
</html>


