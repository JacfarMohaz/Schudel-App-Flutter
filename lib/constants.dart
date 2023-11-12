import 'package:flutter/material.dart';

const kCardColor = Color(0xff3982D7);
const kPinkColor = Color.fromARGB(255, 216, 50, 122);
const kYelowColor = Color.fromARGB(255, 157, 181, 22);
const kPrimaryColor = Color(0xff90B7FC);
const kSidebarColor = Color(0xff6487C5);

TextStyle get subHeadingStyle {
  return TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white70);
}

TextStyle get HeadingStyle {
  return TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white70);
}

TextStyle get titleStyle {
  return TextStyle(
      fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black);
}

TextStyle get subTitleStyle {
  return TextStyle(
      fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black54);
}
