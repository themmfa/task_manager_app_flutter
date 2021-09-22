import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management_app_flutter/components/reusable_button.dart';
import 'package:task_management_app_flutter/constants.dart';
import 'package:task_management_app_flutter/screens/all_tasks.dart';
import 'package:task_management_app_flutter/screens/login.dart';

class SignUpPage extends StatefulWidget {
  static const String id = "signup_screen";
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  final myEmailController = TextEditingController();
  final myPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Flexible(
                  child: Icon(
                    FontAwesomeIcons.clock,
                    size: 100,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "SignUp",
                  style: GoogleFonts.poppins(
                    color: Colors.blue,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              controller: myEmailController,
              decoration:
                  kTextFieldDecoration.copyWith(hintText: "Enter your email"),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              controller: myPasswordController,
              decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter your password"),
            ),
            SizedBox(
              height: 24,
            ),
            ReusableButton(
              title: "Register",
              color: Colors.white,
              onPress: () async {
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                    email: myEmailController.text,
                    password: myPasswordController.text,
                  );
                  if (newUser != null) {
                    Navigator.pushNamed(context, LoginPage.id);
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
