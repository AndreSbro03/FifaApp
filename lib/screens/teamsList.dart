// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/Teams.dart';
import 'package:flutter_application_2/dati/costants.dart';
import 'package:flutter_application_2/dati/functions.dart';
import 'package:flutter_application_2/dati/globals.dart';
import 'package:flutter_application_2/screens/tournament.dart';
import 'package:flutter_application_2/widget/app_bar.dart';
import 'package:flutter_application_2/widget/teamsList/TeamCard.dart';

class TeamsList extends StatefulWidget {
  final bool singlePlayer;
  const TeamsList({Key? key, required this.singlePlayer}) : super(key: key);

  @override
  State<TeamsList> createState() => _TeamsListState();
}

class _TeamsListState extends State<TeamsList> {
  List<Team> teams = [];
  bool isLoading = false;
  int minTeams = activePlayer.length;

  @override
  void initState() {
    super.initState();
    refreshNumTeams();
    refreshNotes();
  }

  void refreshNumTeams() {
    minTeams = activePlayer.length;
    if (!widget.singlePlayer) {
      if ((activePlayer.length % 2) == 1) minTeams++;
      minTeams = minTeams ~/ 2;
    }
    setState(() => minTeams = minTeams - activeTeams.length);
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    teams = teams_t;

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackColor,
        appBar: app_bar(),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Avanti'),
          icon: Icon(Icons.arrow_forward),
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          onPressed: () async {
            if (minTeams == 0) {
              makeRoutePage(
                  context: context,
                  pageRef: tournament_render(
                    singlePlayer: widget.singlePlayer,
                    matches: [],
                  ));
            }
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
              child: Center(
                child: Text(
                  "Teams",
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding),
                child: Center(
                  child: Text(
                    minTeams >= 0
                        ? "Left: " + minTeams.toString()
                        : "Too many teams selected (" +
                            (minTeams.abs()).toString() +
                            ")",
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: (minTeams != 0) ? Colors.red : Colors.white),
                  ),
                ),
              ),
            ),
            /*
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: FlatButton(
                onPressed: () async {},
                child: textStyle("ADD TEAM"),
                color: kPrimaryColor,
                minWidth: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 12,
              ),
            ),*/
            isLoading
                ? CircularProgressIndicator()
                : teams.isEmpty
                    ? Text(
                        'No Teams',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        textAlign: TextAlign.center,
                      )
                    : team_list_card(),
            SizedBox(
              height: 20,
            )
          ],
        ));
  }

  Widget team_list_card() => Expanded(
          child: ListView.separated(
        itemCount: teams.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (context, index) {
          final Team team = teams[index];
          return TeamCard(
              team: team,
              press: () {
                refreshNumTeams();
              });
        },
      ));
}
