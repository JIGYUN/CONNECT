<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.apache.commons.configuration.Configuration"%>
<%@page import="org.springframework.validation.Errors"%>
<%@page import="org.springframework.validation.ObjectError"%>
<%@page import="org.springframework.context.MessageSource"%>
<%@page import="org.springframework.web.servlet.support.RequestContext"%>
<%@page import="org.springframework.validation.BindingResult"%>
<script language='javascript'>

</script>
<!DOCTYPE html>
<html>
    <body>
    <h1 class="h3 mb-3 fw-normal">회원가입</h1> 

    <form id="send-form">
		<div class="form-row">
		    <div class="form-group col-md-6"> 
		        <label for="inputEmail4">이름</label>
		        <input type="email" class="form-control" id="mberNm" name="mberNm" placeholder="이름" readonly="readonly">
		    </div>
		    <div class="form-group col-md-6">
		        <label for="inputEmail4">휴대전화번호</label>
		        <input type="text" class="form-control" id="cryalTelno" name="cryalTelno" placeholder="휴대전화번호" readonly="readonly">  
		        <button type="button" class="btn btn-primary" onClick="fnPopup()">본인인증</button>
		    </div>
		</div>
		
		<div class="form-row">
		    <div class="form-group col-md-6">
		        <label for="inputPassword4">아이디</label>
		        <input type="text" class="form-control" id="id" name="id" placeholder="아이디">
		        <button type="button" class="btn btn-primary" onClick="duplicateId()">아이디 중복체크</button>
		    </div>  
		    <div class="form-group col-md-6">
		        <label for="inputPassword4">이메일</label>
		        <input type="text" class="form-control" id="email" name="email" placeholder="이메일">
		    </div>
		</div>
		
		<div class="form-row">
		    <div class="form-group col-md-6">
		        <label for="inputEmail4">비밀번호</label>
		        <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
		    </div>
		    <div class="form-group col-md-6">
		        <label for="inputPassword4">비밀번호 확인</label>
		        <input type="password" class="form-control" id="passwordConfirm" name="passwordConfirm" placeholder="비밀번호 확인">
		    </div>
		</div>
		
		<button type="button" class="btn btn-primary" onClick="insert()">회원가입</button>
    	<input type="hidden" id="di" name="di" />
    	<input type="hidden" id="birthday" name="birthday"/>
    	<input type="hidden" id="gender" name="gender" />
		<input type="hidden" id="mberSeCd" name="mberSeCd" value = 'A'>
		<input type="hidden" id="approveCode" name="approveCode" value = '1'>
		<input type="hidden" id="role" name="role" value = '1'>
		<input type="hidden" name="duplicateYn" id="duplicateYn" >
		
		<input type="hidden" id="sportHdqrDeptCd" name="sportHdqrDeptCd" value = 'A'>
		<input type="hidden" id="cstmrSttusCd" name="cstmrSttusCd" value = 'A'>
		<input type="hidden" id="dmstcOvseaSeCd" name="dmstcOvseaSeCd" value = 'A'>
		<input type="hidden" id="cstmrSeCd" name="cstmrSeCd" value = 'A'> 
		<input type="hidden" id="zrpctaxBsnmYn" name="zrpctaxBsnmYn" value = 'A'>
		<input type="hidden" id="nationCd" name="nationCd" value = 'KO'>

	</form>
    <script>
	
	function duplicateId() {
		if($("#id").val() == ""){
			alert("아이디를 입력해주세요.");
			$("#id").focus();
			return;
		}  
		
		var formData = {};
		formData.id = $("#id").val();

 		$.ajax({
	        url: "/api/auth/duplicateId",
	        type: "post",
	        contentType: "application/json;charset=utf-8", 
	        dataType :'json',
	 		data : JSON.stringify(formData), 
	        success: function (map){
	        	console.log("map >> " + map)
				if (map.result.cnt > 0) {
					alert("이미 사용중인 아이디 입니다.");
					$("#duplicateYn").val("N");
				} else {
					alert("사용가능한 아이디 입니다.");
					$("#duplicateYn").val("Y");
				}  
	        },
	        error: function(request, status, error){
	            
	        }
	   });
	}
	
	function insert() {
		
		if($("#id").val() == "") {
			alert("아이디를 입력해주세요.");
			$("#id").focus();
			return;
		}
		
		if(!checkId($("#id").val())){
			alert("6-12자의 영문, 숫자, 기호(- _ )만 사용 가능합니다.");
			$("#id").focus();
			return;
		}  
	
		
		if($("#password").val() == "") {
			alert("비밀번호를 입력해주세요.");
			$("#password").focus();
			return; 
		}
		
		if(!checkPw($("#password").val())){
			alert("8자리 이상, 영문 대/소문자, 특수문자, 숫자를 조합해서 입력해주세요.");
			$("#password").focus();
			return;
		}
		
		if($("#passwordConfirm").val() == "") {
			alert("비밀번호 확인을 입력해주세요.");
			$("#passwordConfirm").focus();
			return;
		}

		if(!($("#password").val() == $("#passwordConfirm").val())) {
			alert("비밀번호가 일지하지 않습니다.");
			$("#passwordConfirm").focus();
			return;
		}
		
 		var formData = $("#send-form").serializeObject();
 		console.log(formData);
 		$.ajax({
	        url: "/api/auth/insertCompanyMember",
	        type: "post",
	        contentType: "application/json;charset=utf-8",
	        dataType :'json',
	 		data : JSON.stringify(formData),
	        success: function (map){
                alert("회원가입이 완료되었습니다.");
	        	goLink("/mba/auth/login");
	        },
	        error: function(request, status, error){
	            
	        }
	   });
	}


	$(document).ready(function(){
        $("input[name=name]").keydown(function (key) {
            if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
            	insert();
            }
        });
    });
	
  </script>
  </body>

</html>