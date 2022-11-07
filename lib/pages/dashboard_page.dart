import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class myForm extends StatefulWidget {
  const myForm({Key? key}) : super(key: key);

  @override
  State<myForm> createState() => _myFormState();
}

class _myFormState extends State<myForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(backgroundColor: Colors.indigo[900]),
      appBar: AppBar(
        title: Center(child: Text('Work Order Form')),
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
      
    );
    debugShowCheckedModeBanner:
    false;
  }
}
