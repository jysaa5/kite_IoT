<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><!-- 코어태그 -->
<%@page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>insertForm</title>

<!-- 기본 CSS 처리 시작 -->
<%@ include file="/WEB-INF/views/include/basic.jsp" %>
<!-- 기본 CSS 처리 끝-->

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
<style> 

.gender{

margin: 10px;

}
</style>

</head>
<body>

	<!-- 해더 시작 -->
<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<!-- 해더 끝 -->


	<!-- 메인 컨텐트 시작 -->
	<main role="main" class="container">
		<div class="d-flex align-items-center p-3 my-3 text-white-50 bg-purple rounded box-shadow">
			<!-- <img class="mr-3" src="https://getbootstrap.com/assets/brand/bootstrap-outline.svg" alt="" width="48" height="48"> -->
			<div class="lh-100">
				<h6 class="mb-0 text-white lh-100">로그인</h6>
				<small>Since 2020</small>
			</div>
		</div>

		<div class="my-3 p-3 bg-white rounded box-shadow">
			<h6 class="border-bottom border-gray pb-2 mb-0">로그인</h6>
			<div class="media text-muted pt-3">
				
				<form method ="post" id= "form">
				<div class="form-group" >
				 <label for="uemail"> 이메일(아이디)</label>
				 <input type="email" class="form-control" id="uemail" name ="uemail" required>
				</div>
				
				<div class="form-group" >
				 <label for="password">비밀번호</label>
				 <input type="password" id="upw" class="form-control" name ="upw" required>
				</div>
				
				<input type="submit" value="작성" class="btn btn-primary">
			
				</form>
				</div>
			</div>
	</main>
	
	<script>
	
	$(document).ready(function() {

		var selectOption = '';

		for (var i = 2020; i >= 1950; i--) {

			selectOption += '<option value='+i+'>' + i + '</option>\n';
		}
		//회원가입시 빈 공란인 것을 체크하는 것.
		$('#form').submit(function() {

			var f_uemail = $('#uemail');

			if (f_uemail.val().length < 1) {
				alert('아이디(이메일) 데이터를 입력해야 합니다.');
				f_uemail.focus();
				return false;
			}

			var f_upw = $('#upw');
			if (f_upw.val().length < 1) {
				alert('비밀번호 입력은 필수 항목입니다.');
				f_upw.focus();
				return false;
			}

			var f_uname = $('#uname');
			if (f_uname.val().length < 1) {
				alert('이름은 입력은 필수 항목입니다.');
				f_uname.focus();
				return false;
			}

			var f_gender1 = $('#gender1').prop('checked');
			var f_gender2 = $('#gender2').prop('checked');

			if (f_gender1 == false && f_gender2 == false) {
				alert('성별체크는 필수 사항입니다.');
				return false; //submit이 처리되지 않게 한다.
			}

			var f_idcheck = $('#idcheck');
			if (!f_idcheck.prop('checked')) {
				alert('사용자의 아이디가 사용가능 유무를 체크해주셔야합니다.');
				return false;
			}

			$.ajax({

				url: 'reg_ajax',
				type: 'post',
				data: $(this).serialize(),
				success: function(data){
					if (data == 'success'){
						alert('회원가입되었습니다.');
						location.href = '../'; //index.jsp로 보냄.
					} else {
						alert('회원 가입 처리중에 오류가 발생했습니다.');
					}

				}
			});

			return false;

		});

		$('#byear').html(selectOption);

		//아이디 쓰는 칸에서 커서를 안으로 옮겼을 때.
		$('#uemail').focusin(function() {

			//아이디 쓰는 칸에 공백문자 넣어주기
			$(this).val('');

			//아이디 쓰는 칸 옆에 글에 공백문자 넣어주기.
			$('#idchk_msg').text('');

			$('#idcheck').prop("checked", false);
		});

		//아이디 쓰는 칸에서 밖으로 커서를 빼내었을 때.
		$('#uemail').focusout(function() {
			//alert("focusout 이벤트");

			var param = $(this).val();

			if (param.length < 3) {
				//alert('아이디는 12자리 이상의 문자만 가능합니다.');
				$('#idchk_msg').text('아이디는 12자리 이상의 문자만 가능합니다.');
				$('#idchk_msg').addClass('color_red');
				return false;
			}

			//비동기 통신: id 값을 전송 후 Y 또는 N의 값을 받는 통신.
			$.ajax({
				/* url: '/op/member/idChk', : 절대 경로*/
				url : 'idChk',
				type : 'get',
				data : {
					uid : param
				},
				success : function(data) {
					//Y or N
					//alert(data);

					//클래스 삭제
					$('#idchk_msg').removeClass('color_blue');
					$('#idchk_msg').removeClass('color_red');

					//클래스 추가
					if (data == "Y") {
						$('#idchk_msg').text('사용가능한 아이디(이메일) 입니다.');
						$('#idcheck').prop("checked", true);
						$('#idchk_msg').addClass('color_blue');

					} else {
						$('#idchk_msg').text('사용 불가한 아이디(이메일) 입니다.');
						$('#idcheck').prop("checked", false);
						$('#idchk_msg').addClass('color_red');
					}
				}

			});

		});

	});
	
	
	</script>

	<!-- 메인 컨텐트 끝 -->

	<!-- 푸터 시작 -->
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<!-- 푸터 끝-->
	
	
</body>
</html>