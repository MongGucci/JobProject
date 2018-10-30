<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <c:set var="path" value="${pageContext.servletContext.contextPath}" />
    <link rel="stylesheet" type="text/css" href="${path}/semantic/semantic.css">
<script
  src="https://code.jquery.com/jquery-3.1.1.min.js"
  integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
  crossorigin="anonymous"></script>
<script src="${path}/semantic/semantic.js"></script>
<div >
<i class="question circle outline icon" style="font-size: 30pt; color:gray; "id="ex" ></i>
</div>
<script>
$("#ex").mouseover(function() {
  $( "#ex" ).css('font-size', '20pt');
});
$("#ex").mouseout(function() {
	  $( "#ex" ).css('font-size', '15pt');
	});


</script>
