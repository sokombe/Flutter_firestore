import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_firestore_flutter_app/Models/Users.dart';
import 'package:my_firestore_flutter_app/crud/tables_refs.dart';

//------------------------------  Add User ------------------------------------------
Future addusers(Users user) async {
  var key=USERS_TRAINING_REF.doc().id;
  user.id = key;
  await USERS_TRAINING_REF.doc(key).set(user.tojson());
}

//-----------------------------  get one user  -------------------------------------------
Future<Users?> getonUser(keyDoc) async {
  print('OKOKOK');
  final snap = await USERS_TRAINING_REF.doc(keyDoc).get();
  if (snap.exists) {
    return Users.formJson(snap.data()!);
  }
}

//------------------------------ get allUsers  -----------------------------------------

Future<List<Users>> getAllUsers() async {
    try {
      QuerySnapshot snapshot = await USERS_TRAINING_REF.get();
      List<Users> result =  snapshot.docs.map((doc) => Users.formJson(doc.data() as Map<String,dynamic>)).toList();
      return result;
    } catch (error) {
      print(error);
      return [];
    }
  }

//-------------------------- update user  ------------------------------------------

Future updateUser(Users user)async{
await USERS_TRAINING_REF.doc(user.id).update(user.tojson());
}

//----------------------------------------------------------------------------

//-------------------------- update user  ------------------------------------------

Future deleteUser(String key)async{
await USERS_TRAINING_REF.doc(key).delete();
}

//----------------------------------------------------------------------------
