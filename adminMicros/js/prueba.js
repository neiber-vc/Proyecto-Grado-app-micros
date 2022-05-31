// var selected_item = document.getElementById('tipoatencion');//Se llama el selected
//     selected_item.innerHTML = '';
//     selected_item.innerHTML += `
//             <option value="0" selected>Selecciona la linea</option>
//             ` //Agrego un option por default
//     db.collection("Micros").onSnapshot((querySnapshot) => { //Se llaman los datos
//             querySnapshot.forEach((doc) => {
//             console.log(`${doc.id} => ${doc.data().linea}`);
//             selected_item.innerHTML += `
//             <option value="${doc.id}">${doc.data().linea}</option> . 
//             ` //Aquí agrego los options de acuerdo a la base de datos.
//         });
//     });

var selected_item = document.getElementById('framework');
const btn = document.querySelector('#btn');
const sb = document.querySelector('#framework');


db.collection("Micros").onSnapshot((querySnapshot) => {
    querySnapshot.forEach((doc) => {
        console.log(`${doc.id} => ${doc.data().linea}`);
        selected_item.innerHTML += `<option value = "${doc.id}">${doc.data().linea}</option>`
    });
});

    btn.onclick = (event) => {
        event.preventDefault();
        // show the selected index
        alert(sb.selectedIndex);
        var x = document.getElementById("framework");
        var i = x.selectedIndex;
        document.getElementById("demo").innerHTML = x.value[i].text;
    };

    db.collection("Micros").get().then((querySnapshot) => {
        querySnapshot.forEach((doc) => {
            // doc.data() is never undefined for query doc snapshots
            console.log(doc.id, " => ", doc.data());
        });
    });

    db.collection("Micros").where("linea", "==", "1")
    .get()
    .then((querySnapshot) => {
        querySnapshot.forEach((doc) => {
            // doc.data() is never undefined for query doc snapshots
            console.log(doc.id, " => ", doc.data(), "CONSULTAS");
        });
    })
    .catch((error) => {
        console.log("Error getting documents: ", error);
    });



var cod = document.getElementById("producto");

db.collection("datos").onSnapshot((querySnapshot) => {
    querySnapshot.forEach((doc) => {
        console.log(`${doc.id} => ${doc.data().name}`);
        cod.innerHTML += `<option value = "${doc.id}, ${doc.data().name}, ${doc.data().lat}, ${doc.data().lng}">${doc.data().name}</option>`
    });
});

function mostrar()
{
/* Para obtener el valor */
var cod = document.getElementById("producto").value;
alert(cod);
 
/* Para obtener el texto */
var combo = document.getElementById("producto");
var selected = combo.options[combo.selectedIndex].text;
alert(selected);

}
//var selected_item = document.getElementById('sindicato');



