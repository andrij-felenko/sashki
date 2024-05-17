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


  void remove()  => _status = Status.beated;
  void upgrade() => _status = Status.queen;

  void move (Position coord) {
    if (_status == Status.pawn) {
      if ((_side == Side.black && coord.y == 7) ||
          (_side == Side.white && coord.y == 0)) {
        upgrade();
      }
    }

    _pos = pos;
    notifyListeners();
  }
}