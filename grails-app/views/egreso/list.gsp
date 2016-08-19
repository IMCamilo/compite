<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>list</title>
</head>

<body>
    <g:each in="${egresos}" var="egreso">
        Usuario ${egreso.usuario} <br/>
        Fecha ${egreso.fechaCreacion}<br/>
        aprobacion ${egreso.aprobacion}<br/>
        sedeEnvio ${egreso.sedeEnvio}<br/>
        tipoRendicion ${egreso.tipoRendicion}<br/>
        <g:link action="edit" id="${egreso.id}">Editar</g:link><br/>
        <g:link action="delete" id="${egreso.id}">Borrar</g:link><br/><br/>
    </g:each>
    <g:link action="create">Nueva auditoria</g:link>
</body>
</html>
