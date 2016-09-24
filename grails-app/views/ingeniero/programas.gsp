<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="mainingeniero" />
    <g:set var="entityName" value="${message(code: 'rendicion.label', default: 'Rendicion')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <asset:stylesheet src="compite/autocomplete.css"/>
</head>
<body>
    <a href="#list-rendicion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
    <!--<h1 align="center">Seleccionar una empresa para crear una rendición de movilización</h1>
    <div id="buscar-proyectos" class="content scaffold-list" role="main">
        <form action="busqueda">
            <div class="fieldcontain required" id="proyectoinputdiv">
                <label for="tipo">Busqueda de Proyecto<span class="required-indicator">*</span></label>
                <input class="typeahead" name="nombreProyecto" type="text" required="" placeholder="Busca un proyecto">
                <input type="button" value="Crear Movilización">
            </div>
        </form>
    </div>-->
<div id="list-proyectos" class="content scaffold-list" role="main">
    <h1>Listado de Proyectos por Programa: </h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>
            <th>Seleccionar</th>
            <g:sortableColumn property="codigo" defaultOrder="desc" title="Codigo"/>
            <g:sortableColumn property="nombre" defaultOrder="desc" title="Nombre"/>
            <g:sortableColumn property="estado" defaultOrder="desc" title="Estado"/>
        </tr>
        </thead>
        <tbody>
            <g:each var="proyecto" status="i" in="${proyectos}">
                <tr class="${((i % 2 == 0) ? 'odd' : 'even')}">
                    <td><g:link controller="movilizacion" action="nuevamovilizacion" id="${proyecto.id}">Seleccionar Proyecto</g:link></td>
                    <td>${proyecto.codigo}</td>
                    <td>${proyecto.nombre}</td>
                    <td>${proyecto.estado}</td>
                </tr>
            </g:each>
        </tbody>
    </table>
    <div class="pagination">
        <g:paginate total="${rendicionCount ?: 0}" />
    </div>
</div>
<asset:javascript src="compite/jquery-2.1.1.min.js"/>
<asset:javascript src="compite/typeahead.bundle.js"/>
<script>
    $(document).ready(function() {
        var substringMatcher = function(strs) {
            return function findMatches(q, cb) {
                var matches, substringRegex;
                // an array that will be populated with substring matches
                matches = [];
                // regex used to determine if a string contains the substring `q`
                substrRegex = new RegExp(q, 'i');
                // iterate through the pool of strings and for any string that
                // contains the substring `q`, add it to the `matches` array
                $.each(strs, function(i, str) {
                    if (substrRegex.test(str)) {
                        matches.push(str);
                    }
                });
                cb(matches);
            };
        };
        var proyectos = [
            <g:each in="${proyectos}">
            '${it.codigo} - ${it.nombre}・${it.id}',
            </g:each>
        ];
        $('#proyectoinputdiv .typeahead').typeahead({
            hint: true,
            highlight: true,
            minLength: 1
        }, {
            name: 'proyectos',
            source: substringMatcher(proyectos)
        });
    });
</script>
</body>
</html>