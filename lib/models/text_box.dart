// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/costants.dart';

class TextBox extends StatelessWidget {
  final String text1;
  final VoidCallback press;
  final double varWith;
  final double varHeight;
  bool isSelected;

  //Function dava problemi
  TextBox({
    Key? key,
    required this.text1,
    required this.press,
    required this.varWith,
    required this.varHeight,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: varWith,
            height: varHeight,
            padding: EdgeInsets.only(
              right: kDefaultPadding * 2,
              left: kDefaultPadding * 2,
            ),
            decoration: buttonSelected(isSelected),
            child: Center(
              child: Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: kThrdColor,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 20),
              ),
            ),
          ),
        ));
  }
}

BoxDecoration buttonSelected(bool isSelected) {
  if (isSelected) {
    return BoxDecoration(
      color: kPrimaryColor,
      borderRadius: BorderRadius.circular(16),
      border: Border(
          left: BorderSide(width: 5.0, color: kAltrnColor),
          bottom: BorderSide(width: 5.0, color: kAltrnColor),
          top: BorderSide(width: 5.0, color: kAltrnColor),
          right: BorderSide(width: 5.0, color: kAltrnColor)),
    );
  } else {
    return BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(16),
        border: Border(
            left: BorderSide(width: 5.0, color: kBackColor),
            bottom: BorderSide(width: 5.0, color: kBackColor),
            top: BorderSide(width: 5.0, color: kBackColor),
            right: BorderSide(width: 5.0, color: kBackColor)));
  }
}
