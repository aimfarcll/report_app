import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:report_app/sign/sign_prev_page.dart';
import 'package:signature/signature.dart';

class SignaturePage extends StatefulWidget {
  
  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  SignatureController controller;

@override
  void initState() {
    super.initState();

    controller = SignatureController(
      //put pen colour
      penColor: Colors.black,
      penStrokeWidth: 5,
    );
  }

  @override
  //free controller to clear up when not in used
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: <Widget>[
            Signature(
              controller: controller,
              backgroundColor: Colors.white,
            ),
            buildButtons(context),
          ],
        ),
      );

  Widget buildButtons(BuildContext context) => Container(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildCheck(context),
            buildClear(),
          ],
        ),
      );

  Widget buildCheck(BuildContext context) => IconButton(
        iconSize: 36,
        icon: Icon(Icons.check, color: Colors.green),
        //when clicked, call controller to export image, store to local storage
        onPressed: () async {
          if (controller.isNotEmpty) {
            //! empty, export
            final signature = await exportSignature();

            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SignaturePreviewPage(signature: signature),
            ));

            //clear signature
            controller.clear();
          }
        },
      );

//clear button
  Widget buildClear() => IconButton(
        iconSize: 36,
        icon: Icon(Icons.clear, color: Colors.red),
        //when clicked, call controller to clear digi pad
        onPressed: () => controller.clear(),
      );

  Future<Uint8List> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      //image saved in the gallery properties
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
      //plg penting!! get the signature by getting points of the signature
      points: controller.points,
    );

    //export method
    final signature = await exportController.toPngBytes();
    exportController.dispose();
    return signature; 

  }
}
