<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
%>

<!-- head 영역 -->    
<jsp:include page="include/head.jsp">
	<jsp:param name="title" value="백신예약: 예약 수정" />
</jsp:include>
<script type="text/javascript" src="./resources/js/validation.js"></script>

<body>
	<div class="wrapper">
		<!-- nav 영역(include 디렉티브 태그 이용) -->
		<%@ include file="include/menu.jsp" %>
		
		<!-- visual & title Area --> 
		<div class="visualArea">
			<div class="dimArea"></div>
			<div class="container">
				<h1 class="move-up">예약 수정</h1>
			</div>
		</div>
		
		<!-- 예약하기(form area) -->
		<div class="pd formArea">
			<div class="container"> 
				<div class="row">
					<div class="col-sm-8 offset-sm-2 noticeTextArea">
						<p class="lgText">개인정보 수집 및 이용에 대한 안내</p>
						<p>&ulcorner;감염병의 예방 및 관리에 관한 법률&lrcorner; 제33조의 4 및 같은 법 시행령 제32조의 3에 따라<br>코로나19 예방접종 예약신청을 위하여 다음의 개인정보를 수집합니다.</p>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-8 offset-sm-2 progressBar">
						<ul>
							<li class="active">
								<span class="smText">STEP 01.</span>
								<span class="lgText">예약자 정보 입력</span>
							</li>
							<li class="">
								<span class="smText">STEP 02.</span>
								<span class="lgText">의료기관 찾기</span>
							</li>
							<li class="">
								<span class="smText">STEP 03.</span>
								<span class="lgText">예약 내용 확인</span>
							</li>
						</ul>
					</div>
				</div>
				<!-- 입력값을 데이터베이스에 저장하고 결과창에 출력하는 프로세스 -->
				<form name="newBooking" action="processEditing.jsp" method="post">
					<div class="row">
						<div class="col-sm-8 offset-sm-2 formAreaInner">
							<%
								//수정 페이지인데 table vac를 불러오는 이유
								//수정페이지는 결과페이지에서 넘어옵니다(예약-결과-수정 or 조회-결과-수정)
								//결과페이지에서 표시되는 예약자의 정보가 vac에 저장되어 있어서 이걸 불러옵니다
								PreparedStatement pstmt = null;
								ResultSet rs = null;
								String sql = "select * from vac";
								pstmt = conn.prepareStatement(sql);
								rs = pstmt.executeQuery();
								while (rs.next()){
									String vac = rs.getString("v_vaccine");
									if(vac.equals("Moderna")) vac = "모더나";
									if(vac.equals("Pfizer")) vac = "화이자";
									
									String name = rs.getString("v_name");
									String idNum1 = rs.getString("v_idNum1");
									String idNum2 = rs.getString("v_idNum2");
									String phone1 = rs.getString("v_phone1");
									String phone2 = rs.getString("v_phone2");
									String phone3 = rs.getString("v_phone3");
							%>
							<div class="form-group row">
								<div class="col-sm-4 labelArea">
									<label>백신 선택<span class="require-mark">*</span></label>
								</div>
								<div class="col-sm-8 inputArea">
									<ul class="radioArea">
										<li><input type="radio" name="vaccine" value="Moderna" checked> 모더나</li>
										<li><input type="radio" name="vaccine" value="Pfizer"> 화이자</li>
									</ul>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-sm-4 labelArea">
									<label>예약자 이름<span class="require-mark">*</span></label>
								</div>
								<div class="col-sm-8 inputArea">
									<input type="text" id="name" name="name" class="form-control" required value="<%=name%>">
									<p class="alertText" id="nameError">* 이름에는 한글만 사용 가능합니다</p>
								</div>
							</div>
							<div class="form-group row ">
								<div class="col-sm-4 labelArea">
									<label>예약자 주민등록번호<span class="require-mark">*</span></label>
								</div>
								<div class="col-sm-8 inputArea">
									<div class="row idNumArea">
										<div class="col-4">
											<input type="text" id="idNum1" name="idNum1" maxlength="6" size="6" class="form-control idNum-01" required value="<%=idNum1 %>">
										</div> 
										<span class="col-1 align-center">-</span> 
										<div class="col-2">
											<input type="text" id="idNum2" name="idNum2" maxlength="1" size="1" class="form-control idNum-02" required value="<%=idNum2 %>">
										</div>
										<span class="col-5">******</span>
									</div>
									<p class="alertText" id="birthError">* 주민등록번호 앞자리는 6개의 숫자만 입력 가능합니다</p>
									<p class="alertText" id="genError">* 주민등록번호 뒷자리는 1,2,3,4만 입력 가능합니다</p>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-sm-4 labelArea">
									<label>예약자 휴대폰 번호<span class="require-mark">*</span></label>
								</div>
								<div class="col-sm-8 inputArea">
									<div class="row phnNumArea">
										<div class="col-3" style="text-align:center">
											<%=phone1 %>
										</div>
										<span class="col-1 align-center">-</span>
										<div class="col-3" style="text-align:center">
											<%=phone2 %>
										</div>
										<span class="col-1 align-center">-</span>
										<div class="col-3" style="text-align:center">
											<%=phone3 %>
										</div>
									</div>
									<p class="alertText" id="phnError">* 휴대폰 번호를 정확하게 입력하세요</p>
								</div>
							</div>
							<div class="btnArea">
								<ul class="row justify-content-center">
									<li class="col-3"><input type="submit" class="btn bookingBtn" value="다음" onclick="checkBooking()"></li>
									<li class="col-3"><a href="processEditcancel1.jsp" class="btn btn-outline-secondary">취소</a></li>
								</ul>
							</div>
							<%
								}
								if(rs != null) rs.close();
								if(pstmt != null) pstmt.close();
								if(conn != null) conn.close();
							%>
						</div>
					</div>
				</form>
			</div>
		</div>
		
		<!-- footer 영역(include 디렉티브 태그 이용) -->
		<%@ include file="include/footer.jsp" %>
	</div>
</body>
</html>
