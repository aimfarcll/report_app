import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:report_app/forms/form_page.dart';
import 'package:report_app/pages/home_page.dart';
import 'package:report_app/pages/listForm.dart';
import 'package:report_app/pages/login-page.dart';
import 'auth_page.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

//to check for any authstatechanges which happens when we try to sign in
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return UserForms();
        } else {
          return AuthPage();
        }
      },
    ));
  }
}
