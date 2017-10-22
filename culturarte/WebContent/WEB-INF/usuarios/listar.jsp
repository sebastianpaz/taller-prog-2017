<%-- 
    Document   : listar
    Author     : Igui
--%>
<%@page import="dataTypes.DtUsuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Logica.Fabrica"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="/WEB-INF/errorPages/500.jsp"%>
<!doctype html>
<html>
<head>
<jsp:include page="/WEB-INF/template/head.jsp" />
<title>Usuarios | Culturarte</title>
</head>
<body id="listaimage">
	<jsp:include page="/WEB-INF/template/header.jsp" />

	<div id="listar" class="main">
		<% 	boolean bandera = false;
				ArrayList<DtUsuario> usuarios = (ArrayList<DtUsuario>)request.getAttribute("usuarios");

				for(DtUsuario usuario: usuarios){
			%>
		<div class="usuario">
			<% if (usuario.getRutaImg() == ""){ %>
				<img src="\media\images\defecto.png" />
			<%}else if (Fabrica.getInstance().getICtrlUsuario().esProponente(usuario.getNickName())){ %>
						<img src="/media/images/imagenes/usuarios/proponentes/<%=usuario.getRutaImg() %>.jpg" />
					<%}else { %>
						<img src="/media/images/imagenes/usuarios/colaboradores/<%=usuario.getRutaImg() %>.jpg" />
					<% } %>	
			<div class="derecha">
				<p>

					<a class="nombre"
						href="consultaUsuario?usuario=<%= usuario.getNickName()  %>">
						<%= usuario.getNombre() + " " + usuario.getApellido() %>
					</a> <a class="nombre"
						href="consultaUsuario?usuario=<%= usuario.getNickName()  %>">
						(<%=usuario.getNickName() %>)
					</a> <br> <span class="email text-color"> <%=usuario.getEmail() %>
					</span> <br>
					<% if (Fabrica.getInstance().getICtrlUsuario().esProponente(usuario.getNickName())) {
						bandera = true;
						%>
					<span class="email text-color">Nivel: Proponente </span>
					<% } else { %>
					<%	bandera = false; %>
					<span class="email text-color">Nivel: Colaborador </span>
					<% } %>
				</p>
			</div>
		</div>
		<% } %>
	</div>

	<div class="footer">
		<jsp:include page="/WEB-INF/template/footer.jsp" />
	</div>
</body>
</html>