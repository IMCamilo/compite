<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="mainadministrador" />
    <g:set var="entityName" value="${message(code: 'region.label', default: 'Region')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <div id="create-region" class="content scaffold-create" role="main">
        <div class="panel-group" id="accordion">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">Crear Región</a>
                    </h4>
                </div>
                <div id="collapse1" class="panel-collapse collapse on">
                    <div class="panel-body">
                        <g:hasErrors bean="${this.region}">
                            <ul class="errors" role="alert">
                                <g:eachError bean="${this.region}" var="error"><li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                                </g:eachError>
                            </ul>
                        </g:hasErrors>
                        <g:form action="save">
                            <fieldset class="form">
                                <input type="hidden" name="creadoPor" value="${session.usuarioLogueado.rut}" id="creadoPor"/>
                                <div class="col-md-12">
                                    <div class="col-sm-6">
                                        <div class="fieldcontain required">
                                            <label for="codigo">Codigo
                                                <span class="required-indicator">*</span>
                                            </label>
                                            <input id="codigo" value="" name="codigo" type="number" max="10" min="1" required="" placeholder="Ingrese un codigo">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="fieldcontain required" id="proyectoinputdiv">
                                            <label for="nombre">Nombre
                                                <span class="required-indicator">*</span>
                                            </label>
                                            <input type="text" name="nombre" required="" id="nombre"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <br>
                                </div>
                                <div class="col-md-12">
                                    <div class="col-sm-1">
                                    </div>
                                    <div class="col-sm-6">
                                        <g:submitButton name="create" class="save btn btn-success" onClick="comprobarClave()" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                                    </div>
                                </div>
                            </fieldset>
                        </g:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="list-region" class="content scaffold-list" role="main">
        <h1><g:message code="default.list.label" args="[entityName]" /></h1>
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <table>
            <thead>
            <tr>
                <th>Acciones</th>
                <g:sortableColumn property="id" defaultOrder="desc" title="Código"/>
                <g:sortableColumn property="nombre" defaultOrder="desc" title="Nombre"/>
            </tr>
            </thead>
            <tbody>
            <g:each var="reg" status="i" in="${regionList}">
                <tr class="${((i % 2 == 0) ? 'odd' : 'even')}">
                    <td><a href="edit/${reg.id}">Editar</a></td>
                    <td>${reg.codigo}</td>
                    <td>${reg.nombre}</td>
                </tr>
            </g:each>
            </tbody>
        </table>
        <div class="pagination">
            <g:paginate total="${itemCount ?: 0}" />
        </div>
    </div>
</body>
</html>
