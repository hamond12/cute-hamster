import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/game/gameEngine.dart';
import 'package:flutter_practice/game/seed.dart';
import 'package:flutter_practice/game/hamster.dart';
import 'package:flutter_practice/game/joystick.dart';

class Screen extends StatelessWidget {
  Screen({Key? key}): super(key:key){

    // 버튼에 따라 햄스터 움직이는 방향 설정
    _joystick = JoyStick(onMove: (int direction) => {
      _hamster.move(direction)
    });

    _hamster = Hamster();

    // 햄스터와 떨어지는 씨앗이 부딪혔을 때 햄스터가 사라지게하기
    _seeds = Seeds(
        onCheckCollison: (GameControl target) {
      return _hamster.checkCollisionAndExplode(target);
    });

    _gameEngine.getControls().addControl(_joystick);
    _gameEngine.getControls().addControl(_hamster);
    _gameEngine.getControls().addControl(_seeds);
    _gameEngine.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("해바라기 씨 피하기",
          style: TextStyle(
              fontSize: 25
          ),),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: _gameEngine.getCustomPaint(),
      ),
    );
  }

  final _gameEngine = GameEngine();
  late final _joystick;
  late final _hamster;
  late final _seeds;
}
