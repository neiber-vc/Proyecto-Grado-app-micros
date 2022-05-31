
let id;
const tableUsers = document.querySelector('.table-users');

const renderUser = doc => {
    const tr = `
        <tr data-id='${doc.id}'>
            <td class="py-1"><img src="${doc.data().image}" alt="image"></td>
            <td>${doc.data().username}</td>
            <td>${doc.data().email}</td>
        </tr>
    `;
    tableUsers.insertAdjacentHTML('beforeend', tr);
}

// Get all users (Obtenemos todos los usuarios de firebase)
db.collection('Clients').get().then(querySnapshot => {
    querySnapshot.forEach(doc => {
        console.log(doc.data());
        renderUser(doc);
    });
});