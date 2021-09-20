import 'package:flutter/material.dart';
import 'package:task_management_app_flutter/home_page.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AllTasks(),
    );
  }
}
