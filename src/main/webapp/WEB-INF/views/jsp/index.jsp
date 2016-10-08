<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<script type="text/javascript"
	src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>

<script type="text/javascript"
	src="<c:url value="js/jquery-3.1.1.min.js"/>"></script> 

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
<link rel="stylesheet" href="font-awesome/font-awesome.min.css">


<!-- Plugin CSS -->
<link rel="stylesheet" href="css/animate.min.css" type="text/css">

<!-- Custom CSS -->
<link rel="stylesheet" href="css/creative.css" type="text/css">

<!-- 
<style type="text/css">
#password_info {
	    position:absolute;
	    bottom:-75px;
	    bottom: -115px\9; /* IE Specific */
	    right:55px;
	    width:250px;
	    padding:15px;
	    background:#fefefe;
	    font-size:.875em;
	    border-radius:5px;
	    box-shadow:0 1px 3px #ccc;
	    border:1px solid #ddd;
}
#password_info h4 {
	    margin:0 0 10px 0;
	    padding:0;
	    font-weight:normal;
}
#password_info::before {
	    content: "\25B2";
	    position:absolute;
	    top:-12px;
	    left:45%;
	    font-size:14px;
	    line-height:14px;
	    color:#ddd;
	    text-shadow:none;
	    display:block;
}
</style>
-->
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
				<a class="navbar-brand page-scroll" href="index.html">financetracker</a>
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
				<h1>Your Finance Tracker</h1>
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

			<form:form id="login-form" action="login" commandName="registerForm"
				method="post" role="form" style="display: block;">
				<div class="form-group">
					<input type="text" name="email" path="email" id="usernameLogin"
						tabindex="1" class="form-control" placeholder="Email" value=""
						size=50>
				</div>
				<div class="form-group">
					<input type="password" name="password" path="password"
						id="passwordLogin" tabindex="2" class="form-control"
						placeholder="Password" size=50>
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
			</form:form>
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
				<form:form cssClass="form-horizontal registrationForm"
					id="registrationForm" commandName="user" action="./register">

					<div class="form-group">
						<form:label for="firstName" path="firstName"
							class="cols-sm-2 control-label">Your
							First Name</form:label>
						<form:input id="firstName" path="firstName" name="firstName"
							type="text" cssClass="form-control" />
						<form:errors path="firstName" />
					</div>

					<div class="form-group">
						<form:label for="LastName" path="LastName"
							class="cols-sm-2 control-label">Your
							Last Name</form:label>
						<form:input id="LastName" path="LastName" name="LastName"
							type="text" cssClass="form-control" />
						<form:errors path="lastName" />
					</div>

					<div class="form-group">
						<form:label for="email" path="email"
							class="cols-sm-2 control-label">Your
							Email</form:label>
						<form:input id="email" path="email" name="email" type="text"
							cssClass="form-control" />
						<form:errors path="email" />
					</div>

					<div class="form-group">
						<form:label for="password" path="password"
							class="cols-sm-2 control-label">Your
							Password</form:label>
						<form:input id="password" path="password" name="password"
							type="password" cssClass="form-control" />
						<form:errors path="password" />
					</div>



					<div class="form-group">
						<form:label for="confirm" path="confirm"
							class="cols-sm-2 control-label">Confirm
							Password</form:label>
						<form:input id="confirm" path="confirm" name="confirm"
							type="password" cssClass="form-control" />
						<form:errors path="confirm" />
					</div>



					<div class="form-group ">
						<form:button type="submit"
							class="btn btn-primary btn-lg btn-block login-button"
							value="register">Register</form:button>
					</div>
					<div class="login-register">
						<a href="#services">Login</a>
					</div>
				</form:form>
				
				<script type="text/javascript">
					$(document).ready(function() {
						$(".registrationForm").validate({

							rules : {
								firstName : {
									required : true,
									minlength : 2
								},
								lastName : {
									required : true,
									minlength : 2
								},
								email : {
									required : true,
									email : true
								},
								password : {
									required : true,
									minlength : 6,
									maxlength : 50
								},
								confirm : {
									required : true,
									minlength : 6,
									maxlength : 50,
									equalTo : "#password"
								}
							}
						});
					});
				</script>
			</div>
		</div>
	</section>





	<!--  
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('#registrationForm')
									.validate(
											{
												rules : {
													"firstName" : {
														required : true,
														minlength : 2
													},
													"lastName" : {
														required : true,
														minlength : 2
													},
													"email" : {
														required : true,
														email : true
													},
													"password" : {
														required : true,
														minlength : 6
													},
													"confirm" : {
														required : true,
														minlength : 6
													}
												},
												messages : {
													"firstName" : {
														required : "this field is required",
														minlength : "this field must contain at least {0} characters"
													},
													"lastName" : {
														required : "this field is required",
														minlength : "this field must contain at least {0} characters"
													},
													"email" : {
														required : "this field is required",
														email : "this field must be a valid email"
													},
													"password" : {
														required : "this field is required",
														minlength : "this field must contain at least {0} characters"
													},
													"confirm" : {
														required : "this field is required",
														minlength : "this field must contain at least {0} characters"
													}
												},
												submitHandler : function(form) { // for demo
													alert('valid form');
													return false;
												}
											});

						}); -->
	</script>

	<!-- jQuery -->
	<script src="js/jquery.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="js/bootstrap.min.js"></script>

	<!-- Plugin JavaScript -->
	<script src="js/jquery.easing.min.js"></script>
	<script src="js/jquery.fittext.js"></script>
	<script src="js/wow.min.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="js/creative.js"></script>
</body>

</html>
