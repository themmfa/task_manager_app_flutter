import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableButton extends StatelessWidget {
  final Color? color;
  final String? title;
  final VoidCallback? onPress;

  ReusableButton({this.color, this.title, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 200,
          height: 42,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title!,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
