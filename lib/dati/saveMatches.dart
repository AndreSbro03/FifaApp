import 'package:flutter_application_2/dati/functions.dart';
import 'package:flutter_application_2/dati/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Matches {
  static final Matches instance = Matches._init();

  Matches._init();

  Future saveData(singlePlayer, List matches) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    // set value
    List<String> _out = convertToStringList(matches, singlePlayer);
    await prefs.setStringList('matches', _out);
  }

  Future readData() async {
    final prefs = await SharedPreferences.getInstance();
    // Try reading data from the matches key. If it doesn't exist, return 0.
    List<String> matches = prefs.getStringList('matches') ?? [];
    if (matches.isEmpty) {
      return null;
    } else {
      List _out = convertToList(matches);
      return _out;
    }
  }

  Future removeData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('matches');
  }

  List<String> convertToStringList(List matches, bool singlePlayer) {
    String z = "";
    print('op1' + matches.toString());
    matches = matches.expand((k) => k).toList();

    ///if is not singlePlayer I have to remove one more set of brackets
    if (!singlePlayer) {
      matches = matches.expand((k) => k).toList();
    }

    ///Controllo se all'interno della lista dei matches c'è un ripescato e se la modalità
    ///ripescaggio era attiva, se sì rimuovo l'ultimo elemento
    if (ripescaggio) {
      if (matches.last == 'R') {
        matches.removeLast();
      }
    }
    matches = matches.map((k) => k.toString()).toList();
    z = matches.join('-');
    print(z);
    List<String> _matches = [];
    _matches.clear();
    _matches.add(singlePlayer ? "Y" : "N");
    _matches.add(ripescaggio ? "Y" : "N");
    _matches.add(z);
    print(_matches);
    return _matches;
  }

  List convertToList(List<String> _in) {
    bool singlePlayer = (_in[0] == "Y");
    bool ripescato = (_in[1] == "Y");
    //set the variable of ripescaggio to is old value
    ripescaggio = ripescato;
    List matches;
    matches = _in[2].split("-");
    matches = matches.map((e) => int.parse(e)).toList();
    //print(matches);
    matches = createMatches(singlePlayer, matches);
    //print(matches);
    return [singlePlayer, matches];
  }
}
/*
void main() {
  bool singlePlayer = false;
  List matches = [
    [
      [1, 2],
      [3, 4]
    ],
    [
      [5, 6],
      [7, 8]
    ]
  ];
  List<String> stringMatches = convertToString(matches, singlePlayer);
  convertToList(stringMatches);
}
*/
