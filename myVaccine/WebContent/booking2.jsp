<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
%>

<!-- head 영역 -->    
<jsp:include page="include/head.jsp">
	<jsp:param name="title" value="백신예약: 예약하기" />
</jsp:include>


<!-- datepicker sources -->
<script src="resources/js/bootstrap-datepicker.js"></script>
<script src="resources/js/bootstrap-datepicker.ko.min.js"></script>
<script src="resources/js/datepicker_custom.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		
		/* '검색' 버튼 이벤트 */
		$('#showRes').trigger('click');
		$("#showRes").bind('click', function() {
			
			document.findInst.target = 'ifrm';
		    document.findInst.action = 'processInst.jsp';
		    document.findInst.submit();
			
			if ($('.SearchResultArea').css('display') == 'none') {
				$('.SearchResultArea').slideDown();
			}
			
			/* 아이프레임 영역 새로고침 */
		    document.getElementById("searchList").contentDocument.location.reload(true);
		    document.getElementById("searchResult").contentDocument.location.reload(true);
		});
		
		/* 아이프레임 내 form 값 submit */
		$("#regButton").bind('click', function() {
			$("#searchResult").contents().find("#sendformBtn").trigger('click');
			location.href="result.jsp"
		});
		
	});
	function button_cancel(){
		if (confirm("예약을 취소하시겠습니까??") == true){    //확인
		    document.cancel.action = 'processCancel.jsp';
			document.cancel.submit();
			alert("예약을 취소하였습니다.");
		}else{   //취소
		    return;
		}
	}
</script>


<body>
	<div class="wrapper">
		<!-- nav 영역(include 디렉티브 태그 이용) -->
		<%@ include file="include/menu.jsp" %>
		
		<!-- visual & title Area --> 
		<div class="visualArea">
			<div class="dimArea"></div>
			<div class="container">
				<h1 class="move-up">예약하기</h1>
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
							<li class="">
								<span class="smText">STEP 01.</span>
								<span class="lgText">예약자 정보 입력</span>
							</li>
							<li class="active">
								<span class="smText">STEP 02.</span>
								<span class="lgText">의료기관 찾기</span>
							</li>
							<li class="">
								<span class="smText">STEP 03.</span>
								<span class="lgText">예약 결과 확인</span>
							</li>
						</ul>
					</div>
				</div>
				<!-- // 데이터가 한번에 처리 X 검색 클릭 후 새로고침 해야 데이터 가져옴 -->
				<div class="row">
					<div class="col-sm-8 offset-sm-2 findInstitution">
						<div class="searchArea">
				        	<div class="container-fluid">
				        		<form name="findInst" id="findInst" method="post">
					        		<div class="form-group row datePicker">
					        			<div class="col-sm-2 labelArea">
											<label>날짜 선택<span class="require-mark">*</span></label>
										</div>
										<div class="col-sm-10 inputArea">
											<input type="text" class="form-control datePickerInput" name="date" id="datePicker" required>
										</div>
					        		</div>
					        		<div class="form-group row placePicker">
					        			<div class="col-sm-2 labelArea">
											<label>기관 선택<span class="require-mark">*</span></label>
										</div>
					        			<div class="col-sm-7 inputArea">
					        				<select class="form-select" name="addr1" required>
					        					<option selected>광역시도</option>
					        					<option value="대구광역시">대구광역시</option>
						        			</select>
						        			<select class="form-select" name="addr2" required>
						        				<option selected>시군구</option>
						        				<option value="동구">동구</option>
						        			</select>
						        			<select class="form-select" name="addr3" required>
						        				<option selected>읍면동</option>
						        				<option value="검사동">검사동</option>
						        				<option value="효목동">효목동</option>
						        			</select>
					        			</div>
					        			<div class="col-sm-3 btnArea">
						        			<button type="button" class="btn btn-outline-default" id="showRes">검색</button>
						        		</div>
					        		</div>
				        		</form>
				        		<!-- page 이동 없이 submit을 하기 위해 필요 -->
				        		<iframe name='ifrm' style="display:none"></iframe>
				        	</div>
				        </div>  
						
						<div class="SearchResultArea">
				        	<div class="row">
				        		<!-- 리스트 카운트 -->
				        		<%
								 	PreparedStatement pstmt = null;
		        					ResultSet rs = null;
		        					int cnt = 0;
		        							
			        				String sql = "select count(distinct p_instName) from tmpInstTBL";
			        				pstmt = conn.prepareStatement(sql);
			        				rs = pstmt.executeQuery();
			        				
			        				while(rs.next()){
			        					cnt = rs.getInt(1);
								%>
				        		<p>검색 결과 총 <%=cnt%>개</p>
				        		<%
			        				}
				        		%>
				        		<div class="col-sm-4 instArea">
				        			<iframe class="ifrm_left" name="ifrm_left" src="searchList.jsp" id="searchList"></iframe>
				        			
				        		</div>
				        		
				        		<div class="col-sm-8 infoArea">
				        			<iframe class="ifrm_right" name="ifrm_right" src="searchResult.jsp" id="searchResult"></iframe>
				        		</div>
				        	</div>
				        </div>
				        
				        <div class="btnArea">
							<ul class="row justify-content-center">
								<li class="col-3">
									<button class="btn bookingBtn" id="regButton">예약</button>
								</li>
								<li class="col-3">
									<form name="cancel" id="cancel" method="post">
										<button class="btn btn-outline-secondary" onclick="button_cancel()">취소</button>
									</form>
								</li>
							</ul>
						</div>	
					</div>
				</div>
			</div>
		</div>
		<%
	       	if(rs != null) rs.close();
	   		if(pstmt != null) pstmt.close();
	   		if(conn != null) conn.close();
		%>
		<!-- footer 영역(include 디렉티브 태그 이용) -->
		<%@ include file="include/footer.jsp" %>
	</div>
</body>
</html>