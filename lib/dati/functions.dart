import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/globals.dart';

//accoppiamento non smistato per le partite
List updateMatches(singlePlayer, winners) {
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
  print(matchesResult);
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

  print(matchesResult);
  return matchesResult;
}

dynamic tournamentWinner(List matches) {
  List<int> lastTeam = [];
  if (matches.length == 1) {
    var _winner = matches[0][results[0] - 1];
    if (sortTeams) {
      lastTeam.add(activeTeams[results[0] - 1]);
      activeTeams = lastTeam;
    }
    activePlayer = [];
    results = [];
    return _winner;
  } else {
    return 1;
  }
}

//Chiamare una pagina senza avere una transizione lineare
void makeRoutePage({required BuildContext context, required Widget pageRef}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => pageRef));
}

bool checkForRipescati(matches, singlePlayer) {
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

List getEliminatedPlayer(matches) {
  List losers = matches.map((e) => e.toList()).toList();
  losers.removeLast();
  for (var i = 0; i < losers.length; i++) {
    losers[i].remove(losers[i][results[i] - 1]);
  }

  var flattened = losers.expand((loser) => loser).toList();
  print("Eliminated: " + flattened.toString());
  return flattened;
}

List getWinners(matches) {
  List k = matches.map((e) => e.toList()).toList();
  List _winners = [];
  List<int> _newActiveTeams = [];
  for (var i = 0; i < k.length; i++) {
    _winners.add(k[i][results[i] - 1]);
    if (sortTeams) {
      _newActiveTeams.add(activeTeams[(i * 2) + (results[i] - 1)]);
    }
  }

  if (_newActiveTeams.isNotEmpty) {
    activeTeams = _newActiveTeams;

    ///TODO
    ///inserire una variabile passata come parametro in cui poter salvare una
    ///mappa che collega i giocatori eliminati alla squadra che avevano così da
    ///poter evitare di dover ricorrere a funzioni aggiuntive

  }

  print("Winners: " + _winners.toString());
  return _winners;
}
