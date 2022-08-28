import 'package:blue_ship/model/movable/movable.dart';

class SpaceShipDto extends Movable {
  SpaceShipDto(
      {required super.position,
      required super.velocity,
      required super.staticAngle,
      required super.height,
      required super.width});
}
