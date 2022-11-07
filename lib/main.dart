import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:report_app/forms/form_page.dart';
import 'package:report_app/pages/dashboard_page.dart';
import 'package:report_app/pages/login-page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:report_app/auth/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: FormPage(),
    );
  }
}
