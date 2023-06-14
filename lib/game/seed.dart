import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_practice/game/gameEngine.dart';


const SEED_SIZE = 30.0;

typedef CheckCollisionCallback = bool Function(GameControl target);

class Seeds extends GameControl {
  var _term=0;
  var _random = Random();
  int _relaseInterval = 500;

  final CheckCollisionCallback onCheckCollison;
  Seeds({required this.onCheckCollison});

  @override
  void tick(Canvas canvas, Size size, int current, int term) {
    _term = _term + term;
    while (_term >= _relaseInterval) {
      _term = _term - _relaseInterval;
      _createBall(size);
    }
  }

  void _createBall(Size size){
    var _x = _random.nextDouble() * (size.width - SEED_SIZE);
    getGameControlGroup()?.addControl(Seed(_x, 0, onCheckCollison));
  }
}

class Seed extends GameControl{
  Seed(double ax, double ay, CheckCollisionCallback onCheckCollision){
    x = ax;
    y = ay;
    width = 30;
    height = 30;
    _onCheckCollison = onCheckCollision;
  }

  @override
  void tick(Canvas canvas, Size size, int current, int term) {
    y=y+10;
    if (y> size.height) deleted=true;

    if(_onCheckCollison(this)) deleted=true;

    final image = AssetImage('assets/img/sunflowerSeed.png');
    final imageConfiguration = ImageConfiguration.empty;
    image.resolve(imageConfiguration).addListener(
      ImageStreamListener(
            (ImageInfo info, bool synchronousCall) {
          final ui.Image? uiImage = info.image;
          if (uiImage != null) {
            // 이미지가 로드된 경우 이미지를 그림으로 그리기
            final imageSize = Size(uiImage.width.toDouble(), uiImage.height.toDouble());
            final destinationRect = Rect.fromCenter(
              center: Offset(x + SEED_SIZE / 2, y + SEED_SIZE / 2),
              width: SEED_SIZE,
              height: SEED_SIZE,
            );
            canvas.drawImageRect(uiImage, Offset.zero & imageSize, destinationRect, paint);
          } else {
            // 이미지 로드 중이거나 로드 실패 시 대체 로직
            canvas.drawCircle(Offset(x + SEED_SIZE / 2, y + SEED_SIZE / 2), SEED_SIZE / 2, paint);
          }
        },
      ),
    );
  }

  late CheckCollisionCallback _onCheckCollison;
}

