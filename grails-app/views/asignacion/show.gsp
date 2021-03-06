<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainadministrador" />
        <g:set var="entityName" value="${message(code: 'asignacion.label', default: 'Asignacion')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="show-asignacion" class="content scaffold-show" role="main">
            <h1>Datos de la Asignación</h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:each in="${asignacion}">
                <div class="col-md-12">
                    <div class="col-sm-6">
                        <label>Fecha Creación :</label>
                        <label style="color: dimgray">${formatDate(format:"dd/MM/yyyy", date: it.fechaCreacion)}</label>
                    </div>
                    <div class="col-sm-6">
                        <label>Detalle :</label>
                        <label style="color: dimgray">${it.detalle}</label>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-sm-6">
                        <label>Usuario :</label>
                        <label style="color: dimgray">${nombreUsuario}</label>
                    </div>
                    <div class="col-sm-6">
                        <label>Programa :</label>
                        <label style="color: dimgray">${datosPrograma}</label>
                    </div>
                </div>
            </g:each>
            <g:form resource="${this.asignacion}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="list" action="index">Volver al Listado</g:link>
                    <g:link class="edit" action="edit" resource="${this.asignacion}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
