<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>budget</title>

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/styles.css" rel="stylesheet">


</head>

<body>

	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#sidebar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#"><span>Finance</span>Tracker</a>
				<ul class="user-menu">
					<li class="dropdown pull-right"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown"><svg
								class="glyph stroked male-user">
								<use xlink:href="#stroked-male-user"></use></svg> Hi, <c:out
								value="${user.firstName}" /> <span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="#"><svg class="glyph stroked male-user">
										<use xlink:href="#stroked-male-user"></use></svg> Profile</a></li>
							<li><a href="#"><svg class="glyph stroked gear">
										<use xlink:href="#stroked-gear"></use></svg> Settings</a></li>
							<li><a href="#"><svg class="glyph stroked cancel">
										<use xlink:href="#stroked-cancel"></use></svg> Logout</a></li>
						</ul></li>
				</ul>
			</div>

		</div>
		<!-- /.container-fluid -->
	</nav>

	<div id="sidebar-collapse" class="col-sm-3 col-lg-2 sidebar">
		<form role="search">
			<div class="form-group">
				<input type="text" class="form-control" placeholder="Search">
			</div>
		</form>
		<ul class="nav menu">
			<li><a href="budget"> Budget</a></li>
			<li><a href="charts"> Charts</a></li>
			<li><a href="transactions"> Transactions</a></li>
			<li class="active"><a href="savingItems"> Saving Items</a></li>
			<li><a href="index"> Login Page</a></li>
		</ul>
	</div>

	<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">Saving Items</div>
				<div class="panel-body">

					<table data-toggle="table" data-url="tables/data1.json">
						<tr>
							<th data-field="price" data-sortable="true">Price</th>
							<th data-field="name" data-sortable="true">Name</th>
							<th data-field="description" data-sortable="true">Description</th>
						</tr>
						<c:forEach var="savingItem"
							items="${savingItems}">
							<tr>
								<td><c:out value="${savingItem.price}" /></td>
								<td><c:out value="${savingItem.name}" /></td>
								<td><c:out value="${savingItem.description}" /></td>
							</tr>
						</c:forEach>
					</table>
					<section id="contact">
						<div class="container">
							<div class="main-login main-center">
								<div>
									<button type="button" class="btn btn-primary"
										data-toggle="modal" data-target="#myKodal">+Add
										Saving Item</button>
								</div>
								<form:form class="form-horizontal" commandName="savingItem"
									action="./savingItems">
									<div id="myKodal" class="modal fade" role="dialog">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal">&times;</button>
													<h3>Add New Saving Item</h3>
													<div class="form-group">
														<form:label for="price" path="price"
															class="cols-sm-2 control-label">Price</form:label>
														<div class="cols-sm-10">
															<div class="input-group">
																<span class="input-group-addon"><i
																	class="fa fa-user fa" aria-hidden="true"></i></span>
																<form:input path="price" type="text"
																	class="form-control" name="price" id="price"
																	placeholder="Enter Price" required="required" />
															</div>
														</div>
													</div>

													<div class="form-group">
														<form:label for="name" path="name"
															class="cols-sm-2 control-label">Name</form:label>
														<div class="cols-sm-10">
															<div class="input-group">
																<span class="input-group-addon"><i
																	class="fa fa-user fa" aria-hidden="true"></i></span>
																<form:input path="name" type="text" class="form-control"
																	name="name" id="name" placeholder="Enter Name"
																	required="required" />
															</div>
														</div>
													</div>

													<div class="form-group">
														<form:label for="description" path="description"
															class="cols-sm-2 control-label">Description</form:label>
														<div class="cols-sm-10">
															<div class="input-group">
																<span class="input-group-addon"><i
																	class="fa fa-user fa" aria-hidden="true"></i></span>
																<form:input path="description" type="text"
																	class="form-control" name="description"
																	id="description" placeholder="Enter Description"
																	required="required" />
															</div>
														</div>
													</div>
													<div class="form-group ">
														<form:button type="submit"
															class="btn btn-primary btn-lg btn-block login-button"
															value="addSavingItem">+Add</form:button>
													</div>
												</div>
											</div>
										</div>
									</div>
								</form:form>
							</div>
						</div>
					</section>
				</div>
			</div>
		</div>




		<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript" src="js/jquery-ui.js"></script>

		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


		<script>
			$(function() {
				$('#hover, #striped, #condensed').click(
						function() {
							var classes = 'table';

							if ($('#hover').prop('checked')) {
								classes += ' table-hover';
							}
							if ($('#condensed').prop('checked')) {
								classes += ' table-condensed';
							}
							$('#table-style').bootstrapTable('destroy')
									.bootstrapTable({
										classes : classes,
										striped : $('#striped').prop('checked')
									});
						});
			});

			function rowStyle(row, index) {
				var classes = [ 'active', 'success', 'info', 'warning',
						'danger' ];

				if (index % 2 === 0 && index / 2 < classes.length) {
					return {
						classes : classes[index / 2]
					};
				}
				return {};
			}
		</script>
	</div>

	<!--/.row-->


	<!--/.main-->

	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/chart.min.js"></script>
	<script src="js/chart-data.js"></script>
	<script src="js/easypiechart.js"></script>
	<script src="js/easypiechart-data.js"></script>
	<script src="js/bootstrap-table.js"></script>

	<script>
		!function($) {
			$(document)
					.on(
							"click",
							"ul.nav li.parent > a > span.icon",
							function() {
								$(this).find('em:first').toggleClass(
										"glyphicon-minus");
							});
			$(".sidebar span.icon").find('em:first').addClass("glyphicon-plus");
		}(window.jQuery);

		$(window).on('resize', function() {
			if ($(window).width() > 768)
				$('#sidebar-collapse').collapse('show')
		})
		$(window).on('resize', function() {
			if ($(window).width() <= 767)
				$('#sidebar-collapse').collapse('hide')
		})
	</script>
</body>

</html>