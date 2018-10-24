<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body style="text-align: center;">
	<form class="form-signin" action="${pageContext.servletContext.contextPath }/join.do" method="post">
		아이디 <br> <input style="width: 175px; height: 25px;" type="text"
			onchange="ids(this)" placeholder="아이디(4~19 영어,숫자 포함)" name="id"required /><br>
		<span></span><br> 
		비밀번호 <br> <input
			style="width: 175px; height: 25px;" type="password"
			onchange="ipw(this)" placeholder="비밀번호(4~19 영어,숫자 포함)" name="pass" required /><br>
		<span></span><br> 
		이름 <br> <input
			style="width: 175px; height: 25px;" type="text" name="name" /><br>
		나이<br/> <input
			style="width: 175px; height: 25px;" type="text" name="age" /><br>
			
			 성별 <br>
		<select style="width: 170px; height: 25px;" name="gender">
			<option  >성별</option>
			<option value="M">남자</option>
			<option  value="F">여자</option>
		</select><br> 직업선택<br />
		<br/>
		
		<c:forEach var="i" items="${map }">  
			<input type="checkbox" value="${i.CATENAME }" onchange="gc(this)" name="job" />${i.CATENAME }
		<c:if test="${(i.NO)%4==3 }"><br/></c:if>
		</c:forEach>
		
		
		<br/>

		<br /> 닉네임 <br>
		<input style="width: 175px; height: 25px;" type="text"
			onchange=nkn(this) name="nick" placeholder="닉네임(4~10 영어,한글 포함)" /><br> <span></span><br>
		이메일<br>
		<input style="width: 175px; height: 25px;" type="email"
			onchange=em(this) name="mail" placeholder="○○○@○○○○○.○○○" /><br> <span></span><br>
		휴대전화 <br> <input style="width: 175px; height: 25px;" type="text"
			onchange="phn(this)" name="phone" placeholder="XXX-XXXX-XXXX" /><br> <span></span><br>
		
		<button type="submit">회원 가입</button>
		
	</form>
</body>
<script>
   var ids = function(a) {
      var i1 = new RegExp("^[a-z0-9][a-z0-9_\-]{4,19}$"); 
      var input = a.value;

      
      console.log(input);
      if(input.match(i1) != null) {
         document.getElementsByTagName("span")[0].innerHTML = "<small>사용 가능한 아이디입니다.</small>";
         document.getElementsByTagName("span")[0].style.color ="blue";
         
      }else {
         document.getElementsByTagName("span")[0].innerHTML = "<small>사용 불가능한 아이디입니다.</small>";
         document.getElementsByTagName("span")[0].style.color ="red";
      }
   };
   
   var ipw = function(b) {
      var p1 = new RegExp("^[a-z0-9][a-z0-9_\-]{4,19}$");
      var pw = b.value;
      
      if(pw.match(p1) != null) {
         document.getElementsByTagName("span")[1].innerHTML = "<small>유효한 비밀번호입니다.</small>";
         document.getElementsByTagName("span")[1].style.color ="blue";
            console.log("비밀번호 : " + passInput);
         } else {
            document.getElementsByTagName("span")[1].innerHTML = "<small>유효하지 않은 비밀번호입니다.</small>";
            document.getElementsByTagName("span")[1].style.color ="red";
            

         }
   };
   
   
	   var nkn = function(n) {
		      var n1 = new RegExp("^[가-힣a-zA-Z]{3,10}$");
		      var nk = n.value;
		      
		      if(nk.match(n1) != null) {
		         document.getElementsByTagName("span")[2].innerHTML = "<small>유효한 닉네임 입니다.</small>";
		         document.getElementsByTagName("span")[2].style.color ="blue";
		            console.log("비밀번호 : " + passInput);
		         } else {
		            document.getElementsByTagName("span")[2].innerHTML = "<small>유효하지 않은 닉네임 입니다.</small>";
		            document.getElementsByTagName("span")[2].style.color ="red";
		            

		         }
		   };
		   
   var em = function(e) {
	      var e1 = new RegExp("^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$");
	      var em = e.value;
	      
	      if(em.match(e1) != null) {
	         document.getElementsByTagName("span")[3].innerHTML = "<small>유효한 이메일 입니다.</small>";
	         document.getElementsByTagName("span")[3].style.color ="blue";
	            console.log("비밀번호 : " + passInput);
	         } else {
	            document.getElementsByTagName("span")[3].innerHTML = "<small>유효하지 않은 이메일 입니다.</small>";
	            document.getElementsByTagName("span")[3].style.color ="red";
	            

	         }
	   };
	   
	   var phn = function(s) {
		      var s1 = new RegExp("^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$");
		      var ph = s.value;
		      
		      if(ph.match(s1) != null) {
		         document.getElementsByTagName("span")[4].innerHTML = "<small>정확이 입력하셨습니다.</small>";
		         document.getElementsByTagName("span")[4].style.color ="blue";
		            console.log("비밀번호 : " + passInput);
		         } else {
		            document.getElementsByTagName("span")[4].innerHTML = "<small>잘못 입력 하셨습니다..</small>";
		            document.getElementsByTagName("span")[4].style.color ="red";
		            

		         }
		   };
		   
	 var ct = new Array();
	 var gc = function(target) {
		if(target.checked){
			if(ct.length < 3){
				ct.push(target.value);
			}else{
				window.alert("최대 3개 까지 선택 가능 합니다.");
				target.checked = false;
			}
		}
	}
		 
	  
</script>
</html>