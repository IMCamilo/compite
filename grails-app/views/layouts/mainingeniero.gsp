<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:stylesheet src="application.css"/>
    <g:layoutHead/>
</head>
<body>
    <div class="navbar navbar-default navbar-static-top" role="navigation">
        <div class="container" style="float: right; margin-right: 0%">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <div class="navbar-collapse collapse" aria-expanded="false" style="height: 0.8px;">
                <ul class="nav navbar-nav navbar-left">
                    <li>
                        <a href="${createLink(controller:'ingeniero', action:'index')}">
                            <i class="fa grails-icon">
                                <asset:image src="grails-cupsonly-logo-white.svg"/>
                            </i> COMPITE
                        </a>
                    </li>
                </ul>

                <ul class="nav navbar-nav navbar-right">
                    <li><a class="navbar-brand" href="${createLink(controller:'ingeniero')}">Proyectos</a></li>
                    <li><a class="navbar-brand" href="${createLink(controller:'egresoIng', action: "auditorias")}">Auditorias</a></li>
                    <li><a class="navbar-brand" href="${createLink(controller:'egresoIng')}">Egresos</a></li>
                    <li><a class="navbar-brand" href="${createLink(controller:'movilizacion', action: 'nuevamovilizacion')}">Movilización</a></li>
                    <li role="presentation" class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                            Utilidades <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="navbar-brand" target="_blank" href="${createLink(controller:'manualIngeniero', action:'index')}">Manual del Usuario</a></li>
                        </ul>
                    </li>
                    <li role="presentation" class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                            ${session.usuarioLogueado.nombres} ${session.usuarioLogueado.paterno} <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="navbar-brand" href="${createLink(controller:'ingeniero', action:'cargarperfil',)}">Perfil</a></li>
                            <li>
                                <a class="navbar-brand" href="${createLink(controller:'login', action:'logout')}">
                                    Cerrar sesión
                                </a>
                            </li>
                        </ul>
                    </li>
                    <g:pageProperty name="page.nav" />
                </ul>
            </div>
        </div>
    </div>
    <g:layoutBody/>

    <div id="spinner" class="spinner" style="display:none;">
        <g:message code="spinner.alt" default="Loading&hellip;"/>
    </div>
    <asset:javascript src="application.js"/>
</body>
</html>
