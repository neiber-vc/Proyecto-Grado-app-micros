const modalWrapper = document.querySelector('.modal-wrapper1');

//modal add
const addModal = document.querySelector('.add-modal1');
const addModalForm = document.querySelector('.add-modal1 .form');

//modal edit
const editModal = document.querySelector('.edit-modal1');
const editModalForm = document.querySelector('.edit-modal1 .form');

let id;
const btnAdd = document.querySelector('.btn-add1');
const tableUsers = document.querySelector('.table-drivers');
const tableDrivers = document.querySelector('.table-drivers2');

const renderUser = doc => {
    const tr = `
        <tr data-id='${doc.id}'>
            <td class="py-1"><img src="${doc.data().image}" alt="image"></td>
            <td>${doc.data().username}</td>
            <td>${doc.data().email}</td>
            <td>${doc.data().linea}</td>
            <td>${doc.data().plate}</td>
        </tr>
    `;
    tableUsers.insertAdjacentHTML('beforeend', tr);
}

const renderDriver = doc => {
    const tr = `
    <tr data-id='${doc.id}'>
        <td>${doc.data().nombre}</td>
        <td>${doc.data().ci}</td>
        <td>${doc.data().plate}</td>
        <td>
            <button type="button" class="btn btn-edit btn-dark btn-icon-text">Editar
            <i class="ti-file btn-icon-append"></i>
            </button>
            <button type="button" class="btn btn-dark btn-icon-text">Eliminar
            <i class="ti-eraser btn-icon-append"></i>
            </button>           
        </td>
    </tr>
    `;
    tableDrivers.insertAdjacentHTML('beforeend', tr);

    //click edit user
    const btnEdit = document.querySelector(`[data-id='${doc.id}'] .btn-edit`);
    btnEdit.addEventListener('click', () => {
        editModal.classList.add('modal-show1');

        id = doc.id;

        editModalForm.nombre.value = doc.data().nombre;
        editModalForm.ci.value = doc.data().ci;
        editModalForm.plate.value = doc.data().plate;
    
    });
}

// Get all users (Obtenemos todos los usuarios de firebase)
db.collection('Drivers').get().then(querySnapshot => {
    querySnapshot.forEach(doc => {
        console.log(doc.data());
        renderUser(doc);
    });
});

//Obtenemos todos los usuarios usando realtime
db.collection('Valid').onSnapshot(snapshot => {
    snapshot.docChanges().forEach(change => {
        if(change.type == 'added'){
            renderDriver(change.doc);
        }
        if(change.type == 'removed'){
            let tr = document.querySelector(`[data-id='${change.doc.id}']`);
            let tbody = tr.parentElement;
            tableDrivers.removeChild(tbody);
        }
        if(change.type == 'modified'){
            let tr = document.querySelector(`[data-id='${change.doc.id}']`);
            let tbody = tr.parentElement;
            tableDrivers.removeChild(tbody);
            renderDriver(change.doc);
        }
    });
});

//CLick add user button
btnAdd.addEventListener('click', () => {
    addModal.classList.add('modal-show1');

    addModalForm.nombre.value = '';
    addModalForm.ci.value = '';
    addModalForm.plate.value = '';

});

//user click anyware outside the modal (click afuera del modal)
window.addEventListener('click', e => {
    if(e.target == addModal) {
        addModal.classList.remove('modal-show1');
    }
    if(e.target == editModal){
        editModal.classList.remove('modal-show1');
    }
});

//Click submit in add modal
addModalForm.addEventListener('submit', e => {
    e.preventDefault();
    // console.log(addModalForm.firstName.value);
    db.collection('Valid').add({
        nombre: addModalForm.nombre.value,
        ci: addModalForm.ci.value,
        plate: addModalForm.plate.value,
    });
    modalWrapper.classList.remove('modal-show1');
});

//click submit in edit model
editModalForm.addEventListener('submit', e => {
    e.preventDefault();
    db.collection('Valid').doc(id).update({
        nombre: editModalForm.nombre.value,
        ci: editModalForm.ci.value,
        plate: editModalForm.plate.value,
    });
    editModal.classList.remove('modal-show1');
});