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

<style>

#btn-search-trans {
	background-color: #30a5ff;
	color: #fff;
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
								<use xlink:href="#stroked-male-user"></use></svg></a>
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
			<li class="active"><a href="transactions"> Transactions</a></li>
			<li><a href="savingItems"> Saving Items</a></li>
		</ul>
	</div>

	<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">Transactions for a period of time</div>
					<div class="panel-body">
						<div class="panel-heading">Select a time span</div>
						<form name="dati" action="listTransactions"
							onsubmit="return checkDateRange(d1,d2)">

							<input type="date" id="d1" name="startDate"
								placeholder="Start Date" required="required"/> <input type="date" id="d2"
								name="endDate" placeholder="End Date" required="required"/> <input type="submit"
								class="w3-btn w3-padding-small" id="btn-search-trans" value="Search">
						</form>

						<table data-toggle="table" data-url="tables/data1.json"
							data-show-refresh="true" data-show-toggle="true"
							data-show-columns="true" data-search="true"
							data-select-item-name="toolbar1" data-pagination="true"
							data-sort-name="name" data-sort-order="desc">

							<tr>
								<th data-field="timeOfTransactionToString" data-sortable="true">Time
									of transaction</th>
								<th data-field="category" data-sortable="true">Category</th>
								<th data-field="description" data-sortable="true">Description</th>
								<th data-field="amount" data-sortable="true">Amount</th>
							</tr>
							<section id="contact">
								<div class="container">
									<div class="main-login main-center">
										<c:forEach var="transaction" items="${transactionsInTimeSpan}">
											<tr>
												<td><c:out
														value="${transaction.timeOfTransactionString}" /></td>
												<td><c:out value="${transaction.category}" /></td>
												<td><c:out value="${transaction.description}" /></td>
												<td><c:out value="${transaction.amount}" /></td>
											</tr>
										</c:forEach>
									</div>
								</div>
							</section>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 
	<form:form name="frm" method="post" action="">
		<input type="hidden" name="hdnbt" />
		<input type="button" name="bt" value="gi"
			onclick="{document.frm.hdnbt.value=this.value;document.frm.submit();}" />
	</form:form>
 -->

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
	</script>


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
