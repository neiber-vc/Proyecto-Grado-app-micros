
//datos de array codigo arreglado para implementar 2021/08/01
let parameters = []
let parameters2 = []
let parameters3 = []

console.log(parameters3)

function removeElement(event, position) {
    event.target.parentElement.remove()
    delete parameters[position]
}

const addJsonElement = json => {
    parameters.push(json)
    return parameters.length - 1
}

const addJsonElement2 = json => {
    parameters2.push(json)
    return parameters2.length - 1
}

const addJsonElement3 = json => {
    parameters3.push(json)
    return parameters3.length - 1
}


// Leer documentos
var tbmicros = document.getElementById('table-micros');
//var alovelaceDocumentRef = db.doc('Micros/salida');
// console.log(alovelaceDocumentRef);
db.collection("Micros").onSnapshot((querySnapshot) => {
    //let dato3 = '';
    tbmicros.innerHTML = '';
    querySnapshot.forEach((doc) => {
        //const places = doc.data();
        //console.log(`${doc.id} => ${places.retorno.pt1.lat}, ${places.retorno.pt1.nombre}, ${places.retorno.pt1.lng}`);

        tbmicros.innerHTML += `
        <tr ${doc.id}>
            <td>${doc.data().linea}</td>
           
            
            <!-- <td><button type="button" class="btn btn-primary mr2" onclick="editar('${doc.id}', '${doc.data().linea}', '${doc.data().sindicato}', '${doc.data().ciudad}', '${doc.data().geo}')">Agregar</button></td> -->
            <td><button type="button" class="btn btn-success mr2" onclick="mostrar('${doc.id}', '${doc.data().linea}')"><i class="fas fa-list-ol"></i></button></td>
            <td><form action="rutalist.html" method="get" >
            <input type="hidden" name="id" value="${doc.id}" />
            <input type="hidden" name="linea" value="${doc.data().linea}" />
            <button type="submit" class="btn btn-secondary mr2"><i class="fas fa-route"></i></button>
            <form></td>
            
        </tr>
        `
    });
});

var list_linea = document.getElementById('list-linea');


function mostrar(id, linea, dato33){
console.log(linea);
console.log(id)
//console.log(dato33)


db.collection("Micros").where("linea", "==", linea)
    .onSnapshot((querySnapshot) => {
        list_linea.innerHTML = '';
        querySnapshot.forEach((doc) => {
            // doc.data() is never undefined for query doc snapshots
            //console.log(doc.id, " => ", doc.data().lista);
            // let data = doc.data().lista;
            // console.log(data)
            //dato3 = ''
            doc.data().lista?.forEach((element, index) => {
                 //console.log(index+" = "+"name:"+element?.name+"coordenada:"+element?.coord)
                //  list_linea.innerHTML += `
                addJsonElement3(JSON.parse(element?.coord))
                //console.log(addJsonElement3(JSON.parse(element?.coord)))
                parameters3 = parameters3.filter(el => el != null)
                //dato33 = JSON.stringify(parameters3)
                //console.log("RESPUESTA: "+dato3)
                list_linea.innerHTML += `
            <tr id=${index}>
                <td>${index+1}</td>
                <td>${element?.name}</td>
                <!--<td><button type="button" class="btn btn-danger btn-rounded btn-icon" onclick="eliminar2('${doc.id}','${index}', '${element?.name}', '${element?.coord}')">
                <i class="fas fa-trash-alt"></i>
                </button></td>
                <td>-->
                
            </tr>`
            });
            console.log("DATO FINAL: "+JSON.stringify(parameters3))
            
            //console.log(typeof(dato33))
            list_linea.innerHTML += `
            <button type="button" class="btn btn-danger mr2 borrar" onclick="modificar('${id}', '${JSON.stringify(parameters3)}')">Modificar</button>
            `
            parameters3 = []
        });
    }).catch((error) => {
        console.log("Error getting documents: ", error);
    });
    //dato3 = ''
}

function modificar(id, data3){
    //parameters3 = []
    
    console.log("id="+id)
    console.log("RESPUESTA UPDATE: "+data3)
    console.log(typeof(data3))
    
    var washingtonRef3 = db.collection("Micros").doc(id);
    return washingtonRef3.update({
        geo: data3,
    })
    .then(() => {
        console.log("Documento se actualizo exitosamente!!");
        console.log("RESPUESTA UPDATE: "+data3)
        alert("Documento se actualizo exitosamente!!")
    })
    .catch((error) => {
        // The document probably doesn't exist.
        console.error("Error updating document: ", error);
    });
}

function eliminar2(id, index, name, coord){
    //const val={name: name, coord: coord};
    console.log("MY ID:"+id)
    console.log("MY NAME:"+name)
    console.log("MY COORDENADA:"+coord)
    var washingtonRef2 = db.collection("Micros").doc(id);
    const val={name: name, coord: coord};
    washingtonRef2.update({
        lista: firebase.firestore.FieldValue.arrayRemove(val)
    });
    //console.log(val)
}


// Borrar Documentos
function eliminar(id){
    db.collection("Micros").doc(id).delete().then(() => {
        console.log("Document successfully deleted!");
    }).catch((error) => {
        console.error("Error removing document: ", error);
    });
}

var selected_item = document.getElementById('sindicatoData');

db.collection("datos").onSnapshot((querySnapshot) => {
    querySnapshot.forEach((doc) => {
        //console.log(`${doc.id} => ${doc.data().name}`);
        selected_item.innerHTML += `<option value = "[${doc.data().lng}, ${doc.data().lat}]">${doc.data().name}</option>`
    });
});

// Editar Datos
function editar(id, linea, sindicato, ciudad, ruta){

    document.getElementById('linea').value = linea;
    console.log(linea)

    const $form = document.getElementById("frmUsers")
    const $divElements = document.getElementById("divElements")
    const $btnSave = document.getElementById("btnSave")
    const $btnAdd = document.getElementById("btnAdd")

    const templateElement = (data, position) => {
        return (`
            <button class="delete" onclick="removeElement(event, ${position})"></button>
            <strong>${position+1} -> </strong> ${data}
        `)
    }
    $btnAdd.addEventListener("click", (event) => {
        if($form.sindicatoData.value != ""){
            let index = addJsonElement({
                name: $form.sindicatoData.options[sindicatoData.selectedIndex].text,
                coord: $form.sindicatoData.value
                // lat: $form.lat.value,
                // lng: $form.lng.value
            })
            // ---------------------------------------------------------------------------
            let index2 = addJsonElement2(JSON.parse($form.sindicatoData.value))
            const $div = document.createElement("div")
            $div.classList.add("notification", "is-link", "is-light", "py-2", "my-1")
            //$div.innerHTML = templateElement(`${$form.name.value} ${$form.lat.value} ${$form.lng.value}`, index)
            $div.innerHTML = templateElement(`${$form.sindicatoData.options[sindicatoData.selectedIndex].text}`, index)

            $divElements.insertBefore($div, $divElements.firstChild)

            $form.reset()
        }else{
            alert("Complete los campos")
        }
    })
    
    console.log(linea);
    console.log(sindicato);

    var boton = document.getElementById('btnSave');
    boton.innerHTML = 'Actualizar';

    //guardar datos actualizados
    $btnSave.addEventListener("click", (event) =>{
        var washingtonRef = db.collection("Micros").doc(id);
        parameters = parameters.filter(el => el != null)
        parameters2 = parameters2.filter(el => el != null)
        const $jsonDiv = document.getElementById("jsonDiv")
        // $jsonDiv.innerHTML = `Datos: ${JSON.stringify(parameters)}`
        const dato = JSON.stringify(parameters)
        //let arr = JSON.parse(dato)

        // ------------------------------------este codigo sirve
        const dato2 = JSON.stringify(parameters2)

        console.log('dato a agregar en la lista'+dato)
        console.log(typeof(dato))
        console.log(dato2)
        console.log(typeof(dato2))
        return washingtonRef.update({
            lista: JSON.parse(dato),
            geo: dato2
        })
        .then(() => {
            console.log("Document successfully updated!");
            boton.innerHTML = 'Guardar';
            // console.log(`Datos agregar: ${arr}`)
            $divElements.innerHTML = ""
            //parameters = []
            alert("Datos agregado Exitosamente!!")
            //document.location.reload();
        })
        .catch((error) => {
            // The document probably doesn't exist.
            console.error("Error updating document: ", error);
        });
    })
    parameters2 = []
    
}