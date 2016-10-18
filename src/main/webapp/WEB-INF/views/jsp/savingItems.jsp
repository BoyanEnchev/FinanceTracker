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

<style>
}
.FAQ {
	vertical-align: top;
	height: auto !important;
}

.list {
	display: none;
	height: auto;
	margin: 0;
	float: left;
}

.show {
	display: none;
}

.hide:target+.show {
	display: inline;
}

.hide:target {
	display: none;
}

.hide:target ~ .list {
	display: inline;
} /*style the (+) and
(-) */
.hide, .show {
	width: 30px;
	height: 30px;
	border-radius: 30px;
	font-size: 20px;
	color: #fff;
	text-shadow: 0 1px 0 #666;
	text-align: center;
	text-decoration:;
	box-shadow: 1px 1px 2px #000;
	background: #cccbbb;
	opacity: .95;
	margin-right: 0;
	float: left;
	margin-bottom: 25px;
}

.hide:hover, .show:hover {
	color: #eee;
	text-shadow: 0 0 1px #666;
	text-decoration: none;
	box-shadow: 0 0 4px #222 inset;
	opacity: 1;
	margin-bottom: 25px;
}

.list p {
	height: auto;
	margin: 0;
}

.question {
	float: left;
	height: auto;
	width: 90%;
	line-height: 20px;
	padding-left: 20px;
	margin-bottom: 25px;
	font-style: italic;
}

.btn-add-trans {
	background-color: #4CAF50;
	height: 25px;
	width: 25px;
	margin-left: 5px;
	border-radius: 100%;
	border: none;
	color: white; /* padding: 15px 32px;
*/
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
}

.table-trans {
	border-radius: 2px;
	height: 27px;
	margin: 2px;
	padding: 5px;
	text-align: right;
}

.budget-buttons {
	background-color: transparent;
	border-color: transparent;
}

#actual {
	color: #a91729;
}

#budgeted {
	color: #5f6468;
}

#income {
	color: #008040;
}

#btn-add-income {
	background-color: #30a5ff;
	color: #fff;
}

#btn-add-expense {
	background-color: #30a5ff;
	color: #fff;
}

#unique ul li {
	list-style: none;
	display: inline;
	margin: 0;
	padding: 0;
}
</style>

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
								<use xlink:href="#stroked-male-user"></use></svg> <span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="index"><svg class="glyph stroked cancel">
										<use xlink:href="#stroked-cancel"></use></svg> Logout</a></li>
						</ul></li>
				</ul>
			</div>

		</div>
		<!-- /.container-fluid -->
	</nav>

	<div id="sidebar-collapse" class="col-sm-3 col-lg-2 sidebar">
		<ul class="nav menu">
			<li><a href="budget"> Budget</a></li>
			<li><a href="charts"> Charts</a></li>
			<li><a href="transactions"> Transactions</a></li>
			<li class="active"><a href="savingItems"> Saving Items</a></li>
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
							<th data-field="deleteSavingItem">Delete</th>
						</tr>
						<c:forEach var="savingItem" items="${savingItems}">
							<tr>
								<td><c:out value="${savingItem.price}" /></td>
								<td><c:out value="${savingItem.name}" /></td>
								<td><c:out value="${savingItem.description}" /></td>
								<td>
									<form title="Delete Saving Item" action="deleteSavingItem"
										method="post" onsubmit='redirect();return false;'>
										<input type="text" class="budget-buttons" name="deletedItemPrice"
											value="${savingItem.price}" style="display: none">
											<input type="text" class="budget-buttons" name="deletedItemName"
											value="${savingItem.name}" style="display: none">
											<input type="text" class="budget-buttons" name="deletedItemDesc"
											value="${savingItem.description}" style="display: none">
											<input
											type="image" name="submit" alt="Submit"
											src="data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTkuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iTGF5ZXJfMSIgeD0iMHB4IiB5PSIwcHgiIHZpZXdCb3g9IjAgMCA0NzMgNDczIiBzdHlsZT0iZW5hYmxlLWJhY2tncm91bmQ6bmV3IDAgMCA0NzMgNDczOyIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSIgd2lkdGg9IjI0cHgiIGhlaWdodD0iMjRweCI+CjxnPgoJPHBhdGggZD0iTTMxNy42NjcsMjE0LjQybDUuNjY3LTg2LjQyaDIwLjk1MVYzOGgtOTguMzg0VjBIMTMyLjY2OXYzOEgzNC4yODV2OTBoMjAuOTUxbDIwLDMwNWgxNDAuNTcxICAgYzIzLjU3OCwyNC42MzUsNTYuNzY2LDQwLDkzLjQ3OCw0MGM3MS4zNjgsMCwxMjkuNDMtNTguMDYyLDEyOS40My0xMjkuNDNDNDM4LjcxNSwyNzUuMDE5LDM4NS4xNDMsMjE4Ljc1NSwzMTcuNjY3LDIxNC40MnogICAgTTE2Mi42NjksMzBoNTMuMjMydjhoLTUzLjIzMlYzMHogTTY0LjI4NSw2OGgyNTB2MzBoLTI1MFY2OHogTTEwMy4zMzQsNDAzTDg1LjMwMSwxMjhIMjkzLjI3bC01Ljc3LDg3Ljk4NSAgIGMtNjEuMDMxLDEwLjM4OC0xMDcuNjQ1LDYzLjY0Mi0xMDcuNjQ1LDEyNy41ODZjMCwyMS40MTEsNS4yMzEsNDEuNjIyLDE0LjQ3NSw1OS40M0gxMDMuMzM0eiBNMzA5LjI4NSw0NDMgICBjLTU0LjgyNiwwLTk5LjQzLTQ0LjYwNC05OS40My05OS40M3M0NC42MDQtOTkuNDI5LDk5LjQzLTk5LjQyOXM5OS40Myw0NC42MDQsOTkuNDMsOTkuNDI5UzM2NC4xMTEsNDQzLDMwOS4yODUsNDQzeiIgZmlsbD0iIzYzNjA2MyIvPgoJPHBvbHlnb24gcG9pbnRzPSIzNDIuMjQ4LDI4OS4zOTUgMzA5LjI4NSwzMjIuMzU4IDI3Ni4zMjIsMjg5LjM5NSAyNTUuMTA5LDMxMC42MDggMjg4LjA3MiwzNDMuNTcxIDI1NS4xMDksMzc2LjUzMyAgICAyNzYuMzIyLDM5Ny43NDYgMzA5LjI4NSwzNjQuNzgzIDM0Mi4yNDgsMzk3Ljc0NiAzNjMuNDYxLDM3Ni41MzMgMzMwLjQ5OCwzNDMuNTcxIDM2My40NjEsMzEwLjYwOCAgIiBmaWxsPSIjNjM2MDYzIi8+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPC9zdmc+Cg==">
									</form>
								</td>
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
																	pattern="[a-zA-Z0-9\s]+" title="Only text"
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
																	pattern="[a-zA-Z0-9\s]+" title="Only text"
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