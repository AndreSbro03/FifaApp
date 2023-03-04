// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/Players.dart';
import 'package:flutter_application_2/dati/costants.dart';
import 'package:flutter_application_2/dati/functions.dart';
import 'package:flutter_application_2/dati/globals.dart';
import 'package:flutter_application_2/db/players_database.dart';
import 'package:flutter_application_2/models/text_styles.dart';
import 'package:flutter_application_2/screens/editPlayer.dart';
import 'package:flutter_application_2/screens/teamsList.dart';
import 'package:flutter_application_2/screens/tournament.dart';
import 'package:flutter_application_2/widget/app_bar.dart';
import 'package:flutter_application_2/widget/playerList/player_card.dart';
import 'package:flutter_application_2/widget/playerList/player_detail_page.dart';

class players_list extends StatefulWidget {
  bool singlePlayer;
  players_list({Key? key, required this.singlePlayer}) : super(key: key);

  @override
  State<players_list> createState() => _players_listState();
}

class _players_listState extends State<players_list> {
  late List<Player> players;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    players = await PlayersDatabase.instance.readAllPlayers();
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
            if (activePlayer.length >= 2) {
              makeRoutePage(
                context: context,
                pageRef: sortTeams
                    ? TeamsList(
                        singlePlayer: widget.singlePlayer,
                      )
                    : tournament_render(
                        singlePlayer: widget.singlePlayer,
                        matches: [],
                      ),
              );
            }
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding),
                child: Center(
                  child: Text(
                    "Players",
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: FlatButton(
                onPressed: () async {
                  await Navigator.of(context).push(
                    //AddEditNotePage
                    MaterialPageRoute(
                        builder: (context) => AddEditPlayerPage()),
                  );

                  refreshNotes();
                },
                child: textStyle("ADD PLAYER"),
                color: kPrimaryColor,
                minWidth: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 12,
              ),
            ),
            isLoading
                ? CircularProgressIndicator()
                : players.isEmpty
                    ? Text(
                        'No Players',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        textAlign: TextAlign.center,
                      )
                    : sfondo(),
            //buildPlayers(),sfondo(),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  Widget sfondo() => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: GridView.builder(
              itemCount: players.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: kDefaultPadding,
                crossAxisSpacing: kDefaultPadding,
                childAspectRatio: 0.71,
              ),
              itemBuilder: (context, index) {
                final player = players[index];

                return GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PlayerDetailPage(playerId: player.id!),
                    ));

                    refreshNotes();
                  },
                  child: PlayerCard(player: player, press: () {}),
                  //child: PlayerCardWidget(player: player, index: index),
                );
              }),
        ),
      );
}
