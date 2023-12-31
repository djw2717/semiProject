<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="vo.WorkingTimeVO"%>
<%@page import="dao.AttendanceReasonDAO"%>
<%@page import="dao.EmployeeDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="vo.EmployeeVO"%>
<%@page import="dao.AttendenceDAO"%>
<%@page import="vo.AttendenceVO"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset='utf-8' />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<!-- <link href='../css/main.css' rel='stylesheet' /> -->
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link href="../css/styles.css" rel="stylesheet" />
<link rel="shortcut icon" href="#">
<script src='../js/main.js'></script>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<title>근태관리</title>

<!-- <link rel="stylesheet" href="../attendance/main.css" /> -->

<style>
</style>

<!-- 스크립트 부분 -->


<%
String Today = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>



<script>
	function times() {

		var onul = new Date(); /* 로컬컴퓨터에 설정된 표준시간대를 기준으로 한 현재 시간을 추출 */

		var dd = [ "Sun", "Mon", "Tues", "Wednes", "Thurs", "Fri", "Satur" ];

		var y = onul.getFullYear(); //년

		var m2 = onul.getMonth() + 1; //월

		var d2 = onul.getDate(); //일

		var d = onul.getDay(); /*현재 '요일'을 숫자로 추출 */

		var week = new Array('(일) ', '(월) ', '(화) ', '(수) ', '(목) ', '(금) ',
				'(토) ');

		var d3 = week[d];

		var h = onul.getHours(); /*현재 '시'를 숫자로 추출 */

		var m = onul.getMinutes(); /*현재 '분'을 숫자로 추출 */

		var s = onul.getSeconds(); /*현재 '초'를 숫자로 추출 */

		m = dasi(m);

		s = dasi(s);

		document.getElementById('times').innerHTML = y + "년 " + m2 + "월 " + d2
				+ "일 " + d3 + h + ":" + m + ":" + s;
		document.getElementById('timesm').innerHTML = "근태관리  " + m2 + "월"

		var t = setTimeout(function() {
			times()
		}, 1000); /* 1초마다 갱신(refresh)  */

		/*dasi(분,초)에서 숫자를 가져와서 만약 그 수가 10보다 작다면 앞에 "0"을 추가 함 */
		function dasi(i) {

			if (i < 10) {
				i = "0" + i
			}
			;

			return i;

		}

		var currentDay = new Date();
		var theYear = currentDay.getFullYear();
		var theMonth = currentDay.getMonth();
		var theDate = currentDay.getDate();
		var theDayOfWeek = currentDay.getDay();

		var thisWeek = [];

		/* 	for (var i = 0; i < 7; i++) {
			var resultDay = new Date(theYear, theMonth, theDate
					+ (i - theDayOfWeek));
			// var yyyy = resultDay.getFullYear();
			var mm = Number(resultDay.getMonth()) + 1;
			var dd = resultDay.getDate();
			var ddd = resultDay.getDay();

			console.log("theDate: "+ theDate);
			mm = String(mm).length === 1 ? '0' + mm : mm;
			dd = String(dd).length === 1 ? '0' + dd : dd;

			if (ddd == 1) {
				ddd = '(월)';
			} else if (ddd == 2) {
				ddd = '(화)'
			} else if (ddd == 3) {
				ddd = '(수)'
			} else if (ddd == 4) {
				ddd = '(목)'
			} else if (ddd == 5) {
				ddd = '(금)'
			} else if (ddd == 6) {
				ddd = '(토)'
			} else if (ddd == 0) {
				ddd = '(일)'
			}

			thisWeek[i] = mm + '월' + dd + '일' + ddd;

		}

		document.getElementById('week1').innerHTML = thisWeek[1];
		var date1 = thisWeek[1].substr(3, 2);

		if (theDate == date1) {
			$('#today1').show();
		} else {
			$('#today1').hide();
		}
		document.getElementById('week2').innerHTML = thisWeek[2];
		var date2 = thisWeek[2].substr(3, 2);
		console.log("date2  : "+ date2);

		if (theDate == date2) {
			$('#today2').show();
		} else {
			$('#today2').hide();
		}
		document.getElementById('week3').innerHTML = thisWeek[3];
		var date3 = thisWeek[3].substr(3, 2);
		console.log("date3  : "+ date3);

		if (theDate == date3) {
			$('#today3').show();
		} else {
			$('#today3').hide();
		}
		document.getElementById('week4').innerHTML = thisWeek[4];
		var date4 = thisWeek[4].substr(3, 2);
		console.log("date4  : "+ date4);

		if (theDate == date4) {
			$('#today4').show();
		} else {
			$('#today4').hide();
		}
		document.getElementById('week5').innerHTML = thisWeek[5];
		var date5 = thisWeek[5].substr(3, 2);
		console.log("date5  : "+ date5);

		if (theDate == date5) {
			$('#today5').show();
		} else {
			$('#today5').hide();
		}
		document.getElementById('week6').innerHTML = thisWeek[6];
		var date6 = thisWeek[6].substr(3, 2);
		console.log("date6  : "+ date6);
		
		if (theDate == date6) {
			$('#today6').show();
		} else {
			$('#today6').hide();
		}
		document.getElementById('week0').innerHTML = thisWeek[0];
		var date0 = thisWeek[0].substr(3, 2);
		console.log("date0  : "+ date0);

		if (theDate == date0) {
			$('#today0').show();
		} else {
			$('#today0').hide();
		}

		console.log(thisWeek[0]); */

	}
<%Object obj = session.getAttribute("vo");
String name = null;
String dname = null;
String position = null;

int num = 0;
LocalDateTime now = LocalDateTime.now();

if (obj != null) {
	EmployeeVO vo = (EmployeeVO) obj;
	name = vo.geteName();
	dname = vo.getdName();

	position = vo.geteOfficialResponsibilities();
	num = vo.geteNumber();%>
	var eNumber =
<%=vo.geteNumber()%>
	;
<%}%>
	/* function attbtn(type) {
		if (type == "1") { //만약 출근 버튼을 누르면 jsp파일에 데이터가 넘어가서 데이터의 값을 가진애의 출근시간이 데이터에 넘어감. 
			// db에저장
			$.ajax({
				url : "startTime.jsp",
				data : {
					id : eNumber
				},
				success : function(data) {
					console.log(data.trim());//공백제거
					var data2 = data.trim();

				}
			});

			console.log("-------------------------------------");
			$.ajax({//db에서 출근 시간 가져오기
				type : "get",
				url : "getStartTime.jsp",
				dataType : "html",
				data : {
					id : eNumber
				},
				success : function(response, status, request) {
					console.log("성공");
					console.log(response);
					$("#startHour").html(response.trim())
				}
			});

		} else {
			// endtime.jsp?id=141
			$.ajax({
				url : "endTime.jsp",
				data : {
					id : eNumber
				},
				success : function(data) {
					console.log(data.trim());//공백제거
					var data2 = data.trim();

				}
			});

			$.ajax({//db에서 퇴근 시간 가져오기
				type : "get",
				url : "getEndTime.jsp",
				dataType : "html",
				data : {
					id : eNumber
				},
				success : function(response, status, request) {
					console.log("성공");
					console.log(response);
					$("#quitHour").html(response.trim())
				}
			});
		}
		//시간정보 넘기기 끝

	} */
	$(function() {
		  $("#in").on("click", function() {
		    $.ajax({
		      type: "post",
		      url: "startTime.jsp",
		      data: {
		        id: eNumber
		      },
		      success: function(data) {
		        console.log(data);
		        var data2 = data.trim(); // Remove whitespace

		        if (data2 == "0") {
		          // Already started work, display a notification dialog
		          $("<div>", {
		            title: "알림",
		            text: "이미 출근처리되었습니다."
		          }).dialog({
		            modal: true,
		            buttons: {
		              OK: function() {
		                $(this).dialog("close");
		              }
		            }
		          });
		        } else {
		          // Confirm start work and display the start time
		          $("<div>", {
		            title: "출근하시겠습니까?",
		            text: "출근하시겠습니까?"
		          }).dialog({
		            modal: true,
		            buttons: {
		              OK: function() {
		                $(this).dialog("close");

		                // Get current time and update the "begin" element
		                var n = new Date();
		                var startTime =
		                  n.getHours() +
		                  "시" +
		                  n.getMinutes() +
		                  "분" +
		                  n.getSeconds() +
		                  "초";
		                $("#begin").html(startTime);

		                // Additional code to be executed after starting work
		                console.log("출근 처리 완료");
		              },
		              Cancel: function() {
		                $(this).dialog("close");
		              }
		            }
		          });
		        }
		      }
		    });
		  });
		});

	$(function() {
		  $("#out").on("click", function() {
		    $.ajax({
		      type: "post",
		      url: "endTime.jsp",
		      data: {
		        id: eNumber
		      },
		      success: function(data) {
		        console.log(data);
		        var data2 = data.trim(); // Remove whitespace

		        if (data2 == "0") {
		          // Already ended work, display a notification dialog
		          $("<div>", {
		            title: "알림",
		            text: "이미 퇴근처리되었습니다."
		          }).dialog({
		            modal: true,
		            buttons: {
		              OK: function() {
		                $(this).dialog("close");
		              }
		            }
		          });
		        } else {
		          // Confirm end work and display the end time
		          $("<div>", {
		            title: "퇴근하시겠습니까?",
		            text: "퇴근하시겠습니까?"
		          }).dialog({
		            modal: true,
		            buttons: {
		              OK: function() {
		                $(this).dialog("close");

		                // Get current time and update the "end" element
		                var n = new Date();
		                var endTime =
		                  n.getHours() +
		                  "시" +
		                  n.getMinutes() +
		                  "분" +
		                  n.getSeconds() +
		                  "초";
		                $("#end").html(endTime);

		                // Additional code to be executed after ending work
		                console.log("퇴근 처리 완료");
		              },
		              Cancel: function() {
		                $(this).dialog("close");
		              }
		            }
		          });
		        }
		      }
		    });
		  });
		});

</script>

<!-- 스크립트 부분 -->
</head>


<body onload="times()">

	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark"><%@ include
			file="../menu/navi.jsp"%></nav>
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav"><%@ include file="../menu/side.jsp"%></div>
		<div id="layoutSidenav_content">
			<main>
				<div class="row">
					<div class="col-12">
						<div
							class="page-title-box d-sm-flex align-items-center justify-content-between">

							<h1 class="mb-sm-0 font-size-20" id="timesm">
								<i class="bx bx-buildings"></i>
							</h1>

							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">근태</a></li>
									<li class="breadcrumb-item active">근태관리</li>
								</ol>
							</div>

						</div>
					</div>
				</div>
				<!-- end page title -->

				<div class="row">
					<div class="col-lg-12">
						<div class="card">
							<div class="card-body">
								<div class="row">
									<div class="col-lg-4">
										<div class="d-flex">
											<div class="flex-shrink-0 me-3">
												<img src="../images/after.PNG" alt=""
													class="avatar-md rounded-circle img-thumbnail">
											</div>
											<div class="flex-grow-1 align-self-center">
												<div class="text-muted">
													<p class="mb-2" id="times"></p>
													<h5 class="mb-1">
														<%=name%>&nbsp;
														<%-- 사원명 --%>
														<!-- 직급 --><%=position%>
													</h5>
													<p class="mb-0"><%=dname%></p>
													<!-- 부서 -->
												</div>
											</div>
										</div>
									</div>

									<div class="col-lg-4 align-self-center">
										<div class="text-lg-center mt-4 mt-lg-0">
											<div class="row">
												<div class="col-4">
													<div></div>
												</div>
												<div class="col-4">
													<div></div>
												</div>
											</div>
										</div>
									</div>

									<div class="col-lg-4 d-none d-lg-block">
										<div class="clearfix mt-4 mt-lg-0"></div>
									</div>
								</div>
								<!-- end row -->
							</div>
						</div>
					</div>
				</div>
				<!-- end row -->
				<div class="row">


					<div class="col-xl-18">
						<div class="row">
							<div class="col-sm-6">
								<div class="card">
									<div class="card-body">
										<div class="d-flex align-items-center mb-3">
											<div class="avatar-xs me-3">
												<span
													class="avatar-title rounded-circle bg-primary bg-soft text-primary font-size-18">
													<i class="bx bx-time-five"></i>
												</span>
											</div>
											<h5 class="font-size-16 mb-0">이번달 근무시간</h5>
										</div>
										<h5 class="font-size-15">
											시간<span class="float-end"> <!-- 61% -->
											</span>
										</h5>
										<div class="progress animated-progess progress-md">
											<div class="progress-bar" role="progressbar"
												style="width: 61%" aria-valuenow="61" aria-valuemin="0"
												aria-valuemax="100"></div>
										</div>


										<%
										AttendenceDAO dao = new AttendenceDAO();
																		AttendenceVO vo = dao.getStartTime(num);
																		AttendenceVO vo1 = dao.getEndTime(num);

																		if (vo != null) {
										%>
										출근시간:<%=vo.getOfficeGoingHour()%><br>
										<%
										} else {
										%>
										<div id="begin">출근시간: 출근전</div>
										<%
										}
										%>
										<!-- 퇴근 -->
										<%
										if (vo1 != null) {
										%>
										퇴근시간:<%=vo1.getQuittingTime()%><br>
										<%
										} else {
										%>
										<div id="end">퇴근시간: 퇴근전</div>
										<%
										}
										%>
									</div>
								</div>
							</div>

							<div class="col-sm-6">
								<div class="card">
									<div class="card-body">
										<div class="d-flex align-items-center mb-5">
											<div class="avatar-xs me-3">
												<span
													class="avatar-title rounded-circle bg-primary bg-soft text-primary font-size-18">
													<i class="bx bx-briefcase-alt"></i>
												</span>
											</div>
											<h5 class="font-size-16 mb-0">근태</h5>
										</div>
										<button type="button" class="btn btn-light waves-effect"
											id="in" name="in">출근하기</button>
										<button type="button" class="btn btn-light waves-effect"
											id="out" name="out">퇴근하기</button>
										<br>

									</div>
								</div>
							</div>


						</div>
						<!-- end row -->
					</div>
				</div>

				<div class="row">
					<div class="col-xl-12">
						<div class="card">
							<div class="card-body">
								<div class="clearfix">


									<div class="card-body">
										<div class="d-flex align-items-center mb-3">
											<div class="avatar-xs me-3">
												<span
													class="avatar-title rounded-circle bg-primary bg-soft text-primary font-size-18">
													<i class="bx bx-task"></i>
												</span>
											</div>
											<h5 class="font-size-16 mb-0">이번 주 근무</h5>
										</div>

										<%-- <!-- 당일근무시간출력 -->
										<%
										ArrayList<WorkingTimeVO> list = dao.getWoringTime(num);//메서드호출

										for (WorkingTimeVO vo3 : list) {//for문으로 리스트 출력?
										%>
										
										<table>
											<tr>
												<td><%= vo3.getDay() %></td>
												<td><%= vo3.getTime() %></td>
											</tr>
										
										</table>
											
											
										<%
										}
										%> --%>
										<!-- out.println(vo3); -->
										<div class="mt-4">
											<div data-simplebar="init" style="max-height: 400px;">
												<div class="simplebar-wrapper" style="margin: 0px;">
													<div class="simplebar-height-auto-observer-wrapper">
														<div class="simplebar-height-auto-observer"></div>
													</div>
													<div class="simplebar-mask">
														<div class="simplebar-offset"
															style="right: -17px; bottom: 0px;">
															<div class="simplebar-content-wrapper"
																style="height: auto; overflow: hidden scroll;">
																<div class="simplebar-content" style="padding: 0px;">
																	<div class="table-wrapper">
																		<div class="table-responsive fixed-solution"
																			data-pattern="priority-columns">
																			<div class="sticky-table-header"
																				style="visibility: hidden; width: auto; top: -4.40625px;">

																			</div>
																			<!-- 당일근무시간출력 -->
																			<%
																			ArrayList<WorkingTimeVO> list = dao.getWoringTime(num);//메서드호출
																			ArrayList<AttendenceVO> list1 =  dao.getDate(num);
																			ArrayList<WorkingTimeVO> list2 =  dao.getWoringTime(num);
																		for (int i=0; i<list.size(); i++) {//for문으로 리스트 출력?
																			%>

																			<table
																				class="table table-nowrap align-middle table-hover mb-0"
																				style="height: 80px;">
																				<tbody>
																					<tr>
																						<td style="width: 50px;" data-org-colspan="1"
																							data-columns="id3c6e7ddbeb24f-col-undefined">
																							<div class="form-check">
																								<input class="form-check-input" type="checkbox"
																									id="tasklistCheck01"> <label
																									class="form-check-label" for="tasklistCheck01"></label>
																							</div>
																						</td>
																						<td data-org-colspan="1"
																							data-columns="id3c6e7ddbeb24f-col-undefined"
																							id="todaysp">
																						<%	
																							Date d = new Date();
																							SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
																							String t = sdf.format(d); 
																							if( list2.get(i).getDay().equals(t) ){
																						%>
																							<h5 class="text-truncate font-size-16 mb-1">
																								<a href="#" class="text-dark" ><%= list2.get(i).getDay() %></a>&nbsp;
																								<span
																									class="badge badge-pill badge-soft-success font-size-12"
																									id="today1" style="color: blue">오늘</span>
																							</h5>
																						<%	
																							}else{
																						%>
																							<h5 class="text-truncate font-size-16 mb-1">
																								<a href="#" class="text-dark" ><%= list2.get(i).getDay() %></a>&nbsp;
																								<span
																									class="badge badge-pill badge-soft-success font-size-12"
																									id="today1" style="color: blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- &nbsp; --></span>
																							</h5>
																						
																						<%
																							}
																						%>
																						</td>
																						<td data-org-colspan="1"
																							data-columns="id3c6e7ddbeb24f-col-undefined">

																							<div class="d-flex flex-wrap gap-3">
																							<%
																							
																							%>
																								<a href="#" class="text-dark font-size-16"
																									data-bs-toggle="modal"
																									data-bs-target="#exampleModal"
																									data-bs-whatever="@mdo"> <span
																									class="badge badge-pill badge-soft-secondary font-size-14"
																									style="color: blue">근무<%=list1.get(i).getOfficeGoingHour() %> ~ <%=list1.get(i).getQuittingTime() %></span>&nbsp;
																								</a>
																								<%-- <%
																								}
																								%> --%>

																							</div>
																						</td>
																						<td data-org-colspan="1"
																							data-columns="id3c6e7ddbeb24f-col-undefined">
																							<%=list.get(i).getTime() %>시간
																						</td>

																					</tr>
																					
																			<%-- <%
																			}
																			%>  --%>
																					<%-- <tr>
																						<td  data-org-colspan="1"
																							data-columns="id3c6e7ddbeb24f-col-undefined"><%=list.get(0).getDay() %></td>
																						<td><%=list1.get(0).getOfficeGoingHour() %> ~ <%=list1.get(0).getQuittingTime() %></td>
																					</tr>
																					<tr>
																						<td><%=list.get(1).getDay() %></td>
																						<td><%=list1.get(1).getOfficeGoingHour() %> ~ <%=list1.get(0).getQuittingTime() %></td>
																					</tr>
																						<tr>
																						<td><%=list.get(2).getDay() %></td>
																						<td><%=list1.get(2).getOfficeGoingHour() %> ~ <%=list1.get(0).getQuittingTime() %></td>
																					</tr>
																						<tr>
																						<td><%=list.get(1).getDay() %></td>
																						<td><%=list1.get(1).getOfficeGoingHour() %> ~ <%=list1.get(0).getQuittingTime() %></td>
																					</tr>
																						<tr>
																						<td><%=list.get(1).getDay() %></td>
																						<td><%=list1.get(1).getOfficeGoingHour() %> ~ <%=list1.get(0).getQuittingTime() %></td>
																					</tr> --%>
																					
																				</tbody>
																			</table>
																			<%
																			}
																			%>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Modal 시작 -->
					<div class="modal fade" id="exampleModal" tabindex="-1"
						aria-labelledby="exampleModalLabel">
						<div class="modal-dialog">

							<div class="modal-content">
								<div class="modal-header">

									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<div>
										<div class="card-body">

											<ul class="nav nav-pills nav-justified" role="tablist">

												<li class="nav-item waves-effect waves-light"><a
													class="nav-link active" data-bs-toggle="tab"
													href="#profile-1" role="tab"> <span
														class="d-block d-sm-none"><i class="far fa-user"></i></span>
														<span class="d-none d-sm-block">연차</span>
												</a></li>
												<li class="nav-item waves-effect waves-light"><a
													class="nav-link" data-bs-toggle="tab" href="#messages-1"
													role="tab"> <span class="d-block d-sm-none"><i
															class="far fa-envelope"></i></span> <span
														class="d-none d-sm-block">외근</span>
												</a></li>
												<li class="nav-item waves-effect waves-light"><a
													class="nav-link" data-bs-toggle="tab" href="#settings-1"
													role="tab"> <span class="d-block d-sm-none"><i
															class="fas fa-cog"></i></span> <span class="d-none d-sm-block">원격근무</span>
												</a></li>
											</ul>

											<!-- Tab panes -->
											<div class="tab-content p-3 text-muted">

												<div class="tab-pane active" id="profile-1" role="tabpanel">
													<i class="bx bx-time-five"></i> <select
														class="form-select se">
														<option>오전반차</option>
														<option>오후반차</option>
														<option>연차</option>
													</select> <br> <i class="bx bx-edit-alt"></i> <input id=""
														name="" placeholder="휴가 사유" class="form-control se"
														type="text" value="">
												</div>

												<div class="tab-pane" id="messages-1" role="tabpanel">
													<i class="bx bx-time-five"></i> <select id="" name=""
														title="" tabindex="-1" aria-hidden="true"
														data-select2-id="4"
														class="form-control select2 select2-hidden-accessible se">
														<option value="">오전 9:00</option>
														<option value="">오전 9:30</option>
														<option value="">오전 10:00</option>
														<option value="">오전 10:30</option>
														<option value="">오전 11:00</option>
														<option value="">오전 11:30</option>
													</select> &nbsp;-&nbsp; <select id="" name="" title="" tabindex="-1"
														aria-hidden="true" data-select2-id="4"
														class="form-control select2 select2-hidden-accessible se">
														<option value="">오후 12:00</option>
														<option value="">오후 12:30</option>
														<option value="">오후 01:00</option>
														<option value="">오후 01:30</option>
														<option value="">오후 02:00</option>
														<option value="">오후 02:30</option>
														<option value="">오후 03:00</option>
														<option value="">오후 03:30</option>
														<option value="">오후 04:00</option>
														<option value="">오후 04:30</option>
														<option value="">오후 05:00</option>
														<option value="">오후 05:30</option>
														<option value="">오후 06:00</option>
														<option value="">오후 06:30</option>
														<option value="">오후 07:00</option>
														<option value="">오후 07:30</option>
														<option value="">오후 08:00</option>
														<option value="">오후 08:30</option>
														<option value="">오후 09:00</option>
														<option value="">오후 09:30</option>
														<option value="">오후 10:00</option>
														<option value="">오후 10:30</option>
													</select>

												</div>
												<div class="tab-pane" id="settings-1" role="tabpanel">
													<i class="bx bx-time-five"></i> <select id="" name=""
														title="" tabindex="-1" aria-hidden="true"
														data-select2-id="4"
														class="form-control select2 select2-hidden-accessible se">
														<option value="">오전 9:00</option>
														<option value="">오전 9:30</option>
														<option value="">오전 10:00</option>
														<option value="">오전 10:30</option>
														<option value="">오전 11:00</option>
														<option value="">오전 11:30</option>
													</select> &nbsp;-&nbsp; <select id="" name="" title="" tabindex="-1"
														aria-hidden="true" data-select2-id="4"
														class="form-control select2 select2-hidden-accessible se">
														<option value="">오후 12:00</option>
														<option value="">오후 12:30</option>
														<option value="">오후 01:00</option>
														<option value="">오후 01:30</option>
														<option value="">오후 02:00</option>
														<option value="">오후 02:30</option>
														<option value="">오후 03:00</option>
														<option value="">오후 03:30</option>
														<option value="">오후 04:00</option>
														<option value="">오후 04:30</option>
														<option value="">오후 05:00</option>
														<option value="">오후 05:30</option>
														<option value="">오후 06:00</option>
														<option value="">오후 06:30</option>
														<option value="">오후 07:00</option>
														<option value="">오후 07:30</option>
														<option value="">오후 08:00</option>
														<option value="">오후 08:30</option>
														<option value="">오후 09:00</option>
														<option value="">오후 09:30</option>
														<option value="">오후 10:00</option>
														<option value="">오후 10:30</option>
													</select>

												</div>
											</div>

										</div>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">닫기</button>
									<button type="button" class="btn btn-primary">근무 등록하기</button>
								</div>
							</div>

						</div>
					</div>
					<!-- Modal 끝 -->
			</main>
			<footer class="py-4 bg-light mt-auto" style="bottom: 0;"><%@ include
					file="../menu/footer.jsp"%></footer>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="../js/scripts.js"></script>
	<!-- 사이드바 열고 닫기 -->
</body>
</html>