// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_2/dati/costants.dart';
import 'package:flutter_application_2/screens/homePage.dart';

//'assets\\images\\foto.png'

class app_bar extends StatelessWidget implements PreferredSizeWidget {
  const app_bar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      actions: [
        Padding(
          padding: EdgeInsets.only(right: kDefaultPadding),
          child: IconButton(
            icon: Icon(Icons.home, size: 27),
            onPressed: () {
              //Navigator.popUntil(context, ModalRoute.withName('/homepage'));
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HomePage(),
                  ));

              //makeRoutePage(context: context, pageRef: HomePage());
            },
          ),
        )
      ],
    );
  }
}
