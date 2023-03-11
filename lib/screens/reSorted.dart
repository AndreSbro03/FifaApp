// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/Players.dart';
import 'package:flutter_application_2/dati/costants.dart';
import 'package:flutter_application_2/dati/functions.dart';
import 'package:flutter_application_2/dati/globals.dart';
import 'package:flutter_application_2/db/players_database.dart';
import 'package:flutter_application_2/models/text_styles.dart';
import 'package:flutter_application_2/screens/tournament.dart';
import 'package:flutter_application_2/widget/app_bar.dart';

class subRipescato extends StatelessWidget {
  bool singlePlayer;
  List<dynamic> matches;
  List eliminated;
  List<int> results;
  subRipescato({
    Key? key,
    required this.singlePlayer,
    required this.matches,
    required this.eliminated,
    required this.results,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///La funzione per come l'avevo inizialmente pensata andava a modificare la variabile
    ///dei matches che le veniva passata in input, quindi se poi si voleva tornare indietro
    ///più avanti nel torneo, l'applicazione non trovava un ripescato da sustituire perchè
    ///nella variabile era già stato sostituito. Facendo una copia della variabile e poi
    ///andando a lavorare su questa si evita questo problema, lasciando intatta la variabile iniziale.
    List<dynamic> copyMatches = matches.map((e) => e.toList()).toList();
    return Scaffold(
      backgroundColor: kBackColor,
      appBar: app_bar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding),
              child: Center(
                child: Text(
                  "Chi deve essere ripescato?",
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.bold, color: kThrdColor),
                ),
              ),
            ),
            Container(
              height: getHeight(context) / 1.4,
              width: getWidth(context) / 1.2,
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: eliminated.length,
                itemBuilder: (BuildContext context, int index) {
                  if (singlePlayer) {
                    return localRipescatoCard(
                        eliminated: eliminated,
                        index: index,
                        press: () async {
                          int i = matches.length - 1;
                          copyMatches[i][1] = eliminated[index];
                          makeRoutePage(
                              context: context,
                              pageRef: tournament_render(
                                singlePlayer: singlePlayer,
                                matches: copyMatches,
                                results_: results,
                              ));
                        });
                  } else {
                    return localRipescatoCardMatches(
                        eliminated: eliminated,
                        index: index,
                        press: () {
                          int i = matches.length - 1;
                          copyMatches[i][1] = eliminated[index];
                          makeRoutePage(
                              context: context,
                              pageRef: tournament_render(
                                singlePlayer: singlePlayer,
                                matches: copyMatches,
                                results_: results,
                              ));
                        });
                  }
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//La carta dei giocatori

class localRipescatoCard extends StatefulWidget {
  List eliminated;
  int index;
  final VoidCallback press;
  localRipescatoCard(
      {Key? key,
      required this.eliminated,
      required this.index,
      required this.press})
      : super(key: key);

  @override
  State<localRipescatoCard> createState() => _localRipescatoCardState();
}

class _localRipescatoCardState extends State<localRipescatoCard> {
  Player? correntPlayer;
  PlayersDatabase pb = PlayersDatabase.instance;

  @override
  void initState() {
    super.initState();
    getCorrentPlayer().then((value) {
      //update Ui after getting data
      setState(() {});
    });
  }

  Future getCorrentPlayer() async {
    correntPlayer = await pb.readPlayer(widget.eliminated[widget.index]);
  }

  @override
  Widget build(BuildContext context) {
    getCorrentPlayer();
    return GestureDetector(
      onTap: widget.press,
      child: Container(
          height: getHeight(context) / 10,
          child: Center(child: textStyle(correntPlayer?.name ?? 'err')),
          decoration: BoxDecoration(
              color: correntPlayer?.color ?? Colors.red,
              boxShadow: [
                BoxShadow(
                  color: correntPlayer?.color.withOpacity(0.5) ?? Colors.red,
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ])),
    );
  }
}

class localRipescatoCardMatches extends StatefulWidget {
  List eliminated;
  int index;
  final VoidCallback press;
  localRipescatoCardMatches(
      {Key? key,
      required this.eliminated,
      required this.index,
      required this.press})
      : super(key: key);

  @override
  State<localRipescatoCardMatches> createState() =>
      _localRipescatoCardMatchesState();
}

class _localRipescatoCardMatchesState extends State<localRipescatoCardMatches> {
  Player? correntPlayer1;
  Player? correntPlayer2;

  PlayersDatabase pb = PlayersDatabase.instance;

  @override
  void initState() {
    super.initState();
    getCorrentPlayers().then((value) {
      //update Ui after getting data
      setState(() {});
    });
  }

  Future getCorrentPlayers() async {
    correntPlayer1 = await pb.readPlayer(widget.eliminated[widget.index][0]);
    correntPlayer2 = await pb.readPlayer(widget.eliminated[widget.index][1]);
  }

  @override
  Widget build(BuildContext context) {
    getCorrentPlayers();
    return GestureDetector(
      onTap: widget.press,
      child: Container(
          height: getHeight(context) / 10,
          child: Center(
              child: textStyle((correntPlayer1?.name ?? 'err') +
                  " e \n" +
                  (correntPlayer2?.name ?? 'err'))),
          decoration: BoxDecoration(
              color: correntPlayer1?.color ?? Colors.red,
              boxShadow: [
                BoxShadow(
                  color: correntPlayer1?.color.withOpacity(0.5) ?? Colors.red,
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ])),
    );
  }
}
