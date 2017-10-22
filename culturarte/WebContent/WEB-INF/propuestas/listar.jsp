<%-- 
    Document   : listar
    Author     : Igui
--%>
<%@page import="Logica.clases.Propuesta"%>
<%@page import="javax.swing.tree.TreeNode"%>
<%@page import="dataTypes.DtPropuesta"%>
<%@page import="dataTypes.DtUsuario"%>
<%@page import="dataTypes.DtCategoria"%>
<%@page import="java.util.List"%>
<%@page import="javax.swing.tree.TreeNode"%>
<%@page import="Logica.clases.Categoria"%>
<%@page import="com.culturarte.controllers.Propuestas"%>
<%@page import="dataTypes.TEstado"%>
<%@page import="Logica.Fabrica"%>
<%@page import="javax.swing.tree.DefaultMutableTreeNode"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.culturarte.controllers.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="/WEB-INF/errorPages/500.jsp"%>

<!doctype html>
<html>
<head>
<link href="/media/styles/shop-homepage.css" rel="stylesheet">

<jsp:include page="/WEB-INF/template/head.jsp" />
<title>Propuestas :: Culturarte</title>
</head>
<body id="listaimage">
	<jsp:include page="/WEB-INF/template/header.jsp" />

	<!-- Contenido -->
	<% String actual = request.getParameter("filtro");
	String todos = "Todos";%>
	
	
	
	
	<div class="container text-color">

		<div class="row ">

			<div class="col-lg-3 ">
				<div class="list-group">
					<div class="main">
					<h5> Categoria: </h5>
					<div class="btn-group">
						<% if (request.getParameter("filtro") == null || request.getParameter("filtro") == ""){ %>
							
						 	<button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown"><%= todos.toString() %> <span class="caret"></span></button>
    					 <%}else{ %>
    					 	<button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown"><%= request.getParameter("filtro")%> <span class="caret"></span></button>
    					 <%} %>	
       					 <ul class="dropdown-menu scrollable-menu" role="menu">
      						<%
							DefaultMutableTreeNode raiz = Fabrica.getInstance().getICtrlPropuesta().listarCategorias();
      						Propuestas.vaciarCategoriasList();
							Propuestas.recursivoTree(raiz);%>
							<li><a href="propuestas?filtro=<%=""%>"><%=todos.toString() %></a></li>
							<%for (TreeNode s :Propuestas.getCategoriasList()) {%>
							
      						<li><a href="propuestas?filtro=<%=s.toString() %>"><%=s.toString() %></a></li>
							<%  } %>
						</ul>

					</div>
					</div>
				</div>

			</div>
			
			<!-- /.col-lg-3 -->

			<div class="col-lg-9 main" id="proponentes">

				<div class="row">
					<% 
				String espacio = " ";
				String precio = "$ ";
				ArrayList<DtPropuesta> propuestas = (ArrayList<DtPropuesta>)request.getAttribute("propuestas");

				for(DtPropuesta propuesta: propuestas){
			%>
					<div class="col-lg-4 col-md-6 mb-4">
						<div class="card h-100">
							<% if (propuesta.getRutaImg() == ""){ %>
							<img class="card-img-top" src="\media\images\no-image.png" />
							<%}else { %>
							<img class="card-img-top"
								src="/media/images/imagenes/propuestas/<%=propuesta.getRutaImg() %>.jpg" />
							<%}%>

							<div class="card-body">
								<h4 class="card-title">
									<a class="titulo"
										href="consultaPropuesta?propuesta=<%= propuesta.getTitulo()  %>">
										<h3><%= propuesta.getTitulo() %></h3>
									</a>
								</h4>
								<h5 Style="border-bottom: 1px solid #DDDDDD;">
									Precio Entrada:
									<%= precio %>
									<%= propuesta.getPrecioEntrada() %>
								</h5>
								<h5 Style="border-bottom: 1px solid #DDDDDD;">
									Proponente:
									<%=Fabrica.getInstance().getICtrlUsuario().infoProponente(propuesta.getNickProponente()).getNombre()%>
									<%=espacio%>
									<%=Fabrica.getInstance().getICtrlUsuario().infoProponente(propuesta.getNickProponente()).getApellido()%></h5>
								<p class="card-text" Style="border-bottom: 1px solid #DDDDDD;">
									Categoria:
									<%= propuesta.getCategoria().getNombre() %>
								</p>
								<p class="card-text" Style="border-bottom: 1px solid #DDDDDD;">
									Estado:
									<%= propuesta.getEstado().toString() %>

								</p>
							</div>
							<div class="card-footer">
								<% DtUsuario user = (DtUsuario) (Login.getUsuarioLogueado(request));
						if (user!=null && !Fabrica.getInstance().getICtrlUsuario().esProponente(user.getNickName())){
					%>
								<small class="registrarcolaboracion"> <a
									href="nuevaColaboracion?propuesta=<%= propuesta.getTitulo() %>">Registrar
										Colaboracion</a>
								</small>
								<% 	}%>
							</div>
						</div>

					</div>

					<% } %>
				</div>

				<!-- /.row -->

			</div>
			<!-- /.col-lg-9 -->

		</div>
		<!-- /.row -->

	</div>

	<!-- Contenido -->
	<!-- SCRIPT -->

<style>
.scrollable-menu {
    height: auto;
    max-height: 300px;
    overflow-x: hidden;
}
</style>
	<div class="footer">
		<jsp:include page="/WEB-INF/template/footer.jsp" />
	</div>
</body>
</html>