<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>เทศบาลตำบลนางแล</title>

<!-- Bootstrap Core CSS -->
<link href="../NanglaeGov/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="../NanglaeGov/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- DataTables CSS -->
<link href="../NanglaeGov/vendor/datatables-plugins/dataTables.bootstrap.css"
	rel="stylesheet">


<!-- DataTables Responsive CSS -->
<link href="../NanglaeGov/vendor/datatables-responsive/dataTables.responsive.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="../NanglaeGov/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="../NanglaeGov/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->


<script type='text/javascript' src="../NanglaeGov/js/jquery.js"></script>
<script type='text/javascript' charset="utf-8">
	function listAgriculture() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listAgriculture.do",
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {
							html += "<tr>";
							html += "<td>"
									+ data[i].agi_year
									+ "</td>"
									+ "<td>"
									+ data[i].agi_name
									+ "</td>"
									+ "<td>"
									+ data[i].agi_area
									+ "</td>"
									+ "<td>"
									+ data[i].agi_description
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editAgri\" data-toggle=\"tab\" onclick=\"setEditAgriculture("
									+ data[i].agi_id
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button data-toggle=\"modal\" data-id="
									+ data[i].agi_id
									+ " onclick=\"openDeleteModal(this);\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>";

							html += "</tr>";
						}
						$('#listAgriculture').html(html);
						$('#resultTable').DataTable({

							dom : 'Bfrtip',
							buttons : [ {
								extend : 'pdfHtml5',
								exportOptions : {
									columns : [ 0, 1, 2, 3 ]
								},
								customize : function(doc) {
									doc.defaultStyle['font'] = 'THSarabun';
								}
							}, 'excelHtml5' ]
						});
						$("#loader").hide();
					},
					error : function(data, status, er) {
						alert('error');
						$("#loader").hide();
					}
				});
	}
</script>
<script type='text/javascript'>
	function createAgriculture() {
		$("#loader").show();
		if ($('#agi_year').val() == "") {
			document.getElementById('agi_year').style.borderColor = "red";
			return false;
		} else if ($('#agi_name').val() == "") {
			document.getElementById('agi_name').style.borderColor = "red";
			return false;
		} else if ($('#agi_area').val() == "") {
			document.getElementById('agi_area').style.borderColor = "red";
			return false;
		} else if ($('#agi_description').val() == "") {
			document.getElementById('agi_description').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				agi_id : 0,
				agi_year : $('#agi_year').val(),
				agi_name : $('#agi_name').val(),
				agi_area : $('#agi_area').val(),
				agi_description : $('#agi_description').val()
			};
			$.ajax({
				url : "../NanglaeGov/saveAgriculture.do",
				type : "POST",
				dataType : "JSON",
				data : JSON.stringify(obj),
				contentType : "application/json",
				mimeType : "application/json",
				success : function(data) {
					$("#loader").hide();
					location.reload();
				},
				error : function(data, status, er) {
					alert('error');
					$("#loader").hide();
				}
			});
		}

	}
	function deleteAgriculture() {
		var id = document.getElementById("agi_id").value;

		var obj = {
			agi_id : id

		};
		//alert(id);
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/deleteAgriculture.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert('success');
				location.reload();
			}
		});
	}
	function editAgriculture() {
		var obj = {
			agi_id : $("#editAgiId").val(),
			agi_year : $('#editAgiYear').val(),
			agi_name : $('#editAgiName').val(),
			agi_area : $('#editAgiArea').val(),
			agi_description : $('#editAgiDescription').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveAgriculture.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert('success');
				location.reload();
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
	function setEditAgriculture(agi_id) {

		var obj = {
			agi_id : agi_id
		};

		$.ajax({
			url : "../NanglaeGov/findAgriculture.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editAgiId").val(data.agi_id);
				$("#editAgiYear").val(data.agi_year);
				$("#editAgiName").val(data.agi_name);
				$("#editAgiArea").val(data.agi_area);
				$("#editAgiDescription").val(data.agi_description);
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
</script>
</head>

<body onload="listAgriculture()">

	<div id="wrapper">

		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation"
			style="margin-bottom: 0;background-color: #98c3e8">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<img src="../NanglaeGov/images/logo-nanglae.png">
				<a class="navbar-brand" href="index.do">เทศบาลตำบลนางแล</a>
			</div>
			<!-- /.navbar-header -->

			<ul class="nav navbar-top-links navbar-right">
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"> <i
						class="fa fa-envelope fa-fw"></i> <i class="fa fa-caret-down"></i>
				</a>
					<ul class="dropdown-menu dropdown-messages">
						<li><a href="#">
								<div>
									<strong>John Smith</strong> <span class="pull-right text-muted">
										<em>Yesterday</em>
									</span>
								</div>
								<div>Lorem ipsum dolor sit amet, consectetur adipiscing
									elit. Pellentesque eleifend...</div>
						</a></li>
						<li class="divider"></li>
						<li><a href="#">
								<div>
									<strong>John Smith</strong> <span class="pull-right text-muted">
										<em>Yesterday</em>
									</span>
								</div>
								<div>Lorem ipsum dolor sit amet, consectetur adipiscing
									elit. Pellentesque eleifend...</div>
						</a></li>
						<li class="divider"></li>
						<li><a href="#">
								<div>
									<strong>John Smith</strong> <span class="pull-right text-muted">
										<em>Yesterday</em>
									</span>
								</div>
								<div>Lorem ipsum dolor sit amet, consectetur adipiscing
									elit. Pellentesque eleifend...</div>
						</a></li>
						<li class="divider"></li>
						<li><a class="text-center" href="#"> <strong>Read
									All Messages</strong> <i class="fa fa-angle-right"></i>
						</a></li>
					</ul> <!-- /.dropdown-messages --></li>
				<!-- /.dropdown -->
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"> <i class="fa fa-tasks fa-fw"></i>
						<i class="fa fa-caret-down"></i>
				</a>
					<ul class="dropdown-menu dropdown-tasks">
						<li><a href="#">
								<div>
									<p>
										<strong>Task 1</strong> <span class="pull-right text-muted">40%
											Complete</span>
									</p>
									<div class="progress progress-striped active">
										<div class="progress-bar progress-bar-success"
											role="progressbar" aria-valuenow="40" aria-valuemin="0"
											aria-valuemax="100" style="width: 40%">
											<span class="sr-only">40% Complete (success)</span>
										</div>
									</div>
								</div>
						</a></li>
						<li class="divider"></li>
						<li><a href="#">
								<div>
									<p>
										<strong>Task 2</strong> <span class="pull-right text-muted">20%
											Complete</span>
									</p>
									<div class="progress progress-striped active">
										<div class="progress-bar progress-bar-info" role="progressbar"
											aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"
											style="width: 20%">
											<span class="sr-only">20% Complete</span>
										</div>
									</div>
								</div>
						</a></li>
						<li class="divider"></li>
						<li><a href="#">
								<div>
									<p>
										<strong>Task 3</strong> <span class="pull-right text-muted">60%
											Complete</span>
									</p>
									<div class="progress progress-striped active">
										<div class="progress-bar progress-bar-warning"
											role="progressbar" aria-valuenow="60" aria-valuemin="0"
											aria-valuemax="100" style="width: 60%">
											<span class="sr-only">60% Complete (warning)</span>
										</div>
									</div>
								</div>
						</a></li>
						<li class="divider"></li>
						<li><a href="#">
								<div>
									<p>
										<strong>Task 4</strong> <span class="pull-right text-muted">80%
											Complete</span>
									</p>
									<div class="progress progress-striped active">
										<div class="progress-bar progress-bar-danger"
											role="progressbar" aria-valuenow="80" aria-valuemin="0"
											aria-valuemax="100" style="width: 80%">
											<span class="sr-only">80% Complete (danger)</span>
										</div>
									</div>
								</div>
						</a></li>
						<li class="divider"></li>
						<li><a class="text-center" href="#"> <strong>See
									All Tasks</strong> <i class="fa fa-angle-right"></i>
						</a></li>
					</ul> <!-- /.dropdown-tasks --></li>
				<!-- /.dropdown -->
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"> <i class="fa fa-bell fa-fw"></i>
						<i class="fa fa-caret-down"></i>
				</a>
					<ul class="dropdown-menu dropdown-alerts">
						<li><a href="#">
								<div>
									<i class="fa fa-comment fa-fw"></i> New Comment <span
										class="pull-right text-muted small">4 minutes ago</span>
								</div>
						</a></li>
						<li class="divider"></li>
						<li><a href="#">
								<div>
									<i class="fa fa-twitter fa-fw"></i> 3 New Followers <span
										class="pull-right text-muted small">12 minutes ago</span>
								</div>
						</a></li>
						<li class="divider"></li>
						<li><a href="#">
								<div>
									<i class="fa fa-envelope fa-fw"></i> Message Sent <span
										class="pull-right text-muted small">4 minutes ago</span>
								</div>
						</a></li>
						<li class="divider"></li>
						<li><a href="#">
								<div>
									<i class="fa fa-tasks fa-fw"></i> New Task <span
										class="pull-right text-muted small">4 minutes ago</span>
								</div>
						</a></li>
						<li class="divider"></li>
						<li><a href="#">
								<div>
									<i class="fa fa-upload fa-fw"></i> Server Rebooted <span
										class="pull-right text-muted small">4 minutes ago</span>
								</div>
						</a></li>
						<li class="divider"></li>
						<li><a class="text-center" href="#"> <strong>See
									All Alerts</strong> <i class="fa fa-angle-right"></i>
						</a></li>
					</ul> <!-- /.dropdown-alerts --></li>
				<!-- /.dropdown -->
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i>
						<i class="fa fa-caret-down"></i>
				</a>
					<ul class="dropdown-menu dropdown-user">
						<li><a href="#"><i class="fa fa-user fa-fw"></i>
								ดูข้อมูลส่วนตัว</a></li>
						<li><a href="#"><i class="fa fa-gear fa-fw"></i> ตั้งค่า</a>
						</li>
						<li class="divider"></li>
						<li><a href="login.html"><i class="fa fa-sign-out fa-fw"></i>
								ออกจากระบบ</a></li>
					</ul> <!-- /.dropdown-user --></li>
				<!-- /.dropdown -->
			</ul>
			<!-- /.navbar-top-links -->

			<div class="navbar-default sidebar" role="navigation">
				<div class="sidebar-nav navbar-collapse">
					<ul class="nav" id="side-menu">
						<li><a href="#"><i class="fa fa-child fa-fw"></i> บุคคล<span
								class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="personnel.do">บุคลากร</a></li>
								<li><a href="population.do">ประชากร</a></li>
								<li><a href="labor.do">แรงงาน</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="fa fa-road fa-fw"></i>
								สาธารณูปโภค<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="transport.do">ระบบคมนาคมขนส่ง</a></li>
								<li><a href="electric.do">ระบบไฟฟ้า</a></li>
								<li><a href="pipeline.do">ระบบประปา</a></li>
								<li><a href="drainange.do">ระบบระบายน้ำ</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="fa fa-home fa-fw"></i>
								สาธารณุปการ<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="#">เคหะ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="village.do">หมู่บ้าน</a></li>
										<li><a href="industry.do">การอุตสาหกรรม</a></li>
										<li><a href="education.do">การศึกษา</a></li>
										<li><a href="religion.do">การศาสนา</a></li>
										<li><a href="commerce.do">การพาณิชย์</a></li>
										<li><a href="tourism.do">แหล่งท่องเที่ยว</a></li>
									</ul> <!-- /.nav-third-level --></li>
								<li><a href="#">บริการ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="health.do">การสาธารสุข</a></li>
										<li><a href="security.do">ความปลอดภัยในชีวิตและทรัพย์สิน</a>
										</li>
										<li><a href="group.do">กลุ่มในชุมชน</a></li>
										<li><a href="service.do">ศูนย์บริการประชาชน</a></li>
										<li><a href="inventory.do">การคลัง</a></li>
									</ul> <!-- /.nav-third-level --></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="glyphicon glyphicon-leaf"></i>
								ธรรมชาติและสิ่งแวดล้อม<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="agriculture.do">การเกษตรกรรม</a></li>
								<li><a href="#">ทรัพยากรธรรมชาติ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="waterresource.do">ทรัพยากรณ์น้ำ</a></li>
										<li><a href="landresource.do">ทรัพยากรณ์ดิน</a></li>
										<li><a href="forrestresource.do">ทรัพยากรณ์ป่าไม้</a></li>
									</ul></li>
								<li><a href="polution.do">มลพิษ</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="copy.do"><i class="fa fa-copy"></i>
								คัดลอกข้อมูล</a></li>
					</ul>
				</div>
				<!-- /.sidebar-collapse -->
			</div>
		</nav>
		<div id="page-wrapper" style="background-color: #d7f0f5">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">การเกษตรกรรม</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.panel-heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#listAgri" data-toggle="tab">การเกษตรกรรม</a>
								</li>
								<li><a href="#addAgri" data-toggle="tab">เพิ่มการเกษตรกรรม</a>
								</li>
							</ul>
							<div class="panel-body">

								<!-- Tab panes -->

								<div class="tab-content">
									<div class="tab-pane fade in active" id="listAgri">
										พ.ศ. <select>
											<option value="2558">2558</option>
											<option value="2559">2559</option>
										</select> <br>
										<h1></h1>
										<div class="table-responsive">
											<table id="resultTable"
												class="table table-striped table-bordered table-hover">

<!-- Start change table -->
												<thead>
													<tr>
														<th>ปีที่ข้อมูล</th>
														<th>พื้นที่เกษตรกรรม</th>
														<th>จำนวน(ไร่)</th>
														<th>การทำการเกษตร</th>
														<th style="text-align: center;">ตัวเลือก</th>
													</tr>
												</thead>
												<tbody id="listAgriculture">
												</tbody>
<!-- End change table -->
											</table>
										</div>
									</div>
									<div class="tab-pane fade" id="addAgri">
										<form role="form">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
													<td><input id="agi_year" maxlength="4"
														class="form-control" placeholder="" value="2558"
														name="vil-year"></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">พื้นที่การเกษตร</td>
													<td><input id="agi_name" maxlength="100"
														class="form-control" placeholder="ระบุพื้นที่การเกษตร"
														name="vil-number" required="true"></td>

												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">จำนวนพื้นที่</td>
													<td><input id="agi_area" maxlength="5"
														class="form-control" placeholder="ระบุจำนวนพื้นที่"
														name="vil-name" required="true"></td>
													<td style="padding: 15px">ไร่</td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">การทำการเกษตร</td>
															class="form-control" placeholder="ระบุรายละเอียด"
															name="vil-name" required="true"></textarea></td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px">
														<button style="width: 100px" type="reset"
															class="btn btn-warning">ล้างข้อมูล</button> <input
														style="width: 100px" type="button" class="btn btn-success"
														value="บันทึก" onclick="createAgriculture()" />
													</td>
												</tr>
											</table>
										</form>
									</div>
									<!-- Start modal -->
									<div>
										<div class="modal fade" id="DeleteModal" tabindex="-1"
											role="dialog" aria-labelledby="myModalLabel"
											aria-hidden="true">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal"
															aria-hidden="true">&times;</button>
														<h4 class="modal-title" id="H3">-----
															ยืนยันการลบข้อมูล !! -----</h4>
													</div>
													<div class="modal-body">
														<p>คุณต้องการลบข้อมูลชุดนี้?</p>
														<input type="hidden" name="agi_id" id="agi_id" value="" />
													</div>

													<div class="modal-footer">
														<button type="button" class="btn btn-default"
															data-dismiss="modal">ยกเลิก</button>
														<button type="button" id="deleteAgriculture"
															class="btn btn-danger" onclick="deleteAgriculture();">ลบข้อมูล</button>

													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- End modal -->

									<div class="tab-pane fade" id="editAgri">
										<form role="form">
											<input type="hidden" id="editAgiId">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
													<td><input id="editAgiYear" maxlength="4"
														class="form-control" placeholder="" value="2558"
														name="vil-year"></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">พื้นที่การเกษตร</td>
													<td><input id="editAgiName" maxlength="100"
														class="form-control" placeholder="" name="vil-number"
														required="true"></td>

												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">จำนวนพื้นที่</td>
													<td><input id="editAgiArea" maxlength="5"
														class="form-control" placeholder="" name="vil-name"
														required="true"></td>
													<td style="padding: 15px">ไร่</td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">การทำการเกษตร</td>
													<td><textarea id="editAgiDescription" maxlength="255"
															class="form-control" placeholder="" name="vil-name"
															required="true"></textarea></td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px"><a
														href="#listAgri" data-toggle="tab"><button
																style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
														<input style="width: 100px" type="button"
														class="btn btn-success" value="บันทึก"
														onclick="editAgriculture()" /></td>
												</tr>
											</table>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- jQuery -->
		<script src="../NanglaeGov/vendor/jquery/jquery.min.js"></script>

		<!-- Bootstrap Core JavaScript -->
		<script src="../NanglaeGov/vendor/bootstrap/js/bootstrap.min.js"></script>

		<!-- Metis Menu Plugin JavaScript -->
		<script src="../NanglaeGov/vendor/metisMenu/metisMenu.min.js"></script>

		<!-- DataTables JavaScript -->
		<script src="../NanglaeGov/vendor/datatables/js/jquery.dataTables.min.js"></script>
		<script
			src="https://cdn.datatables.net/buttons/1.2.4/js/dataTables.buttons.min.js"></script>
		<script
			src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.24/build/pdfmake.min.js"></script>
		<script src="../NanglaeGov/vendor/datatables/js/vfs_fonts.js"></script>
		<script
			src="//cdn.datatables.net/buttons/1.2.4/js/buttons.html5.min.js"></script>
		<script
			src="//cdn.datatables.net/buttons/1.2.4/js/buttons.print.min.js"></script>
		<script src="../NanglaeGov/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
		<script src="../NanglaeGov/vendor/datatables-responsive/dataTables.responsive.js"></script>
		<script
			src="https://cdn.datatables.net/buttons/1.2.4/js/buttons.bootstrap.min.js"></script>
		<script
			src="//cdn.datatables.net/buttons/1.2.4/js/buttons.colVis.min.js"></script>
		<script
			src="//cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>


		<!-- Custom Theme JavaScript -->
		<script src="../NanglaeGov/dist/js/sb-admin-2.js"></script>

		<!-- Page-Level Demo Scripts - Tables - Use for reference -->
		<script>
			$(document).ready(function() {

			});

			function openDeleteModal(id) {
				$('#agi_id').val($(id).data('id'));
				$('#DeleteModal').modal('show');
			}
		</script>
</body>

</html>
