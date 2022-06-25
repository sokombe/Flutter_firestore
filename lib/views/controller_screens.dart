
import 'package:flutter/material.dart';
import 'package:my_firestore_flutter_app/views/add_users.dart';
import 'package:my_firestore_flutter_app/views/all_users.dart';

// ignore: use_key_in_widget_constructors
class ControllerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
return DefaultTabController(length: 3, child: 
Scaffold(
  appBar: AppBar(
    title: Text("Gestion des utilisateurs"),
    bottom: TabBar(tabs: [
      Tab(
        icon: Icon(Icons.edit_attributes,size: 28,),
        text: "Add",
      ),
        Tab(
        icon: Icon(Icons.supervised_user_circle_sharp,size: 28,),
        text: "Users",
      ),
        Tab(
        icon: Icon(Icons.search,size: 28,),
        text: "Search",
      ),

    ]),
  ),
body: TabBarView(children: [
      Center(
child: AddUser()

      ),
            Center(
child: AllUsers(),

      ),
            Center(
child: Text("C"),

      )

]),
)
);

  }
}