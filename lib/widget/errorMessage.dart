import 'package:flutter/material.dart';

Widget ErrorMessage() => ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Colors.cyan,
    ),
    onPressed: () {
      SnackBar(
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        content: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 48,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Oops Error!',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          'This Username is not found! Please try again later',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 25,
                left: 20,
                child: ClipRRect(
                  child: Stack(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.red.shade200,
                        size: 17,
                      )
                    ],
                  ),
                )),
            Positioned(
                top: -20,
                left: 5,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    const Positioned(
                        top: 5,
                        child: Icon(
                          Icons.clear_outlined,
                          color: Colors.white,
                          size: 20,
                        ))
                  ],
                )),
          ],
        ),
      );
    },
    child: const Text('Show Flash Error Message'));
