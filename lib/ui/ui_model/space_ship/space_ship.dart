import 'dart:math';

import 'package:blue_ship/model/space_ship_dto/space_ship_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../space_map/space_cubit.dart';

class SpaceShip extends StatelessWidget {
  final SpaceShipDto spaceShipDto;

  const SpaceShip({Key? key, required this.spaceShipDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SpaceCubit>(context);
    double angle =
        spaceShipDto.velocity.isNotNull() ? spaceShipDto.velocity.angle() - pi / 2 : spaceShipDto.staticAngle;
    return Positioned(
        height: spaceShipDto.height,
        width: spaceShipDto.width,
        top: spaceShipDto.position.y - bloc.state.camera.startY,
        left: spaceShipDto.position.x - bloc.state.camera.startX,
        child: Transform(
            transform: Matrix4.rotationZ(angle),
            alignment: Alignment.center,
            child: Image.asset(
              "assets/spaceship.png",
            )));
  }
}
