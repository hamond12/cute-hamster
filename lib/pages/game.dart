import 'package:flutter/material.dart';
import 'package:flutter_practice/game/screen.dart';

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
          fontFamily: 'Omu',
      ),
      home: Screen(),
    );
  }
}