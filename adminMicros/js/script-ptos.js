//Agregar documentos
function guardar(){
    var name = document.getElementById('name').value;
    var lat = document.getElementById('lat').value;
    var lng = document.getElementById('lng').value;
    console.log(lat);
    // var salida1 = document.getElementById('salida').value;

    db.collection("datos").add({
        name: name,
        lat: lat,
        lng: lng,
    })
    .then((docRef) => {
        console.log("Document written with ID: ", docRef.id);
        document.getElementById('name').value = '';
        document.getElementById('lat').value = '';
        document.getElementById('lng').value = '';
    })
    .catch((error) => {
        console.error("Error adding document: ", error);
    });
    
}

// Leer documentos
var tbmicros = document.getElementById('tb-pts-criticos');
//var alovelaceDocumentRef = db.doc('Micros/salida');
// console.log(alovelaceDocumentRef);
db.collection("datos").onSnapshot((querySnapshot) => {
    tbmicros.innerHTML = '';
    querySnapshot.forEach((doc) => {
        const places = doc.data();
        //console.log(`${doc.id} => ${places.retorno.pt1.lat}, ${places.retorno.pt1.nombre}, ${places.retorno.pt1.lng}`);

        tbmicros.innerHTML += `
        <tr ${doc.id}>
            <td>${doc.id}</td>
            <td>${doc.data().name}</td>
            <td>${doc.data().lat}</td>
            <td>${doc.data().lng}</td>
            <td>
                <button type="button" class="btn btn-primary btn-rounded btn-icon" onclick="editar('${doc.id}', '${doc.data().name}', '${doc.data().lat}', '${doc.data().lng}')">
                <i class="fas fa-edit"></i>
                </button>
            </td>
            <td>
                <button type="button" class="btn btn-danger btn-rounded btn-icon" onclick="eliminar('${doc.id}')">
                <i class="fas fa-trash-alt"></i>
                </button>
            </td>
        </tr>
        `
    });
});

// Borrar Documentos
function eliminar(id){
    db.collection("datos").doc(id).delete().then(() => {
        console.log("Document successfully deleted!");
    }).catch((error) => {
        console.error("Error removing document: ", error);
    });
}

// Editar Datos
function editar(id, name, lat, lng){

    document.getElementById('name').value = name;
    document.getElementById('lat').value = lat;
    document.getElementById('lng').value = lng;

    var boton = document.getElementById('boton');
    boton.innerHTML = 'Actualizar';

    boton.onclick = function(){
        var washingtonRef = db.collection("datos").doc(id);
        // Set the "capital" field of the city 'DC'
        var name = document.getElementById('name').value;
        var lat = document.getElementById('lat').value;
        var lng = document.getElementById('lng').value;

        return washingtonRef.update({
            name: name,
            lat: lat,
            lng: lng,
        })
        .then(() => {
            console.log("Document successfully updated!");
            boton.innerHTML = 'Guardar';
            document.getElementById('name').value = '';
            document.getElementById('lat').value = '';
            document.getElementById('lng').value = '';
        })
        .catch((error) => {
            // The document probably doesn't exist.
            console.error("Error updating document: ", error);
        });
    } 
}
