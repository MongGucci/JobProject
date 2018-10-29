<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="text-center">
<form class="form-signin" action="${pageContext.servletContext.contextPath }/join/join.do" method="post">
    
      <h1 class="h3 mb-3 font-weight-normal" >회원가입</h1>
      <br>
      
      <div class="form-label-group">
        <label style="width: 230px; height: 50px;"  class="alert alert-primary">아이디</label><br>
        <input style="width: 230px; height: 25px;" class="border border-warning" type="text"
         id="id" class="form-control" name="id" onkeyup="getid(this);"   
         placeholder="아이디(4~19자 영어,숫자 포함)" required/><span></span><br>
      </div><br>

      <div class="form-label-group">
        <label style="width: 230px; height: 50px;"  class="alert alert-primary">비밀번호</label><br>
        <input style="width: 230px; height: 25px;" class="border border-warning" type="password" onchange="ipw(this)" name="pass"  placeholder="비밀번호(4~19 영어,숫자 포함)" required/><br><span></span>
      </div><br>
      
       <div class="form-label-group">
        <label style="width: 230px; height: 50px;"  class="alert alert-primary">이름</label><br>
        <input style="width: 230px; height: 25px;" class="border border-warning" type="text" onkeyup="name" name="name"/><br>
      </div>
      <br>
       <div class="form-label-group">
        <label style="width: 230px; height: 50px;"  class="alert alert-primary">나이</label><br>
        <input style="width: 230px; height: 25px;" class="border border-warning" type="text" name="age"/><br>
      </div>
         <br>
         <label style="width: 230px; height: 50px;"  class="alert alert-primary">성별</label><br>
      <select style="width: 230px; height: 25px;" class="border border-warning" name="gender">
         <option>성별</option>
         <option value="M">남자</option>
         <option value="F">여자</option>
      </select><br>
      <br> <label style="width: 230px; height: 50px;"  class="alert alert-primary">직업선택</label><br>
      
      <c:forEach var="i" items="${map }">  
         <input type="checkbox" value="${i.CATENAME }" onchange="gc(this)" name="job" />${i.CATENAME }
      <c:if test="${(i.NO)%4==3 }"><br/></c:if>
      </c:forEach>
      <br/>
      <br>
       <div class="form-label-group">
        <label style="width: 230px; height: 50px;"  class="alert alert-primary">닉네임</label><br>
        <input style="width: 230px; height: 25px;" class="border border-warning" type="text" onchange=nkn(this) name="nick" placeholder="닉네임(4~10 영어,한글 포함)" /><br><span></span>
      </div><br>

      <div class="form-label-group">
        <label style="width: 230px; height: 50px;"  class="alert alert-primary">Email address</label><br>
       <input style="width: 230px; height: 25px;" class="border border-warning" type="email" onkeyup="em(this)" name="email" id="email" aria-descrivedby="emailHelp"  placeholder="Sample@example.com"/><br><span></span>
         <br>
      </div>
      <button type="button" id="emailauth" disabled="disabled">인증번호 전송</button><small id="checked"> </small> <br>
      <br>
     인증 번호 <br><input type="text" name="confirm" id="confirm" class="from-control" placeholder="인증키를 입력하세요" disabled="disabled" required/><span></span><br>
     <br><button type="button" id="confirmok" disabled="disabled">인증하기</button><small id="checked1"></small><br>
    
      <br>
    <div class="form-label-group">
        <label style="width: 230px; height: 50px;"  class="alert alert-primary">휴대전화</label><br>
        <input style="width: 230px; height: 25px;" class="border border-warning" type="text" onchange="phn(this)" name="phone" placeholder="XXX-XXXX-XXXX" /><br><span></span><br>
      </div>
      <br>
      <button type="submit" class="btn btn-success" id="btnsubmit" disabled="disabled">회원 가입</button>
       <p class="mt-5 mb-3 text-muted text-center">JOB'go ㏇</p>
   </form>
   </div>
<script>
 



  document.getElementById("id").onkeyup = function() {
      var id = this.value;
      console.log("id :" + id);
      var r = /^[a-z0-9]{4,19}$/;
      if(r.test(id)){
         var req = new XMLHttpRequest();
         
         req.open("get", "joinajax.do?id="+id, true);
         req.onreadystatechange = function() {
            if(this.readyState==4) {
               var m =JSON.parse(this.responseText);
               console.log(m);
               
               if(m.pass == "on"){
                  console.log("1");
                  document.getElementsByTagName("span")[0].innerHTML = "이미 사용중인 아이디입니다.";
                  document.getElementsByTagName("span")[0].style.color ="red";
               }else {
                  console.log("2");
                  document.getElementsByTagName("span")[0].innerHTML = "아주 멋진 아이디에요.";
                  document.getElementsByTagName("span")[0].style.color ="green";
               }
            }
         }
         req.send();
      } else {
         document.getElementsByTagName("span")[0].innerHTML = "아이디는 영문숫자혼용 4~12자로 설정바랍니다.";
         document.getElementsByTagName("span")[0].style.color ="red";
      }
   };
      
   var ipw = function(b) {
      var p1 = new RegExp("^[a-z0-9][a-z0-9_\-]{4,19}$");
      var pw = b.value;
      console.log("pass : " + pw);
      if(pw.match(p1) != null) {
         document.getElementsByTagName("span")[1].innerHTML = "<small>유효한 비밀번호입니다.</small>";
         document.getElementsByTagName("span")[1].style.color ="blue";
         } else {
            document.getElementsByTagName("span")[1].innerHTML = "<small>유효하지 않은 비밀번호입니다.</small>";
            document.getElementsByTagName("span")[1].style.color ="red";
            

         }
   };
   
   
      var nkn = function(n) {
            var n1 = new RegExp("^[가-힣a-zA-Z]{3,10}$");
            var nk = n.value;
            console.log("nick : " + nk);
            if(nk.match(n1) != null) {
               document.getElementsByTagName("span")[2].innerHTML = "<small>유효한 닉네임 입니다.</small>";
               document.getElementsByTagName("span")[2].style.color ="blue";
               } else {
                  document.getElementsByTagName("span")[2].innerHTML = "<small>유효하지 않은 닉네임 입니다.</small>";
                  document.getElementsByTagName("span")[2].style.color ="red";
                  

               }
         };
   
         
          var em = function(e) {
               var e1 = new RegExp("^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$");
               var em = e.value;
               console.log("email : " + em);
               if(em.match(e1) != null) {
                  document.getElementsByTagName("span")[3].innerHTML = "<small>유효한 이메일 입니다.</small>";
                  document.getElementsByTagName("span")[3].style.color ="blue";
                  $("#emailauth").prop("disabled", false);
                     
                  } else {
                     document.getElementsByTagName("span")[3].innerHTML = "<small>유효하지 않은 이메일 입니다.</small>";
                     document.getElementsByTagName("span")[3].style.color ="red";
                     
                   }
            }  

          
        
          var ckn = function(k) {
               var k1 = txt;
               var cknb = k.value;
               console.log("인증번호 : " + cknb);
               if(cknb.match(k1) != null) {
                  document.getElementsByTagName("span")[4].innerHTML = "<small>정확이 입력하셨습니다.</small>";
                  document.getElementsByTagName("span")[4].style.color ="blue";
                     
                  } else {
                     document.getElementsByTagName("span")[4].innerHTML = "<small>잘못 입력 하셨습니다..</small>";
                     document.getElementsByTagName("span")[4].style.color ="red";
                     

                  }
            };
         
         
      var phn = function(s) {
            var s1 = new RegExp("^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$");
            var ph = s.value;
            console.log("핸드폰 번호 : " + ph);
            if(ph.match(s1) != null) {
              document.getElementsByTagName("span")[5].innerHTML = "<small>정확이 입력하셨습니다.</small>";
               document.getElementsByTagName("span")[5].style.color ="blue";
                  
               } else {
                  document.getElementsByTagName("span")[5].innerHTML = "<small>잘못 입력 하셨습니다.</small>";
                  document.getElementsByTagName("span")[5].style.color ="red";
                  

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
      }else{
         var idx = ct.indexOf(target.value);
         ct.splice(idx,1);
      }
   }
       
  $("#emailauth").on("click",function(){
   var param = {"email":$(email).val()};
   $("#confirm").prop("disabled",false);
   $("#confirmok").prop("disabled",false);
   $.post("${pageContext.servletContext.contextPath}/join/mail.do",param).done(function(rst){
      document.getElementById("checked").innerHTML="전송";
      document.getElementById("checked").style.color="green";
      document.getElementById("checked1").innerHTML="";
   });
   
}); 
   
  $("#confirmok").on("click", function() {
      var param = 
         {"confirmkey":$("#confirm").val()};
      $.post("${pageContext.servletContext.contextPath}/join/emailauth.do", param).done(function(rst) {
         console.log(rst);
         if(rst.includes("true") == true) {
            document.getElementById("checked1").innerHTML = "인증완료";
            document.getElementById("checked1").style.color = "green";
            $("#mail").prop("readonly", true);
            $("#emailauth").prop("disabled", true);   
            $("#confirm").prop("disabled", true);
            $("#confirmok").prop("disabled", true);
            $("#btnsubmit").prop("disabled", false);
         }else {
            document.getElementById("checked1").innerHTML = "인증실패";
            document.getElementById("checked1").style.color = "red";
            $("#confirm").prop("disabled", true);
            $("#confirmok").prop("disabled", true);
            document.getElementById("emailauth").innerHTML = "재전송";
            document.getElementById("checked").innerHTML = "";
         }
      });
   });
  
  
</script>
</html>