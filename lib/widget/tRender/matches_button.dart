// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/costants.dart';

class resultButton extends StatefulWidget {
  final int index;
  final dynamic icon;
  final List<int> results;
  const resultButton({
    Key? key,
    required this.index,
    this.icon,
    required this.results,
  }) : super(key: key);

  @override
  State<resultButton> createState() => _resultButtonState();
}

class _resultButtonState extends State<resultButton> {
  // ignore: prefer_final_fields
  dynamic _icon = Icons.code_sharp;

  void changeResult(index, icon) {
    //prendo il risultato della partita per cambiarlo
    int result = widget.results[index];

    if (result == 0) {
      result = 1;
    } else if (result == 1) {
      result = 2;
    } else if (result == 2) {
      result = 0;
    }

    //reinserisco il risultato della partita
    widget.results[index] = result;

    //cambio l'icona del bottone in base al risultato
    switch (result) {
      case 0:
        icon = Icons.code_sharp;
        break;
      case 1:
        icon = Icons.arrow_back_ios;
        break;
      case 2:
        icon = Icons.arrow_forward_ios;
        break;
    }

    setState(() {
      //avviso l'app che deve ricaricare le parti con questa variabile
      _icon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    var index = widget.index;
    //var _icon = widget.icon;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kPrimaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 4,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: IconButton(
          onPressed: () {
            changeResult(index, _icon);
          },
          icon: Icon(
            _icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
