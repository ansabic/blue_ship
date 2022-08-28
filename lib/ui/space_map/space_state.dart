part of 'space_cubit.dart';

@immutable
abstract class SpaceState {
  final List<Movable> objects;
  final List<Movable> toRender;
  final Camera camera;

  const SpaceState({required this.objects, required this.camera, required this.toRender});

  SpaceState copyWith<T extends SpaceState>({List<Movable>? objects, Camera? camera, List<Movable>? toRender}) {
    if (T == ScreenRefresh) {
      return ScreenRefresh(
          objects: objects ?? this.objects, camera: camera ?? this.camera, toRender: toRender ?? this.toRender);
    } else {
      return SpaceInitial(camera: camera ?? this.camera);
    }
  }
}

class SpaceInitial extends SpaceState {
  static SpaceShipDto initialSpaceShip() => SpaceShipDto(
      position: PositionVector(x: Constants.spaceWidth / 2, y: Constants.spaceHeight / 2),
      velocity: VelocityVector.initial(),
      staticAngle: VelocityVector.initial().angle(),
      height: 25,
      width: 25);

  SpaceInitial({required super.camera})
      : super(
            toRender: [initialSpaceShip()],
            objects: [initialSpaceShip()]);
}

class ScreenRefresh extends SpaceState {
  const ScreenRefresh({required super.objects, required super.camera, required super.toRender});
}
