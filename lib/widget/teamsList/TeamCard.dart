// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/Teams.dart';
import 'package:flutter_application_2/dati/costants.dart';
import 'package:flutter_application_2/dati/globals.dart';

class TeamCard extends StatefulWidget {
  final Team team;
  final Function press;
  const TeamCard({
    Key? key,
    required this.team,
    required this.press,
  }) : super(key: key);

  @override
  State<TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  bool isSelected = false;
  Team? _team;
  int err = 0;

  //Ritorna 1 in caso di errore e 0 se è andato tutto bene
  int _checkTeam(_id) {
    if (_id == null) {
      return 1;
    }
    if (activeTeams.contains(_id)) {
      isSelected = true;
    }
    return 0;
  }

  void toggleCard() {
    //activePlayer deve essere definita il player_list
    if (isSelected == false) {
      activeTeams.add(_team?.id ?? 0);
    } else {
      activeTeams.remove(_team?.id ?? 0);
    }
    setState(() {
      isSelected = !isSelected;
    });

    widget.press();
  }

  @override
  Widget build(BuildContext context) {
    _team = widget.team;
    err = _checkTeam(_team?.id);
    return GestureDetector(
      onTap: toggleCard,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          decoration: BoxDecoration(
              color: kBackColor,
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? kSelectedGlow.withOpacity(0.5)
                      : kUnSelectedGlow.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
              border: Border.all(
                color: isSelected ? kSelectedGlow : kUnSelectedGlow,
                width: 4,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/team_' + _team!.id.toString() + '.png',
                width: 80,
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Text(
                  _team?.name ?? 'Err',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              //Expanded(child: Container()),
              SizedBox(height: getHeight(context) / 20),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  isSelected ? Icons.done : Icons.close_outlined,
                  size: 50,
                  color: isSelected ? kSelectedGlow : kUnSelectedGlow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
