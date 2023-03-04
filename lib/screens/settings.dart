import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/costants.dart';
import 'package:flutter_application_2/dati/globals.dart';
import 'package:flutter_application_2/models/text_box.dart';
import 'package:flutter_application_2/screens/playersList.dart';
import 'package:flutter_application_2/models/settings_view.dart';
import 'package:flutter_application_2/widget/app_bar.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool singlePlayer = true;

  void gmSingle() {
    setState(() {
      singlePlayer = true;
    });
  }

  void gmSquad() {
    setState(() {
      singlePlayer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackColor,
      appBar: const app_bar(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Avanti"),
        icon: const Icon(Icons.arrow_forward),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => players_list(
                      singlePlayer: singlePlayer,
                    )),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding),
                child: Center(
                  child: Text(
                    "Settings",
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              )),
          Row(
            children: [
              Expanded(
                child: TextBox(
                  text1: "Single",
                  isSelected: singlePlayer,
                  press: () {
                    gmSingle();
                  },
                  varWith: MediaQuery.of(context).size.width / 2.5,
                  varHeight: MediaQuery.of(context).size.height / 8,
                ),
              ),
              Expanded(
                child: TextBox(
                  text1: "Squad",
                  isSelected: !singlePlayer,
                  press: () {
                    gmSquad();
                  },
                  varWith: MediaQuery.of(context).size.width / 2.5,
                  varHeight: MediaQuery.of(context).size.height / 8,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Text(
                "AVANZATE",
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingsView(
                      text1: "Ripescaggio",
                      selected: ripescaggio,
                      changeGlobals: () {
                        ripescaggio = !ripescaggio;
                        return ripescaggio;
                      },
                    ),
                    SettingsView(
                      text1: "Estrazione Club",
                      selected: sortTeams,
                      changeGlobals: () {
                        sortTeams = !sortTeams;
                        return sortTeams;
                      },
                    ),
                    SettingsView(
                      text1: "Risorteggia Incontri",
                      selected: reSort,
                      changeGlobals: () {
                        reSort = !reSort;
                        return reSort;
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
