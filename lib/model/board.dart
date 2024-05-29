import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
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
    _white.addListener(_dataChanged);
    _black.addListener(_dataChanged);
    addListener(_dataChanged);
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

    _makeTurn(pos);
  }

  // io
  int writeToByteData(ByteData data, int offset) {
    int offset_ = 0;
    offset_ += _black.writeToByteData(data, offset + offset_);
    offset_ += _white.writeToByteData(data, offset + offset_);
    data.setInt32(offset + offset_, _turn.index, Endian.little);
    offset_ += 4;
    offset_ += _selectedField.writeToByteData(data, offset + offset_);
    return offset_;
  }

  void _makeTurn(Position pos) {
    Piece? piece = user.pieceByPos(selectedField);

    if (piece == null) return;

    int shift = _sizeOfPieceShiftMove(piece.pos, pos, turn);
    List <Piece>  userLine = user.findPieces(Player.positionBetween(piece.pos, pos));
    List <Piece> enemyLine = opponent.findPieces(Player.positionBetween(piece.pos, pos));

    // move
    if ((piece.isQueen && userLine.isEmpty && enemyLine.isEmpty && shift != 0) ||
        (piece.isPawn && shift == 1)) {
      piece.move(pos);
      switchPlayer();
    }
    // beat
    else if (enemyLine.length == 1 &&
        (piece.isQueen && userLine.isEmpty) || (piece.isPawn && shift == 2)) {
      enemyLine[0].remove();
      piece.move(pos);
      selectField = pos;
      if (!_isWeCanBeat(piece)) {
        switchPlayer();
      }
    }
  }

  void _dataChanged() async {
    if (!Platform.isAndroid) { return; }
    // save io to file
    ByteData data = ByteData(1600);
    int offset = writeToByteData(data, 0);

    Directory directory = await getApplicationCacheDirectory();
    String? path = directory.path;

    File file = File('$path/current_board.chg');
    await file.writeAsBytes(data.buffer.asUint32List().sublist(0, offset));
  }

  bool _isWeCanBeat(Piece piece) {
    List <Position> star = [
      Position( 1,  1),
      Position( 1, -1),
      Position(-1,  1),
      Position(-1, -1),
    ];
    int it = 1;
    // print('\n start check from position: ${piece.pos}');
    while ((piece.pos + star[0] * it).isInRange(1, 6) ||
        (piece.pos + star[1] * it).isInRange(1, 6) ||
        (piece.pos + star[2] * it).isInRange(1, 6) ||
        (piece.pos + star[3] * it).isInRange(1, 6)) {
      for (int i = 0; i < 4; i++) {
        // print('i $i');
        if (!(piece.pos + star[i] * it).isInRange(1, 6)) {
          // print('skip ${piece.pos + star[i] * it}');
          continue;
        }

        if (user.pieceByPos(piece.pos + star[i] * it) != null) {
          star[i] = Position(7, 7);
          // print('break here ${star[i]}');
          continue;
        }

        if (opponent.pieceByPos(piece.pos + star[i] * it) != null) {
          // print('find ${piece.pos + star[i] * it}');
          if (_checkFreeField(piece.pos + star[i] * (it + 1))) {
            // we can beat
            // print('beat ${piece.pos + star[i] * (it + 1)}');
            return true;
          }
        }
      }
      if (piece.isQueen) { it++; } else { break; }
    }
    return false;
  }

  int _sizeOfPieceShiftMove(Position from, Position to, Side side) {
    Position diff = from - to;
    if (diff.x == 0 || diff.y == 0) { return 0; }

    if (diff.x.abs() != diff.y.abs()) { return 0; }
    int shift = diff.x.abs();

    if (shift == 1) {
      if (diff.y < 0 && side == Side.white || diff.y > 0 && side == Side.black) {
        return 0;
      }
    }

    return shift;
  }

  bool _checkFreeField(Position pos) {
    return _black.pieceByPos(pos) == null && _white.pieceByPos(pos) == null;
  }
}