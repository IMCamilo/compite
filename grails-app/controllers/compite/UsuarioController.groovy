package compite

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UsuarioController {

    private BigInteger usuarioId = session.usuarioLogueado.id
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
            params.max = Math.min(max ?: 10, 100)
            respond Usuario.list(params), model: [usuarioCount: Usuario.count()]
    }

    def show(Usuario usuario) {
        def trans= Transporte.findByUsuario(usuario)
        if(trans==null){
            trans=null
            respond usuario, model: [transporte:trans]
        } else {
            respond usuario, model: [transporte: trans]
        }
    }

    def create() {
        respond new Usuario(params)
    }

    @Transactional
    def save(Usuario usuario) {
        if (usuario == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (usuario.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond usuario.errors, view:'index'
            return
        }

        usuario.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'usuario.label', default: 'Usuario'), usuario.id])
                redirect usuario
            }
            '*' { respond usuario, [status: CREATED] }
        }
    }

    def edit(Usuario usuario) {
        respond usuario
    }

    @Transactional
    def update(Usuario usuario) {
        println "Estoy actualizando el usuario"
        println "Id usuario logueado: "+usuarioId

        if (usuario == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (usuario.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond usuario.errors, view:'edit'
            return
        }

        def tipoUsuario = Usuario.executeQuery("select tipo from Usuario where id="+usuarioId)
        def tipo = tipoUsuario[0]
        println "El tipo del usuario logueado es ${tipo}"

        usuario.save flush:true
        /*Si el tipo de usuario es Ingeniero, que me redireccione al perfil del Ingeniero*/
        if (tipo == 2) {
            println "Es Ingeniero"
            redirect(controller: "ingeniero", action: "perfil", params: [id: usuario.id])
            flash.message = "Perfil Actualizado Correctamente"
        } else {
            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'usuario.label', default: 'Usuario'), usuario.id])
                    redirect(controller: "administrador", action: "perfil", params: [id: usuario.id])
                }
                '*'{ respond usuario, [status: OK] }
            }
        }
    }

    @Transactional
    def delete(Usuario usuario) {

        def buscaEgresos = Egreso.executeQuery("from Egreso e where e.usuario="+usuario.id)
        if (buscaEgresos) {
            println "Tiene egresos"
            transactionStatus.setRollbackOnly()
            redirect (controller: "usuario", action: "show", id: usuario.id)
            flash.error = "Usuario tiene Egresos asignados, no se puede eliminar"
            return
        }

        if (usuario == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        usuario.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'usuario.label', default: 'Usuario'), usuario.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'usuario.label', default: 'Usuario'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
