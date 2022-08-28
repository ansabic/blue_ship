import 'package:blue_ship/common/constants.dart';
import 'package:blue_ship/model/vector/vector.dart';

class Camera {
  double startX;
  double endX;
  double startY;
  double endY;

  Camera({required this.endY, required this.startY, required this.endX, required this.startX});

  void moveWithVelocity({required VelocityVector velocity, required PositionVector playerPosition}) {
    const time = 1000 / Constants.fps;
    if (playerPosition.x >= width() / 2 && playerPosition.x <= Constants.spaceWidth - width() / 2) {
      final dX = velocity.x * time;
      startX += dX;
      endX += dX;
    }
    if (playerPosition.y >= height() / 2 && playerPosition.y <= Constants.spaceHeight - height() / 2) {
      final dY = velocity.y * time;
      startY += dY;
      endY += dY;
    }
  }

  double height() => endY - startY;

  double width() => endX - startX;
}
