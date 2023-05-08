import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_firestore_flutter_app/Models/users.dart';
import 'package:my_firestore_flutter_app/crud/tables_refs.dart';
import 'package:my_firestore_flutter_app/views/all_users.dart';

//------------------------------  Add User ------------------------------------------
Future addusers(Users user) async {
  var key = Collection_table_user.doc().id;
  user.id = key;
  await Collection_table_user.doc(key).set(user.tojson());
}

//-----------------------------  get one user  -------------------------------------------
Future<Users?> getonUser(keyDoc) async {
  print('OKOKOK');
  final snap = await Collection_table_user.doc(keyDoc).get();
  if (snap.exists) {
    return Users.formJson(snap.data()!);
  }
}

//------------------------------ get allUsers  -----------------------------------------

Future<List<Users>> getAllUsers() async {
  try {
    QuerySnapshot snapshot = await Collection_table_user.get();
    List<Users> result = snapshot.docs
        .map((doc) => Users.formJson(doc.data() as Map<String, dynamic>))
        .toList();
    return result;
  } catch (error) {
    print(error);
    return [];
  }
}

//-------------------------- update user  ------------------------------------------

Future updateUser(Users user) async {
  await Collection_table_user.doc(user.id).update(user.tojson());
}

//----------------------------------------------------------------------------

//-------------------------- update user  ------------------------------------------

Future deleteUser(String key) async {
  await Collection_table_user.doc(key).delete();
}

//----------------------------------------------------------------------------
List<Users> allusers = [];
creatAListener() {
  Collection_table_user.snapshots().listen((querySnapshot) {
    querySnapshot.docChanges.forEach((change) {
      // Do something with change
      if (change.type == DocumentChangeType.added) {
        allusers.add(Users.formJson(change.doc.data() as Map<String, dynamic>));
      }
      if (change.type == DocumentChangeType.modified) {
        var modifiedDoc =
            Users.formJson(change.doc.data() as Map<String, dynamic>);
        //******* */
        var oldIndex =
            allusers.indexWhere((element) => element.id == modifiedDoc.id);
        //
        allusers.removeWhere((element) => element.id == modifiedDoc.id);
        //
        allusers.insert(oldIndex, modifiedDoc);
      }
      if (change.type == DocumentChangeType.removed) {
        var modifiedDoc =
            Users.formJson(change.doc.data() as Map<String, dynamic>);
        //******* */
        var oldIndex =
            allusers.indexWhere((element) => element.id == modifiedDoc.id);
        //
        allusers.removeAt(oldIndex);
      }
    });
  });
}
