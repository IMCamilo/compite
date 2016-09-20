<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainadministrador" />
        <g:set var="entityName" value="${message(code: 'empresa.label', default: 'Empresa')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-empresa" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
            </ul>
        </div>
        <div id="create-empresa" class="content scaffold-create" role="main">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.empresa}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.empresa}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form action="save">
                <fieldset class="form">
                    <div class="fieldcontain required">
                    <label for="tipo">Rut
                        <span class="required-indicator">*</span>
                    </label>
                        <input type="text" id="rut" name="rut" required oninput="checkRut(this)" placeholder="Ingrese RUT"></div>
                    <div class="fieldcontain required">
                    <label for="descripcion">Tipo
                        <span class="required-indicator">*</span>
                    </label>
                    <input name="tipo" value="" required="" placeholder="Nombre tipo empresa Ej: Software" maxlength="15" id="nombres" type="text"></div>
                    <div class="fieldcontain required">
                    <label for="valor">Nombre
                        <span class="required-indicator">*</span>
                    </label>
                    <input name="nombre" value="" required="" placeholder="Nombre ficticio empresa" maxlength="10" id="paterno" type="text"></div>
                    <div class="fieldcontain required">
                    <label for="valor">Razón Social
                        <span class="required-indicator">*</span>
                    </label>
                    <input name="razonSocial" value="" required="" placeholder="Razon Social" maxlength="10" id="paterno" type="text"></div>
                    <div class="fieldcontain required">
                    <label for="nombre">Giro
                        <span class="required-indicator">*</span>
                    </label>
                    <input name="giro" value="" required="" placeholder="Giro de la empresa Ej: Consultores de Software" maxlength="10" id="materno" type="text"></div>
                    <div class="fieldcontain required">
                    <label for="nombre">Gerente
                        <span class="required-indicator">*</span>
                    </label>
                    <input name="gerente" value="" required="" placeholder="Nombre del representante legal" maxlength="10" id="materno" type="text"></div>
                    <div class="fieldcontain required">
                    <label for="nombre">Dirección
                        <span class="required-indicator">*</span>
                    </label>
                    <input name="direccion" value="" required="" placeholder="Region/Comuna/Area/Calle/Numero" maxlength="10" id="materno" type="text"></div>
                    <div class="fieldcontain required">
                    <label for="nombre">Correo
                        <span class="required-indicator">*</span>
                    </label>
                    <input name="correo" value="" required="" placeholder="Ej: correo@dominio.cl" maxlength="10" id="materno" type="email"></div>

                    <div class="fieldcontain required">
                    <label for="nombre">Telefono
                        <span class="required-indicator">*</span>
                    </label>
                    <input name="telefono" value="" required="" placeholder="(Cod. Area)+numero Ej: 56 2 123456" maxlength="10" id="materno" type="text" onkeypress="return isNumber(event)"></div>
                    <input name="creadoPor" value="${session.usuarioLogueado.rut}" required="" type="hidden">
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                </fieldset>
            </g:form>
        </div>
        <div id="list-empresa" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table>
                <thead>
                    <tr>
                        <th>ver</th>
                        <g:sortableColumn property="rut" defaultOrder="desc" title="Rut"/>
                        <g:sortableColumn property="nombre" defaultOrder="desc" title="Nombre"/>
                        <g:sortableColumn property="razonSocial" defaultOrder="desc" title="Razon Social"/>
                        <g:sortableColumn property="giro" defaultOrder="desc" title="Giro"/>
                        <g:sortableColumn property="direccion" defaultOrder="desc" title="Direccion"/>
                    </tr>
                </thead>
                <tbody>
                    <g:each var="empresa" status="i" in="${empresaList}">
                         <tr class="${((i % 2 == 0) ? 'odd' : 'even')}">
                            <td><a href="show/${empresa.id}">ver</a></td>
                            <td>${empresa.rut}</td>
                            <td>${empresa.nombre}</td>
                            <td>${empresa.razonSocial}</td>
                            <td>${empresa.giro}</td>
                            <td>${empresa.direccion}</td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination">
                <g:paginate total="${empresaCount ?: 0}" />
            </div>
        </div>
    <asset:javascript src="compite/validarut.js"/>

    </body>
</html>
