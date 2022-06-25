import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_firestore_flutter_app/views/controller_screens.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: ControllerPage(),
      theme: ThemeData(
        primarySwatch: Colors.pink
      ),
    )
  );
}

