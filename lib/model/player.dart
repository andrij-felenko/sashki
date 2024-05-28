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

  int piecesCount(Status status) {
    var counter = 0;

    for (Piece it in _pieces) {
      if (it.status == status) {
        counter++;
      }
    }

    return counter;
  }

  Piece? pieceByPos(Position pos) {
    for (Piece it in _pieces) {
      if (it.status != Status.beaten && it.pos == pos) {
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
      newPiece.addListener(_recalculatePieces);
    }
  }

  void _recalculatePieces() {
    notifyListeners();
  }

  bool findPiece(Position pos) {
    for (Piece it in _pieces) {
      if (it.status != Status.beaten && it.pos == pos) {
        return true;
      }
    }

    return false;
  }

  static List <Position> positionBetween(Position f, Position s) {
    List <Position> ret = [];
    int xStep = (f.x - s.x) > 0 ? -1 : 1;
    int yStep = (f.y - s.y) > 0 ? -1 : 1;
    int x = f.x + xStep;
    int y = f.y + yStep;

    while (x != s.x && y != s.y) {
      ret.add(Position(x, y));
      x += xStep; 
      y += yStep;
    }

    return ret;
  }

  Piece? findOneBetween(List <Position> list) {
    Piece? ret;
    for (Position it in list) {
      Piece? temp = pieceByPos(it);
      if (temp == null) { continue; }
      
      if (ret != null) { return null; }
      ret = temp;
    }

    return ret;
  }

  void changeUser(User user) { _user = user; notifyListeners(); }
}