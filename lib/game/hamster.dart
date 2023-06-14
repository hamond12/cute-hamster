import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_practice/game/gameEngine.dart';

const HAMSTER_WIDTH = 60.0;
const HAMSTER_HEIGHT = 50.0;

class Hamster extends GameControl {
  void move(int direction) {
    _direction = direction;
  }

  bool checkCollisionAndExplode(GameControl target) {
    var result = checkCollision(target);
    if (result) deleted = true;
    return result;
  }

  @override
  void onStart(Canvas canvas, Size size, int current) {
    width = HAMSTER_WIDTH;
    height = HAMSTER_HEIGHT;
    x = (size.width - width) / 2;
    y = size.height - HAMSTER_WIDTH * 2;
    paint.color = Colors.blue;
  }

  @override
  void tick(Canvas canvas, Size size, int current, int term) {
    x = x + _direction;
    const radius = HAMSTER_WIDTH / 2;

    // 이미지 로드
    final image = AssetImage('assets/img/hamster.png');
    final imageConfiguration = ImageConfiguration.empty;
    image.resolve(imageConfiguration).addListener(
      ImageStreamListener(
            (ImageInfo info, bool synchronousCall) {
          final ui.Image? uiImage = info.image;
          if (uiImage != null) {
            // 이미지가 로드된 경우 이미지를 그림으로 그리기
            final imageSize = Size(uiImage.width.toDouble(), uiImage.height.toDouble());
            final destinationRect = Rect.fromCenter(
              center: Offset(x + radius, y + radius),
              width: HAMSTER_WIDTH,
              height: HAMSTER_HEIGHT,
            );
            canvas.drawImageRect(uiImage, Offset.zero & imageSize, destinationRect, paint);
          } else {
            // 이미지 로드 중이거나 로드 실패 시 대체 로직
            canvas.drawCircle(Offset(x + radius, y + radius), radius, paint);
          }
        },
      ),
    );
  }

  int _direction = 0;
}
