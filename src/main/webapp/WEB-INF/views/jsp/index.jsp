<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>Creative - Start Bootstrap Theme</title>

<!-- Bootstrap Core CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">

<!-- Custom Fonts -->
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
	rel='stylesheet' type='text/css'>
<link
	href='http://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="../font-awesome/css/font-awesome.min.css"
	type="text/css">

<!-- Plugin CSS -->
<link rel="stylesheet" href="css/animate.min.css" type="text/css">

<!-- Custom CSS -->
<link rel="stylesheet" href="css/creative.css" type="text/css">


</head>

<body id="page-top">

	<nav id="mainNav" class="navbar navbar-default navbar-fixed-top">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand page-scroll" href="index.html">projecttracker</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li><a class="page-scroll" href="#about">Start</a></li>
					<li><a class="page-scroll" href="#services">Sign up</a></li>
					<li><a class="page-scroll" href="#contact">Sign in</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>

	<header>
		<div class="header-content">
			<div class="header-content-inner">
				<h1>Your Project Tracker</h1>
				<hr>
				<a href="#about" class="btn btn-primary btn-xl page-scroll">Start!</a>
			</div>
		</div>
	</header>

	<section class="bg-primary" id="about">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-lg-offset-2 text-center">
					<h2 class="section-heading">We've got what you need!</h2>
					<hr class="light">
					<a href="#services" class="btn btn-default btn-xl">Sign up</a> <a
						href="#contact" class="btn btn-default btn-xl">Sign in</a>
				</div>
			</div>
		</div>
	</section>

	<section id="services">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading">Sign up</h2>
					<hr class="primary">
				</div>
			</div>
		</div>
		<div class="container">

			<form id="login-form" action="#" method="post" role="form"
				style="display: block;">
				<div class="form-group">
					<input type="text" name="username" id="usernameLogin" tabindex="1"
						class="form-control" placeholder="Username" value="" size=50>
				</div>
				<div class="form-group">
					<input type="password" name="password" id="passwordLogin"
						tabindex="2" class="form-control" placeholder="Password" size=50>
				</div>

				<div class="form-group">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3">
							<input type="submit" name="login-submit" id="login-submit"
								tabindex="4" class="form-control btn btn-login" value="Log In">
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="row">
						<div class="col-lg-12">
							<div class="text-center">
								<a href="http://phpoll.com/recover" tabindex="5"
									class="forgot-password">Forgot Password?</a>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</section>




	<aside class="bg-dark">
		<div class="container text-center">
			<div class="call-to-action">
				<h2>Free Software Tracker</h2>
			</div>
		</div>
	</aside>

	<section id="contact">
		<div class="container">
			<div class="main-login main-center">
				<form:form class="form-horizontal" commandName="registerForm" action="register">

					<div class="form-group">
						<form:label for="firstName" path="firstName" class="cols-sm-2 control-label">Your
							First Name</form:label>
						<div class="cols-sm-10">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-user fa"
									aria-hidden="true"></i></span> 
									<form:input path="firstName" type="text" class="form-control"
									name="firstName" id="firstName" placeholder="Enter your Name"
									required="required" />
							</div>
						</div>
					</div>

					<div class="form-group">
						<form:label for="lastName" path="lastName" class="cols-sm-2 control-label">Your
							Last Name</form:label>
						<div class="cols-sm-10">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-user fa"
									aria-hidden="true"></i></span> <form:input path="lastName" type="text" class="form-control"
									name="lastName" id="lastName" placeholder="Enter your Name"
									required="required" />
							</div>
						</div>
					</div>

					<div class="form-group">
						<form:label for="email" path="email" class="cols-sm-2 control-label">Your
							Email</form:label>
						<div class="cols-sm-10">
							<div class="input-group">
								<span class="input-group-addon"><i
									class="fa fa-envelope fa" aria-hidden="true"></i></span> <form:input path="email"
									type="text" class="form-control" name="email" id="email"
									placeholder="Enter your Email" required="required" />
							</div>
						</div>
					</div>

					<div class="form-group">
						<form:label for="password" path="password" class="cols-sm-2 control-label">Password</form:label>
						<div class="cols-sm-10">
							<div class="input-group">
								<span class="input-group-addon"><i
									class="fa fa-lock fa-lg" aria-hidden="true"></i></span> <form:input path="password"
									type="password" class="form-control" name="password"
									id="password" placeholder="Enter your Password"
									required="required" />
							</div>
						</div>
					</div>

					<div class="form-group">
						<form:label for="confirm" path="confirm" class="cols-sm-2 control-label">Confirm
							Password</form:label>
						<div class="cols-sm-10">
							<div class="input-group">
								<span class="input-group-addon"><i
									class="fa fa-lock fa-lg" aria-hidden="true"></i></span> 
									<form:input path="confirm"
									type="password" class="form-control" name="confirm"
									id="confirm" placeholder="Confirm your Password"
									required="required" />
							</div>
						</div>
					</div>

					<div class="form-group ">
						<form:button type="submit"
							class="btn btn-primary btn-lg btn-block login-button" value="register">Register</form:button>
					</div>
					<div class="login-register">
						<a href="#services">Login</a>
					</div>
				</form:form>
			</div>
		</div>
	</section>
	
	<!-- jQuery -->
	<script src="js/jquery.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="js/bootstrap.min.js"></script>

	<!-- Plugin JavaScript -->
	<script src="../js/jquery.easing.min.js"></script>
	<script src="../js/jquery.fittext.js"></script>
	<script src="../js/wow.min.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="../js/creative.js"></script>

</body>

</html>
