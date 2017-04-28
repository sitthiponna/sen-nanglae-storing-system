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

<title>www.Nanglea.com</title>

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
<script type='text/javascript'>
	function numberWithCommas(x) {
		var parts = x.toString().split(".");
		parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return parts.join(".");
	}
	function listInventory() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listInventory.do",
					type : "POST",
					success : function(data) {
						var htmls = '';
						var html = '';
						var totalIncome = 0;
						var totalOutcome = 0;
						var balance = 0;
						for (var i = 0; i < data.length; i++) {
							totalIncome += data[i].ivn_collect
									+ data[i].ivn_gov_provide
									+ data[i].ivn_gor_purchase;
							totalOutcome += data[i].inv_outcome;
							html += "<tr>";
							html += "<td>"
									+ data[i].ivn_year
									+ "</td>"
									+ "<td>"
									+ numberWithCommas(data[i].ivn_collect)
									+ "</td>"
									+ "<td>"
									+ numberWithCommas(data[i].ivn_gov_provide)
									+ "</td>"
									+ "<td>"
									+ numberWithCommas(data[i].ivn_gor_purchase)
									+ "</td>"
									+ "<td>"
									+ numberWithCommas(data[i].inv_outcome)
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editInven\" data-toggle=\"tab\" onclick=\"setEditInventory("
									+ data[i].ivn_id
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button data-toggle=\"modal\" data-id="
									+ data[i].ivn_id
									+ " onclick=\"openDeleteModal(this);\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"

							html += "</tr>";
						}
						balance = totalOutcome - totalIncome;
						htmls += "<tr>";
						htmls += "<th style=\"text-align: left\" colspan=\"2\">รายรับจริง</th>";
						var fixed_totalIncome = parseFloat(totalIncome)
								.toFixed(2);
						htmls += "<th style=\"text-align: right\" colspan=\"3\">"
								+ numberWithCommas(fixed_totalIncome) + "</th>";
						htmls += "<th colspan=\"2\">บาท</th>"
						htmls += "</tr>";
						htmls += "<tr>";
						htmls += "<th style=\"text-align: left\" colspan=\"2\">รายจ่ายจริง</th>";
						htmls += "<th style=\"text-align: right\" colspan=\"3\">"
								+ numberWithCommas(totalOutcome) + "</th>";
						htmls += "<th colspan=\"2\">บาท</th>"
						htmls += "</tr>";
						htmls += "<tr>";
						htmls += "<th style=\"text-align: left\" colspan=\"2\">เงินสะสมคงเหลือ</th>";
						var checkBalance = (balance < 0) ? balance * -1
								: balance;
						var fixed_checkBalance = parseFloat(checkBalance)
								.toFixed(2);
						htmls += "<th style=\"text-align: right\" colspan=\"3\">"
								+ numberWithCommas(fixed_checkBalance)
								+ "</th>";
						htmls += "<th colspan=\"2\">บาท</th>"
						htmls += "</tr>";
						
						$('#listInventorys').html(html);
						$("#resultTable").DataTable({

							dom : 'Bfrtip',
							buttons : [ {
								extend : 'pdfHtml5',
								exportOptions : {
									columns : [ 0, 1, 2, 3, 4 ]
								},
								customize : function(doc) {
									doc.defaultStyle['font'] = 'THSarabun';
								}
							}, 'excelHtml5' ]
						});
						$('#listInventoryss').html(htmls);
						$("#resultTables").DataTable({

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
	function createInventory() {
		$("#loader").show();
		if ($('#ivn_year').val() == "") {
			document.getElementById('ivn_year').style.borderColor = "red";
			return false;
		} else if ($('#ivn_collect').val() == "") {
			document.getElementById('ivn_collect').style.borderColor = "red";
			return false;
		} else if ($('#ivn_gov_provide').val() == "") {
			document.getElementById('ivn_gov_provide').style.borderColor = "red";
			return false;
		} else if ($('#ivn_gor_purchase').val() == "") {
			document.getElementById('ivn_gor_purchase').style.borderColor = "red";
			return false;
		} else if ($('#inv_outcome').val() == "") {
			document.getElementById('inv_outcome').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				ivn_id : 0,
				ivn_year : $('#ivn_year').val(),
				ivn_collect : $('#ivn_collect').val(),
				ivn_gov_provide : $('#ivn_gov_provide').val(),
				ivn_gor_purchase : $('#ivn_gor_purchase').val(),
				inv_outcome : $('#inv_outcome').val()

			};
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/saveInventory.do",
				type : "POST",
				dataType : "JSON",
				data : JSON.stringify(obj),
				contentType : "application/json",
				mimeType : "application/json",
				success : function(data) {
					//alert('success');
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
	function deleteInventory() {
		var id = document.getElementById("ivn_id").value;
		var obj = {
			ivn_id : id

		};
		$.ajax({
			url : "../NanglaeGov/deleteInventory.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				location.reload();
			}
		});
	}
	function editInventory() {
		var obj = {
			ivn_id : $('#editIvnId').val(),
			ivn_year : $("#editIvnYear").val(),
			ivn_collect : $('#editIvnCollect').val(),
			ivn_gov_provide : $('#editIvnGovProvide').val(),
			ivn_gor_purchase : $('#editIvnGorPurchase').val(),
			inv_outcome : $('#editInvOutcome').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveInventory.do",
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
	function setEditInventory(ivn_id) {

		var obj = {
			ivn_id : ivn_id
		};

		$.ajax({
			url : "../NanglaeGov/findInventory.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editIvnId").val(data.ivn_id);
				$("#editIvnYear").val(data.ivn_year);
				$("#editIvnCollect").val(data.ivn_collect);
				$("#editIvnGovProvide").val(data.ivn_gov_provide);
				$("#editIvnGorPurchase").val(data.ivn_gor_purchase);
				$("#editInvOutcome").val(data.inv_outcome);
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
</script>
</head>

<body onload="listInventory();">

	<div id="wrapper">

		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation"
			style="margin-bottom: 0">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.html">เทศบาลตำบลนางแล</a>
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
								<li><a href="personnel.html">บุคลากร</a></li>
								<li><a href="population.html">ประชากร</a></li>
								<li><a href="labor.html">แรงงาน</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="fa fa-road fa-fw"></i>
								สาธารณูปโภค<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="transport.html">ระบบคมนาคมขนส่ง</a></li>
								<li><a href="electric.html">ระบบไฟฟ้า</a></li>
								<li><a href="pipeline.html">ระบบประปา</a></li>
								<li><a href="drainange.html">ระบบระบายน้ำ</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="fa fa-home fa-fw"></i>
								สาธารณุปการ<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="#">เคหะ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="village.html">หมู่บ้าน</a></li>
										<li><a href="industry.html">การอุตสาหกรรม</a></li>
										<li><a href="education.html">การศึกษา</a></li>
										<li><a href="religion.html">การศาสนา</a></li>
										<li><a href="commerce.html">การพาณิชย์</a></li>
										<li><a href="tourism.html">แหล่งท่องเที่ยว</a></li>
									</ul> <!-- /.nav-third-level --></li>
								<li><a href="#">บริการ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="health.html">การสาธารสุข</a></li>
										<li><a href="security.html">ความปลอดภัยในชีวิตและทรัพย์สิน</a>
										</li>
										<li><a href="group.html">กลุ่มในชุมชน</a></li>
										<li><a href="service.html">ศูนย์บริการประชาชน</a></li>
										<li><a href="inventory.html">การคลัง</a></li>
									</ul> <!-- /.nav-third-level --></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="glyphicon glyphicon-leaf"></i>
								ธรรมชาติและสิ่งแวดล้อม<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="agriculture.html">การเกษตรกรรม</a></li>
								<li><a href="#">ทรัพยากรธรรมชาติ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="waterresource.html">ทรัพยากรณ์น้ำ</a></li>
										<li><a href="landresource.html">ทรัพยากรณ์ดิน</a></li>
										<li><a href="forrestresource.html">ทรัพยากรณ์ป่าไม้</a></li>
									</ul></li>
								<li><a href="polution.html">มลพิษ</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="copy.html"><i class="fa fa-copy"></i>
								คัดลอกข้อมูล</a></li>
					</ul>
				</div>
				<!-- /.sidebar-collapse -->
			</div>
		</nav>
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">การคลัง</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.panel-heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#listInven" data-toggle="tab">ข้อมูลการคลัง</a>
								</li>
								<li><a href="#addInven" data-toggle="tab">เพิ่มการคลัง</a>
								</li>
							</ul>
							<div class="panel-body">

								<!-- Tab panes -->
								<div class="tab-content">
									<div class="tab-pane fade in active" id="listInven">
										พ.ศ. <select>
											<option value="2558">2558</option>
											<option value="2559">2559</option>
										</select> <br>
										<br>
										
										<div class="table-responsive">
											<table id="resultTable"
												class="table table-striped table-bordered table-hover">
<!-- Start change table -->
												<thead>
													<tr>
														<th>ปีงบประมาณ</th>
														<th>รายได้จัดเก็บเอง</th>
														<th>รายได้ที่รัฐจัดสรรให้</th>
														<th>เงินอุดหนุนจากรัฐบาล</th>
														<th>รายจ่าย</th>
														<th style="text-align: center;">ตัวเลือก</th>
													</tr>
												</thead>
												<tbody id="listInventorys">
												</tbody>
<!-- End change table -->
											</table>
										</div>
										<div class="table-responsive">
											<table id="resultTables"
												class="table table-striped table-bordered table-hover">
<!-- Start change table2 -->
												<thead>
													
												</thead>
												<tbody id="listInventoryss">
												</tbody>
<!-- End change table2 -->
											</table>
										</div>
									</div>
									<div class="tab-pane fade" id="addInven">
										<form role="form">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีงบประมาณ</td>
													<td><input id="ivn_year" maxlength="4"
														class="form-control" placeholder="" name="vil-number"
														required="true"></td>

												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">รายได้จัดเก็บเอง</td>
													<td><input id="ivn_collect" maxlength="15"
														class="form-control" placeholder="" name="vil-number"
														required="true"></td>

												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">รายได้รัฐจัดสรรให้</td>
													<td><input id="ivn_gov_provide" maxlength="15"
														class="form-control" placeholder="" name="vil-number"
														required="true"></td>

												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">รายได้อุดหนุนจากรัฐบาล</td>
													<td><input id="ivn_gor_purchase" maxlength="15"
														class="form-control" placeholder="" name="vil-number"
														required="true"></td>

												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">รายจ่าย</td>
													<td><input id="inv_outcome" maxlength="15"
														class="form-control" placeholder="" name="vil-number"
														required="true"></td>

												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px">
														<button style="width: 100px" type="reset"
															class="btn btn-warning">ล้างข้อมูล</button> <input
														style="width: 100px" type="button" class="btn btn-success"
														value="บันทึก" onclick="createInventory()" />
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
														<input type="hidden" name="ivn_id" id="ivn_id" value="" />
													</div>

													<div class="modal-footer">
														<button type="button" class="btn btn-default"
															data-dismiss="modal">ยกเลิก</button>
														<button type="button" id="deleteInventory"
															class="btn btn-danger" onclick="deleteInventory();">ลบข้อมูล</button>

													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- End modal -->
									<div class="tab-pane fade" id="editInven">
										<form role="form">
											<input type="hidden" id="editIvnId">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีงบประมาณ</td>
													<td><input id="editIvnYear" maxlength="4"
														class="form-control" placeholder="" name="vil-number"
														required="true"></td>

												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">รายได้จัดเก็บเอง</td>
													<td><input id="editIvnCollect" maxlength="15"
														class="form-control" placeholder="" name="vil-number"
														required="true"></td>

												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">รายได้รัฐจัดสรรให้</td>
													<td><input id="editIvnGovProvide" maxlength="15"
														class="form-control" placeholder="" name="vil-number"
														required="true"></td>

												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">รายได้อุดหนุนจากรัฐบาล</td>
													<td><input id="editIvnGorPurchase" maxlength="15"
														class="form-control" placeholder="" name="vil-number"
														required="true"></td>

												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">รายจ่าย</td>
													<td><input id="editInvOutcome" maxlength="15"
														class="form-control" placeholder="" name="vil-number"
														required="true"></td>

												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px"><a
														href="#listInven" data-toggle="tab"><button
																style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
														<input style="width: 100px" type="button"
														class="btn btn-success" value="บันทึก"
														onclick="editInventory()" /></td>
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
				$('#dataTables-example').DataTable({
					responsive : true
				});
			});
			function openDeleteModal(id) {
				$('#ivn_id').val($(id).data('id'));
				$('#DeleteModal').modal('show');
			}
		</script>
</body>

</html>
