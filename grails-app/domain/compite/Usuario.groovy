package compite
/**
 * Created by camilo on 16-08-16.
 */
class Usuario {

    String rut
    String nombres
    String paterno
    String materno
    String direccion
    String correo
    String telefono
    String clave
    Integer tipo
    String creadoPor
    Date fechaCreacion = new Date()

    static hasMany = [rendicion:Rendicion, transporte:Transporte, auditoria:Auditoria, egreso:Egreso, asignacion:Asignacion, programa:Programa]

    static constraints = {

    }
}
