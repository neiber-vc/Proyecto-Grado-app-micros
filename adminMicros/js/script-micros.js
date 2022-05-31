
//Agregar documentos
function guardar(){
    var linea = document.getElementById('linea').value;
    var sindicato = document.getElementById('sindicato').value;
    var ciudad = document.getElementById('ciudad').value;

    db.collection("Micros").add({
        linea: linea,
        sindicato: sindicato,
        ciudad: ciudad,
        // geo: ruta,
    })
    .then((docRef) => {
        confirmarg();
        //alert("se guardo exitosamente!!")
        console.log("Document written with ID: ", docRef.id);
        document.getElementById('linea').value = '';
        //document.getElementById('sindicato').value = '';
        document.getElementById('ciudad').value = '';
        // document.getElementById('ruta').value = '';
    })
    .catch((error) => {
        console.error("Error adding document: ", error);
    });
    
}

// Leer documentos
var tbmicros = document.getElementById('table-micros');

db.collection("Micros").onSnapshot((querySnapshot) => {
    tbmicros.innerHTML = '';
    querySnapshot.forEach((doc) => {
        const places = doc.data();

        console.log('..............................');

        console.log(`Document found at path: ${doc.ref.path}`);

        tbmicros.innerHTML += `
        <tr ${doc.id}>
            <td>${doc.data().linea}</td>
            <td>${doc.data().sindicato}</td>
            <td>${doc.data().ciudad}</td>
            <td><button type="button" class="btn btn-primary mr2" onclick="editar('${doc.id}', '${doc.data().linea}', '${doc.data().sindicato}', '${doc.data().ciudad}')">Editar</button></td>
            <td><button type="button" class="btn btn-danger mr2" onclick="eliminar('${doc.id}')">Eliminar</button></td>
        </tr>
        `
    });
});

// Borrar Documentos
// function eliminar(id){
//     db.collection("Micros").doc(id).delete().then(() => {
//         confirmdelet();
//         console.log("Document successfully deleted!");
//     }).catch((error) => {
//         console.error("Error removing document: ", error);
//     });
// }

// Editar Datos
function editar(id, linea, sindicato, ciudad){

    document.getElementById('linea').value = linea;
    document.getElementById('sindicato').value = sindicato;
    document.getElementById('ciudad').value = ciudad;
    // document.getElementById('ruta').value = ruta;
    // console.log(ruta);
    console.log(sindicato);

    var boton = document.getElementById('boton');
    boton.innerHTML = 'Actualizar';

    

    boton.onclick = function(){
        var washingtonRef = db.collection("Micros").doc(id);
        // Set the "capital" field of the city 'DC'
        var linea = document.getElementById('linea').value;
        var sindicato = document.getElementById('sindicato').value;
        var ciudad = document.getElementById('ciudad').value;
        // var ruta = document.getElementById('ruta').value;

        
        return washingtonRef.update({
            linea: linea,
            sindicato: sindicato,
            ciudad: ciudad,
            // geo: ruta,
        })
        .then(() => {
            confirmaredit();
            console.log("Document successfully updated!");
            boton.innerHTML = 'Guardar';
            document.getElementById('linea').value = '';
            //document.getElementById('sindicato').value = '';
            document.getElementById('ciudad').value = '';
            // document.getElementById('ruta').value = '';
        })
        .catch((error) => {
            // The document probably doesn't exist.
            console.error("Error updating document: ", error);
        });
    } 
}

function confirmarg(){
    swal("Se guardo Exitosamente!!", "Presionar para continuar!", "success");
}

function confirmaredit(){
    swal("Se actualizo Exitosamente!!", "Presionar para continuar!", "success");
}

function eliminar(id){
    swal({
        title: "Esta seguro?",
        text: "Una vez eliminado, ¡no podrá recuperar este dato!",
        icon: "warning",
        buttons: true,
        dangerMode: true,
      })
      .then((willDelete) => {
        if (willDelete) {
          swal("Dato Eliminado Exitosamente!!", {
            icon: "success",
          });
            db.collection("Micros").doc(id).delete().then(() => {
            //confirmdelet();
            console.log("Document successfully deleted!");
            }).catch((error) => {
                console.error("Error removing document: ", error);
            });
        } else {
          swal("No se elimino el Dato");
        }
      });
}