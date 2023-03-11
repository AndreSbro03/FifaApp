// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/Teams.dart';
import 'package:flutter_application_2/dati/functions.dart';
import 'package:flutter_application_2/dati/costants.dart';
import 'package:flutter_application_2/dati/globals.dart';
import 'package:flutter_application_2/dati/saveMatches.dart';
import 'package:flutter_application_2/screens/reSorted.dart';
import 'dart:math';
import 'package:flutter_application_2/screens/winScreen.dart';
import 'package:flutter_application_2/widget/app_bar.dart';
import 'package:flutter_application_2/widget/tRender/players_matchcard.dart';
import 'package:flutter_application_2/widget/tRender/squad_p_matchcard.dart';

class tournament_render extends StatefulWidget {
  bool singlePlayer;
  bool? reLoad;
  List<dynamic> matches;
  List<int>? results_;
  tournament_render(
      {Key? key,
      required this.singlePlayer,
      required this.matches,
      required this.results_,
      this.reLoad})
      : super(key: key);

  @override
  State<tournament_render> createState() => _tournament_renderState();
}

class _tournament_renderState extends State<tournament_render> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List matches = widget.matches;
    bool singlePlayer = widget.singlePlayer;
    bool reLoad = widget.reLoad ?? false;
    List<int>? results = widget.results_;

    //Creazione o aggiornamento torneo
    if (!reLoad) {
      List winners = [];
      if (matches.isEmpty) {
        activePlayer.shuffle(Random());
        activeTeams.shuffle(Random());
        matches = createMatches(singlePlayer);
        if (sortTeams) {
          associateTeam(matches, singlePlayer);
        }
      } else {
        winners = getWinners(matches, results!);
        if (reSort) {
          winners.shuffle(Random());
        }
        matches = updateMatches(singlePlayer, winners, results);
        print("Results are: " + results.toString());
      }
    }

    Matches.instance.saveData(singlePlayer, matches);
    print("Courrent active teams: " + activeTeams.toString());

    var draw = 0;
    results = List.filled(matches.length, draw);
    print("Results are: " + results.toString());

    List losers = [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: app_bar(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Avanti"),
        icon: Icon(Icons.arrow_forward),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          if (matches.length == 1 && results!.length == 1) {
            dynamic win = tournamentWinner(matches, results);
            makeRoutePage(
                context: context,
                pageRef: WinPage(win: win, singlePlayer: singlePlayer));
          } else {
            //Controllo se un ripescato ha passato il turno per definirne l'identità
            if (checkForRipescati(matches, singlePlayer, results)) {
              losers = getEliminatedPlayer(matches, results);

              makeRoutePage(
                  context: context,
                  pageRef: subRipescato(
                    matches: matches,
                    eliminated: losers,
                    singlePlayer: singlePlayer,
                    results: results!,
                  ));
            } else {
              makeRoutePage(
                  context: context,
                  pageRef: tournament_render(
                    singlePlayer: singlePlayer,
                    matches: matches,
                    results_: results,
                  ));
            }
          }
        },
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: matches.length,
        itemBuilder: (BuildContext context, int index) {
          if (singlePlayer) {
            return matchesRow(
              index: index,
              matches: matches,
              results: results!,
            );
          } else {
            return squadMatchesRow(
              index: index,
              matches: matches,
              results: results!,
            );
          }
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
