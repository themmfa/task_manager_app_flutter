import 'package:flutter/material.dart';
import 'package:task_management_app_flutter/screens/all_tasks.dart';
import 'package:task_management_app_flutter/screens/home_page.dart';
import 'package:task_management_app_flutter/screens/login.dart';
import 'package:task_management_app_flutter/screens/singup.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: HomePage.id,
    routes: {
      HomePage.id: (context) => HomePage(),
      SignUpPage.id: (context) => SignUpPage(),
      LoginPage.id: (context) => LoginPage(),
    },
  ));
}
