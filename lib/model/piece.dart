import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'position.dart';
import 'enums.dart'; export 'enums.dart';

class Piece extends ChangeNotifier {
  Status _status = Status.pawn;
  Position _pos = Position(-1, -1);
  final Side _side;

  Piece(this._side, this._pos) {
    _pos.addListener(notifyListeners);
  }

  set coord(Position pos) { _pos = pos; notifyListeners(); }
  Position get pos => _pos;
  Side     get side => _side;
  Status   get status => _status;
  set status(Status s) { _status = s; notifyListeners(); }

  bool get isPawn => _status == Status.pawn;
  bool get isQueen => _status == Status.queen;
  bool get isBeaten => _status == Status.beaten;

  void remove() {
    print(status);
    status = Status.beaten;
    print(status);
    print(pos);
  }
  void upgrade() => status = Status.queen;

  void move (Position coord) {
    if (_status == Status.pawn) {
      if (
        (_side == Side.black && coord.y == 7) ||
        (_side == Side.white && coord.y == 0)
      ) {
        upgrade();
      }
    }

    this.coord = coord;
    notifyListeners();
  }

  // io
  int writeToByteData(ByteData data, int offset) {
    int offset_ = 0;
    data.setInt32(offset, status.index, Endian.little);
    offset_ += 4;
    offset_ += pos.writeToByteData(data, offset + offset_);
    return offset_;
  }
}