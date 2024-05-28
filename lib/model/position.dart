import 'package:flutter/material.dart';

class Position extends ChangeNotifier {
  int _x;
  int _y;

  Position(this._x, this._y);

  int get x => _x;
  int get y => _y;

  set x(int x) { _x = x; notifyListeners(); }
  set y(int y) { _y = y; notifyListeners(); }

  @override
  String toString() => 'Position(x: $_x, y: $_y)';

  @override
  bool operator == (Object other) {
    if (identical(this, other)) return true;

    return other is Position &&
      other.x == x &&
      other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}