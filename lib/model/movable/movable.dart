import 'package:blue_ship/common/constants.dart';
import 'package:blue_ship/model/vector/vector.dart';

abstract class Movable {
  PositionVector position;
  VelocityVector velocity;
  double staticAngle;
  double height;
  double width;

  Movable(
      {required this.position,
      required this.velocity,
      required this.staticAngle,
      required this.height,
      required this.width});

  void changePosition() {
    const time = 1000 / Constants.fps;
    position = PositionVector(x: position.x + velocity.x * time, y: position.y + velocity.y * time);
  }
}
