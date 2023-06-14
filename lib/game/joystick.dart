import 'package:flutter/material.dart';
import 'package:flutter_practice/game/button.dart';
import 'package:flutter_practice/game/gameEngine.dart';

const BUTTON_SIZE = 60.0;
const BUTTON_POSITION_LEFT = -1;
const BUTTON_POSITION_RIGHT = 1;

typedef MoveCallback = void Function(int direction);

class JoyStick extends GameControl{
  final MoveCallback onMove;

  JoyStick({required this.onMove});

  @override

  @override
  void onStart(Canvas canvas, Size size, int current) {
    getGameControlGroup()?.addControl(
        Button(
            onDown: () => onMove(-5),
            onUp: () => onMove(0),
            direction: BUTTON_POSITION_LEFT
        )
    );

    getGameControlGroup()?.addControl(
        Button(
            onDown: () => onMove(5),
            onUp: () => onMove(0),
            direction: BUTTON_POSITION_RIGHT
        )
    );
  }


}