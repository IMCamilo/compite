package compite

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import pl.touk.excel.export.WebXlsxExporter
import pl.touk.excel.export.XlsxExporter
import pl.touk.excel.export.getters.LongToDatePropertyGetter

@Transactional(readOnly = true)
class EgresoIngController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    private BigInteger usuarioId = session.usuarioLogueado.id

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def listaEgresos = Egreso.findAll("from Egreso as e where e.usuario="+session.usuarioLogueado.id)
        def egresos = []
        listaEgresos.each { egreso ->
            def result = [:]
            result.id = egreso.id
            result.programa = egreso.programa
            result.concepto = egreso.concepto
            result.aprobacion = egreso.aprobacion
            result.tipoMoneda = egreso.tipoMoneda
            result.monto = egreso.monto
            result.tipoDocumento = egreso.tipoDocumento
            result.pagadoA = egreso.pagadoA
            result.movilizacion = egreso.movilizacion
            result.rendicion = egreso.rendicion
            egresos.add(result)
        }

        [egresos: egresos, egresoCount: Egreso.count()]
    }

    def show(Egreso egreso) {
        def listaArchivos = Archivo.findAllByEntidadAndEntidadId("egreso",egreso.id)
        def buscaMovilizaciones = Movilizacion.executeQuery("from Movilizacion as m where m.egreso="+egreso.id)
        println "buscaMovilizaciones: "+buscaMovilizaciones
        println "listaArchivos: "+listaArchivos
        respond egreso, model:[archivos:listaArchivos, listaMovilizaciones: buscaMovilizaciones]
    }

    def crear(Integer max) {
        def buscaPrograma = Asignacion.executeQuery("select a.programa from Asignacion as a where a.usuario="+session.usuarioLogueado.id)
        def programa = buscaPrograma[0]

        def rendicionList = Rendicion.findAll()
        def itemsList = Item.findAll()
        params.max = Math.min(max ?: 10, 100)
        respond Egreso.list(params), model:[egresoCount: Egreso.count(), rendiciones:rendicionList, items:itemsList, programaId: programa.id]
    }

    def create() {
        respond new Egreso(params)
    }

    @Transactional
    def save() {
        println "Estoy en el save de Egreso Ing"
        def i = null

        println "params.nombreItem "+params.nombreItem
        try {
            println "Estoy en try"
            String[] itemObtenido = ((String) params.nombreItem).split("-");
            println "**************itemObtenido*********** "+itemObtenido[1]
            i = Item.findById(itemObtenido[1])
        } catch (Exception e) {
            println "Estoy en catch"
            println "validando asignación. "+e.getMessage()
        }

        if (!i){
            flash.message = "Debes seleccionar un item para esta asignación"
            redirect(controller: "egresoIng", action: "index", id: proyecto)
            return
        }

        params.item = i.id
        def egreso = new Egreso(params)

        if (egreso == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (egreso.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond egreso.errors, view:'index'
            return
        }

        egreso.save flush:true, failOnError: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'egreso.label', default: 'Egreso'), egreso.id])
                redirect action: "show", id: egreso.id
            }
            '*' { respond egreso, [status: CREATED] }
        }
    }

    def edit(Egreso egreso) {
        def usuario = Usuario.findById(usuarioId)
        def item = Item.findById(egreso.itemId)
        def programa = Programa.findById(egreso.programaId)
        def itemsList = Item.findAll()
        respond egreso, model:[items:itemsList, usuario:usuario, item:item, programa:programa]
    }

    def cargarArchivo(Egreso egreso) {
        def usuario = Usuario.findById(usuarioId)
        def item = Item.findById(egreso.itemId)
        def programa = Programa.findById(egreso.programaId)
        def itemsList = Item.findAll()
        respond egreso, model:[items:itemsList, usuario:usuario, item:item, programa:programa]
    }

    @Transactional
    def update() {
        println "Estoy en el update de Egreso Ing"
        println "Esto es params: "+params.id
        aprobacion = params.aprobacion
        if (aprobacion == "RECHAZADO") {
            println "Estoy auditando un Egreso"
        } else {
            String[] itemObtenido = ((String) params.nombreItem).split(" - ");
            def i = Item.findById(itemObtenido[1])
            params.item = i.id
            def egreso = Egreso.get(params.id)
            egreso.properties = params
            if(egreso.rendicion!=null){
                egreso.aprobacion="AUDITADA"
                if (egreso == null) {
                    transactionStatus.setRollbackOnly()
                    notFound()
                    return
                }

                if (egreso.hasErrors()) {
                    transactionStatus.setRollbackOnly()
                    respond egreso.errors, view:'edit'
                    return
                }

                egreso.save flush:true, failOnError: true

                request.withFormat {
                    form multipartForm {
                        flash.message = message(code: 'default.updated.message', args: [message(code: 'egreso.label', default: 'Egreso'), egreso.id])
                        redirect egreso
                    }
                    '*'{ respond egreso, [status: OK] }
                }
            }
            if (egreso == null) {
                transactionStatus.setRollbackOnly()
                notFound()
                return
            }

            if (egreso.hasErrors()) {
                transactionStatus.setRollbackOnly()
                respond egreso.errors, view:'edit'
                return
            }

            egreso.save flush:true, failOnError: true

            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'egreso.label', default: 'Egreso'), egreso.id])
                    redirect egreso
                }
                '*'{ respond egreso, [status: OK] }
            }
        }
    }

    @Transactional
    def delete(Egreso egreso) {

        if (egreso == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        egreso.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'egreso.label', default: 'Egreso'), egreso.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'egreso.label', default: 'Egreso'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_adFOUND }
        }
    }
    //egreso de movilizacion crear
    def egresomovilizacion(Integer max, Integer id) {
        def buscaPrograma = Asignacion.executeQuery("select a.programa from Asignacion as a where a.usuario="+session.usuarioLogueado.id)
        def programa = buscaPrograma[0]
        if (programa.id == null) {
            println "No tiene Programa"
            redirect controller: "ingeniero", action: "index"
            flash.message = "No tienes un programa, comuniquese con el administrador"
        } else {
            println "Id Programa:" + programa.id
            def listaMovilizaciones = Movilizacion.executeQuery("from Movilizacion where usuario=" + session.usuarioLogueado.id + "and programa=" + programa.id+" and egreso="+null)
            def item= Item.findAll()
            params.max = Math.min(max ?: 10, 100)
            respond Egreso.list(params), model: [movsList: listaMovilizaciones, items:item, programaId: programa.id]
        }
    }

    def admovs(){
        def movilizacionSeleccionada = params.in
        if (movilizacionSeleccionada == null){
            flash.error ="Debe seleccionar a lo menos una movilizacion para crear el Egreso, intente nuevamente."
            redirect(action: "egresomovilizacion")
        } else {
            def it = null
            try {
                String[] itemObtenido = ((String) params.nombreItem).split("-");
                it = Item.findById(itemObtenido[1])
            } catch (Exception e) {
                println "validando item... " + e.getMessage()
            }

            if (!it) {
                flash.message = "Debes Indicar un Item para el Egreso"
                redirect(controller: "egresoIng", action: "egresomovilizacion")
                return
            }

            params.item = it.id
            def egreso = new Egreso(params)
            println "esto es el egreso********* "+egreso

            if (egreso == null) {
                transactionStatus.setRollbackOnly()
                notFound()
                return
            }

            if (egreso.hasErrors()) {
                transactionStatus.setRollbackOnly()
                respond egreso.errors, view: 'index'
                return
            }

            egreso.save flush: true, failOnError: true

            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.created.message', args: [message(code: 'egreso.label', default: 'Egreso'), egreso.id])
                }
                '*' { respond egreso, [status: CREATED] }
            }

            def buscaEgreso = Egreso.executeQuery("select max(id) from Egreso")
            def egre = buscaEgreso[0]
            println "adjuntando movilizaciones...." + egre
            Integer i = 0, sum = 0

            while (i < params.in.size()) {
                def movil = params.in[i]
                sum = params.
                println("Seleccion de parametro : " + params.in[i])
                Integer e = egre
                Integer m = Integer.parseInt(movil)
                println "movilizacion numero del integer :" + movil
                params.egreso = e
                def movilizacion = Movilizacion.get(m)
                movilizacion.properties = params

                if (movilizacion == null) {
                    transactionStatus.setRollbackOnly()
                    notFound()
                    return
                }

                if (egreso.hasErrors()) {
                    transactionStatus.setRollbackOnly()
                    respond egreso.errors, view: 'create'
                    return
                }

                movilizacion.save flush: true, failOnError: true

                i++
            }
            sumarmovs()
        }
    }
    def sumarmovs(){
        def buscaEgreso = Egreso.executeQuery("select max(id) from Egreso")
        def egre = buscaEgreso[0]
        def suma = Movilizacion.executeQuery("select sum(m.precio) as suma from Movilizacion as m where m.egreso="+egre)
        println "la suma es " +suma
        params.monto = suma
        def egreso = Egreso.get(egre)
        egreso.properties = params
        if (egreso == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (egreso.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond egreso.errors, view:'index'
            return
        }

        egreso.save flush:true, failOnError: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'egreso.label', default: 'Egreso'), egreso.id])
                redirect controller: "egresoIng", action: "show", id: egreso.id
            }
            '*' { respond egreso, [status: CREATED] }
        }
    }

    // Auditorias de egresos
    def auditorias() {
        def buscar = Egreso.executeQuery("from Egreso as e where e.usuario="+session.usuarioLogueado.id+" and e.aprobacion='RECHAZADO'")
        def listaAuditorias = []
        buscar.each { egreso ->
            def buscaObservacion = Rendicion.executeQuery("select observacion from Rendicion as r where r.id="+egreso.rendicion.id)
            def observacion = buscaObservacion[0]
            def result = [:]
            result.id = egreso.id
            result.programa = egreso.programa
            result.concepto = egreso.concepto
            result.aprobacion = egreso.aprobacion
            result.tipoMoneda = egreso.tipoMoneda
            result.monto = egreso.monto
            result.tipoDocumento = egreso.tipoDocumento
            result.pagadoA = egreso.pagadoA
            result.observacion = observacion
            listaAuditorias.add(result)
        }
        [listaAuditorias: listaAuditorias]
    }

    @Transactional
    def download() {
        InputStream contentStream
        try {
            def file = new File(params.rutaAbsoluta)
            response.setHeader "Content-disposition", "attachment; filename=${params.nombreArchivo}"
            response.setHeader("Content-Length", "file-size")
            response.setContentType("file-mime-type")
            contentStream = file.newInputStream()
            response.outputStream << contentStream
            webRequest.renderView = false
        } catch (Exception e) {
            println "error en : ${e.getMessage()}"
        } finally {
            IOUtils.closeQuietly(contentStream)
        }
    }

    def reporte(Egreso egreso) {
        def movs=Movilizacion.findAll("from Movilizacion where usuario="+session.usuarioLogueado.id+" and egreso="+egreso.id)
        if (movs == null) {
            movs = null
        }
        def listaArchivos = Archivo.findAllByEntidadAndEntidadId("egreso", egreso.id)
        respond egreso, model:[archivos:listaArchivos, movilizacion:movs]
    }


    def exportExcel() {

        def resEgreso = Egreso.executeQuery("from Egreso where id = "+params.egreso)

        def datamap = [:]

        resEgreso.each { egreso ->
            def detalleItem = Item.findById(egreso.itemId) 
            def detallePrograma = Programa.findById(egreso.programaId) 
            def detalleProyecto = Proyecto.findById(egreso.proyectoId) 
            datamap.item = detalleItem.nombre
            datamap.programa = detallePrograma.nombre
            datamap.pagadoA = egreso.pagadoA
            datamap.empresa = egreso.rutEmpresa
            datamap.proyecto = detalleProyecto.nombre
            datamap.aprobacion = egreso.aprobacion
            datamap.tipoMoneda = egreso.tipoMoneda
            datamap.tipoDocumento = egreso.tipoDocumento
            datamap.monto = egreso.monto
            datamap.concepto = egreso.concepto
            datamap.fechaCreacion = egreso.fechaCreacion
            datamap.nDocumento = egreso.nDocumento
        }

        String path = System.getProperty("user.dir")+"/archivos/PLANTILLAEGRESO-NOBORRAR.xlsx"

        new WebXlsxExporter(path).with {
            setResponseHeaders(response)
            //putCellValue(//fila,//columna,//texto)
            putCellValue(4, 1, datamap.item)
            putCellValue(4, 4, datamap.programa)
            putCellValue(5, 1, datamap.pagadoA)
            putCellValue(5, 4, datamap.empresa)
            putCellValue(6, 1, datamap.proyecto)
            putCellValue(6, 4, datamap.aprobacion)
            putCellValue(7, 1, datamap.tipoMoneda)
            putCellValue(7, 4, datamap.tipoDocumento)
            putCellValue(8, 1, datamap.monto)
            putCellValue(8, 4, datamap.nDocumento)
            putCellValue(9, 1, datamap.concepto)
            putCellValue(9, 4, datamap.fechaCreacion)
            save(response.outputStream)
        }
    }

}
