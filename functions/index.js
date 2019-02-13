const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firestore);

exports.deleteUser = functions.firestore
    .document('/deleted_user_list/{userID}')
    .onDelete((snapshot, context) => {
        return admin.auth().deleteUser(snapshot.id)
            .then(() => console.log('Deleted user with ID:' + snapshot.id))
            .catch((error) => console.error('There was an error while deleting user:',error));
    });