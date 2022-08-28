import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:blue_ship/model/meteor_dto/meteor.dart';
import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../model/camera/camera.dart';
import '../../model/movable/movable.dart';
import '../../model/space_ship_dto/space_ship_dto.dart';
import '../../model/vector/vector.dart';

part 'space_state.dart';

class SpaceCubit extends Cubit<SpaceState> {
  SpaceCubit({required Size size})
      : super(SpaceInitial(
            camera: Camera(
                startX: Constants.spaceWidth / 2 - size.width / 2,
                endX: Constants.spaceWidth / 2 + size.width / 2,
                startY: Constants.spaceHeight / 2 - size.height / 2,
                endY: Constants.spaceHeight / 2 + size.height / 2))) {
    initNextState();
    generateMeteorsRandomly();
    timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ Constants.fps), (_) => refresh());
  }

  late Timer timer;

  late SpaceState nextState;

  SpaceShipDto player({required List<Movable> allList}) =>
      allList.firstWhere((element) => element is SpaceShipDto) as SpaceShipDto;

  void appendChanges({required List<Movable> newList, Camera? camera}) {
    nextState = nextState.copyWith<ScreenRefresh>(objects: newList, camera: camera);
  }

  void refresh() {
    final List<Movable> toRender = [];
    final pl = player(allList: state.objects);
    if(pl.velocity.isNotNull()) {
      state.camera.moveWithVelocity(velocity: pl.velocity, playerPosition: pl.position);
    }
    for (Movable movable in nextState.objects) {
      if (inCamera(object: movable)) {
        toRender.add(movable);
      }
      if (movable.velocity.isNotNull()) {
        movable.changePosition();
      }
    }
    emit(nextState.copyWith<ScreenRefresh>(toRender: toRender));
  }

  void addMovable({required Movable object}) {
    final newList = List.of(state.objects);
    newList.add(object);
    appendChanges(newList: newList);
  }

  void playerNewAngle({required Offset position}) {
    final newList = List.of(state.objects);
    final pl = player(allList: newList);
    pl.velocity.newVelocityFromPosition(
        startingDestination: pl.position,
        endingDestination: PositionVector(x: position.dx + state.camera.startX, y: position.dy + state.camera.startY),
        speed: Constants.speed);
    pl.staticAngle = pl.velocity.angle() - pi / 2;
    appendChanges(newList: newList, camera: state.camera);
  }

  void resetVelocity() {
    final newList = List.of(nextState.objects);
    final pl = player(allList: newList);
    pl.velocity = VelocityVector.initial();
  }

  @override
  Future<void> close() {
    timer.cancel();
    return super.close();
  }

  double randDouble() => Random(DateTime.now().microsecondsSinceEpoch).nextDouble();

  void generateMeteorsRandomly() {
    final List<Movable> meteors = [];
    for (int i = 0; i < 200; i++) {
      final velocity = VelocityVector(y: randDouble() * 0.005, x: randDouble() * 0.005);
      final meteor = MeteorDto(
          width: 20 + randDouble() * 20,
          height: 20 + randDouble() * 20,
          position: PositionVector(x: randDouble() * Constants.spaceWidth, y: randDouble() * Constants.spaceHeight),
          velocity: velocity,
          staticAngle: velocity.angle());
      meteors.add(meteor);
    }
    final resultList = nextState.objects..addAll(meteors);
    appendChanges(newList: resultList);
  }

  bool inCamera({required Movable object}) =>
      object.position.x + object.width / 2 >= state.camera.startX &&
      object.position.x - object.width / 2 <= state.camera.endX &&
      object.position.y + object.height / 2 >= state.camera.startY &&
      object.position.y - object.height / 2 <= state.camera.endY;

  void initNextState() {
    nextState = state;
  }
}
