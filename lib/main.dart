// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/homePage.dart';
import 'dati/globals.dart' as globals;

void main() {
  runApp(const MyApp());
  globals.activePlayer;
  globals.activeTeams;
  globals.results;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FIFA APP',
        home: Scaffold(body: HomePage()));
  }
}
