import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shashki/model/enums.dart';
import 'package:shashki/model/user.dart';

import 'player.dart';
import 'piece.dart';
import 'position.dart';

class Board extends ChangeNotifier {
  final Player _white;
  final Player _black;
  Side _turn;
  Position _selectedField;
  double _widgetSize = 50;

  static final Board _instance = Board._internal();
  Board._internal()
      : _turn = Side.white,
        _white = Player(Side.white),
        _black = Player(Side.black),
        _selectedField = Position( -1, -1) {
    _white.user = User('White user');
    _black.user = User('Black User');
    _white.addListener(notifyListeners);
    _black.addListener(notifyListeners);
  }
  factory Board() => _instance;

  Player get white => _white;
  Player get black => _black;
  Player get user    => _turn == Side.black ? _black : _white;
  Player get opponent => _turn == Side.black ? _white : _black;

  Side get turn => _turn;
  Position get selectedField => _selectedField;
  set selectField(Position pos) { _selectedField = pos; notifyListeners(); }
  double get widgetSize => _widgetSize;
  set widgetSize(double size) {
    if (_widgetSize == size) {
      return;
    }

    _widgetSize = size;
    notifyListeners();
  }


  void _selectFieldPos(int x, int y) { selectField = (Position(x, y)); }

  void switchPlayer() {
    _turn = _turn == Side.black ? Side.white : Side.black;
    notifyListeners();
  }

  bool isEnd() {
    // check is game finished just now
    return false;
  }

  void makeTurn(Position from, Position to) { user.turn(from, to); }

  void kill(Position coord) {
    //
  }

  void click(Position pos) {
    if (selectedField == pos || (pos.x % 2 == pos.y % 2)) {
      _selectFieldPos(-1, -1);
      return;
    }

    if (user.findPiece(pos)) {
      selectField = pos;
      return;
    }

    if (opponent.findPiece(pos)) {
      return;
    }

    Piece? piece = user.pieceByPos(selectedField);

    if (piece == null) return;

    if (piece.status == Status.queen) {

    } else if (piece.status == Status.pawn) {
      print(pos);
      piece.move(pos);
    }

    /// 2. check is we can move here, include is we beat enemy
    /// 3. make turn

    /// 4. if we kill, than we continue move, else switch player
    if (true /* is we kill check */) {
      //
    } else {
      switchPlayer();
    }
  }
}