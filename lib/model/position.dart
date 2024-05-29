import 'dart:typed_data';

import 'package:flutter/material.dart';

class Position extends ChangeNotifier {
  int _x;
  int _y;

  Position(this._x, this._y);

  int get x => _x;
  int get y => _y;

  set x(int x) { _x = x; notifyListeners(); }
  set y(int y) { _y = y; notifyListeners(); }

  bool isInRange(int less, int more) {
    return x >= less && x <= more && y >= less && y <= more;
  }

  @override
  String toString() => 'Position(x: $_x, y: $_y)';

  @override
  bool operator == (Object other) {
    if (identical(this, other)) return true;

    return other is Position && other.x == x && other.y == y;
  }

  Position operator - (Position other) => Position(x - other.x, y - other.y);
  Position operator + (Position other) => Position(x + other.x, y + other.y);
  Position operator * (int      scale) => Position(x * scale, y * scale);

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  // io
  int writeToByteData(ByteData data, int offset) {
    data.setInt32(offset,     x, Endian.little);
    data.setInt32(offset + 4, y, Endian.little);
    return 8;
  }
}