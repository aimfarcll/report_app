import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';

class generatePdf extends StatefulWidget {
  const generatePdf({Key? key}) : super(key: key);

  @override
  State<generatePdf> createState() => _generatePdfState();
}

class _generatePdfState extends State<generatePdf> {
  @override
  String _buttonText = "Generate PDF";
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Image.network(
                    "https://media.geeksforgeeks.org/wp-content/uploads/20220112153639/gfglogo-300x152.png"),
              ),
              TextButton(
                child: Text(
                  _buttonText,
                  style: TextStyle(fontSize: 25),
                ),
                onPressed: () async {
                  final date = DateTime.now();

                  final invoice = Invoice(
                  client: Client(
                    name:
                  )
                  )

                },
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    elevation: 2,
                    backgroundColor: Colors.indigo[900]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
