// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/costants.dart';

class ripescatoCard extends StatelessWidget {
  const ripescatoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          right: kDefaultPadding,
          left: kDefaultPadding,
        ),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade600,
          
          borderRadius: BorderRadius.circular(16),
        ),
        
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
          child: Center(
            child: Text(
              "Ripescato",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}