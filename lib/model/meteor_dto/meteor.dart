import 'package:blue_ship/model/movable/movable.dart';

class MeteorDto extends Movable {
  MeteorDto(
      {required super.position,
      required super.velocity,
      required super.staticAngle,
      required super.width,
      required super.height});
}
