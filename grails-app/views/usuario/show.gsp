<html>
    <head>
        <title>Show contact</title>
    </head>
    <body>
        <h1>Mostrar usuario</h1>
        rut: ${usuario.rut}<br/>
        nombres: ${usuario.nombres}<br/>
        paterno: ${usuario.paterno}<br/>
        materno: ${usuario.materno}<br/>
        direccion: ${usuario.direccion}<br/>
        correo: ${usuario.correo}<br/>
        telefono: ${usuario.telefono}<br/>
        clave: ${usuario.clave}<br/>
        tipo: ${usuario.tipo}<br/>
        <g:link action="edit" id="${usuario.id}">Edit</g:link><br />
        <g:link action="delete" id="${usuario.id}">Delete</g:link>
    </body>
</html>