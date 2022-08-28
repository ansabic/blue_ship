import 'dart:math';

import 'package:blue_ship/model/meteor_dto/meteor.dart';
import 'package:blue_ship/ui/space_map/space_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Meteor extends StatelessWidget {
  final MeteorDto meteorDto;

  const Meteor({Key? key, required this.meteorDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double angle = meteorDto.velocity.isNotNull() ? meteorDto.velocity.angle() - pi / 2 : meteorDto.staticAngle;
    final bloc = BlocProvider.of<SpaceCubit>(context);
    return Positioned(
        height: meteorDto.height,
        width: meteorDto.width,
        top: meteorDto.position.y - bloc.state.camera.startY,
        left: meteorDto.position.x - bloc.state.camera.startX,
        child: Transform(
            transform: Matrix4.rotationZ(angle),
            alignment: Alignment.center,
            child: Image.asset(
              "assets/meteor.png",
            )));
  }
}
