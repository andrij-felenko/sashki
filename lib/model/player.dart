import 'package:flutter/cupertino.dart';

import 'piece.dart';
import 'position.dart';
import 'user.dart';

class Player extends ChangeNotifier {
  final Side _side;
  final List <Piece> _pieces;
  User _user;

  Player(this._side) : _user = User("auto"), _pieces = [] {
    reset();
  }

  Side get side => _side;
  User get user => _user;
  List <Piece> get pieces => _pieces;

  set user(User user) => _user;

  Piece piece(int i) => _pieces[i];

  Piece? pieceByPos(Position pos) {
    for (Piece it in _pieces) {
      if (it.pos == pos) {
        return it;
      }
    }

    return null;
  }

  void turn(Position from, Position to) {
    //
  }

  void reset() {
    _pieces.clear();

    // create fishki and place each in destination position
    for (int i = 0; i < 12; i++) {
      Position pos = Position((i % 4) * 2, i ~/ 4);
      if ((i ~/ 4) % 2 == 0) pos.x++;

      if (_side == Side.white) { pos.x = 7 - pos.x; pos.y = 7 - pos.y; }
      
      Piece newPiece = Piece(_side, pos);
      _pieces.add(newPiece);
      newPiece.addListener(notifyListeners);
    }
  }

  bool findPiece(Position pos) {
    for (Piece it in _pieces) {
      if (it.pos == pos) {
        return true;
      }
    }

    return false;
  }

  void changeUser(User user) { _user = user; notifyListeners(); }
}