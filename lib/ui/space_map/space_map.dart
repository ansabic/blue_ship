import 'package:blue_ship/model/meteor_dto/meteor.dart';
import 'package:blue_ship/model/space_ship_dto/space_ship_dto.dart';
import 'package:blue_ship/ui/space_map/space_cubit.dart';
import 'package:blue_ship/ui/ui_model/meteor/meteor.dart';
import 'package:blue_ship/ui/ui_model/space_ship/space_ship.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpaceMap extends StatelessWidget {
  const SpaceMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SpaceCubit(size: MediaQuery.of(context).size),
      child: BlocBuilder<SpaceCubit, SpaceState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<SpaceCubit>(context);
          return Listener(
            behavior: HitTestBehavior.opaque,
            onPointerUp: (event) {
              bloc.resetVelocity();
            },
            onPointerCancel: (event) {
              bloc.resetVelocity();
            },
            onPointerDown: ((event) {
              bloc.playerNewAngle(position: event.position);
            }),
            onPointerMove: ((event) {
              bloc.playerNewAngle(position: event.position);
            }),
            child: Stack(
              fit: StackFit.expand,
              children: state.toRender.map((e) {
                if(e is SpaceShipDto) {
                  return SpaceShip(spaceShipDto: e);
                }
                else if(e is MeteorDto) {
                  return Meteor(meteorDto: e);
                }
                else {
                  return Positioned(
                    top: e.position.y,
                    left: e.position.x,
                    child: const Icon(Icons.account_circle),
                  );
                }
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
