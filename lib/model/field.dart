import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'user_board_items.dart';
import 'fishka.dart';
import 'position.dart';

class Field extends ChangeNotifier {
  UserBoardItems _white_user;
  UserBoardItems _black_user;
  Side _current_turn;
  Position current_select_field = Position( -1, -1);

  UserBoardItems get white => _white_user;
  UserBoardItems get black => _black_user;

  Position get current_field => current_select_field;

  bool is_end() {
    // check is game finished just now
    return false;
  }

  Field() : _current_turn = Side.White,
            _white_user = UserBoardItems(Side.White),
            _black_user = UserBoardItems(Side.Black);

  Side get current_turn => _current_turn;

  void turn(Position from, Position to) {
    _current_turn == Side.White ? _white_user.turn(from, to)
                                : _black_user.turn(from, to);
  }

  void kill(Position coord) {
    //
  }

  void click(Position coord) {
    /// 1. check what field are relate to { white, black, empty }
    if (current_select_field == coord) {
      current_select_field = Position(-1, -1);
      notifyListeners();
      return;
    }

    if (user.findFishka(coord)) {
      current_select_field = coord;
      notifyListeners();
      return;
    }

    /// 2. check is we can move here, include is we beat enemy
    /// 3. make turn
    /// 4. if we kill, than we continue move, else switch player
  }

  UserBoardItems get user => _current_turn == Side.Black ? _black_user : _white_user;
}