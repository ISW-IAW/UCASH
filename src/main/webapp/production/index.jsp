<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="entidades.Vw_usuariorol, entidades.Vw_rolopciones, 
    datos.Dt_usuario,datos.Dt_rolOpciones,
    java.util.ArrayList;"
%>

  
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
<html>
<head>

<meta charset="ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
	
<title>Sistema Contable | Inicio </title>


    <!-- Bootstrap -->
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
	
    <!-- bootstrap-progressbar -->
    <link href="../vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
    <!-- JQVMap -->
    <link href="../vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet"/>
    <!-- bootstrap-daterangepicker -->
    <link href="../vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">

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
							<img src="img.jpg" alt="..."
								class="img-circle profile_img">
						</div>
						<div class="profile_info">
							<span>Bienvenido,</span>
							<h2><%=vwur.getNombre()+" "+vwur.getApellido() %></h2>
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
								<li><a><i class="fa fa-shield"></i> Seguridad <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_usuario.jsp">Usuarios</a></li>
										<li><a href="tbl_rol.jsp">Roles</a></li>
										<li><a href="tbl_opciones.jsp">Opciones</a></li>
										<li><a href="tbl_usuarioRol.jsp">Roles de Usuario</a></li>
										<li><a href="tbl_rolOpciones.jsp">Opciones de Rol</a></li>
									</ul></li>
									
									<li><a><i class="fa fa-building"></i> Empresa<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_empresa.jsp">Empresas</a></li>
										<li><a href="tbl_departamento.jsp">Departamento</a></li>
										<li><a href="tbl_municipio.jsp">Municipio</a></li>
										<li><a href="tbl_representanteLegal.jsp">Representante Legal</a></li>
									</ul></li>
									
									<li><a><i class="fa fa-file"></i> Cuenta Contable<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_catalogocuenta.jsp">Catalogo Cuenta</a></li>
										<li><a href="tbl_tipocuenta.jsp">Tipo Cuenta</a></li>
										<li><a href="tbl_cuentacontable.jsp">Cuenta Contable</a></li>
									</ul></li>
									
									<li><a><i class="fa fa-dollar"></i> Moneda<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_moneda.jsp">Moneda</a></li>
										<li><a href="tbl_tasaCambio.jsp">Tasa Cambio</a></li>
									</ul></li>

								<li><a><i class="fa fa-book"></i> Asiento Contable<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_asientoContable.jsp">Asiento Contable</a></li>
										<li><a href="tbl_periodoContable.jsp">Periodo Contable</a></li>
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
								aria-expanded="false"> <img src="img.jpg" alt=""><%=vwur.getNombre()+" "+vwur.getApellido() %>.
							</a>
								<div class="dropdown-menu dropdown-usermenu pull-right"	aria-labelledby="navbarDropdown">
									<a class="dropdown-item" href="../login.jsp"><i class="fa fa-sign-out pull-right"></i> Sesi�n</a>
								</div>
							</li>
						</ul>
					</nav>
				</div>
			</div>
			<!-- /top navigation -->

        <!-- page content -->
        <div class="right_col" role="main">
          <div class="row">
			<div class="col-md-12 col-sm-12">
				<div class="x_panel">
					
					<div class="x_title">
						<a><i class="fa fa-building" style="font-size:30px">Empresa</i></a>
						<div class="clearfix"></div>
					</div>
					
					<div class="x_content">
						<div class="field item form-group colspan-3">
							<a href="tbl_empresa.jsp" style="font-size:20px; padding-left:15px;"><i class="fa fa-lg fa-table" style="padding-right:10px;"></i>Empresa</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_departamento.jsp" style="font-size:20px; padding-left:15px;"><i class="fa fa-lg fa-location-arrow" style="padding-right:10px;"></i>Departamento</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_municipio.jsp" style="font-size:20px; padding-left:15px;"><i class="fa fa-lg fa-location-arrow" style="padding-right:10px;"></i>Municipio</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_representanteLegal.jsp" style="font-size:20px; padding-left:15px;"><i class="fa fa-lg fa-user" style="padding-right:10px;"></i>Representante Legal</a>
						</div>
					</div>
					
				</div>
				
				<div class="x_panel">
					
					<div class="x_title">
						<a><i class="fa fa-bitcoin" style="font-size:30px">Moneda</i></a>
						<div class="clearfix"></div>
					</div>
					
					<div class="x_content">
						<div class="field item form-group colspan-3">				
							<a href="tbl_moneda.jsp" style="font-size:20px; padding-left:15px;"><i class="fa fa-lg fa-dollar" style="padding-right:10px;"></i>Moneda</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_tasaCambio.jsp" style="font-size:20px; padding-left:15px;"><i class="fa fa-lg fa-percent" style="padding-right:10px;"></i>Tasa Cambio</a>
						</div>
					</div>
					
				</div>
				
				<div class="x_panel">
					
					<div class="x_title">
						<a><i class="fa fa-balance-scale" style="font-size:30px">Asiento Contable</i></a>
						<div class="clearfix"></div>
					</div>
					
					<div class="x_content">
						<div class="field item form-group colspan-3">
							<a href="tbl_asientoContable.jsp" style="font-size:20px; padding-left:15px;"><i class="fa fa-lg fa-dollar" style="padding-right:10px;"></i>Asiento Contable</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_periodoContable.jsp" style="font-size:20px; padding-left:15px;"><i class="fa fa-lg fa-calendar" style="padding-right:10px;"></i>Periodo Contable</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_periodoFiscal.jsp" style="font-size:20px; padding-left:15px;"><i class="fa fa-lg fa-legal" style="padding-right:10px;"></i>Periodo Fiscal</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_tipoDocumento.jsp" style="font-size:20px; padding-left:15px;"><i class="fa fa-lg fa-file-text" style="padding-right:10px;"></i>Tipo Documento</a>
						</div>
					</div>
					
				</div>
				
				<div class="x_panel">
					
					<div class="x_title">
						<a><i class="fa fa-suitcase" style="font-size:30px">Cuenta Contable</i></a>
						<div class="clearfix"></div>
					</div>
					
					<div class="x_content">
						<div class="field item form-institution colspan-3">
							<a href="tbl_catalogocuenta.jsp" style="font-size:20px; padding-left:15px;"><i class="fa fa-lg fa-book" style="padding-right:10px;"></i>Catalogo Cuenta</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_tipocuenta.jsp" style="font-size:20px; padding-left:15px;"><i class="fa fa-lg fa-tasks" style="padding-right:10px;"></i>Tipo Cuenta</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_cuentacontable.jsp" style="font-size:20px; padding-left:15px;"><i class="fa fa-lg fa-archive" style="padding-right:10px;"></i>Cuenta Contable</a>
						</div>
					</div>
					
				</div>
				
				<div class="x_panel">
					
					<div class="x_title">
						<a><i class="fa fa-shield" style="font-size:30px">Seguridad</i></a>
						<div class="clearfix"></div>
					</div>
					
					<div class="x_content">
						<div class="field item form-institution colspan-3">
							<a href="tbl_usuario.jsp" style="font-size:20px; padding-left:15px;"><i class="fa fa-lg fa-user" style="padding-right:10px;"></i>Usuario</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_rol.jsp" style="font-size:20px; padding-left:15px;"><i class="fa fa-lg fa-unlock" style="padding-right:10px;"></i>Rol</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_usuarioRol.jsp" style="font-size:20px; padding-left:15px;"><i class="fa fa-lg fa-puzzle-piece" style="padding-right:10px;"></i>Usuario Rol</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_rolOpciones.jsp" style="font-size:20px; padding-left:15px;"><i class="fa fa-lg fa-cogs" style="padding-right:10px;"></i>Rol Opciones</a>
						</div>
					</div>
					
				</div>
				
			</div>
		</div>
        </div>
        <!-- /page content -->

        <!-- footer content -->
        <footer>
          <div class="pull-right">
            <a><i class="green">FROGBMJ Software </i><i>por</i> <i class="red"> Eldian's Development</i></a>
          </div>
          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
      </div>
    </div>

    <!-- jQuery -->
    <script src="../vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
   <script src="../vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <!-- FastClick -->
    <script src="../vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="../vendors/nprogress/nprogress.js"></script>
    <!-- Chart.js -->
    <script src="../vendors/Chart.js/dist/Chart.min.js"></script>
    <!-- jQuery Sparklines -->
    <script src="../vendors/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
    <!-- Flot -->
    <script src="../vendors/Flot/jquery.flot.js"></script>
    <script src="../vendors/Flot/jquery.flot.pie.js"></script>
    <script src="../vendors/Flot/jquery.flot.time.js"></script>
    <script src="../vendors/Flot/jquery.flot.stack.js"></script>
    <script src="../vendors/Flot/jquery.flot.resize.js"></script>
    <!-- Flot plugins -->
    <script src="../vendors/flot.orderbars/js/jquery.flot.orderBars.js"></script>
    <script src="../vendors/flot-spline/js/jquery.flot.spline.min.js"></script>
    <script src="../vendors/flot.curvedlines/curvedLines.js"></script>
    <!-- DateJS -->
    <script src="../vendors/DateJS/build/date.js"></script>
    <!-- bootstrap-daterangepicker -->
    <script src="../vendors/moment/min/moment.min.js"></script>
    <script src="../vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
    
    <!-- Custom Theme Scripts -->
    <script src="../build/js/custom.min.js"></script>
  </body>
</html>