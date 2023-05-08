import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_firestore_flutter_app/Models/users.dart';
import 'package:my_firestore_flutter_app/crud/crud.dart';

class AddUser extends StatelessWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controllerName = TextEditingController();
    final _controllerAge = TextEditingController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          /*    await getonUser('at64mwq7jZqozT4j8lUq').then((value) {
            print(value!.id.toString());
          }); */

          //await getAllUsers();
         // await getAllUsers2();

          getAllUsers().then((value) {
         value.forEach((element) { 
           print(element.age);
         });
          });


        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _controllerName,
                decoration: InputDecoration(
                    labelText: "name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    )),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _controllerAge,
                decoration: InputDecoration(
                    labelText: "age",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
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
//-----------------------------------------------------------------------------------------------------------------
                    final user = Users(
                        name: _controllerName.text,
                        age: int.parse(_controllerAge.text));
                        //*************************************** */
                    addusers(user).then((value) {
                      _controllerAge.text = "";
                      _controllerName.text = "";
                    });

//----------------------------------------------------------------------------------------------------------------
                  },
                  child: Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}
