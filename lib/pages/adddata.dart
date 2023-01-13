import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class adddata extends StatefulWidget {
  const adddata({Key? key}) : super(key: key);

  @override
  State<adddata> createState() => _adddataState();
}

class _adddataState extends State<adddata> {
  final namecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: TextField(controller: namecontroller,),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              final name = namecontroller.text;
              createUser(
                  name:name);
            }
          )
        ],
      ),
  );
    Future createUser({required String name}) async {
      final docUser =FirebaseFirestore.instance.collection('users').doc();

      final json = {
        'name': name,
        'age': 21,
        'birthday': DateTime(2007,10,8),
      };
      await docUser.set(json);
    }
  }

  class User {
  String id;
  final String name;
  final int age;
  final DateTime birthday;

  User({
    this.id = '',
    required this.name,
    required this.age,
    required this.birthday,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'age': age,
    'birthday' : birthday
  };
  }

