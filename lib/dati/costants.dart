import 'package:flutter/material.dart';

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

const kBackColor = Color(0xFF081c34);
const kPrimaryColor = Color(0xFF1a936f);
const kSecondaryColor = Color(0xFFEF5B5B);
const kThrdColor = Color(0xFFFFE8E1);
const kAltrnColor = Color(0xFFFCDC4D);

const kSelectedGlow = Color(0xFF00FF98);
const kUnSelectedGlow = Color(0xFFED1D24);

const kDefaultPadding = 20.0;

double getHeight(context) {
  double height = MediaQuery.of(context).size.height;
  return height;
}

double getWidth(context) {
  double width = MediaQuery.of(context).size.width;
  return width;
}
