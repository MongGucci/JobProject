<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<title>JOB GO</title>
<div style="text-align: center;">
	<h1>채용 정보 공고</h1>
	<form
		action="${pageContext.servletContext.contextPath }/hire/addhire.do"
		id="sb" method="post" enctype="multipart/form-data">
		채용 제목 : <input type="text" name="title"
			style="width: 200px; height: 28px;" id="title" onchange="ti(this)"><br>
		<br> 채용 내용 : <input type="text" name="content"
			style="width: 300px; height: 28px;" id="content" onchange="c(this)"><br>
		<br> 시 작 일 : <input type="date" class="form-control"
			name="startdate" style="width: 200px; height: 28px;" id="start"><br>
		<br> 마 감 일 : <input type="date" class="form-control"
			name="enddate" style="width: 200px; height: 28px;" id="end"><br>
		<br> 회사 이름 : <input type="text" name="name"
			style="width: 200px; height: 28px;" id="name" onchange="con(this)"><br>
		<span></span><br> 회사 직무 : <select name="jobcate" id="jobcate"
			style="width: 200px; height: 28px;">
			<option value="">선택해주세요</option>
			<c:forEach var="j" items="${alljob }">
				<option value="${j.CATENAME }">${j.CATENAME }</option>
			</c:forEach>
		</select><br> <Br> 채용 인원 : <select name="recruitnum" id="recruitnum"
			style="width: 200px; height: 28px;">
			<c:forEach var="m" begin="0" end="50" step="1">
				<option value="${m }">${m }명</option>
			</c:forEach>
		</select><br> <br> 이 메 일 : <input type="text" name="email"
			style="width: 200px; height: 28px;" id="email" onchange="em(this)"><br>
		<br> 채 용 직 : <select name="hireshape" id="hireshape"
			style="width: 200px; height: 28px;">
			<option value="">선택해주세요</option>
			<c:forEach var="h" items="${allshape }">
				<option value="${h.SHAPE }">${h.SHAPE }</option>
			</c:forEach>
		</select><br> <br> 채용 정보 : <input type="file" name="path"> <br>
		<br>
		<button type="submit" id="sbt" onchange="sbt(this)" disabled>채용
			공고 등록</button>

	</form>
</div>
<script>
	// 버튼 활성화 
	var ar = [ false, false, false, false ];
	var vaild = function() {
		console.log(ar);
		if (ar.includes(false)) {
			document.getElementById("sbt").disabled = true;
		} else {
			document.getElementById("sbt").disabled = false;
		}

	};

	var ti = function(a) {
		var tiput = a.value
		if (tiput == null) {
			ar[0] = false;
		} else {
			ar[0] = true;
		}
		vaild();
	};

	var c = function(b) {
		var cput = b.value
		if (cput == null) {
			ar[1] = false;
		} else {
			ar[1] = true;
		}
		vaild();
	};

	var con = function(a) {
		var cona = a.value;
		console.log("회사 이름 : " + cona);
		var xhr = new XMLHttpRequest();
		xhr.open("get", "${path}/hire/coajax.do?coname=" + cona, true);
		xhr.onreadystatechange = function() {
			if (this.readyState == 4) {
				var obj = JSON.parse(this.responseText);
				console.log(obj.no);
				if (obj.no == "on") {
					document.getElementsByTagName("span")[0].innerHTML = "<small>등록되지 않은 기업입니다.</small>";
					document.getElementsByTagName("span")[0].style.color = "red";
					ar[2] = false;
				} else {
					document.getElementsByTagName("span")[0].innerHTML = "";
					ar[2] = true;
				}
				vaild();
			}

		}
		xhr.send();
	};

	var em = function(d) {
		var emput = d.value
		if (emput == null) {
			ar[3] = false;
		} else {
			ar[3] = true;
		}
		vaild();
	};

	
	
</script>
