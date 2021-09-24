import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app_flutter/screens/all_tasks.dart';

import 'package:task_management_app_flutter/screens/home_page.dart';
import 'package:task_management_app_flutter/screens/login.dart';
import 'package:task_management_app_flutter/screens/singup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        SignUpPage.id: (context) => SignUpPage(),
        LoginPage.id: (context) => LoginPage(),
        AllTasks.id: (context) => AllTasks(),
      },
    ),
  );
}
