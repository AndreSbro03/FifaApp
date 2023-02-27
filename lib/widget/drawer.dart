// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/costants.dart';

class drawer extends StatelessWidget {
  const drawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        child: Column(children: [
          Text(
            "Tornei di Fifa",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          SizedBox(height: kDefaultPadding),
          Container(
            height: 50,
            color: Colors.grey.shade300,
            child: const Center(child: Text('Opzione 1')),
          ),
          Container(
            height: 50,
            color: Colors.grey.shade200,
            child: const Center(child: Text('Opzione 2')),
          ),
          Container(
            height: 50,
            color: Colors.grey.shade300,
            child: const Center(child: Text('Opzione 3')),
          ),
          Expanded(
            child: SizedBox(),
          ),
          Text(
            "Sbro",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          )
        ]),
      ),
    );
  }
}
