import 'dart:math';


abstract class Vector {
  double x;
  double y;

  isNotNull() {
    return x != 0 || y != 0;
  }

  double angle() {
    if (y != 0 && x != 0) {
     if(x < 0) {
       return atan(y / x);
     }
     else {
       return atan(y / x) + pi;
     }
    } else if (y == 0) {
      if(x > 0) {
        return 0;
      }
      else {
        return pi;
      }
    } else if (x == 0) {
      if(y > 0) {
        return pi/2;
      }
      else {
        return pi * 3 / 2;
      }
    }
    else {
      return pi;
    }
  }

  Vector({required this.x, required this.y});

  double length() => sqrt(x * x + y * y);

  Vector operator +(other);

  Vector operator -(other);

  @override
  bool operator ==(Object other) => other is Vector && x == other.x && y == other.y;

  @override
  int get hashCode => int.parse((x * 10000).round().toString() + (y * 10000).round().toString());
}

class PositionVector extends Vector {
  PositionVector({required super.x, required super.y});

  @override
  PositionVector operator +(other) {
    other as PositionVector;
    return PositionVector(x: x + other.x, y: y + other.y);
  }

  @override
  PositionVector operator -(other) {
    other as PositionVector;
    return PositionVector(x: x - other.x, y: y - other.y);
  }
}

class VelocityVector extends Vector {
  VelocityVector({required super.x, required super.y});

  VelocityVector.initial() : this(x: 0, y: 0);

  void newVelocityFromPosition(
      {required PositionVector startingDestination, required PositionVector endingDestination, required double speed}) {
    PositionVector result = startingDestination - endingDestination;
    final double angle = result.angle();
    x = speed * cos(angle);
    y = speed * sin(angle);

  }

  @override
  VelocityVector operator +(other) {
    other as PositionVector;
    return VelocityVector(x: x + other.x, y: y + other.y);
  }

  @override
  VelocityVector operator -(other) {
    other as PositionVector;
    return VelocityVector(x: x - other.x, y: y - other.y);
  }
}
