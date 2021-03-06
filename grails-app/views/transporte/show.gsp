<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainadministrador" />
        <g:set var="entityName" value="${message(code: 'transporte.label', default: 'Transporte')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-transporte" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-transporte" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <g:each in="${transporte}">
                <div class="col-md-12">
                    <div class="col-sm-6">
                        <label>Tipo :</label>
                        <label style="color: dimgray">${it.tipo}</label>
                    </div>
                    <div class="col-sm-6">
                        <label>Descripción :</label>
                        <label style="color: dimgray">${it.descripcion}</label>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-sm-6">
                        <label>Marca :</label>
                        <label style="color: dimgray">${it.marca}</label>
                    </div>
                    <div class="col-sm-6">
                        <label>Kms Por Litro :</label>
                        <label style="color: dimgray">${it.kmPorLitro}</label>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-sm-6">
                        <label>Modelo :</label>
                        <label style="color: dimgray">${it.modelo}</label>
                    </div>
                    <div class="col-sm-6">
                        <label>Combustible :</label>
                        <label style="color: dimgray">${it.combustible}</label>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-sm-6">
                        <label>Usuario :</label>
                        <label style="color: dimgray">${nombreUsuario}</label>
                    </div>
                </div>
            </g:each>
            <g:form resource="${this.transporte}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.transporte}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
