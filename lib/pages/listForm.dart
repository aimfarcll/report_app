import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:report_app/auth/auth_page.dart';
import 'package:report_app/auth/main_page.dart';
import 'package:report_app/main.dart';
import 'package:report_app/pages/dashboard_page.dart';
import 'package:report_app/pages/home_page.dart';
import 'package:report_app/pages/settingsUi.dart';
import 'package:report_app/sign/signature_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:report_app/forms/form_page.dart';

class UserForms extends StatefulWidget {
  const UserForms({Key? key}) : super(key: key);

  @override
  State<UserForms> createState() => _UserFormsState();
}

class _UserFormsState extends State<UserForms> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
       Text('Forms'),
          IconButton(onPressed: () {}, icon: Icon(Icons.expand_circle_down))
        ],
      ),
      leading: IconButton(
        onPressed: () {
          //drawer: Drawer(backgroundColor: Colors.indigo[900]);
        },
        icon: Icon(Icons.search_outlined)
        , ),
     actions: <Widget>[
        /*IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => FormPage()));


          },
        ),*/
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));

          },
        ),
  ],
      backgroundColor: Colors.indigo[900],
      elevation: 50.0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    body:
        Column(
          children: [
    Container(
      padding: EdgeInsets.fromLTRB(20,10,10,5),
    child: Align(
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          Text('All forms'),
          IconButton(onPressed: () {}, icon: Icon(Icons.navigate_next))
        ],
      ),),),
    Expanded(
      child: Container(

      child: StreamBuilder<List<UserData>>(
      stream: readUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong ${snapshot.error}');
  }
        else if(snapshot.hasData) {
          final users = snapshot.data!;

          return ListView(
  children: users.map(buildUser).toList(),
  ); }
          else {
            return Center(child: CircularProgressIndicator());
  }
      }
    ),

  ),
    ),
            Expanded(
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 50,
                      child: TextButton(
                         onPressed: () {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => FormPage()));
  },
  style: ElevatedButton.styleFrom(
    primary: Colors.deepOrange,
  shape: CircleBorder(),
  padding: EdgeInsets.only()),
  child: Icon(Icons.add, color: Colors.white,),


                      ),
                    ),),),
          ]),


  );

  Widget buildUser(UserData user) => ListTile(
  leading: CircleAvatar(child: IconButton(onPressed: (){}, icon: Icon(Icons.event_note_outlined)
    ,)),
  title: Text(user.name),
  subtitle: Text(user.date.toIso8601String()),
  );

  Stream<List<UserData>> readUsers() => FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => UserData.fromJson(doc.data())).toList());

}
