<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>
<!DOCTYPE html>
<html lang="ko">
    <tiles:insertAttribute name="header" />
    <body>
    	<!-- 상단 내비 (sidebar.jsp) -->
        <tiles:insertAttribute name="left"/>

	    <!-- 본문 -->
	    <main class="container">
      		<tiles:insertAttribute name="body"/>
    	</main>

    	<!-- 푸터 -->
    	<tiles:insertAttribute name="foot" />
    </body>
</html>