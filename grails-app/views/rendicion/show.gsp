<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>show</title>
</head>

<body>
    usuario ${rendicion.usuario}<br/>
    proyecto ${rendicion.proyecto}<br/>
    tipo ${rendicion.tipo}<br/>
    nombre ${rendicion.nombre}<br/>
    motivo ${rendicion.motivo}<br/>
    recorrido ${rendicion.recorrido}<br/>
    tiempo ${rendicion.tiempo}<br/>
    total ${rendicion.total}<br/>
    fecha ${rendicion.fecha}<br/>
    <g:link action="edit" id="${rendicion.id}">Editar</g:link><br/>
    <g:link action="delete" id="${rendicion.id}">Borrar</g:link><br/><br/>
</body>
</html>