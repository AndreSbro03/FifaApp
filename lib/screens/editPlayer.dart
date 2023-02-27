// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/Players.dart';
import 'package:flutter_application_2/dati/costants.dart';
import 'package:flutter_application_2/db/players_database.dart';
import 'package:flutter_application_2/widget/player_form_widget.dart';

class AddEditPlayerPage extends StatefulWidget {
  final Player? player;

  const AddEditPlayerPage({
    Key? key,
    this.player,
  }) : super(key: key);
  @override
  _AddEditPlayerPageState createState() => _AddEditPlayerPageState();
}

class _AddEditPlayerPageState extends State<AddEditPlayerPage> {
  final _formKey = GlobalKey<FormState>();
  late Color color;
  late String name;
  late String image;

  @override
  void initState() {
    super.initState();

    color = widget.player?.color ?? Colors.red;
    name = widget.player?.name ?? '';
    image = widget.player?.image ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: kBackColor,
        appBar: AppBar(
          backgroundColor: kBackColor,
          elevation: 0,
          title: Padding(
            padding:
                EdgeInsets.only(right: MediaQuery.of(context).size.width / 6.5),
            child: Text(
              "TOURNAMENT",
              style: TextStyle(color: Colors.white70),
            ),
          ),
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: PlayerFormWidget(
            color: color,
            name: name,
            image: image,
            onChangedColor: (color) => setState(() => this.color = color),
            onChangedName: (name) => setState(() => this.name = name),
            onChangedImage: (image) => setState(() => this.image = image),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid =
        name.isNotEmpty && image.isNotEmpty && (name.length <= 12);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: () {
          addOrUpdateNote();
        },
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.player != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final player = widget.player!.copy(
      color: color,
      name: name,
      image: image,
    );

    await PlayersDatabase.instance.updatePlayer(player);
  }

  Future addNote() async {
    final player = Player(
      color: color,
      name: name,
      image: image,
    );

    await PlayersDatabase.instance.createPlayer(player);
  }
}
