// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/costants.dart';
import 'package:flutter_application_2/dati/globals.dart';

class isPlayerSelected extends StatefulWidget {
  final int? id;
  const isPlayerSelected({Key? key, this.id}) : super(key: key);

  @override
  State<isPlayerSelected> createState() {
    return _isPlayerSelectedState();
  }
}

class _isPlayerSelectedState extends State<isPlayerSelected> {
  bool isSelected = false;

  void _checkPlayer(_id) {
    if (activePlayer.contains(_id)) {
      isSelected = true;
    }
  }

  void toggleCard() {
    //activePlayer deve essere definita il player_list
    if (isSelected == false) {
      activePlayer.add(widget.id);
    } else {
      activePlayer.remove(widget.id);
    }
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    int? _id = widget.id;
    _checkPlayer(_id);
    return FlatButton(
      height: 30,
      onPressed: toggleCard,
      child: Text(
        isSelected ? "Gioca" : "XX",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      color: isSelected ? kPrimaryColor : Colors.red.shade300,
    );
  }
}
