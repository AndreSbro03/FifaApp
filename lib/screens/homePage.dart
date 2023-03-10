// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/costants.dart';
import 'package:flutter_application_2/dati/functions.dart';
import 'package:flutter_application_2/dati/saveMatches.dart';
import 'package:flutter_application_2/screens/settings.dart';
import 'package:flutter_application_2/screens/tournament.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Text("TOURNAMENT",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            SizedBox(
              height: getHeight(context) / 20,
            ),
            SizedBox(
              width: getWidth(context) / 1.25,
              child: Text(
                "Premi sul bottone per iniziare un nuovo torneo",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: getHeight(context) / 20,
            ),
            Center(
              child: Container(
                //Cerchio esterno
                //padding: EdgeInsets.all(10),
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kPrimaryColor,
                    width: 15,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimaryColor.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 5,
                      //offset: Offset(0, 3), // changes position of shadow
                    )
                  ],
                ),
                child: DecoratedBox(
                  //Icona
                  child: IconButton(
                    icon: Icon(
                      Icons.sports_soccer_sharp,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      makeRoutePage(context: context, pageRef: Settings());
                    },
                    color: Colors.black,
                    iconSize: 150,
                  ),
                  decoration: BoxDecoration(
                    //Cerchio interno
                    color: kSecondaryColor,
                    shape: BoxShape.circle,
                    /* boxShadow: [
                      BoxShadow(
                        color: kSecondaryColor.withOpacity(0.5),
                        spreadRadius: 4,
                        blurRadius: 5,
                        //offset: Offset(0, 3), // changes position of shadow
                      )
                    ],*/
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: getHeight(context) / 20),
              child: SizedBox(
                height: 0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: getHeight(context) / 24),
              child: IconButton(
                onPressed: () async {
                  List? matchesData = (await Matches.instance.readData());
                  if (matchesData != null) {
                    List matches = matchesData[1];
                    print('HomePage: ' + matches.toString());
                    bool? singlePlayer = (await Matches.instance.readData())[0];
                    makeRoutePage(
                        context: context,
                        pageRef: tournament_render(
                          singlePlayer: singlePlayer ?? true,
                          matches: matches,
                          results_: null,
                          reLoad: true,
                        ));
                  }
                },
                icon: Icon(Icons.history),
                iconSize: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: getHeight(context) / 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text("SBRO",
                  style: TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
            )
          ],
        ),
      ),
    );
  }
}
