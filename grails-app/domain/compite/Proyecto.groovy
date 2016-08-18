package compite

/**
 * Created by camilo on 16-08-16.
 */
class Proyecto {

    String codigo
    String nombre
    Date fechaCreacion
    Integer estado
    Date fechaFin

    static hasMany = [usuarioproyecto:UsuariosProyecto]
    static belongsTo = [empresa:Empresa]

    static constraints = {

    }

}