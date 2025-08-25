<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<div class="container">
    <header class="blog-header py-3">
        <div class="row flex-nowrap justify-content-between align-items-center">
            <div class="col-4 pt-1">
                <!--<a class="text-muted" href="#">Valuable Works</a>-->
            </div>
            <div class="col-4 text-center">  
                <a class="blog-header-logo text-dark"  href="/">KTR_OLP</a>
            </div>
            <div class="col-4 d-flex justify-content-end align-items-center">
            	<sec:authorize ifNotGranted="EXTERNAL_AUTH">
	                <div style="margin-right:5px;"><a class="btn btn-sm btn-outline-secondary" href="/mba/auth/join">회원가입</a></div>
	                <div><a class="btn btn-sm btn-outline-secondary" href="/mba/auth/login">로그인</a></div>
                </sec:authorize>  
                <sec:authorize access="hasRole('EXTERNAL_AUTH')">
                	<div><a class="btn btn-sm btn-outline-secondary" href="/mba/auth/logout">로그아웃</a></div>  
                </sec:authorize>  
            </div>  
        </div>    
    </header>
    <nav class="navbar navbar-expand-lg navbar-light bg-light rounded">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample09" aria-controls="navbarsExample09" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarsExample09">
            <ul class="navbar-nav mr-auto" id="topBar">
                <li class="nav-item" id="schedule"><a class="nav-link" href="/bbs/board/boardList">게시판</a></li>
                <li class="nav-item" id="household"><a class="nav-link" href="/mpg/mypage/companyMemberApprove">기업요청 관리</a></li>
                <li class="nav-item" id="reminder"><a class="nav-link" href="/mpg/mypage/companyModify">기업정보 관리</a></li>
                <li class="nav-item" id="place"><a class="nav-link" href="/mpg/mypage/companyMemberSpecify">기업 담당자 관리</a></li> 
            </ul>     
        </div>
    </nav>
</div>