<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
%>

<!-- head 영역 -->    
<jsp:include page="include/head.jsp">
	<jsp:param name="title" value="백신예약: 예약완료" />
</jsp:include>


<body>
	<div class="wrapper">
		<!-- nav 영역(include 디렉티브 태그 이용) -->
		<%@ include file="include/menu.jsp" %>
		
		<!-- visual & title Area --> 
		<div class="visualArea">
			<div class="dimArea"></div>
			<div class="container">
				<h1 class="move-up">예약 완료</h1>
			</div>
		</div>
		
		
		
		<!-- 예약 완료(result area) -->
		<div class="pd resultArea">
			<div class="container">
				<!-- 예약조회/수정페이지로 출력될 때에는 해당영역에 style="display:none"을 넣어주시기 바랍니다 -->
				<div class="row">
					<div class="col-sm-8 offset-sm-2 progressBar">
						<ul>
							<li class="">
								<span class="smText">STEP 01.</span>
								<span class="lgText">예약자 정보 입력</span>
							</li>
							<li class="">
								<span class="smText">STEP 02.</span>
								<span class="lgText">의료기관 찾기</span>
							</li>
							<li class="active">
								<span class="smText">STEP 03.</span>
								<span class="lgText">예약 결과 확인</span>
							</li>
						</ul>
					</div>
				</div>

				<!-- 예약자 정보 영역(userArea) -->
				<div class="row">
					<div class="col-sm-8 offset-sm-2 infoArea userArea">
						<h2>예약자 정보</h2>
						<table class="table align-middle">
							<tbody>
								<%
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
								<tr>
									<th>이름</th>
									<td><%=name %></td>
								</tr>
								<tr>
									<th>주민등록번호</th>
									<td><%=idNum1 %> - <%=idNum2 %><span>******</span></td>
								</tr>
								<tr>
									<th>휴대폰 번호</th>
									<td><%=phone1 %> - <%=phone2 %> - <%=phone3 %></td>
                </tr>
							</tbody>
						</table>
					</div>
						
					<!-- 예약 정보 영역 -->
					<div class="col-sm-8 offset-sm-2 infoArea vacArea">
						<h2>예약 정보</h2>
						<table class="table align-middle">
							<tbody>
								<tr>
									<th>선택한 백신</th>
									<td><%=vac %></td>
								</tr>
								<%
									}

									String sql2 = "select p_instName, p_instAddress1, p_instAddress2, p_instAddress3, p_instAddress4, p_appDate, date_format(vac_time, '%H:%i') from tmpInstTBL2";
									pstmt = conn.prepareStatement(sql2);
									rs = pstmt.executeQuery();
									while (rs.next()){
										String instName = rs.getString("p_instName");
										String addr1 = rs.getString("p_instAddress1");
										String addr2 = rs.getString("p_instAddress2");
										String addr3 = rs.getString("p_instAddress3");
										String addr4 = rs.getString("p_instAddress4");
										String appDate = rs.getString("p_appDate");
										String selectTime = rs.getString("date_format(vac_time, '%H:%i')");
								%>
								<tr>
									<th>의료기관</th>
									<td><%= instName %> (<%=addr1 %> <%=addr2 %> <%=addr3 %> <%=addr4 %>)</td>
								</tr>
								<tr>
									<th>1차 접종일시</th>
									<td style="color:#0048F5"><%= appDate %> ( <%=selectTime %> )</td>
								</tr>
								<%
									}
									if(rs != null) rs.close();
									if(pstmt != null) pstmt.close();
									if(conn != null) conn.close();
								%>
								<tr>
									<th>2차 접종일시</th>
									<td style="color:#0048F5"> 1차 접종일로부터 6주 후</td>
								</tr>

							</tbody>
						</table>
					</div>
					<!-- 수정/확인/취소 버튼 추가(2021.09.03) -->
					<!-- 페이지 구성 시 필요없는 버튼이 있으면 li 삭제 -->
					<div class="col-sm-8 offset-sm-2 btnArea">
						<ul class="row justify-content-center">
							<li class="col-3"><form action = "bookingEdit.jsp" method="post"><button class="btn btn-outline-default">수정</button></form></li>
							<li class="col-3"><a href="#" class="btn btn-default">확인</a></li>
							<li class="col-3"><form action = "processCancel.jsp" method="post"><button class="btn btn-secondary">취소</button></form></li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<!-- footer 영역(include 디렉티브 태그 이용) -->
		<%@ include file="include/footer.jsp" %>
	</div>
</body>
</html>