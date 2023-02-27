// ignore_for_file: deprecated_member_use, prefer_const_constructors
// Creazione gestore carte di credito

import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/costants.dart';
import 'package:flutter_application_2/dati/globals.dart';

class SettingsView extends StatefulWidget {
  SettingsView(
      {required this.text1,
      required this.selected,
      required this.changeGlobals});
  final String text1;
  final bool selected;
  final Function() changeGlobals;

  @override
  State<SettingsView> createState() {
    return _SettingsViewState(selected);
  }
}

class _SettingsViewState extends State<SettingsView> {
  bool active = false;

  _SettingsViewState(bool selected) {
    active = selected;
  }

  void toggleCard() {
    setState(() {
      //notifica al framework il cambio di stato
      active = widget.changeGlobals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        height: 60,
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.settings_applications, size: 14),
            SizedBox(width: 16), //Componente fittizio
            Text(widget.text1, style: TextStyle(fontWeight: FontWeight.bold)),
            //Elemento che riempie più spazio possibile
            Expanded(child: Container()),
            FlatButton(
              onPressed: toggleCard,
              child: Text(!active ? "No" : "Si"),
              color: !active ? kSecondaryColor : Colors.green.shade300,
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: !active ? Colors.grey.shade400 : kThrdColor,
        ),
      ),
    );
  }
}
