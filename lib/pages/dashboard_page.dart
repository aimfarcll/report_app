import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class myForm extends StatefulWidget {
  const myForm({Key? key}) : super(key: key);

  @override
  State<myForm> createState() => _myFormState();
}

class _myFormState extends State<myForm> {
  @override

  CollectionReference _referencemyForms = FirebaseFirestore.instance.collection('myForms');
  late Stream <QuerySnapshot>_streammyForms;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streammyForms= _referencemyForms.snapshots();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: Drawer(backgroundColor: Colors.indigo[900]),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Forms'),
        leading: IconButton(
            onPressed: () {
              //drawer: Drawer(backgroundColor: Colors.indigo[900]);
            },
          icon: Icon(Icons.search_outlined)
        , ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.indigo[900],
        elevation: 50.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _streammyForms,
        builder: (BuildContext context, AsyncSnapshot snapshot){

          if(snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if(snapshot.connectionState==ConnectionState.active)
            {
              QuerySnapshot querySnapshot = snapshot.data;
            }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
    debugShowCheckedModeBanner:
    false;
  }
}
