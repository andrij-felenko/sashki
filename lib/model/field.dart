import 'user_board_items.dart';
import 'fishka.dart';
import 'position.dart';

class Field {
  UserBoardItems _white_user;
  UserBoardItems _black_user;
  Side _current_turn;
  Position _current_selectfield = Position( -1, -1);

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
    // check if already use this line, if click on empty, make turn

    /// 1. check what field are relate to { white, black, empty }


    /// 2. check is we can move here, include is we beat enemy
    /// 3. make turn


  }
}