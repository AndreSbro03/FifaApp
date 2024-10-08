import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/globals.dart';

//accoppiamento non smistato per le partite
List updateMatches(singlePlayer, winners, results) {
  List matchesResult = [];
  List<dynamic> _wins = [];
  for (var i = 0; i < results.length; i++) {
    _wins.add(winners[i]);

    if (_wins.length > 1) {
      matchesResult.add(_wins);
      _wins = [];
    }
  }
  if (_wins.length == 1) {
    if (ripescaggio) {
      if (singlePlayer) {
        _wins.add("R");
      } else {
        _wins.add(["R"]);
      }
      matchesResult.add(_wins);
    } else {
      _wins.add(_wins[0]);
      matchesResult.add(_wins);
    }
  }
  print("Matches results: " + matchesResult.toString());
  return matchesResult;
}

List createMatches(singlePlayer, [List? matches]) {
  List matchesResult = [];
  List<dynamic> z = [];
  List<List> duel = [];
  List players = matches ?? activePlayer;
  if (singlePlayer) {
    //Torneo singolo
    for (var id in players) {
      z.add(id);
      if (z.length > 1) {
        duel.add(z);
        z = [];
      }
    }
    if (z.length == 1) {
      if (ripescaggio) {
        z.add("R");
      } else {
        z.add(z[0]);
      }
      duel.add(z);
    }
    matchesResult = duel;
  } else {
    //Torneo doppio
    var _matches = [];

    for (var id in players) {
      z.add(id);
      if (z.length > 1) {
        duel.add(z);
        z = [];
        if (duel.length > 1) {
          _matches.add(duel);
          duel = [];
        }
      }
    }
    if (z.length == 1) {
      z.add(z[0]);
      duel.add(z);
    }
    if (duel.length == 1) {
      if (ripescaggio) {
        duel.add(["R"]);
      } else {
        duel.add(duel[0]);
      }
    }
    if (duel.isNotEmpty) {
      _matches.add(duel);
    }
    matchesResult = _matches;
  }

  print("Matches results: " + matchesResult.toString());
  return matchesResult;
}

dynamic tournamentWinner(List matches, results) {
  if (matches.length == 1) {
    var _winner = matches[0][results[0] - 1];
    activePlayer = [];
    results = [];
    return _winner;
  } else {
    return 1;
  }
}

bool checkForRipescati(matches, singlePlayer, results) {
  for (var i = 0; i < results.length; i++) {
    var _winner = matches[i][results[i] - 1];
    if (singlePlayer && _winner == "R") {
      return true;
    } else if (!singlePlayer && _winner[0] == "R") {
      return true;
    }
  }

  return false;
}

///Creo una copia della variabile dei matches, rimuovo l'ultimo, poichè è quello con la R
///quindi so già che non mi interessa, rimuovo i vincitori e quindi rimango con gli sconfitti
List getEliminatedPlayer(matches, results) {
  List losers = matches.map((e) => e.toList()).toList();
  losers.removeLast();
  for (var i = 0; i < losers.length; i++) {
    losers[i].remove(losers[i][results[i] - 1]);
  }

  var flattened = losers.expand((loser) => loser).toList();
  print("Eliminated: " + flattened.toString());
  return flattened;
}

List getWinners(matches, List<int> results) {
  List k = matches.map((e) => e.toList()).toList();
  List _winners = [];
  for (var i = 0; i < k.length; i++) {
    _winners.add(k[i][results[i] - 1]);
  }

  print("Winners: " + _winners.toString());
  return _winners;
}

//Chiamare una pagina senza avere una transizione lineare
void makeRoutePage({required BuildContext context, required Widget pageRef}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => pageRef));
}

///Assegnazione dei team, prendendo come rifermento l'Id del primo (o unico) giocatore
///di ogni squadra gli si associa l'id di un team, di modo che a prescindere da tutte le
///operazioni che si possano fare alle variabili dei matches le squadre potranno sempre
///essere associate allo stesso team
void associateTeam(List<dynamic> matches, bool singlePlayer) {
  if (singlePlayer) {
    for (int i = 0; i < matches.length; i++) {
      assTeams[matches[i][0]] = activeTeams[(i * 2) + 0];
      if (matches[i][1] != 'R') {
        assTeams[matches[i][1]] = activeTeams[(i * 2) + 1];
      }
    }
  } else {
    for (int i = 0; i < matches.length; i++) {
      assTeams[matches[i][0][0]] = activeTeams[(i * 2) + 0];
      if (matches[i][1][0] != 'R') {
        assTeams[matches[i][1][0]] = activeTeams[(i * 2) + 1];
      }
    }
  }
  print("The teams MAP is: " + assTeams.toString());
}
