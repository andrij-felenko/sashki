import 'package:flutter/material.dart';

class Position extends ChangeNotifier {
  int _x;
  int _y;

  int get x => _x;
  int get y => _y;

  set x(int x) {
    _x = x;
    notifyListeners();
  }

  set y(int y) {
    _y = y;
    notifyListeners();
  }

  Position(this._x, this._y);

  @override
  String toString() => 'Position(x: $_x, y: $_y)';
}