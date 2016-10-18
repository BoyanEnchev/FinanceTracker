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
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">


<script
	src="http://ajax.aspnetcdn.com/ajax/modernizr/modernizr-2.8.3.js"></script>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.min.js"></script>

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
			<li class="active"><a href="budget"> Budget</a></li>
			<li><a href="charts"> Charts</a></li>
			<li><a href="transactions"> Transactions</a></li>
			<li><a href="savingItems"> Saving Items</a></li>
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
						<div class="row">
							<div class="col-xs-12 col-md-6 col-lg-3">
								<div class="panel panel-blue panel-widget ">
									<div class="row no-padding">
										<div class="col-sm-9 col-lg-7 widget-right">
											<div class="large" id="income">
												<c:out value="${income }" />
											</div>
											<div class="text-muted">Income</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-xs-12 col-md-6 col-lg-3">
								<div class="panel panel-blue panel-widget ">
									<div class="row no-padding">
										<div class="col-sm-9 col-lg-7 widget-right">
											<div class="large" id="budgeted">
												<c:out value="${budgeted }" />
											</div>
											<div class="text-muted">Budgeted</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-xs-12 col-md-6 col-lg-3">
								<div class="panel panel-blue panel-widget ">
									<div class="row no-padding">
										<div class="col-sm-9 col-lg-7 widget-right">
											<div class="large" id="actual">
												<c:out value="${actual }" />
											</div>
											<div class="text-muted">Actual</div>
										</div>
									</div>
								</div>
							</div>
						</div>


						<section id="contact">
							<div class="container">
								<div class="main-login main-center">
									<div style="float: left; display: inline; list-style: none"
										id="unique">
										<ul>
											<li><button type="button"
													class="w3-btn w3-padding-large" id="btn-add-income"
													data-toggle="modal" data-target="#myKodal">+Add
													Income Item</button></li>
											<li>&nbsp;&nbsp;&nbsp;</li>

											<li><button type="button"
													class="w3-btn w3-padding-large" id="btn-add-expense"
													data-toggle="modal" data-target="#myGodal">+Add
													Expense Item</button></li>


											<li>
												<form name="dates" action="listBudgetItems"
													onsubmit="return checkDateRange(d1,d2)">

													<input type="date" id="d1" name="startDate"
														placeholder="Start Date" required="required" /> <input
														type="date" id="d2" name="endDate" placeholder="End Date"
														required="required" /> <input type="submit"
														class="w3-btn w3-padding-small" id="btn-search-trans"
														value="Search">
												</form>
											</li>
										</ul>
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
																		pattern="^(0|[1-9][0-9]*)$"
																		title="Only positive numbers" required="required" />
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
																		pattern="^(0|[1-9][0-9]*)$"
																		title="Only positive numbers" required="required" />
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
						</div>


						<tr>
							<th width="50%" data-field="category" data-sortable="true">Category
								Name</th>
							<th width="10%" data-field="addTransactionButton">&nbsp;Add<br>Transaction
							</th>
							<th data-field="plannedMoney" data-sortable="true">Budgeted</th>
							<th data-field="payedMoney" data-sortable="true">Actual</th>
							<th data-field="leftMoney" data-sortable="true">What' left</th>
							<th data-field="delete">Delete</th>
						</tr>
						<section id="contact">
							<div class="container">
								<div class="main-login main-center">
									<c:forEach var="item" items="${budgetItems}">
										<c:if test="${item.expOrInc == false }">
											<c:set var="itCat" value="${item.category}" />
											<tr>
												<td><details>
														<summary>
															<c:out value="${item.category}" />
														</summary>
														<table style="width: 100%">
															<tr>
																<th>Description</th>
																<th width="20%">Date</th>
																<th width="15%">Amount</th>
																<th width="10%">Edit/Remove</th>
															</tr>

															<c:forEach var="transaction"
																items="${itemsNamesTransValues[itCat]}">
																<tr>
																	<td><c:out value="${transaction.description}" /></td>
																	<td><c:out
																			value="${transaction.timeOfTransactionString}" /></td>
																	<td><c:out value="${transaction.amount}" /></td>
																	<td>
																		<form title="Edit Transaction"
																			action="editTransaction" method="post"
																			onsubmit='redirect();return false;'>
																			<input type="text" class="budget-buttons"
																				name="editedID" value="${transaction.id}"
																				style="display: none"> <input type="text"
																				class="budget-buttons" name="editedItemID"
																				value="${transaction.item_id}" style="display: none">
																			<input type="text" class="budget-buttons"
																				name="editedAmount" value="${transaction.amount}"
																				style="display: none"> <input name="submit"
																				type="image" data-toggle="modal"
																				data-target="#editForm"
																				src="data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTkuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iTGF5ZXJfMSIgeD0iMHB4IiB5PSIwcHgiIHZpZXdCb3g9IjAgMCAzMDAgMzAwIiBzdHlsZT0iZW5hYmxlLWJhY2tncm91bmQ6bmV3IDAgMCAzMDAgMzAwOyIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSIgd2lkdGg9IjE2cHgiIGhlaWdodD0iMTZweCI+CjxnPgoJPGc+CgkJPHBhdGggZD0iTTE0OS45OTYsMEM2Ny4xNTcsMCwwLjAwMSw2Ny4xNjEsMC4wMDEsMTQ5Ljk5N1M2Ny4xNTcsMzAwLDE0OS45OTYsMzAwczE1MC4wMDMtNjcuMTYzLDE1MC4wMDMtMTUwLjAwMyAgICBTMjMyLjgzNSwwLDE0OS45OTYsMHogTTIyMS4zMDIsMTA3Ljk0NWwtMTQuMjQ3LDE0LjI0N2wtMjkuMDAxLTI4Ljk5OWwtMTEuMDAyLDExLjAwMmwyOS4wMDEsMjkuMDAxbC03MS4xMzIsNzEuMTI2ICAgIGwtMjguOTk5LTI4Ljk5Nkw4NC45MiwxODYuMzI4bDI4Ljk5OSwyOC45OTlsLTcuMDg4LDcuMDg4bC0wLjEzNS0wLjEzNWMtMC43ODYsMS4yOTQtMi4wNjQsMi4yMzgtMy41ODIsMi41NzVsLTI3LjA0Myw2LjAzICAgIGMtMC40MDUsMC4wOTEtMC44MTcsMC4xMzUtMS4yMjQsMC4xMzVjLTEuNDc2LDAtMi45MS0wLjU4MS0zLjk3My0xLjY0N2MtMS4zNjQtMS4zNTktMS45MzItMy4zMjItMS41MTItNS4yMDNsNi4wMjctMjcuMDM1ICAgIGMwLjM0LTEuNTE3LDEuMjg2LTIuNzk4LDIuNTc4LTMuNTgybC0wLjEzNy0wLjEzN0wxOTIuMyw3OC45NDFjMS42NzgtMS42NzUsNC40MDQtMS42NzUsNi4wODIsMC4wMDVsMjIuOTIyLDIyLjkxNyAgICBDMjIyLjk4MiwxMDMuNTQxLDIyMi45ODIsMTA2LjI2NywyMjEuMzAyLDEwNy45NDV6IiBmaWxsPSIjZDRiYTU1Ii8+Cgk8L2c+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPC9zdmc+Cg==">

																			<div class="main-login main-center">
																				<form:form class="form-horizontal"
																					commandName="editedTransaction"
																					action="./editTransaction">
																					<div id="editForm" class="modal fade" role="dialog">
																						<div class="modal-dialog">
																							<div class="modal-content">
																								<div class="modal-header">
																									<button type="button" class="close"
																										data-dismiss="modal">&times;</button>
																									<h3>Edit Transaction</h3>
																									<div class="form-group">
																										<form:label for="description"
																											path="description"
																											class="cols-sm-2 control-label">Description</form:label>
																										<div class="cols-sm-10">
																											<div class="input-group">
																												<span class="input-group-addon"><i
																													class="fa fa-user fa" aria-hidden="true"></i></span>
																												<form:input path="description" type="text"
																													class="form-control" name="description"
																													id="description"
																													placeholder="${transaction.description }"
																													required="required" />
																												<form:input path="item_id" type="text"
																													class="form-control" name="item_id"
																													id="item_id" placeholder="Enter Category"
																													required="required" value="${item.id}"
																													style="display:none" />

																											</div>
																										</div>
																									</div>
																									<div class="form-group">
																										<form:label for="timeOfTransactionString"
																											path="timeOfTransactionString"
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
																														class="form-control" name="amount"
																														id="amount"
																														placeholder="${transaction.amount }"
																														pattern="^(0|[1-9][0-9]*)$"
																														title="Only positive numbers"
																														required="required" />
																												</div>
																											</div>
																										</div>
																									</div>

																									<div class="form-group ">
																										<form:button type="submit"
																											class="btn btn-primary btn-lg btn-block login-button"
																											value="editTransaction">Edit</form:button>
																									</div>
																								</div>
																							</div>
																						</div>
																					</div>
																				</form:form>
																			</div>
																		</form> &nbsp;

																		<form title="Delete Transaction"
																			action="deleteTransaction" method="post"
																			onsubmit='redirect();return false;'>
																			<input type="text" class="budget-buttons"
																				name="deletedID" value="${transaction.id}"
																				style="display: none"> <input type="text"
																				class="budget-buttons" name="deletedItemID"
																				value="${item.id}" style="display: none"> <input
																				type="text" class="budget-buttons"
																				name="deletedAmount" value="${transaction.amount}"
																				style="display: none"><input type="image"
																				name="submit" alt="Submit"
																				src="data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTYuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iQ2FwYV8xIiB4PSIwcHgiIHk9IjBweCIgd2lkdGg9IjE2cHgiIGhlaWdodD0iMTZweCIgdmlld0JveD0iMCAwIDUxMCA1MTAiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDUxMCA1MTA7IiB4bWw6c3BhY2U9InByZXNlcnZlIj4KPGc+Cgk8ZyBpZD0iY2FuY2VsIj4KCQk8cGF0aCBkPSJNMjU1LDBDMTE0Ljc1LDAsMCwxMTQuNzUsMCwyNTVzMTE0Ljc1LDI1NSwyNTUsMjU1czI1NS0xMTQuNzUsMjU1LTI1NVMzOTUuMjUsMCwyNTUsMHogTTM4Mi41LDM0Ni44bC0zNS43LDM1LjcgICAgTDI1NSwyOTAuN2wtOTEuOCw5MS44bC0zNS43LTM1LjdsOTEuOC05MS44bC05MS44LTkxLjhsMzUuNy0zNS43bDkxLjgsOTEuOGw5MS44LTkxLjhsMzUuNywzNS43TDI5MC43LDI1NUwzODIuNSwzNDYuOHoiIGZpbGw9IiNiNTBkMmMiLz4KCTwvZz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8L3N2Zz4K">
																		</form> &nbsp;

																	</td>
																</tr>

															</c:forEach>
														</table>
													</details></td>

												<td><c:if test="${item.expOrInc == false}">
														<button title="Add Transaction" class="budget-buttons"
															type="image" data-toggle="modal"
															data-target="#${item.category }">
															<img
																src="data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTkuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iTGF5ZXJfMSIgeD0iMHB4IiB5PSIwcHgiIHZpZXdCb3g9IjAgMCAyOTcgMjk3IiBzdHlsZT0iZW5hYmxlLWJhY2tncm91bmQ6bmV3IDAgMCAyOTcgMjk3OyIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSIgd2lkdGg9IjI0cHgiIGhlaWdodD0iMjRweCI+CjxnPgoJPGc+CgkJPGc+CgkJCTxnPgoJCQkJPGNpcmNsZSBzdHlsZT0iZmlsbDojMTZBMDg1OyIgY3g9IjE0OC41IiBjeT0iMTQ4LjUiIHI9IjE0OC41Ii8+CgkJCTwvZz4KCQk8L2c+Cgk8L2c+Cgk8cGF0aCBzdHlsZT0iZmlsbDojMEU3NzYzOyIgZD0iTTI0NS4zMzcsMTI3LjVsLTE5My42NzQsNDJsMTI0Ljg1LDEyNC44NWM1OS41NDYtMTEuMzY5LDEwNi40NjgtNTguMjkxLDExNy44MzctMTE3LjgzNyAgIEwyNDUuMzM3LDEyNy41eiIvPgoJPHBvbHlnb24gc3R5bGU9ImZpbGw6I0VDRjBGMTsiIHBvaW50cz0iMjQ1LjMzNywxMjcuNSAxNjkuNSwxMjcuNSAxNjkuNSw1MS42NjMgMTI3LjUsNTEuNjYzIDEyNy41LDEyNy41IDUxLjY2MywxMjcuNSAgICA1MS42NjMsMTY5LjUgMTI3LjUsMTY5LjUgMTI3LjUsMjQ1LjMzNyAxNjkuNSwyNDUuMzM3IDE2OS41LDE2OS41IDI0NS4zMzcsMTY5LjUgICIvPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+Cjwvc3ZnPgo=" />
														</button>
													</c:if></td>
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
																								pattern="[a-zA-Z0-9\s]+" title="Only text"
																								required="required" />
																							<form:input path="item_id" type="text"
																								class="form-control" name="item_id" id="item_id"
																								placeholder="Enter Category" required="required"
																								value="${item.id}" style="display:none" />

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
																								id="timeOfTransactionString"
																								required="required"></form:input>

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
																									pattern="^(0|[1-9][0-9]*)$"
																									title="Only positive numbers"
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
												<td><c:out value="${item.plannedMoney}" /></td>
												<td><c:out value="${item.payedMoney}" /></td>
												<td><c:out
														value="${item.plannedMoney - item.payedMoney}" />
												<td><form action="deleteBudgetItem" method="post"
														onsubmit='redirect();return false;'>
														<input type="text" class="budget-buttons" name="deleted"
															value="${item.id}" style="display: none"> <input
															type="image" name="submit" alt="Submit"
															src="data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTkuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iTGF5ZXJfMSIgeD0iMHB4IiB5PSIwcHgiIHZpZXdCb3g9IjAgMCA0NzMgNDczIiBzdHlsZT0iZW5hYmxlLWJhY2tncm91bmQ6bmV3IDAgMCA0NzMgNDczOyIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSIgd2lkdGg9IjI0cHgiIGhlaWdodD0iMjRweCI+CjxnPgoJPHBhdGggZD0iTTMxNy42NjcsMjE0LjQybDUuNjY3LTg2LjQyaDIwLjk1MVYzOGgtOTguMzg0VjBIMTMyLjY2OXYzOEgzNC4yODV2OTBoMjAuOTUxbDIwLDMwNWgxNDAuNTcxICAgYzIzLjU3OCwyNC42MzUsNTYuNzY2LDQwLDkzLjQ3OCw0MGM3MS4zNjgsMCwxMjkuNDMtNTguMDYyLDEyOS40My0xMjkuNDNDNDM4LjcxNSwyNzUuMDE5LDM4NS4xNDMsMjE4Ljc1NSwzMTcuNjY3LDIxNC40MnogICAgTTE2Mi42NjksMzBoNTMuMjMydjhoLTUzLjIzMlYzMHogTTY0LjI4NSw2OGgyNTB2MzBoLTI1MFY2OHogTTEwMy4zMzQsNDAzTDg1LjMwMSwxMjhIMjkzLjI3bC01Ljc3LDg3Ljk4NSAgIGMtNjEuMDMxLDEwLjM4OC0xMDcuNjQ1LDYzLjY0Mi0xMDcuNjQ1LDEyNy41ODZjMCwyMS40MTEsNS4yMzEsNDEuNjIyLDE0LjQ3NSw1OS40M0gxMDMuMzM0eiBNMzA5LjI4NSw0NDMgICBjLTU0LjgyNiwwLTk5LjQzLTQ0LjYwNC05OS40My05OS40M3M0NC42MDQtOTkuNDI5LDk5LjQzLTk5LjQyOXM5OS40Myw0NC42MDQsOTkuNDMsOTkuNDI5UzM2NC4xMTEsNDQzLDMwOS4yODUsNDQzeiIgZmlsbD0iIzYzNjA2MyIvPgoJPHBvbHlnb24gcG9pbnRzPSIzNDIuMjQ4LDI4OS4zOTUgMzA5LjI4NSwzMjIuMzU4IDI3Ni4zMjIsMjg5LjM5NSAyNTUuMTA5LDMxMC42MDggMjg4LjA3MiwzNDMuNTcxIDI1NS4xMDksMzc2LjUzMyAgICAyNzYuMzIyLDM5Ny43NDYgMzA5LjI4NSwzNjQuNzgzIDM0Mi4yNDgsMzk3Ljc0NiAzNjMuNDYxLDM3Ni41MzMgMzMwLjQ5OCwzNDMuNTcxIDM2My40NjEsMzEwLjYwOCAgIiBmaWxsPSIjNjM2MDYzIi8+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPC9zdmc+Cg==">
													</form></td>
										</c:if>
									</c:forEach>
								</div>
							</div>
							<br> <br>
						
						</section>
						<!-- Second table -->
						
						
						<tr>
							<th width="50%" data-field="category" data-sortable="true">Category
								Name</th>
							<th data-field="plannedMoney" data-sortable="true">Amount</th>
							<th data-field="delete">Delete</th>
						</tr>
						<section id="contact">
							<div class="container">
								<div class="main-login main-center">
									<c:forEach var="item" items="${budgetItems}">
										<c:if test="${item.expOrInc == true }">
											<tr>
												<td><c:out value="${item.category}" /></td>
												<td><c:out value="${item.plannedMoney}" /></td>
												<td><form action="deleteBudgetItem" method="post"
														onsubmit='redirect();return false;'>
														<input type="text" class="budget-buttons" name="deleted"
															value="${item.id}" style="display: none"> <input
															type="image" name="submit" alt="Submit"
															src="data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTkuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iTGF5ZXJfMSIgeD0iMHB4IiB5PSIwcHgiIHZpZXdCb3g9IjAgMCA0NzMgNDczIiBzdHlsZT0iZW5hYmxlLWJhY2tncm91bmQ6bmV3IDAgMCA0NzMgNDczOyIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSIgd2lkdGg9IjI0cHgiIGhlaWdodD0iMjRweCI+CjxnPgoJPHBhdGggZD0iTTMxNy42NjcsMjE0LjQybDUuNjY3LTg2LjQyaDIwLjk1MVYzOGgtOTguMzg0VjBIMTMyLjY2OXYzOEgzNC4yODV2OTBoMjAuOTUxbDIwLDMwNWgxNDAuNTcxICAgYzIzLjU3OCwyNC42MzUsNTYuNzY2LDQwLDkzLjQ3OCw0MGM3MS4zNjgsMCwxMjkuNDMtNTguMDYyLDEyOS40My0xMjkuNDNDNDM4LjcxNSwyNzUuMDE5LDM4NS4xNDMsMjE4Ljc1NSwzMTcuNjY3LDIxNC40MnogICAgTTE2Mi42NjksMzBoNTMuMjMydjhoLTUzLjIzMlYzMHogTTY0LjI4NSw2OGgyNTB2MzBoLTI1MFY2OHogTTEwMy4zMzQsNDAzTDg1LjMwMSwxMjhIMjkzLjI3bC01Ljc3LDg3Ljk4NSAgIGMtNjEuMDMxLDEwLjM4OC0xMDcuNjQ1LDYzLjY0Mi0xMDcuNjQ1LDEyNy41ODZjMCwyMS40MTEsNS4yMzEsNDEuNjIyLDE0LjQ3NSw1OS40M0gxMDMuMzM0eiBNMzA5LjI4NSw0NDMgICBjLTU0LjgyNiwwLTk5LjQzLTQ0LjYwNC05OS40My05OS40M3M0NC42MDQtOTkuNDI5LDk5LjQzLTk5LjQyOXM5OS40Myw0NC42MDQsOTkuNDMsOTkuNDI5UzM2NC4xMTEsNDQzLDMwOS4yODUsNDQzeiIgZmlsbD0iIzYzNjA2MyIvPgoJPHBvbHlnb24gcG9pbnRzPSIzNDIuMjQ4LDI4OS4zOTUgMzA5LjI4NSwzMjIuMzU4IDI3Ni4zMjIsMjg5LjM5NSAyNTUuMTA5LDMxMC42MDggMjg4LjA3MiwzNDMuNTcxIDI1NS4xMDksMzc2LjUzMyAgICAyNzYuMzIyLDM5Ny43NDYgMzA5LjI4NSwzNjQuNzgzIDM0Mi4yNDgsMzk3Ljc0NiAzNjMuNDYxLDM3Ni41MzMgMzMwLjQ5OCwzNDMuNTcxIDM2My40NjEsMzEwLjYwOCAgIiBmaWxsPSIjNjM2MDYzIi8+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPC9zdmc+Cg==">
													</form></td>
										</c:if>
									</c:forEach>
								</div>
							</div>
						</section>
					</table>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/jquery-ui.js"></script>

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


	<script>
		function checkDateRange(start, end) {
			// Parse the entries
			var start = document.getElementById('d1').value;
			var startDate = new Date(start);
			var end = document.getElementById('d2').value;
			var endDate = new Date(end);
			console.log(startDate)
			console.log(endDate)

			// Check the date range, 86400000 is the number of milliseconds in one day
			var difference = (endDate - startDate) / (86400000 * 7);
			if (difference < 0) {
				alert("The start date must come before the end date.");
				return false;
			}
			if (difference <= 1) {
				alert("The range must be at least seven days apart.");
				return false;
			}
			return true;
		}

		function validate(form) {
			//forms processsing goes here...
			console.log(form, form.name)
			return false;
		}

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
