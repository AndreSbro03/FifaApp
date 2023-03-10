// ignore_for_file: prefer_const_constructors, camel_case_types

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/Players.dart';
import 'package:flutter_application_2/dati/costants.dart';
import 'isPlayerSelected.dart';

class PlayerCard extends StatelessWidget {
  final Player player;
  final VoidCallback press; //Function dava problemi
  const PlayerCard({
    Key? key,
    required this.player,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              top: kDefaultPadding * 2,
              right: kDefaultPadding * 2,
              left: kDefaultPadding * 2,
            ),
            decoration: BoxDecoration(
              color: Color(player.color.hashCode),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Image.asset(
                    //player.image,
                    'assets/images/foto.png'),
                Padding(
                  padding: const EdgeInsets.only(
                      top: kDefaultPadding / 2, bottom: kDefaultPadding / 4),
                  child: Text(
                    player.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: getHeight(context) /
                            (20 * log((player.name).length + 1))),
                  ),
                ),
                isPlayerSelected(
                  //chiamarlo ogni volta con l'id del giocatore corrente
                  id: player.id,                  
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
