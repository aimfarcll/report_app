import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:report_app/auth/auth_page.dart';
import 'package:report_app/forms/form_page.dart';
import 'package:report_app/location/map_screen.dart';
import 'package:report_app/pages/adddata.dart';
import 'package:report_app/pages/dashboard_page.dart';
import 'package:report_app/pages/listForm.dart';
import 'package:report_app/pages/login-page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:report_app/auth/main_page.dart';
import 'package:report_app/pages/settingsUi.dart';
import 'package:report_app/sign/signature_page.dart';
import 'package:get/get.dart';
import 'location/location_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_app/pages/home_page.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());
    return GetMaterialApp(
      debugShowCheckedModeBanner:
      false,
        title: 'Flutter Demo', theme: ThemeData(),
      //home: AuthPage(),
      //home: HomePage(),
      //home: MainPage(),
      home: SettingsPage(),
      //home: adddata(),
      // home: LoginPage(showRegisterPage: () {  },)
      // home: SignaturePage(),
     // home: FormPage(),
      //home: UserForms(),
      //home: generatePdf(),
      //home: MapScreen(),
        );
  }
}
