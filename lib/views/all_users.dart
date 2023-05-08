import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_firestore_flutter_app/Models/users.dart';
import 'package:my_firestore_flutter_app/crud/crud.dart';
import 'package:my_firestore_flutter_app/crud/tables_refs.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Users> allUser = [];
    final _updateName = TextEditingController();
    final _updateAge = TextEditingController();

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: Collection_table_user.orderBy("name").snapshots(),
          builder: (_, snap) {
            if (snap.hasError) {
              return Center(
                child: Text("Erreur"),
              );
            }
            if (snap.hasData) {
              allUser = snap.data!.docs
                  .map((doc) =>
                      Users.formJson(doc.data() as Map<String, dynamic>))
                  .toList();

              return ListView.builder(
                itemCount: allUser.length,
                itemBuilder: (_, i) {
                  return Card(
                    child: ListTile(
                      title: Text(allUser[i].name.toString()),
                      subtitle: Text(allUser[i].age.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Update user: " +
                                            allUser[i].name.toString()),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              TextField(
                                                controller: _updateName,
                                                decoration: InputDecoration(
                                                    labelText: "name",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  40)),
                                                    )),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: _updateAge,
                                                decoration: InputDecoration(
                                                    labelText: "Age",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  40)),
                                                    )),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    print(allUser[i]
                                                        .id
                                                        .toString());
                                                    //-----------------------------------------------------------------------------------------------------------------
                                                    final user = Users(
                                                        id: allUser[i].id,
                                                        name: _updateName.text,
                                                        age: int.parse(
                                                            _updateAge.text));

                                                    updateUser(user)
                                                        .then((value) {
                                                      _updateAge.text = "";
                                                      _updateName.text = "";
                                                      Navigator.pop(context);
                                                    });

                                                    //----------------------------------------------------------------------------------------------------------------
                                                  },
                                                  child: Text('Save')),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: (() {
                                                Navigator.pop(context);
                                              }),
                                              child: Text("Annuler"))
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 25,
                                color: Colors.blue,
                              )),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Voulez-vous supprimer " +
                                            allUser[i].name.toString()),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: (() async {
                                                await deleteUser(
                                                    allUser[i].id.toString());
                                                Navigator.pop(context);
                                              }),
                                              child: Text("Oui")),
                                          ElevatedButton(
                                              onPressed: (() {
                                                Navigator.pop(context);
                                              }),
                                              child: Text("Non"))
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.delete,
                                size: 25,
                                color: Colors.red,
                              )),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
