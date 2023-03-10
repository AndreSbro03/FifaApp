// ignore_for_file: prefer_const_constructors, camel_case_types

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/Players.dart';
import 'package:flutter_application_2/dati/costants.dart';
import 'package:flutter_application_2/dati/globals.dart';
import 'package:flutter_application_2/db/players_database.dart';
import 'matches_button.dart';
import 'ripescato_card.dart';

class matchesRow extends StatefulWidget {
  final List matches;
  final List<int> results;
  final int index;
  matchesRow({
    Key? key,
    required this.index,
    required this.matches,
    required this.results,
  }) : super(key: key);

  @override
  State<matchesRow> createState() => _matchesRowState();
}

class _matchesRowState extends State<matchesRow> {
  Player? gP1;
  Player? gP2;
  bool ripescato = false;
  PlayersDatabase pb = PlayersDatabase.instance;

  int team1Id = 1;
  int team2Id = 1;

  @override
  void initState() {
    super.initState();
    getPlayers().then((value) {
      //update Ui after getting data
      getTeams();
      setState(() {});
    });
  }

  Future getPlayers() async {
    List<dynamic> duel = widget.matches[widget.index];
    gP1 = await pb.readPlayer(duel[0]);
    gP2 = await pb.readPlayer(duel[0]);
    if (duel[1] == "R") {
      ripescato = true;
    } else {
      gP2 = await pb.readPlayer(duel[1]);
    }
  }

  ///Questa funzione recupera a partire da l'idex del match le squadre
  ///ad esso associate, le variabili team1Id e team2Id sono inizializzate
  ///a 1 perchè è necessario dargli un valore porvvisorio poichè questa funzione
  ///necessita di ripescato per funzionare, che però è un una funzione future.
  void getTeams() {
    if (sortTeams) {
      print("Ripescato " + ripescato.toString());
      team1Id = activeTeams[(widget.index * 2)];
      if (ripescato == false) {
        team2Id = activeTeams[(widget.index * 2) + 1];
      }
    }
  }

  @override
  Container build(BuildContext context) {
    getPlayers();
    var icon = Icons.code_sharp;
    return Container(
      height: 100,
      color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(
                    right: kDefaultPadding,
                    left: kDefaultPadding,
                  ),
                  decoration: BoxDecoration(
                    color: gP1?.color ?? Colors.red,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: kDefaultPadding),
                      child: Row(children: [
                        Image.asset(
                          sortTeams
                              ? 'assets/images/team_' +
                                  team1Id.toString() +
                                  '.png'
                              : 'assets/images/foto.png',
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: kDefaultPadding / 2),
                          child: Text(
                            gP1?.name ?? 'err',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: getHeight(context) /
                                    (25 *
                                        log((gP1?.name ?? 'err').length + 1))),
                          ),
                        ),
                      ]))),
            ),
            resultButton(
              index: widget.index,
              icon: icon,
              results: widget.results,
            ),
            secondCard(ripescato, gP2, team2Id)
          ],
        ),
      ),
    );
  }
}

secondCard(ripescato, gP2, team2Id) {
  if (ripescato) {
    return ripescatoCard();
  } else {
    return p2card(gP2: gP2, team2Id: team2Id, ripescato: ripescato);
  }
}

class p2card extends StatelessWidget {
  Player? gP2;
  int team2Id;
  bool ripescato;
  p2card(
      {Key? key,
      required this.gP2,
      required this.team2Id,
      required this.ripescato})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          right: kDefaultPadding,
          left: kDefaultPadding,
        ),
        decoration: BoxDecoration(
          color: gP2?.color ?? Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
          child: Row(
            children: [
              Image.asset(
                ripescato
                    ? 'assets/images/foto.png'
                    : (sortTeams
                        ? 'assets/images/team_' + team2Id.toString() + '.png'
                        : 'assets/images/foto.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding / 2),
                child: Text(
                  gP2?.name ?? 'err',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: getHeight(context) /
                          (25 * log((gP2?.name ?? 'err').length + 1))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
