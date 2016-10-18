

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>charts</title>

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/datepicker3.css" rel="stylesheet">
<link href="css/styles.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>

</head>

<body>
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#sidebar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span>  <span
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
			<li class="active"><a href="charts"> Charts</a></li>
			<li><a href="transactions"> Transactions</a></li>
			<li><a href="savingItems"> Saving Items</a></li>
		</ul>
	</div>

	<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">



		<div class="row">
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">Planned Money</div>
					<div class="panel-body">
						<div class="canvas-wrapper">
							<div id="plannedMoneyChart"></div>
						</div>
					</div>
				</div>
			</div>


			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">Payed Money</div>
					<div class="panel-body">
						<div class="canvas-wrapper">
							<div id="payedMoneyChart"></div>
						</div>
					</div>
				</div>
			</div>
		</div>



	</div>
	<!--/.main-->


	<script
		src="http://ajax.aspnetcdn.com/ajax/modernizr/modernizr-2.8.3.js"></script>
	<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/canvasjs/1.7.0/canvasjs.min.js"></script>
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/canvasjs/1.7.0/jquery.canvasjs.min.js"></script>
	<script src="js/chart-data.js"></script>
	<script src="js/easypiechart.js"></script>
	<script src="js/easypiechart-data.js"></script>
	<script src="js/bootstrap-datepicker.js"></script>





	<script type="text/javascript">
		function loadplannedmoneychart() {

			var budgetItems = ${budgetItemsJson};

			var plannedMoneyArray = [];
			for (index in budgetItems) {
				var item = budgetItems[index];
				if (item.expOrInc) {
					var plannedMoney = item.plannedMoney;
					var category = item.category;
					plannedMoneyArray.push({
						y : plannedMoney,
						label : category
					});
				}
			}

			var plannedMoneyChart = new CanvasJS.Chart(
					"plannedMoneyChart",
					{
						title : {
							text : "Percentage planned money by  category"
						},
						animationEnabled : true,
						data : [ {
							type : "doughnut",
							startAngle : 60,
							//showInLegend : false,
							explodeOnClick : true,
							dataPoints : plannedMoneyArray
						} ]
					});
			$("#plannedMoneyChart").append(plannedMoneyChart);
			plannedMoneyChart.render();
		}
	</script>

	<script>
		function loadpayedmoneychart() {

			var budgetItems = ${budgetItemsJson};

			var payedMoneyArray = [];
			for (index in budgetItems) {
				var item = budgetItems[index];
				if (!item.expOrInc) {
					var payedMoney = item.payedMoney;
					var category = item.category;
					payedMoneyArray.push({
						y : payedMoney,
						label : category
					});
				}
			}

			var payedMoneyChart = new CanvasJS.Chart(
					"payedMoneyChart",
					{
						title : {
							text : "Percentage payed money by  category"
						},
						animationEnabled : true,
						data : [ {
							type : "doughnut",
							startAngle : 60,
							//showInLegend : false,
							explodeOnClick : true,
							dataPoints : payedMoneyArray
						} ]
					});
			$("#payedMoneyChart").append(payedMoneyChart);
			payedMoneyChart.render();
		}
	</script>



	<script>
		$(document).ready(function() {
			loadplannedmoneychart();
			loadpayedmoneychart();
		});

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