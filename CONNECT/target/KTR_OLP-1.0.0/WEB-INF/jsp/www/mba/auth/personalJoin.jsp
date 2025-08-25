<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
    <body>
    <h1 class="h3 mb-3 fw-normal">회원가입</h1> 
    <form id="send-form">
    	<input type="hidden" class="form-control" id="di" name="di" value="${map.di}"/>
    	<input type="hidden" class="form-control" id="birthday" name="birthday" value="${map.birthday}"/>
    	<input type="hidden" class="form-control" id="gender" name="gender" value="${map.gender}"/>  
		<div class="form-row">
		    <div class="form-group col-md-6">
		        <label for="inputEmail4">이름</label>
		        <input type="email" class="form-control" id="mberNm" name="mberNm" placeholder="이름" value="${map.mberNm}" readonly>
		    </div>
		    <div class="form-group col-md-6">
		        <label for="inputEmail4">휴대전화번호</label>  
		        <input type="text" class="form-control" id="cryalTelno" name="cryalTelno" placeholder="휴대전화번호" value="${map.cryalTelno}" readonly>
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

		
		<div class="form-row">
		    <div class="form-group col-md-6">
		        <label for="inputEmail4">주소</label>
		        <input type="text" class="form-control" id="zip" name="zip" placeholder="주소" style="margin-bottom:8px;" readonly>
		        <button type="button" class="btn btn-primary" onClick="openJusoPopup()">우편번호 검색</button>
		        <input type="text" class="form-control" id="detailAdres" name="detailAdres" placeholder="상세주소" style="margin-bottom:8px;" readonly>
		        <input type="text" class="form-control" id="detailAdres2" name="detailAdres2" placeholder="상세주소2" readonly>
		    </div> 
		</div>
		
				
		<div class="form-row">
		    <div class="form-group col-md-6">
		        <label for="inputPassword4">관심분야</label>
		        </br>
		        <select id="interestField" name="interestField">
		        	<option value="">선택하기</option>
		        	<option value="KC인증">KC인증</option>
		        	<option value="일반전기제품">일반전기제품</option>
		        	<option value="의료분야">의료분야</option>
		        	<option value="화장품">화장품</option>
		        	<option value="일반의뢰접수">일반의뢰접수</option>
		        </select>
		        <select id="interestField2" name="interestField2">
		        	<option value="">선택하기</option>
		        	<option value="KC인증">KC인증</option>
		        	<option value="일반전기제품">일반전기제품</option>
		        	<option value="의료분야">의료분야</option>
		        	<option value="화장품">화장품</option>
		        	<option value="일반의뢰접수">일반의뢰접수</option>
		        </select>
		        <select id="interestField3" name="interestField3">
		        	<option value="">선택하기</option>
		        	<option value="KC인증">KC인증</option>
		        	<option value="일반전기제품">일반전기제품</option>
		        	<option value="의료분야">의료분야</option>
		        	<option value="화장품">화장품</option>
		        	<option value="일반의뢰접수">일반의뢰접수</option>
		        </select>
		    </div>    
		    <div class="form-group col-md-6">
		        <label for="inputEmail4">직무</label>  
		        </br>
		        <select id="jobCode" name="jobCode">
		        	<option value="">선택하기</option>
		        	<option value="기획.전략">기획.전략</option>
		        	<option value="법무.사무.총무">법무.사무.총무</option>
		        	<option value="인사.HR">인사.HR</option>
		        	<option value="회계.세무">회계.세무</option>  
		        	<option value="마케팅.광고.MD">마케팅.광고.MD</option>ㄴ
		        	<option value="개발.데이터">개발.데이터</option>
		        	<option value="디자인">디자인</option>
		        	<option value="물류.무역">물류.무역</option>
		        	<option value="운전.운송.배송">운전.운송.배송</option>
		        	<option value="영업">영업</option>
		        	<option value="고객상담.TM">고객상담.TM</option>
		        	<option value="금융.보험">금융.보험</option>
		        	<option value="식.음료">식.음료</option>
		        	<option value="교객서비스.리테일">교객서비스.리테일</option>
		        	<option value="엔지니어링.설계">엔지니어링.설계</option>  
		        	<option value="제조.생산">제조.생산</option>
		        	<option value="교육">교육</option>
		        	<option value="건축.시설">건축.시설</option>
		        	<option value="의료.바이오">의료.바이오</option>
		        	<option value="미디어.몬화.스포츠">미디어.몬화.스포츠</option>
		        	<option value="공공.복지">공공.복지</option>
		        </select>
		    </div>    
		</div>
		
		<div class="form-row">
		    <div class="form-group col-md-6">
		        <label for="recommendTeam">추천 소속</label>
		        <input type="text" class="form-control" id="recommendTeam" name="recommendTeam" placeholder="추천 소속"> 
		    </div>  
		    <div class="form-group col-md-6">
		        <label for="recommendNm">추천 이름</label>  
		        <input type="text" class="form-control" id="recommendNm" name="recommendNm" placeholder="추천 이름">
		    </div>
		</div>
		
		<button type="button" class="btn btn-primary" onClick="insert()">회원가입</button>
		<input type="hidden" id="mberSeCd" name="mberSeCd" value='B'>
		<input type="hidden" id="sportHdqrDeptCd" name="sportHdqrDeptCd" value='A'>
		<input type="hidden" id="cstmrSttusCd" name="cstmrSttusCd" value='A'>
		<input type="hidden" id="dmstcOvseaSeCd" name="dmstcOvseaSeCd" value='A'>
		<input type="hidden" id="cstmrSeCd" name="cstmrSeCd" value='A'> 
		<input type="hidden" id="zrpctaxBsnmYn" name="zrpctaxBsnmYn" value='A'>     
		<input type="hidden" id="nationCd" name="nationCd" value='KO'>
		<input type="hidden" id="ihidnum" name="ihidnum" value='${map.birthday}'>
		<input type="hidden" name="duplicateYn" id="duplicateYn" >
		<input type="hidden" id="approveCode" name="approveCode" value = '1'>
		<input type="hidden" id="role" name="role" value = '1'>
	</form>  
    <script>     
  	
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
		
		if($("#duplicateYn").val() != "Y") {
			alert("아이디 중복체크를 진행해주세요.");
			$("#id").focus(); 
			return;
		}  
		
		if($("#email").val() == "") {  
			alert("이메일을 입력해주세요.");
			$("#email").focus();
			return;
		}
		
		if(!checkEmail($("#email").val())){
			alert("이메일을 형식을 확인해주세요");
			$("#email").focus();
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
		
		if($("#job").val() == "") {
			alert("직업을 선택하세요.");
			$("#job").focus();
			return;
		}
		
		if($("#interestField").val() == "") {
			alert("관심분야를 선택해주세요."); 
			$("#interestField").focus();
			return;
		}
		
		if($("#interestField2").val() == "") {
			alert("관심분야2를 선택해주세요."); 
			$("#interestField2").focus();
			return;
		}
		
		if($("#interestField3").val() == "") {
			alert("관심분야3를 선택해주세요."); 
			$("#interestField3").focus();
			return;
		}
		
		if($("#detailAdres").val() == "") {
			alert("주소를 입력해주세요."); 
			$("#detailAdres").focus();
			return;
		}  
		  
		$("#detailAdres").val($("#detailAdres").val() + " " + $("#detailAdres2").val());
		
 		var formData = $("#send-form").serializeObject();
 		console.log(formData);
 		$.ajax({
	        url: "/api/auth/insertMember",
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