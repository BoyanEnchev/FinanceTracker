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

<!--Icons-->
<script type="text/javascript"
	src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="<c:url value="js/jquery-3.1.1.min.js"/>"></script>





<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->

<style>
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
}

/*style the (+) and (-) */
.hide, .show {
	width: 30px;
	height: 30px;
	border-radius: 30px;
	font-size: 20px;
	color: #fff;
	text-shadow: 0 1px 0 #666;
	text-align: center;
	text-decoration: none;
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
</style>

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
							<li><a href="logout"><svg class="glyph stroked cancel">
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
			<li class="active"><a href="budget"> Budget</a></li>
			<li><a href="charts"> Charts</a></li>
			<li><a href="transactions"> Transactions</a></li>
			<li><a href="savingItems"> Saving Items</a></li>
			<li><a href="index"> Login Page</a></li>
		</ul>
	</div>

	<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">Budget Items</div>
				<div class="panel-body">
					<table data-toggle="table" data-url="tables/data1.json"
						data-show-refresh="true" data-show-toggle="true"
						data-show-columns="true" data-search="true"
						data-select-item-name="toolbar1" data-pagination="true"
						data-sort-name="name" data-sort-order="desc">
						<div class="budgeted-block">
							<div class="block-label">Budgeted</div>
							<div id="budgeted-amount" class="budgeted-value currency">200.00</div>
						</div>
						<div class="budgeted-block">
							<div class="block-label">Actual</div>
							<div id="budgeted-amount" class="budgeted-value currency">210.00</div>
						</div>
						<div class="budgeted-block">
							<div class="block-label">Savings</div>
							<div id="budgeted-amount" class="budgeted-value currency">200.00</div>
						</div>

						<section id="contact">
							<div class="container">
								<div class="main-login main-center">
									<div>
										<button type="button" class="btn btn-primary"
											data-toggle="modal" data-target="#myKodal">+Add
											Income Item</button>
									</div>
									<form:form class="form-horizontal" commandName="item"
										action="./budget">
										<div id="myKodal" class="modal fade" role="dialog">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal">&times;</button>
														<h3>Add New Income Item</h3>
														<div class="form-group">
															<form:label for="category" path="category"
																class="cols-sm-2 control-label">Category</form:label>
															<div class="cols-sm-10">
																<div class="input-group">
																	<span class="input-group-addon"><i
																		class="fa fa-user fa" aria-hidden="true"></i></span>
																	<form:select path="category" type="text"
																		class="form-control" name="category" id="category"
																		placeholder="Enter Category" required="required">

																		<c:forEach var="category" items="${incomeCategories}">
																			<form:option value="${category }"></form:option>
																		</c:forEach>

																	</form:select>

																</div>
															</div>
														</div>

														<div class="form-group">
															<form:label for="plannedMoney" path="plannedMoney"
																class="cols-sm-2 control-label">Amount</form:label>
															<div class="cols-sm-10">
																<div class="input-group">
																	<span class="input-group-addon"><i
																		class="fa fa-user fa" aria-hidden="true"></i></span>
																	<form:input path="plannedMoney" type="text"
																		class="form-control" name="plannedMoney"
																		id="plannedMoney" placeholder="Enter Amount"
																		required="required" />
																</div>
															</div>
														</div>
														<div class="form-group ">
															<form:button type="submit"
																class="btn btn-primary btn-lg btn-block login-button"
																value="addBudgetItem">+Add</form:button>
														</div>
													</div>
												</div>
											</div>
										</div>
									</form:form>
								</div>
							</div>
						</section>





						<section id="contact">
							<div class="container">
								<div class="main-login main-center">
									<div>
										<button type="button" class="btn btn-primary"
											data-toggle="modal" data-target="#myGodal">+Add
											Expense Item</button>
									</div>

									<form:form class="form-horizontal" commandName="item"
										action="./budget">
										<div id="myGodal" class="modal fade" role="dialog">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal">&times;</button>
														<h3>Add New Expense Item</h3>
														<div class="form-group">
															<form:label for="category" path="category"
																class="cols-sm-2 control-label">Category</form:label>
															<div class="cols-sm-10">
																<div class="input-group">
																	<span class="input-group-addon"><i
																		class="fa fa-user fa" aria-hidden="true"></i></span>
																	<form:select path="category" type="text"
																		class="form-control" name="category" id="category"
																		placeholder="Enter Category" required="required">

																		<c:forEach var="category" items="${expenseCategories}">
																			<form:option value="${category }"></form:option>
																		</c:forEach>

																	</form:select>

																</div>
															</div>
														</div>

														<div class="form-group">
															<form:label for="plannedMoney" path="plannedMoney"
																class="cols-sm-2 control-label">Amount</form:label>
															<div class="cols-sm-10">
																<div class="input-group">
																	<span class="input-group-addon"><i
																		class="fa fa-user fa" aria-hidden="true"></i></span>
																	<form:input path="plannedMoney" type="text"
																		class="form-control" name="plannedMoney"
																		id="plannedMoney" placeholder="Enter Amount"
																		required="required" />
																</div>
															</div>
														</div>
														<div class="form-group ">
															<form:button type="submit"
																class="btn btn-primary btn-lg btn-block login-button"
																value="addBudgetItem">+Add</form:button>
														</div>
													</div>
												</div>
											</div>
										</div>
									</form:form>
								</div>
							</div>
						</section>


						<tr>
							<th data-field="category" data-sortable="true">Category name</th>
							<th data-field="plannedMoney" data-sortable="true">Budgeted</th>
							<th data-field="payedMoney" data-sortable="true">Actual</th>
							<th data-field="leftMoney" data-sortable="true">What' left</th>
						</tr>
						<section id="contact">
							<div class="container">
								<div class="main-login main-center">
									<c:forEach var="item" items="${budgetItems}">
										<c:set var="itCat" value="${item.category}" />
										<tr>
											<td><details>
													<summary>
														<c:out value="${item.category}" />
													</summary>
													<table style="width: 100%">
														<tr>
															<th>Description</th>
															<th>Date</th>
															<th>Amount</th>
														</tr>

														<c:forEach var="transaction"
															items="${itemsNamesTransValues[itCat]}">
															<tr>
																<td><c:out value="${transaction.description}" /></td>
																<td><c:out
																		value="${transaction.timeOfTransactionString}" /></td>
																<td><c:out value="${transaction.amount}" /></td>
															</tr>
														</c:forEach>
													</table>
												</details></td>
											<td><c:out value="${item.plannedMoney}" /></td>
											<td><c:out value="${item.payedMoney}" /> &nbsp;
												<button type="button" class="btn btn-primary"
													data-toggle="modal" data-target="#${item.category }">+</button></td>
											<section id="contact">
												<div class="container">
													<div class="main-login main-center">
														<form:form class="form-horizontal"
															commandName="transaction" action="./transactionForm">
															<div id="${item.category }" class="modal fade"
																role="dialog">
																<div class="modal-dialog">
																	<div class="modal-content">
																		<div class="modal-header">
																			<button type="button" class="close"
																				data-dismiss="modal">&times;</button>
																			<h3>Add New Transaction</h3>
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
																						<form:input path="item_id" type="text"
																							class="form-control" name="item_id" id="item_id"
																							placeholder="Enter Category" required="required"
																							value="${item.id}" />

																					</div>
																				</div>
																			</div>
																			<div class="form-group">
																				<form:label for="timeOfTransaction"
																					path="timeOfTransaction"
																					class="cols-sm-2 control-label">Date</form:label>
																				<div class="cols-sm-10">

																					<div class="input-group">
																						<span class="input-group-addon"><i
																							class="fa fa-user fa" aria-hidden="true"></i></span>
																						<form:input type="date"
																							path="timeOfTransactionString"
																							name="timeOfTransactionString"
																							id="timeOfTransactionString"></form:input>

																					</div>
																				</div>
																				<div class="form-group">
																					<form:label for="amount" path="amount"
																						class="cols-sm-2 control-label">Amount</form:label>
																					<div class="cols-sm-10">
																						<div class="input-group">
																							<span class="input-group-addon"><i
																								class="fa fa-user fa" aria-hidden="true"></i></span>
																							<form:input path="amount" type="text"
																								class="form-control" name="amount" id="amount"
																								placeholder="Enter Amount" required="required" />
																						</div>
																					</div>
																				</div>
																			</div>

																			<div class="form-group ">
																				<form:button type="submit"
																					class="btn btn-primary btn-lg btn-block login-button"
																					value="addBudgetItem">+Add</form:button>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</form:form>
													</div>
												</div>
											</section>
											<td><c:out
													value="${item.plannedMoney - item.payedMoney}" />
										</tr>
									</c:forEach>

									</td>
								</div>
							</div>
						</section>
					</table>
				</div>
			</div>
		</div>
	</div>
	</div>

	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/jquery-ui.js"></script>

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


	<script>
		$(function() {
			$('#hover, #striped, #condensed').click(function() {
				var classes = 'table';

				if ($('#hover').prop('checked')) {
					classes += ' table-hover';
				}
				if ($('#condensed').prop('checked')) {
					classes += ' table-condensed';
				}
				$('#table-style').bootstrapTable('destroy').bootstrapTable({
					classes : classes,
					striped : $('#striped').prop('checked')
				});
			});
		});

		function rowStyle(row, index) {
			var classes = [ 'active', 'success', 'info', 'warning', 'danger' ];

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
