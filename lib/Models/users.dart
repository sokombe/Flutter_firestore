

import 'package:flutter/cupertino.dart';

class Users{
  String? id;
  String? name;
  int? age;


  Users({this.id='',@required this.name,@required  this.age  });


//-------------------------------------convert to json-----------------------------------------------------------
  Map<String,dynamic> tojson(){
    return {
        'id': id,
        'name': name,
        'age':age

    };
  }
  //--------------------------------------------------------------------------------------------------------------- 


 factory Users.formJson(Map<String,dynamic> json){
  return Users(id: json["id"], name: json["name"], age: json['age']);
}

}