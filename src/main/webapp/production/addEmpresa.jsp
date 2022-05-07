<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>


<%
	//INVALIDA LA CACHE DEL NAVEGADOR //
	response.setHeader( "Pragma", "no-cache" );
	response.setHeader( "Cache-Control", "no-store" );
	response.setDateHeader( "Expires", 0 );
	response.setDateHeader( "Expires", -1 );
	
	//DECLARACIONES
	Vw_usuariorol vwur = new Vw_usuariorol();
	Dt_rolOpciones dtro = new Dt_rolOpciones();
	ArrayList<Vw_rolopciones> listOpc = new ArrayList<Vw_rolopciones>();
	boolean permiso = false; //VARIABLE DE CONTROL
	
	//OBTENEMOS LA SESION
	vwur = (Vw_usuariorol) session.getAttribute("acceso");
	if(vwur!=null){
		//OBTENEMOS LA LISTA DE OPCIONES ASIGNADAS AL ROL
		
		listOpc = dtro.listarRolOpciones(vwur.getId_rol());
		
		
		//RECUPERAMOS LA URL = MI OPCION ACTUAL
		int index = request.getRequestURL().lastIndexOf("/");
		String miPagina = request.getRequestURL().substring(index+1);
		
		//VALIDAR SI EL ROL CONTIENE LA OPCION ACTUAL DENTRO DE LA MATRIZ DE OPCIONES
		for(Vw_rolopciones vrop : listOpc){
			if(vrop.getOpciones().trim().equals(miPagina.trim())){
				permiso = true; //ACCESO CONCEDIDO
				break;
			}
		}
	}
	else{
		response.sendRedirect("../login.jsp?msj=401");
		return;
	}
		
	if(!permiso){
		// response.sendRedirect("../login.jsp?msj=401");
		response.sendRedirect("page_403.jsp");
		return;
	}
	
%>

<!DOCTYPE html>
<html lang="es">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Agregar | Empresa</title>

<!-- Bootstrap -->
<link href="cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
<link href="../vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link href="../vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
<!-- iCheck -->
<link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
<!-- Datatables -->

<link
	href="../vendors/datatables.net-bs/css/dataTables.bootstrap.min.css"
	rel="stylesheet">
<link
	href="../vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css"
	rel="stylesheet">
<link
	href="../vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css"
	rel="stylesheet">
<link
	href="../vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css"
	rel="stylesheet">
<link
	href="../vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css"
	rel="stylesheet">
<!-- Custom Theme Style -->
<link href="../build/css/custom.min.css" rel="stylesheet">
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<div class="col-md-3 left_col">
				<div class="left_col scroll-view">
					<div class="navbar nav_title" style="border: 0;">
						<a href="index.html" class="site_title"><i class="fa fa-money"></i>
							<span>Sistema Contable</span></a>
					</div>

					<div class="clearfix"></div>

					<!-- menu profile quick info -->
					<div class="profile clearfix">
						<div class="profile_pic">
							<img src="img.jpg" alt="..." class="img-circle profile_img">
						</div>
						<div class="profile_info">
							<span>Bienvenido,</span>
							<h2><%= vwur.getNombre() + " "+ vwur.getApellido() %></h2>
						</div>
					</div>
					<!-- /menu profile quick info -->

					<br />

					<!-- sidebar menu -->
					<div id="sidebar-menu"
						class="main_menu_side hidden-print main_menu">
						<div class="menu_section">
							<ul class="nav side-menu">
								<li><a href="index.html"><i class="fa fa-home"></i>Inicio</a></li>
							</ul>
						</div>

						<div class="menu_section">
							<h3>Gesti�n</h3>
							<ul class="nav side-menu">
								<li><a><i class="fa fa-shield"></i> Seguridad <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_usuario.jsp">Usuarios</a></li>
										<li><a href="tbl_rol.jsp">Roles</a></li>
										<li><a href="tbl_opciones.jsp">Opciones</a></li>
										<li><a href="tbl_usuarioRol.jsp">Roles de Usuario</a></li>
										<li><a href="tbl_rolOpciones.jsp">Opciones de Rol</a></li>
									</ul></li>

								<li><a><i class="fa fa-building"></i> Empresa<span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_empresa.jsp">Empresas</a></li>
										<li><a href="tbl_departamento.jsp">Departamento</a></li>
										<li><a href="tbl_municipio.jsp">Municipio</a></li>
										<li><a href="tbl_representanteLegal.jsp">Representante
												Legal</a></li>
									</ul></li>

								<li><a><i class="fa fa-file"></i> Cuenta Contable<span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_catalogocuenta.jsp">Catalogo Cuenta</a></li>
										<li><a href="tbl_tipocuenta.jsp">Tipo Cuenta</a></li>
										<li><a href="tbl_cuentacontable.jsp">Cuenta Contable</a></li>
									</ul></li>

								<li><a><i class="fa fa-dollar"></i> Moneda<span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_moneda.jsp">Moneda</a></li>
										<li><a href="tbl_tasaCambio.jsp">Tasa Cambio</a></li>
									</ul></li>

								<li><a><i class="fa fa-book"></i> Asiento Contable<span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_asientoContable.jsp">Asiento
												Contable</a></li>
										<li><a href="tbl_periodoContable.jsp">Periodo
												Contable</a></li>
										<li><a href="tbl_periodoFiscal.jsp">Periodo Fiscal</a></li>
										<li><a href="tbl_tipoDocumento.jsp">Tipo Documento</a></li>
									</ul></li>
							</ul>
						</div>
					</div>
					<!-- /sidebar menu -->
				</div>
			</div>

			<!-- top navigation -->
			<div class="top_nav">
				<div class="nav_menu">
					<div class="nav toggle">
						<a id="menu_toggle"><i class="fa fa-bars"></i></a>
					</div>
					<nav class="nav navbar-nav">
						<ul class=" navbar-right">
							<li class="nav-item dropdown open" style="padding-left: 15px;">
								<a href="javascript:;" class="user-profile dropdown-toggle"
								aria-haspopup="true" id="navbarDropdown" data-toggle="dropdown"
								aria-expanded="false"> <img src="img.jpg" alt="">Lic.
									Jos� Ortega.
							</a>
								<div class="dropdown-menu dropdown-usermenu pull-right"
									aria-labelledby="navbarDropdown">
									<a class="dropdown-item" href=/*"../login.jsp"*/><i class="fa fa-sign-out pull-right"></i> Cerrar sesion</a>
								</div>
							</li>
						</ul>
					</nav>
				</div>
			</div>
			<!-- /top navigation -->
			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>Agregar empresa</h3>
						</div>

						<div class="title_right">
							<div class="col-md-5 col-sm-5 form-group pull-right top_search">
								<div class="input-group">
									<input type="text" class="form-control"
										placeholder="Search for..."> <span
										class="input-group-btn">
										<button class="btn btn-default" type="button">Go!</button>
									</span>
								</div>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>

					<div class="column">
						<div class="row">
							<div class="col-md-12 col-sm-12">
								<div class="x_panel">
									<div class="x_title">
										<h2>
											Formulario <small>Agregar Representante Legal.
												Primero agregue un representante legal para poder agregar la
												empresa</small>
										</h2>

										<div class="clearfix"></div>
									</div>
									<div class="x_content">
										<div class="x_content">
											<form class="" action="../Sl_representanteLegal"
												method="post" novalidate>
												<input type="hidden" value="1" name="opcion" id="opcion" />
												<span class="section">Datos de Representante Legal</span>

												<div class="field item form-group">
													<label
														class="col-form-label col-md-3 col-sm-3  label-align">Nombre
														<span class="required">*</span>
													</label>
													<div class="col-md-6 col-sm-6">
														<input class="form-control" class='optional' name="nombre"
															data-validate-length-range="5,15" type="text"
															required="required" />
													</div>
												</div>
												<div class="field item form-group">
													<label
														class="col-form-label col-md-3 col-sm-3  label-align">Apellido
														<span class="required">*</span>
													</label>
													<div class="col-md-6 col-sm-6">
														<input class="form-control" class='optional'
															name="apellido" data-validate-length-range="5,15"
															type="text" required="required" />
													</div>
												</div>
												
									
												
												
												<div class="field item form-group">
													<label
														class="col-form-label col-md-3 col-sm-3  label-align">Tipo de identificacion
														<span class="required">*</span>
													</label>
													<div class="col-md-6 col-sm-6">
													
													<%
													ArrayList<Tbl_tipoIdentificacion> listaTI = new ArrayList<Tbl_tipoIdentificacion>();
													Dt_tipoIdentificacion dtTI = new Dt_tipoIdentificacion();
													listaTI = dtTI.listarTipoIdentificacion();
													%>
													<select class="form-control js-example-basic-single"
														name="idTipoIdentifiacion" id="idTipoIdentifiacion" required="required">
														<option value="0">Seleccione...</option>
														<%
														for (Tbl_tipoIdentificacion identificacion : listaTI) {
														%>
														<option value="<%=identificacion.getIdTipoIdentifiacion()%>">
															<%=identificacion.getTipo()%>
														</option>
														<%
														}
														%>

													</select>
													</div>
												</div>
												
												
												
												<div class="field item form-group">
													<label
														class="col-form-label col-md-3 col-sm-3  label-align">Correo<span
														class="required">*</span></label>
													<div class="col-md-6 col-sm-6">
														<input id="correo" class="form-control" name="correo"
															class='email' required="required" type="email" />
													</div>
												</div>
												
												<div class="field item form-group">
													<label
														class="col-form-label col-md-3 col-sm-3  label-align">Tel�fono<span
														class="required">*</span></label>
													<div class="col-md-6 col-sm-6">
														<input class="form-control" type="tel" class='tel'
															name="telefono" required='required'
															data-validate-length-range="8,8" />
													</div>
												</div>
										</div>
										<div class="ln_solid">
											<div class="form-group">
												<div class="col-md-6 offset-md-3">
													<button id="agregarRL" type='submit'
														class="btn btn-primary">Agregar</button>
													<button id="reiniciarRL" type='reset'
													onClick=(location.reload()) class="btn btn-success">Reiniciar</button>
													<button id="cancelarRL" type="button"
														class="btn btn-primary">Cancelar</button>
												</div>
											</div>
										</div>
										</form>
									</div>
								</div>
							</div>

							<div class="col-md-12 col-sm-12">
								<div class="x_panel">
									<div class="x_title">
										<h2>
											Formulario <small>Agregar empresa</small>
										</h2>

										<div class="clearfix"></div>
									</div>
									<div class="x_content">
										<form class="" action="../Sl_empresa" method="post" novalidate>
											<input type="hidden" value="1" name="opcion" id="opcion" />

											<span class="section">Datos de empresa</span>
											<div class="field item form-group">
												<label class="col-form-label col-md-3 col-sm-3  label-align">RUC<span
													class="required">*</span></label>
												<div class="col-md-6 col-sm-6">
													<input required name="ruc" class="form-control"
														placeholder="ex. 2347827431" required="required" />
												</div>
											</div>
											<div class="field item form-group">
												<label class="col-form-label col-md-3 col-sm-3  label-align">Raz�n
													social<span class="required">*</span>
												</label>
												<div class="col-md-6 col-sm-6">
													<input name="razonSocial" class="form-control"
														class='optional' type="text" required="required" />
												</div>
											</div>
											<div class="field item form-group">
												<label class="col-form-label col-md-3 col-sm-3  label-align">Nombre
													comercial<span class="required">*</span>
												</label>
												<div class="col-md-6 col-sm-6">
													<input name="nombreComercial" class="form-control"
														class='optional' name="occupation" type="text"
														required="required" />
												</div>
											</div>
											<div class="field item form-group">
												<label class="col-form-label col-md-3 col-sm-3  label-align">Correo<span
													class="required">*</span></label>
												<div class="col-md-6 col-sm-6">
													<input name="correo" class="form-control" class='email'
														required="required" type="email" />
												</div>
											</div>

											<div class="field item form-group">
												<label class="col-form-label col-md-3 col-sm-3  label-align">Tel�fono<span
													class="required">*</span></label>
												<div class="col-md-6 col-sm-6">
													<input name="telefono" class="form-control" type="tel"
														class='tel' required='required' data-validate-length-range="8,8" />
												</div>
											</div>
											<div class="field item form-group">
												<label class="col-form-label col-md-3 col-sm-3  label-align">Direcci�n<span
													class="required">*</span>
												</label>
												<div class="col-md-6 col-sm-6">
													<input name="direccion" class="form-control"
														class='optional' name="occupation"
														data-validate-length-range="5,100" type="text"
														required="required" />
												</div>
											</div>
											


											<div class="field item form-group">
												<label class="col-form-label col-md-3 col-sm-3  label-align">Representante legal<span
													class="required">*</span>
												</label>
												<div class="col-md-6 col-sm-6">
													<input readonly  name="valueIdR" class="form-control"
														class='optional' id="valueIdR" />
												</div>
											</div>


											<div class="field item form-group">
												<label class="col-form-label col-md-3 col-sm-3  label-align">Periodo
													fiscal: <span class="required">*</span>
												</label>
												<div class="col-md-6 col-sm-6">
													<!--                                                 
												<input class="form-control" class='optional' name="occupation" data-validate-length-range="5,15" type="text" /></div> -->
													<%
													ArrayList<Tbl_periodoFiscal> listaPeriodo = new ArrayList<Tbl_periodoFiscal>();
													Dt_periodoFiscal dtPeriodo = new Dt_periodoFiscal();
													listaPeriodo = dtPeriodo.listarperiodoFiscal();
													%>

													<select class="form-control js-example-basic-single"
														name="periodoFiscal" id="periodoFiscal" required="required">
														<option value="0">Seleccione...</option>
														<%
														for (Tbl_periodoFiscal periodo : listaPeriodo) {
														%>
														<option value="<%=periodo.getIdPeriodoFiscal()%>">
															<%=periodo.getFechaInicio()%> ->
															<%=periodo.getFechaFinal()%>
														</option>
														<%
														}
														%>

													</select>
												</div>
											</div>



											<div class="field item form-group">
												<label class="col-form-label col-md-3 col-sm-3  label-align">Departamento:
													<span class="required">*</span>
												</label>
												<div class="col-md-6 col-sm-6">
													<!--                                                 <input class="form-control" class='optional' name="occupation" data-validate-length-range="5,15" type="text" /></div> -->
													<%
													ArrayList<Tbl_departamento> listaDep = new ArrayList<Tbl_departamento>();
													Dt_departamento dtDep = new Dt_departamento();
													listaDep = dtDep.listarDepartamento();
													%>
													<select class="form-control js-example-basic-single"
														name="departamento" id="departamento" required="required">
														<option value="0">Seleccione...</option>
														<%
														for (Tbl_departamento depa : listaDep) {
														%>
														<option value="<%=depa.getIdDepartamento()%>">
															<%=depa.getDepartamento()%>
														</option>
														<%
														}
														%>

													</select>
												</div>
											</div>

											<div class="field item form-group">
												<label class="col-form-label col-md-3 col-sm-3  label-align">Municipio:
													<span class="required">*</span>
												</label>
												<div class="col-md-6 col-sm-6">
													<!--                                                 <input class="form-control" class='optional' name="occupation" data-validate-length-range="5,15" type="text" /></div> -->
													<%
													ArrayList<Vw_municipio> listaMuni = new ArrayList<Vw_municipio>();
													Dt_municipio dtMunicipio = new Dt_municipio();
													listaMuni = dtMunicipio.listarMunicipio();
													%>
													<select class="form-control js-example-basic-single"
														name="municipio" id="municipio" required="required">
														<option value="0">Seleccione...</option>
														<%
														for (Vw_municipio muni : listaMuni) {
														%>
														<option value="<%=muni.getIdMunicipio()%>">
															<%=muni.getMunicipio()%>
														</option>
														<%
														}
														%>

													</select>
												</div>
											</div>
											<div class="ln_solid">
												<div class="form-group">
													<div class="col-md-6 offset-md-3">
														<button id="agregarE" type='submit'
															class="btn btn-primary">Agregar</button>
														<button id="reiniciarE" type='reset'
														onClick=(location.reload())	class="btn btn-success">Reiniciar</button>
														<button id="cancelarE" type="button"
															class="btn btn-primary">Cancelar</button>
													</div>
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /page content -->

				<!-- footer content -->
				<footer>
					<div class="pull-right">Sistema contable by Eldian's Software</div>
					<div class="clearfix"></div>
				</footer>
				<!-- /footer content -->
			</div>
		</div>


		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
		<script src="../vendors/validator/multifield.js"></script>
		<script src="../vendors/validator/validator.js"></script>

		<!-- Javascript functions	-->
		<script>
			function hideshow() {
				var password = document.getElementById("password1");
				var slash = document.getElementById("slash");
				var eye = document.getElementById("eye");

				if (password.type === 'password') {
					password.type = "text";
					slash.style.display = "block";
					eye.style.display = "none";
				} else {
					password.type = "password";
					slash.style.display = "none";
					eye.style.display = "block";
				}

			}
		</script>

		<script>
			// initialize a validator instance from the "FormValidator" constructor.
			// A "<form>" element is optionally passed as an argument, but is not a must
			var validator = new FormValidator({
				"events" : [ 'blur', 'input', 'change' ]
			}, document.forms[0]);
			// on form "submit" event
			document.forms[0].onsubmit = function(e) {
				var submit = true, validatorResult = validator.checkAll(this);
				console.log(validatorResult);
				return !!validatorResult.valid;
			};
			// on form "reset" event
			document.forms[0].onreset = function(e) {
				validator.reset();
			};
			// stuff related ONLY for this demo page:
			$('.toggleValidationTooltips').change(function() {
				validator.settings.alerts = !this.checked;
				if (this.checked)
					$('form .alert').remove();
			}).prop('checked', false);
		</script>


		<script>
			function getURL() {
				const url = window.location.href;
				const idR = url.substring(url.indexOf('=') + 1);
				if (url == "http://localhost:8080/SistemaContable/production/addEmpresa.jsp?msj="
						+ idR) {
					console.log("Test");
					document.getElementById("agregarRL").disabled = true;
					document.getElementById("cancelarRL").disabled = true;
					document.getElementById("reiniciarRL").disabled = true;

					document.getElementById("agregarE").disabled = false;
					document.getElementById("cancelarE").disabled = false;
					document.getElementById("reiniciarE").disabled = false;
				} else if (url == "http://localhost:8080/SistemaContable/production/addEmpresa.jsp") {
					console.log("Test");
					document.getElementById("agregarRL").disabled = false;
					document.getElementById("cancelarRL").disabled = false;
					document.getElementById("reiniciarRL").disabled = false;

					document.getElementById("agregarE").disabled = true;
					document.getElementById("cancelarE").disabled = true;
					document.getElementById("reiniciarE").disabled = true;
				}
			}

			window.onload = getURL();
		</script>
		<script>
			function returnIdR() {
				const url = window.location.href;
				const idR = url.substring(url.indexOf('=') + 1);

				if (url == "http://localhost:8080/SistemaContable/production/addEmpresa.jsp") {
					document.getElementById('valueIdR').value = "Se ingresara automaticamente cuando guarde el representante legal";

				} else {
					
					document.getElementById('valueIdR').value = idR;

				}

				console.log(document.getElementById('valueIdR').value);
			}

			window.onload = returnIdR();
		</script>


		<!-- jQuery -->
		<script src="../vendors/jquery/dist/jquery.min.js"></script>
		<!-- Bootstrap -->
		<script src="../vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
		<!-- FastClick -->
		<script src="../vendors/fastclick/lib/fastclick.js"></script>
		<!-- NProgress -->
		<script src="../vendors/nprogress/nprogress.js"></script>
		<!-- validator -->
		<!-- <script src="../vendors/validator/validator.js"></script> -->

		<!-- Custom Theme Scripts -->
		<script src="../build/js/custom.min.js"></script>
		</div>
</body>

</html>
