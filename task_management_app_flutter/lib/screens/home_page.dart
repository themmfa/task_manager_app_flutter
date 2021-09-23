import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management_app_flutter/components/reusable_button.dart';
import 'package:task_management_app_flutter/screens/login.dart';
import 'package:task_management_app_flutter/screens/singup.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  child: Icon(
                    FontAwesomeIcons.clock,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Task Manager",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48,
            ),
            ReusableButton(
              color: Colors.white,
              title: "Sign Up",
              onPress: () {
                Navigator.pushNamed(context, SignUpPage.id);
              },
            ),
            SizedBox(
              height: 10,
            ),
            ReusableButton(
              color: Colors.white,
              title: "Login",
              onPress: () {
                setState(() {
                  Navigator.pushNamed(context, LoginPage.id);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
