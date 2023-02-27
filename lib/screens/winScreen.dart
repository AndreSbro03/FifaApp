// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/Players.dart';
import 'package:flutter_application_2/dati/costants.dart';
import 'package:flutter_application_2/dati/functions.dart';
import 'package:flutter_application_2/dati/globals.dart';
import 'package:flutter_application_2/dati/saveMatches.dart';
import 'package:flutter_application_2/db/players_database.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/widget/app_bar.dart';
import 'package:particles_flutter/particles_flutter.dart';

class WinPage extends StatefulWidget {
  dynamic win;
  bool singlePlayer;
  WinPage({Key? key, required this.win, required this.singlePlayer})
      : super(key: key);

  @override
  State<WinPage> createState() => _WinPageState();
}

class _WinPageState extends State<WinPage> {
  Player? winner1;
  Player? winner2;

  int dBox = 0;

  PlayersDatabase pb = PlayersDatabase.instance;

  @override
  void initState() {
    super.initState();
    getWinner().then((value) {
      //update Ui after getting data
      setState(() {});
    });
  }

  Future getWinner() async {
    winner1 = widget.singlePlayer
        ? await pb.readPlayer(widget.win)
        : await pb.readPlayer(widget.win[0]);
    winner2 = widget.singlePlayer ? null : await pb.readPlayer(widget.win[1]);
  }

  @override
  Widget build(BuildContext context) {
    print(activeTeams.toString());
    return Scaffold(
        appBar: app_bar(),
        body: Stack(children: [
          CircularParticle(
            key: UniqueKey(),
            awayRadius: 80,
            numberOfParticles: 200,
            speedOfParticles: 2,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            onTapAnimation: true,
            particleColor: Colors.white.withAlpha(150),
            awayAnimationDuration: Duration(milliseconds: 600),
            maxParticleSize: 8,
            isRandSize: true,
            isRandomColor: true,
            randColorList: [
              Colors.red.withAlpha(210),
              Colors.purple.withAlpha(210),
              Colors.yellow.withAlpha(210),
              Colors.green.withAlpha(210)
            ],
            awayAnimationCurve: Curves.easeInOutBack,
            enableHover: true,
            hoverColor: Colors.white,
            hoverRadius: 90,
            connectDots: false, //not recommended
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: kDefaultPadding * 2,
                  horizontal: kDefaultPadding * 4),
              child: Column(
                children: [
                  Text(
                    "VINCITORE",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: kDefaultPadding * 2,
                      right: kDefaultPadding * 2,
                      left: kDefaultPadding * 2,
                    ),
                    decoration: BoxDecoration(
                      color: winner1?.color ?? Colors.red,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          sortTeams
                              ? 'assets/images/team_' +
                                  activeTeams[0].toString() +
                                  '.png'
                              : 'assets/images/foto.png',
                          width: getHeight(context) / 4.5,
                          height: getHeight(context) / 4.5,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: kDefaultPadding / 2),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding),
                            child: Text(
                              (winner1?.name ?? 'err') +
                                  (widget.singlePlayer
                                      ? ''
                                      : (' e \n' + (winner2?.name ?? 'err'))),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getHeight(context) / 10),
                  TextButton(
                    onPressed: () {
                      Matches.instance.removeData();
                      makeRoutePage(context: context, pageRef: MyApp());
                    },
                    child: Container(
                      height: 40,
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            "Fine Torneo",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: kBackColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]));
  }
}
