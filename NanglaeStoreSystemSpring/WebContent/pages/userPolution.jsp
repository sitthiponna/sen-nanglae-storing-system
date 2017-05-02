<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>เทศบาลตำบลนางแล</title>

<!-- Bootstrap Core CSS -->
<link href="../NanglaeGov/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="../NanglaeGov/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- DataTables CSS -->
<link
	href="../NanglaeGov/vendor/datatables-plugins/dataTables.bootstrap.css"
	rel="stylesheet">

<!-- DataTables Responsive CSS -->
<link
	href="../NanglaeGov/vendor/datatables-responsive/dataTables.responsive.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="../NanglaeGov/dist/css/sb-admin-2.css" rel="stylesheet">
<link href="../NanglaeGov/dist/css/sweetalert2.min.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="../NanglaeGov/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- Data Table -->
<link href="css/dataTable/dataTables.bootstrap.min.css" rel="stylesheet">
<link href="css/dataTable/buttons.bootstrap.min.css" rel="stylesheet">


<script type='text/javascript' src="../NanglaeGov/js/jquery.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.1.1/jquery-confirm.min.js"></script>


<script type='text/javascript'>
	function listPolution() {
		$("#loader").show();

		$
				.ajax({
					url : "../NanglaeGov/listPolution.do",
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {

							var id = data[i].pol_id;
							function loader() {
								document.getElementById("myLink").innerHTML = id;
							}

							html += "<tr>";
							html += "<td>"
									+ data[i].pol_year
									+ "</td>"
									+ "<td>"
									+ data[i].pol_name
									+ "</td>"
									+ "<td>"
									+ data[i].pol_effect
									+ "</td>"
									+ "<td>"
									+ data[i].pol_area
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editPolution\" data-toggle=\"tab\" onclick=\"setEditPolution("
									+ data[i].pol_id
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deletePolution("
									+ data[i].pol_id
									+ ");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"

							html += "</tr>";
						}
						$('#listPolutions').html(html);
						$(document).ready(function() {
							var table = $('#resultTable').DataTable({
								lengthChange : false,
								buttons : ['excel',{extend : 'pdf',exportOptions : {
								columns : [ 0, 1, 2, 3 ]},customize : function(doc) {
								doc.defaultStyle['font'] = 'THSarabun';
										}
									},
								]
						});
						table.buttons().container().appendTo('#page-wrapper .col-sm-6:eq(0)');
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
	function createPolution() {
		$("#loader").show();
		if ($('#pol_year').val() == "") {
			document.getElementById('pol_year').style.borderColor = "red";
			return false;
		} else if ($('#pol_name').val() == "") {
			document.getElementById('pol_name').style.borderColor = "red";
			return false;
		} else if ($('#pol_effect').val() == "") {
			document.getElementById('pol_effect').style.borderColor = "red";
			return false;
		} else if ($('#pol_area').val() == "") {
			document.getElementById('pol_area').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				pol_id : 0,
				pol_year : $('#pol_year').val(),
				pol_name : $('#pol_name').val(),
				pol_effect : $('#pol_effect').val(),
				pol_area : $('#pol_area').val()
			};
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/savePolution.do",
				type : "POST",
				dataType : "JSON",
				data : JSON.stringify(obj),
				contentType : "application/json",
				mimeType : "application/json",
				success : function(data) {
					swal({
						title : 'บันทึกข้อมูลสำเร็จ',
						type : 'success'
					}).then(function() {
						location.reload();
					});
				},
				error : function(data, status, er) {
					alert('error');
					$("#loader").hide();
				}
			});
		}

	}

	function deletePolution(pol_id) {
		swal({
			title : 'คุณต้องการลบข้อมูลหรือไม่?',
			type : 'warning',
			showCancelButton : true,
			confirmButtonColor : '#3085d6',
			cancelButtonColor : '#d33',
			confirmButtonText : 'ตกลง',
			cancelButtonText : 'ยกเลิก'
		}).then(function() {
		var id = pol_id;
		var obj = {
			pol_id : id
		};

		$.ajax({
			url : "../NanglaeGov/deletePolution.do",
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
		});
	}
	function editPolution() {
		var obj = {
			pol_id : $('#editPolId').val(),
			pol_year : $('#editPolYear').val(),
			pol_name : $('#editPolName').val(),
			pol_effect : $('#editPolEffect').val(),
			pol_area : $('#editPolArea').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/savePolution.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				swal({
					title : 'บันทึกข้อมูลสำเร็จ',
					type : 'success'
				}).then(function() {
					location.reload();
				});
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}

	function setEditPolution(pol_id) {

		var obj = {
			pol_id : pol_id
		};

		$.ajax({
			url : "../NanglaeGov/findPolution.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editPolId").val(data.pol_id);
				$("#editPolYear").val(data.pol_year);
				$("#editPolName").val(data.pol_name);
				$("#editPolEffect").val(data.pol_effect);
				$("#editPolArea").val(data.pol_area);
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
</script>
</head>

<body onload="listPolution()">

	<div id="wrapper">

		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation"
			style="margin-bottom: 0; background-color: #98c3e8">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<img src="../NanglaeGov/images/logo-nanglae.png"> <a
					class="navbar-brand" href="userIndex.do">เทศบาลตำบลนางแล</a>
			</div>
			<!-- /.navbar-header -->

			<ul class="nav navbar-top-links navbar-right">
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
						<li><a href="index.do"><i class="fa fa-sign-out fa-fw"></i>
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
								<li><a href="userPersonnel.do">บุคลากร</a></li>
								<li><a href="userPopulation.do">ประชากร</a></li>
								<li><a href="userLabor.do">แรงงาน</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="fa fa-road fa-fw"></i>
								สาธารณูปโภค<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="userTransport.do">ระบบคมนาคมขนส่ง</a></li>
								<li><a href="userElectric.do">ระบบไฟฟ้า</a></li>
								<li><a href="userPipeline.do">ระบบประปา</a></li>
								<li><a href="userDrainage.do">ระบบระบายน้ำ</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="fa fa-home fa-fw"></i>
								สาธารณุปการ<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="#">เคหะ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="userVillage.do">หมู่บ้าน</a></li>
										<li><a href="userIndustry.do">การอุตสาหกรรม</a></li>
										<li><a href="userEducation.do">การศึกษา</a></li>
										<li><a href="userReligion.do">การศาสนา</a></li>
										<li><a href="userCommerce.do">การพาณิชย์</a></li>
										<li><a href="userTourism.do">แหล่งท่องเที่ยว</a></li>
									</ul> <!-- /.nav-third-level --></li>
								<li><a href="#">บริการ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="userHealth.do">การสาธารสุข</a></li>
										<li><a href="userSecurity.do">ความปลอดภัยในชีวิตและทรัพย์สิน</a>
										</li>
										<li><a href="userGroup.do">กลุ่มในชุมชน</a></li>
										<li><a href="userService.do">ศูนย์บริการประชาชน</a></li>
										<li><a href="userInventory.do">การคลัง</a></li>
									</ul> <!-- /.nav-third-level --></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="glyphicon glyphicon-leaf"></i>
								ธรรมชาติและสิ่งแวดล้อม<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="userAgriculture.do">การเกษตรกรรม</a></li>
								<li><a href="#">ทรัพยากรธรรมชาติ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="userWaterresource.do">ทรัพยากรณ์น้ำ</a></li>
										<li><a href="userLandresource.do">ทรัพยากรณ์ดิน</a></li>
										<li><a href="userForestresource.do">ทรัพยากรณ์ป่าไม้</a></li>
									</ul></li>
								<li><a href="userPolution.do">มลพิษ</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="userCopy.do"><i class="fa fa-copy"></i>
								คัดลอกข้อมูล</a></li>
					</ul>
				</div>
				<!-- /.sidebar-collapse -->
			</div>
		</nav>
	</div>
	<div id="page-wrapper" style="background-color: #d7f0f5">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">มลพิษ</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.panel-heading -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#listPolution" data-toggle="tab">ข้อมูลมลพิษ</a>
							</li>
							<li><a href="#addPolution" data-toggle="tab">เพิ่มมลพิษ</a>
							</li>
						</ul>
						<div class="panel-body">

							<!-- Tab panes -->
							<div class="tab-content">
								<div class="tab-pane fade in active" id="listPolution">
									<div class="table-responsive">
										<table id="resultTable"
											class="table table-striped table-bordered table-hover">
<!-- Start change table -->
												<thead>
													<tr>
														<th>ปีที่ข้อมูล</th>
														<th>มลพิษ</th>
														<th>ผลกระทบ</th>
														<th>พิ้นที่ได้รับผลกระทบ</th>
														<th style="text-align: center;">ตัวเลือก</th>
													</tr>
												</thead>
												<tbody id="listPolutions">
												</tbody>
<!-- End change table -->
										</table>
									</div>
								</div>
								<div class="tab-pane fade" id="addPolution">
									<form role="form">
										<table width="70%" align="center">
											<tr>
												<td style="padding: 15px">ปีข้อมูล</td>
												<td><input id="pol_year" maxlength="4"
													class="form-control" placeholder="" value="2558"
													name="vil-year"></td>
											</tr>
											<tr>

												<td style="padding: 15px">มลพิษ</td>
												<td><input id="pol_name" maxlength="50"
													class="form-control" placeholder="" name="vil-number"
													required="true"></td>

											</tr>
											<tr>
												<td style="padding: 15px">ผลกระทบ</td>
												<td><textarea id="pol_effect" maxlength="100"
														class="form-control" placeholder="ระบุรายละเอียด"
														name="vil-name" required="true"></textarea></td>
											</tr>
											<tr>
												<td style="padding: 15px">พื้นที่ประสบปัญหา</td>
												<td style="padding-top: 10px"><textarea id="pol_area"
														maxlength="100" class="form-control"
														placeholder="ระบุรายละเอียด" name="vil-name"
														required="true"></textarea></td>
											</tr>
											<tr>
												<td></td>
												<td align="center" style="padding: 15px">
													<button style="width: 100px" type="reset"
														class="btn btn-warning">ล้างข้อมูล</button> <input
													style="width: 100px" type="button" class="btn btn-success"
													value="บันทึก" onclick="createPolution()" />
												</td>
											</tr>
										</table>
									</form>
								</div>
								<div class="tab-pane fade" id="editPolution">
									<form role="form">
										<input type="hidden" id="editPolId">
										<table width="65%" align="center">
											<tr>
												<td style="padding: 15px">ปีข้อมูล</td>
												<td><input id="editPolYear" maxlength="4"
													class="form-control" placeholder="" value="2558"
													name="vil-year"></td>
											</tr>
											<tr>

												<td style="padding: 15px">มลพิษ</td>
												<td><input id="editPolName" maxlength="50"
													class="form-control" placeholder="ระบุชื่อมลพิษ"
													name=" required="true"></td>

											</tr>
											<tr>
												<td style="padding: 15px">ผลกระทบ</td>
												<td><textarea id="editPolEffect" maxlength="100"
														class="form-control" placeholder="ระบุผลกระทบ" name=""
														required="true"></textarea></td>
											</tr>
											<tr>
												<td style="padding: 15px">พื้นที่ประสบปัญหา</td>
												<td style="padding-top: 10px"><textarea
														id="editPolArea" maxlength="100" class="form-control"
														placeholder="ระบุพื้นที่ประสบปัญหา" name=""
														required="true"></textarea></td>
											</tr>
											<tr>
												<td></td>
												<td align="center" style="padding: 15px"><a
													href="#listPolution" data-toggle="tab"><button
															style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
													<input style="width: 100px" type="button"
													class="btn btn-success" value="บันทึก"
													onclick="editPolution()" /></td>
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
		<script
			src="../NanglaeGov/vendor/datatables/js/jquery.dataTables.min.js"></script>
		<script src="../NanglaeGov/js/dataTables.buttons.min.js"></script>
		<script src="../NanglaeGov/js/pdfmake.min.js"></script>
		<script src="../NanglaeGov/vendor/datatables/js/vfs_fonts.js"></script>
		<script src="../NanglaeGov/js/buttons.html5.min.js"></script>
		<script src="../NanglaeGov/js/buttons.print.min.js"></script>
		<script
			src="../NanglaeGov/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
		<script
			src="../NanglaeGov/vendor/datatables-responsive/dataTables.responsive.js"></script>
		<script src="../NanglaeGov/js/buttons.bootstrap.min.js"></script>
		<script src="../NanglaeGov/js/buttons.colVis.min.js"></script>
		<script src="../NanglaeGov/js/jszip.min.js"></script>

		<!-- Custom Theme JavaScript -->
		<script src="../NanglaeGov/dist/js/sb-admin-2.js"></script>
		<!-- Sweetalert2 JavaScript -->
		<script src="../NanglaeGov/js/sweetalert2.min.js"></script>

</body>

</html>
