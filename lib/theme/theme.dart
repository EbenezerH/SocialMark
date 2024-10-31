import 'package:flutter/material.dart';

bool darkMode = false;

Color black = Colors.black;
Color black87 = Colors.black87;

Color white = Colors.white;
Color white70 = Colors.white70;
Color red = Colors.red;
Color green = Colors.green;
Color blue = Colors.blue;
const Color grey = Colors.grey;

Color containerbgColor = const Color.fromARGB(239, 232, 230, 230);
const Color firstColor =  Color(0xfff39200);
const Color secondColor =  Color.fromARGB(255, 255, 205, 129);
const Color thirdColor =  Color.fromARGB(255, 0, 0, 0);
Color textFieldBgColor = white;
Color appBarColor = firstColor;
Color svgSignColor = firstColor;
Color greyWithOpacity5 = const Color.fromARGB(130, 158, 158, 158);
const Color focusedBorderColor = Color.fromARGB(255, 116, 17, 84);
Color whiteTogrey =
    darkMode == false ? Colors.white : const Color.fromARGB(255, 179, 173, 173);
const Color profileIconeBb = Color(0x60000099);



double paddingLeft = 20;
double paddingRight = 20;
double paddingH = paddingLeft + paddingRight;

// Keyboard colors
Color keyboardBackground = const Color(0xfff0f0f0);
Color buttonBackground = const Color(0xfff8f8f8);
Color letterColor = black;
Color signColor = firstColor;

// keyboard var
double theWidth = 0;
double radius = 10;
double borderWidth = 0;
double buttonHeight = (theWidth - 25) / 10;
double buttonWidth = (theWidth - 37.5) / 10;
double buttonWidth_2 = buttonWidth * 1.5;

BoxDecoration decorationButton(buttonBackground) {
  return BoxDecoration(
      color: buttonBackground,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
      ),
      boxShadow: const [
        BoxShadow(
          color: Color(0x50000000),
          spreadRadius: 0,
          blurRadius: 0,
          offset: Offset(0, 1),
        )
      ]);
}
