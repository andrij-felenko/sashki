import 'package:flutter/material.dart';

import 'user_board_items.dart';
import 'fishka.dart';
import 'position.dart';

class Field {
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

  void click(Position coord) {
    print('click: $coord');
    current_select_field.x = coord.x;
    current_select_field.y = coord.y;
    // check if already use this line, if click on empty, make turn

    /// 1. check what field are relate to { white, black, empty }


    /// 2. check is we can move here, include is we beat enemy
    /// 3. make turn


  }
}