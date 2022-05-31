
//datos de array codigo arreglado para implementar 2021/08/01
let parameters = []
let parameters2 = []
let parameters3 = []
let id = ''

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

var list_linea = document.getElementById('list-linea');
var selected_item = document.getElementById('sindicatoData');
var lineadiv = document.getElementById('divlinea');
var rutadiv = document.getElementById('divruta');


db.collection("datos").onSnapshot((querySnapshot) => {
    querySnapshot.forEach((doc) => {
        //console.log(`${doc.id} => ${doc.data().name}`);
        selected_item.innerHTML += `<option value = "[${doc.data().lng}, ${doc.data().lat}]">${doc.data().name}</option>`
    });
});


// -------------------------------------
$(function () {
    $(document).on('click', '.borrar', function (event) {
        event.preventDefault();
        $(this).closest('tr').remove();
    });
});

/**
    * Funcion que captura las variables pasados por GET
    * Devuelve un array de clave=>valor
    */
 function getGET()
 {
     // capturamos la url
     var loc = document.location.href;
     // si existe el interrogante
     if(loc.indexOf('?')>0)
     {
         // cogemos la parte de la url que hay despues del interrogante
         var getString = loc.split('?')[1];
         // obtenemos un array con cada clave=valor
         var GET = getString.split('&');
         var get = {};
         // recorremos todo el array de valores
         for(var i = 0, l = GET.length; i < l; i++){
             var tmp = GET[i].split('=');
             get[tmp[0]] = unescape(decodeURI(tmp[1]));
         }
         return get;
     }
 }
 window.onload = function()
 {
     // Cogemos los valores pasados por get
     var valores=getGET();
     if(valores)
     {
         //recogemos los valores que nos envia la URL en variables para trabajar 
             //con ellas
         id = valores['id'];
         var linea = valores['linea'];
         
         console.log(id)
         console.log(linea)
         //document.getElementById('linea').value = linea;
         
        
        //  var edad = valores['edad'];
        //      // hacemos un bucle para pasar por cada indice del array de valores
        //  for(var index in valores)
        //  {
        //      document.write(" clave: "+index+" - valor: "+valores[index]);

        db.collection("Micros").where("linea", "==", linea)
    .onSnapshot((querySnapshot) => {
        list_linea.innerHTML = '';
        lineadiv.innerHTML = '';
        querySnapshot.forEach((doc) => {
            lineadiv.innerHTML += `<h1 class="text-primary">Linea Nro: ${linea}</h1>`;
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
                <td id=${index}>${index+1}</td>
                <td id="name_row${index}">${element?.name}</td>
                <td id="coord_row${index}">${element?.coord}</td>
                <td><button type="button" class="btn btn-danger btn-rounded btn-icon" onclick="eliminar2('${doc.id}','${index}', '${element?.name}', '${element?.coord}')">
                <i class="fas fa-trash-alt"></i>
                </button></td>
                <td>
                <button id="editbtn${index}" type="button" class="btn btn-primary btn-rounded btn-icon" onclick="editar('${index}','${element?.name}', '${element?.coord}')">
                <i class="fas fa-edit"></i>
                </button>
                </td>
                <td>
                <span class="btn btn-sm btn-success btn_row_below_clone"><i class="fas fa-plus-circle"></i></span>
                </td>
            </tr>`
            });
            console.log("RUTA CREADA: "+JSON.stringify(parameters3))
            var washingtonRef3 = db.collection("Micros").doc(id);
            washingtonRef3.update({
                geo: JSON.stringify(parameters3),
            });
            //console.log(typeof(dato33))
            // list_linea.innerHTML += `
            // <button type="button" class="btn btn-danger mr2 borrar" onclick="modificar('${id}', '${JSON.stringify(parameters3)}')">Modificar</button>
            // `
            list_linea.innerHTML += `
            <button type="button" class="btn btn-danger mr2 borrar" onclick="actualizar('${id}', '${JSON.stringify(parameters3)}')">ACTUALIZAR</button>
            `
            parameters3 = []
        });
    }).catch((error) => {
        console.log("Error getting documents: ", error);
    });
        
    }
 }

 function guardar(){
    //const val={name: name, coord: coord};
    var coord = document.getElementById('sindicatoData').value;
    var combo = document.getElementById('sindicatoData');
    var name = combo.options[combo.selectedIndex].text;
    console.log("MY ID:"+id)
    console.log("MY NAME:"+name)
    console.log("MY COORDENADA:"+coord)
    const val = {name: name, coord: coord};
    console.log("valor:"+val)
    var washingtonRef2 = db.collection("Micros").doc(id);

    washingtonRef2.update({
        lista: firebase.firestore.FieldValue.arrayUnion(val)
    }).then(() => {
        console.log("Document successfully updated!");
    })
    .catch((error) => {
        // The document probably doesn't exist.
        console.error("Error updating document: ", error);
        alert("NO DEBER AGREGAR LA MISMA CALLE O PUNTO DE REFERENCIA");
    });
    
}

// function eliminar2(id, index, name, coord){
//     //const val={name: name, coord: coord};
//     console.log("MY ID:"+id)
//     console.log("MY NAME:"+name)
//     console.log("MY COORDENADA:"+coord)
//     var washingtonRef2 = db.collection("Micros").doc(id);
//     const val={name: name, coord: coord};
//     washingtonRef2.update({
//         lista: firebase.firestore.FieldValue.arrayRemove(val)
//     });
//     //console.log(val)
// }

function eliminar2(id, index, name, coord){
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
          console.log("MY ID:"+id)
          console.log("MY NAME:"+name)
          console.log("MY COORDENADA:"+coord)
          var washingtonRef2 = db.collection("Micros").doc(id);
          const val={name: name, coord: coord};
          washingtonRef2.update({
              lista: firebase.firestore.FieldValue.arrayRemove(val)
          });
        } else {
          swal("No se elimino el Dato");
        }
      });
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
        alert("La Ruta del Micro se ha creado exitosamente!!")
    })
    .catch((error) => {
        // The document probably doesn't exist.
        console.error("Error updating document: ", error);
    });
}

function editar(index, name, coord){
    rutadiv.innerHTML = '';
    
    console.log(index);
    console.log(name);
    console.log(coord);
    console.log(id);

    var boton = document.getElementById('boton');
    boton.innerHTML = 'ACTUALIZAR';

    var edit = document.getElementById(index);

    rutadiv.innerHTML += `<h4 class="card-title">RUTA # ${parseInt(index)+1}:</h4>`

    var combo = document.getElementById('sindicatoData');
    combo.options[combo.selectedIndex].text = name;
    //name2.innerHTML = 'name'
    console.log(name)

    boton.onclick = function(){
        //var washingtonRef = db.collection("Micros").doc(id);
        // Set the "capital" field of the city 'DC'
        var name = document.getElementById('sindicatoData').value;
        console.log("DATO A GUARDAR:"+name);
        var combo = document.getElementById('sindicatoData');
        var name2 = combo.options[combo.selectedIndex].text;
        console.log(name2);
        // var sindicato = document.getElementById('sindicato').value;
        // var ciudad = document.getElementById('ciudad').value;
        // var ruta = document.getElementById('ruta').value;

        var nametd = document.getElementById('name_row'+index);
        nametd.innerHTML = name2;

        var coordtd = document.getElementById('coord_row'+index);
        coordtd.innerHTML = name;
        
        boton.innerHTML = 'AGREGAR';
        
    } 

}

let parameters4 = []

const addJsonElement4 = json => {
    parameters4.push(json)
    return parameters4.length - 1
}

let parameters5 = []

const addJsonElement5 = json => {
    parameters5.push(json)
    return parameters5.length - 1
}

function actualizar(id){
    
    // Definimos el array donde guardaremos los datos...
    var data = [];
    var data2 = [];

    // Obtenemos la variable con las filas de tbody...
    var rows = document.getElementById('list-linea').rows;

    // Recorremos las filas y añadimos al array el valor de las celdas con los offset 1 (capítulo) y 3 (porcentaje)...
    for (var i = 0; i < rows.length; i++) {
        data.push('name:'+rows[i].cells[1].innerHTML, 'coord:'+rows[i].cells[2].innerHTML);
        data2.push(rows[i].cells[2].innerHTML);

        addJsonElement4({
            name: rows[i].cells[1].innerHTML,
            coord: rows[i].cells[2].innerHTML
        });

        addJsonElement5(JSON.parse(rows[i].cells[2].innerHTML))
 
    }
    parameters4 = parameters4.filter(el => el != null)
    const dato4 = JSON.stringify(parameters4)
    parameters5 = parameters5.filter(el => el != null)
    const dato5 = JSON.stringify(parameters5)
    console.log(JSON.parse(dato4))
    console.log(dato5)
    // Ya tenemos los datos guardados, ahora hacemos lo que queramos con ellos...

    var washingtonRef = db.collection("Micros").doc(id);

    swal({
        title: "Rutas De Micros",
        text: "Se creara la ruta de micro Actualizada",
        icon: "warning",
        buttons: true,
        dangerMode: true,
    })
      .then((willDelete) => {
        if (willDelete) {
          swal("Ruta creada Exitosamente!!", {
            icon: "success",
          });
          return washingtonRef.update({
            lista: JSON.parse(dato4),
            geo: dato5
        })
        .then(() => {
            //swal("Ruta creada exitosamente!!", "Presionar para continuar!", "success");
            document.location.reload();
            console.log("Document successfully updated!");
            //boton.innerHTML = 'Guardar';
            // console.log(`Datos agregar: ${arr}`)
            //$divElements.innerHTML = ""
            parameters4 = []
            parameters5 = []
            //alert("Datos Actualizado y ruta creada!!")
            //confirmaredit();
            //document.location.reload();
        })
        .catch((error) => {
            // The document probably doesn't exist.
            console.error("Error updating document: ", error);
        });
        } else {
          swal("Se cancelo la creacion de rutas :(!");
        }
    });

    // return washingtonRef.update({
    //     lista: JSON.parse(dato4),
    //     geo: dato5
    // })
    // .then(() => {
    //     //swal("Ruta creada exitosamente!!", "Presionar para continuar!", "success");
    //     document.location.reload();
    //     console.log("Document successfully updated!");
    //     //boton.innerHTML = 'Guardar';
    //     // console.log(`Datos agregar: ${arr}`)
    //     //$divElements.innerHTML = ""
    //     parameters4 = []
    //     parameters5 = []
    //     //alert("Datos Actualizado y ruta creada!!")
    //     //confirmaredit();
    //     //document.location.reload();
    // })
    // .catch((error) => {
    //     // The document probably doesn't exist.
    //     console.error("Error updating document: ", error);
    // });
}

// --------------------------------------------------------------------------------------------
$(document).ready(function($)
  {
    
    $(document).on('click',".btn_row_below_clone", function(e)
    {
      var r = $(this).closest('tr').clone();
      $(this).closest('tr').after(r);
    });
    
  });

// function confirmaredit(){
//     swal("Ruta creada exitosamente!!", "Presionar para continuar!", "success");
//     document.location.reload();
// }