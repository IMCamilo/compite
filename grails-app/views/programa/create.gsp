<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="mainadministrador" />
    <g:set var="entityName" value="${message(code: 'programa.label', default: 'Programa')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <asset:stylesheet src="compite/autocomplete.css"/>
</head>
<body>
<div id="create-programa" class="content scaffold-create" role="main">
    <h1><g:message code="default.create.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.programa}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.programa}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
                    <g:message error="${error}" />
                </li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form action="save">
        <fieldset class="form">
            <div class="col-md-12">
                <div class="col-sm-6">
                    <div class="fieldcontain required">
                        <label for="nombre">Codigo
                            <span class="required-indicator">*</span>
                        </label>
                        <input name="codigo" required="" id="codigo" type="number" min="1" max="10" placeholder="Código del Programa">
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="fieldcontain required">
                        <label for="nombre">Nombre
                            <span class="required-indicator">*</span>
                        </label>
                        <input name="nombre" required="" id="nombre" type="text" minlength="5" maxlength="50" placeholder="Nombre del Programa">
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="col-sm-6">
                    <div class="fieldcontain">
                        <label class="" for="presupuesto">Presupuesto</label>
                        <input name="presupuesto" minlength="5" maxlength="15" required="" id="presupuesto" type="text" placeholder="Valor monetario asignado al programa" onkeypress="return soloNumeros(event)">
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="fieldcontain required">
                        <label for="estado">Estado
                            <span class="required-indicator">*</span>
                        </label>
                        <select name="estado" value="" required="" id="estado">
                            <option value="" disabled selected>Seleccione Estado</option>
                            <option value="ACTIVO">Activo</option>
                            <option value="INACTIVO">Inactivo</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="col-sm-6">
                    <div class="fieldcontain required">
                        <label for="tipo">Tipo
                            <span class="required-indicator">*</span>
                        </label>
                        <select name="tipo" value="" required="" id="tipo">
                            <option value="" disabled selected>Seleccione Tipo</option>
                            <option value="PUBLICO">Publico</option>
                            <option value="PRIVADO">Privado</option>
                        </select>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="fieldcontain required">
                        <label for="fechaIncio">Centro de costo
                            <span class="required-indicator">*</span>
                        </label>
                        <input type="number"name="centroCosto" max="1000" required="">
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="col-sm-6">
                    <div class="fieldcontain required">
                        <label for="fechaIncio">Fecha Inicio
                            <span class="required-indicator">*</span>
                        </label>
                        <input type="date"name="fechaInicio" required="">
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="fieldcontain required">
                        <label for="fechaFin">Fecha Fin
                            <span class="required-indicator">*</span>
                        </label>
                        <input type="date" name="fechaFin" required="">
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="col-sm-6">
                    <div class="fieldcontain required">
                        <label for="fechaIncio">Duración
                            <span class="required-indicator">*</span>
                        </label>
                        <input type="number" name="duracion" max="100" required="">
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="fieldcontain required">
                        <label for="fechaFin">Versión
                            <span class="required-indicator">*</span>
                        </label>
                        <input type="number" name="version" max="10" required="">
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="col-sm-6">
                    <div class="fieldcontain required">
                        <label for="fechaIncio">Centro de costo
                            <span class="required-indicator">*</span>
                        </label>
                        <input type="number"name="centroCosto" max="1000" required="">
                    </div>
                </div>

            </div>
            <div class="col-md-12">
                <div class="col-sm-6">
                    <div class="fieldcontain required">
                        <label for="region">Región
                            <span class="required-indicator">*</span>
                        </label>
                        <select name="region" value="" required="" id="region">
                            <option value="" disabled selected>Seleccione Región</option>
                            <g:each var="reg" in="${region}">
                            <option value="${reg.id}">${reg.nombre}</option>
                            </g:each>
                        </select>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="fieldcontain required">
                        <g:link controller="region" action="index">Crear Región/Sede</g:link>
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
                    <g:submitButton name="create" class="save btn btn-info" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </div>
            </div>
        </fieldset>
    </g:form>
</div>
<asset:javascript src="compite/jquery-2.1.1.min.js"/>
<asset:javascript src="compite/typeahead.bundle.js"/>

<script>
    /*funcion que permite el ingreso de solo letras*/
    function soloLetras(e) {
        tecla = (document.all) ? e.keyCode : e.which;
        if (tecla==8) return true;
        patron =/[A-Za-z]/;
        te = String.fromCharCode(tecla);
        return patron.test(te);
    }

    /*funcion que permite el ingreso de solo numeros*/
    function soloNumeros (e){
        tecla = (document.all) ? e.keyCode : e.which;
        if (tecla==8){
            return true;
        }
        patron =/[0-9]/;
        tecla_final = String.fromCharCode(tecla);
        return patron.test(tecla_final);
    }
</script>
</body>
</html>
