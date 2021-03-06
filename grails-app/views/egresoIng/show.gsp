<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainingeniero" />
        <g:set var="entityName" value="${message(code: 'egreso.label', default: 'Egreso')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="modal fade" id="elIDdelModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Movilizaciones del Egreso</h4>
                    </div>
                    <div class="modal-body">
                        <table>
                            <thead>
                                <tr>
                                    <td>Fecha</td>
                                    <td>Motivo/empresa</td>
                                    <td>Direción</td>
                                    <td>Distancia</td>
                                    <td>Tipo</td>
                                    <td>Precio</td>
                                </tr>
                            </thead>
                            <tbody>
                                <g:each var="movilizacion" status="i" in="${listaMovilizaciones}">
                                    <tr>
                                        <td>${formatDate(format:"dd/MM/yyyy", date: movilizacion.fechaCreacion)}</td>
                                        <td>${movilizacion.motivoEmpresa}</td>
                                        <td>${movilizacion.direccion}</td>
                                        <td>${movilizacion.distancia}</td>
                                        <td>${movilizacion.tipo}</td>
                                        <td>${movilizacion.precio}</td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="show-egresoIng" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:each in="${egreso}">
                <h1>Detalle de Egreso nº ${it.id}</h1>
                <div class="col-md-12">
                    <div class="col-sm-6">
                        <label>Item :</label>
                        <label style="color: dimgray">${it.item.nombre}</label>
                    </div>
                    <div class="col-sm-6">
                        <label>Programa :</label>
                        <label style="color: dimgray">${it.programa.nombre}</label>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-sm-6">
                        <label>Pagado A :</label>
                        <label style="color: dimgray">${it.pagadoA}</label>
                    </div>
                    <div class="col-sm-6">
                        <label>Rut Empresa :</label>
                        <label style="color: dimgray">${it.rutEmpresa}</label>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-sm-6">
                        <label>Proyecto :</label>
                        <label style="color: dimgray">${it.proyecto.nombre}</label>
                    </div>
                    <div class="col-sm-6">
                        <label>Aprobacion :</label>
                        <label style="color: dimgray">${it.aprobacion}</label>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-sm-6">
                        <label>Tipo de Cambio :</label>
                        <label style="color: dimgray">${it.tipoMoneda}</label>
                    </div>
                    <div class="col-sm-6">
                        <label>Tipo de Documento :</label>
                        <label style="color: dimgray">${it.tipoDocumento}</label>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-sm-6">
                        <label>Monto :</label>
                        <label style="color: dimgray">$ ${it.monto}</label>
                    </div>
                    <g:if test="${!it.movilizacion.isEmpty()}">
                        <div class="col-sm-6">
                            <label>Movilizaciones :</label>
                            <a type="button" class="save" data-toggle="modal" data-target="#elIDdelModal">Ver Movilizaciones</a>
                        </div>
                    </g:if>
                </div>
                <div class="col-md-12">
                    <div class="col-sm-6">
                        <label>Concepto :</label>
                        <label style="color: dimgray">${it.concepto}</label>
                    </div>
                    <div class="col-sm-6">
                        <label>Fecha Ingreso :</label>
                        <label style="color: dimgray">${formatDate(format:"dd/MM/yyyy", date: it.fechaCreacion)}</label>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-sm-6">
                        <label>Nº Documento :</label>
                        <label style="color: dimgray">${it.nDocumento}</label>
                    </div>
                    <g:if test="${it.rendicion != null}">
                        <div class="col-sm-6">
                            <label>Rendición :</label>
                            <label style="color: dimgray">Nº ${it.rendicion.id}</label>
                        </div>
                    </g:if>
                </div>
                <div class="col-md-12">
                    <div class="col-sm-6">
                        <g:form name="name" action="exportExcel">
                            <input type="hidden" name="egreso" value="${it.id}">
                            <input class="btn btn-primary" type="submit" name="Exportar Excel" value="Exportar Excel">
                        </g:form>
                    </div>
                </div>
            </g:each>
            <div style="padding:7.5%"></div>
            <h1>Archivos Cargados</h1>
            <div style="width:50%">
                <table>
                    <thead>
                        <tr>
                            <th>Creado Por</th>
                            <th>Nombre Archivo</th>
                            <th>Subido</th>
                            <th>Acción</th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:if test="${archivos.isEmpty()}">
                            <tr><td>Egresos no tiene archivos cargados.</td></tr>
                        </g:if>
                        <g:else>
                            <g:each var="archivo" status="i" in="${archivos}">
                                <tr class="${((i % 2 == 0) ? 'odd' : 'even')}">
                                    <td>${archivo.creadoPor}</td>
                                    <td>${archivo.nombre}</td>
                                    <td><prettytime:display date="${archivo.date}"/></td>
                                    <td>
                                        <g:form action="download">
                                            <g:hiddenField name="rutaAbsoluta" value="${archivo.ruta}"/>
                                            <g:hiddenField name="nombreArchivo" value="${archivo.nombre}"/>
                                            <g:submitButton name="name" style="width:100%" value="Ver/Descargar"/>
                                        </g:form>
                                    </td>
                                </tr>
                            </g:each>
                        </g:else>
                    </tbody>
                </table>
            </div>
            <g:form resource="${this.egreso}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="volver" action="index">Volver al Listado</g:link>
                    <g:if test="${egreso.aprobacion == "NO"}">
                        <a class="edit" href="../edit/${egreso.id}"><g:message code="default.button.edit.label" default="Edit" /></a>
                        <a class="cargaArchivo" href="../cargarArchivo/${egreso.id}">Cargar Archivo</a>
                        <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </g:if>
                    <g:elseif test="${egreso.aprobacion == "RECHAZADO"}">
                        <a class="edit" href="../edit/${egreso.id}"><g:message code="default.button.edit.label" default="Edit" /></a>
                        <a class="cargaArchivo" href="../cargarArchivo/${egreso.id}">Cargar Archivo</a>
                    </g:elseif>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
