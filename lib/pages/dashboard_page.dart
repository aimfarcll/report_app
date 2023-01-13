import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class myForm extends StatelessWidget {
  myForm({Key? key}) : super(key: key) {
    _streammyForms = _referencemyForms.snapshots();
  }


  CollectionReference _referencemyForms = FirebaseFirestore.instance.collection('users');
  late Stream <QuerySnapshot> _streammyForms;


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
            icon: Icon(Icons.add),
            onPressed: () {


            },
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
              List<QueryDocumentSnapshot> documents = querySnapshot.docs;

              //Convert the documents to Maps
              List<Map> items = documents.map((e) =>
              {
                'name': e['name'],
                'address': e['address']
              }).toList();

            return ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
            //Get the item at this index
            Map thisItem = items[index];
            //REturn the widget for the list items
            return ListTile(
            title: Text('${thisItem['name']}'),
            subtitle: Text('${thisItem['address']}'),

            );
            });
            }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
    debugShowCheckedModeBanner:
    false;
  }
}
