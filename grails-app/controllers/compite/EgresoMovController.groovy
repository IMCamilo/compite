package compite

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class EgresoMovController {
    static Integer idproyecto
    private BigInteger usuarioId = session.usuarioLogueado.id
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max, Integer id) {
        def movList = Movilizacion.findAll()
        def egresoList = Egreso.findAll()
        params.max = Math.min(max ?: 10, 100)
        respond EgresoMov.list(params), model:[egresoMovCount: EgresoMov.count(), movilizaciones: movList, egresos: egresoList]
    }

    def show(EgresoMov egresoMov) {
        respond egresoMov
    }

    def create() {
        respond new EgresoMov(params)
    }

    @Transactional
    def save() {
        def m = null
        def eg = null

        try {
            String[] movilizacionObt = ((String) params.nombreMovilizacion).split(" ・ ");
            String[] egresoObt = ((String) params.nombreEgreso).split(" ・ ");
            m = Movilizacion.findById(movilizacionObt[1])
            eg = Egreso.findById(egresoObt[1])
        } catch (Exception e) {
            println "validando asignación. "+e.getMessage()
        }
        if (!m && !eg) {
            flash.message = "Debes seleccionar una movilizacion y un egreso"
            redirect(controller: "egresoMov", action: "index")
            return
        } else if (!m){
            flash.message = "Debes seleccionar una movilización"
            redirect(controller: "egresoMov", action: "index")
            return
        } else {
            flash.message = "Debes seleccionar un egreso"
            redirect(controller: "egresoMov", action: "index")
            return
        }

        params.movilizacion = m.id
        params.egreso = eg.id

        def egresoMov = new EgresoMov(params)

        if (egresoMov == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (egresoMov.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond egresoMov.errors, view:'create'
            return
        }

        egresoMov.save flush:true, failOnError:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'egresoMov.label', default: 'EgresoMov'), egresoMov.id])
                redirect egresoMov
            }
            '*' { respond egresoMov, [status: CREATED] }
        }
    }

    def edit(EgresoMov egresoMov) {
        def egreso = Egreso.findById(egresoMov.egresoId)
        def movilizacion = Movilizacion.findById(egresoMov.movilizacionId)
        def egresosList = Egreso.findAll()
        def movtList = Movilizacion.findAll()
        respond egresoMov, model:[egreso: egreso, movilizacion: movilizacion, egresos: egresosList, movilizaciones: movtList]
    }

    @Transactional
    def update() {
        String[] movilizacionObt = ((String) params.nombreMovilizacion).split(" ・ ");
        String[] egresoObt = ((String) params.nombreEgreso).split(" ・ ");
        def m = Movilizacion.findById(movilizacionObt[1])
        def e = Egreso.findById(egresoObt[1])
        params.movilizacion = m.id
        params.egreso = e.id

        def egresoMov = EgresoMov.get(params.id)
        egresoMov.properties = params


        if (egresoMov == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (egresoMov.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond egresoMov.errors, view:'edit'
            return
        }

        egresoMov.save flush:true, failOnError:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'egresoMov.label', default: 'EgresoMov'), egresoMov.id])
                redirect egresoMov
            }
            '*'{ respond egresoMov, [status: OK] }
        }
    }

    @Transactional
    def delete(EgresoMov egresoMov) {

        if (egresoMov == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        egresoMov.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'egresoMov.label', default: 'EgresoMov'), egresoMov.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'egresoMov.label', default: 'EgresoMov'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    //Seleccion de movilizaciones
    def egresos(Integer id, Integer max){
        idproyecto=id
        def busqueda = EgresoMov.executeQuery("from Movilizacion m, EgresoMov e where m.id=e.movilizacion_id")
        //def busqueda = EgresoMov.executeQuery("from EgresoMov where proyecto_id = $idproyecto and usuario_id = $usuarioId")
        def movs
        def proyecto=Proyecto.findById(id)
        params.max = Math.min(max ?: 10, 100)
        if (busqueda!=null){
            movs = Movilizacion.executeQuery("from Movilizacion where usuario_id="+usuarioId+"and proyecto_id="+idproyecto)
        }else{
            movs = null
        }

        [movsList: movs, proyecto: proyecto]
    }
    def crearegreso(Integer id){
        println ("Seleccion de parametros: "+params.in )
        redirect(controller:"egresoMov", action: "egresos", id:idproyecto )
    }
}
