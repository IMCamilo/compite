package compite

class Egreso {

    String aprobacion, concepto, tipoDocumento, tipoMoneda, nDocumento, pagadoA, creadoPor, rutEmpresa
    Date fechaCreacion
    Integer monto

    static belongsTo = [programa:Programa, usuario:Usuario, item:Item, rendicion:Rendicion, proyecto: Proyecto]
    static hasMany = [egresomov:EgresoMov]
    static constraints = {
        creadoPor nullable: true, blank: true
        rendicion nullable: true, blank: true
    }

}
