<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
    <body>
    <style>
	    .btn {
	        text-transform: capitalize;
	        font-size: 15px;
	        padding: 10px 19px;
	        cursor: pointer
	    }
	
	    .m-b-20 {
	        margin-bottom: 20px
	    }
	
	    .btn-md {
	        padding: 10px 16px;
	        font-size: 15px;
	        line-height: 23px
	    }  
	
	    .heading{
	      font-size: 21px;
	    }
	
	    #infoMessage p{
	        color: red !important;
	    }
	 
	
	    .btn-google {
	        color: #545454;
	        background-color: #ffffff;
	        box-shadow: 0 1px 2px 1px #ddd;
	    }
	
	
	    .or-container {
	        align-items: center;
	        color: #ccc;
	        display: flex;
	        margin: 25px 0;
	    }
	
	    .line-separator {
	        background-color: #ccc;
	        flex-grow: 5;
	        height: 1px;
	    }
	
	    .or-label {
	        flex-grow: 1;
	        margin: 0 15px;
	        text-align: center;
	    }
	</style>
    <meta name="google-signin-client_id" content="442434028472-3k5o0k7urabal0ff915pt58788v44pm1.apps.googleusercontent.com">
    <div class="col-sm-5">
        <form name="frm" id="frm" method="post" action="/com/auth/login">
        <input type="hidden" name="loginType" value="n" >
        <h1 class="h3 mb-3 fw-normal">로그인</h1>
        <div class="form-floating">
            <input type="text" class="form-control" name="mberId" id="mberId" placeholder="아이디">
            <label for="id"></label>
        </div>
        <div class="form-floating">
            <input type="password" class="form-control" name="mberPw" id="mberPw" placeholder="비밀번호">
            <label for="password"></label>
        </div>      
        <c:if test="${map.failYn eq 'Y'}">  
        	<p style="color:red;">입력하신 회원정보를 찾을 수 없습니다.</p>
        </c:if>  
        <div class="row" style="padding:5px;">
            <div class="col-md-12">
                <button class="btn btn-primary w-100 py-2" type="button" onClick="goLogin()">Login</button>
            </div>  
	    </div>      
        <div class="row" style="padding:5px;">
	  	    <div class="col-md-12">
                <button class="btn btn-primary w-100 py-2" type="button" onClick="goLink('/mba/auth/companyDocJoin')">회원가입</button>
            </div>
	    </div>  
        <div class="row" style="padding:5px;"> 
	  	    <div class="col-md-12">
                <button class="btn btn-primary w-100 py-2" type="button" onClick="goLink('/mba/auth/idFind')">아이디 찾기</button>
            </div> 
	    </div>
        <div class="row" style="padding:5px;">
	  	    <div class="col-md-12">
                <button class="btn btn-primary w-100 py-2" type="button" onClick="goLink('/mba/auth/pwFind')">비밀번호 찾기</button>
            </div>
	    </div>
    </form>
    </main>
    </div>
    <script>
		function goLogin(){
		    if ($("#mberId").val() == "") {
		        alert("아이디를 입력해주세요.");
		        return;
		    }
		    
			if(!checkId($("#mberId").val())){
				alert("6-12자의 영문, 숫자, 기호(- _ )만 사용 가능합니다.");
				$("#mberId").focus();
				return;
			}
			  
		    if ($("#mberPw").val() == "") {
		        alert("비밀번호를 입력해주세요.");
		        return;
		    }
		    
			if(!checkPw($("#mberPw").val())){
				alert("8자리 이상, 영문 대/소문자, 특수문자, 숫자를 조합해서 입력해주세요.");
				$("#mberPw").focus();
				return;
			}
	
	        $("#frm").attr("method","post");
	        $("#frm").attr("action", "/com/auth/login");
	        $("#frm").submit();
		}
   
	    $(document).ready(function(){
	        $("input[name=mberPw]").keydown(function (key) {
	            if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
	                goLogin();
	            }
	        });
	    });
    </script>
    </body>
</html>