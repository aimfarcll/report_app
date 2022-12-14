// ignore_for_file: prefer_const_constructors

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:report_app/auth/main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Signed In as: ' + user.email!),
          MaterialButton(onPressed: () {
            FirebaseAuth.instance.signOut();
           Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainPage()));
          }, 
          color: Colors.deepPurple,
          child: Text('Sign Out'),
          ),
        ],
      )),
    );
  }
}
