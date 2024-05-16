import 'fishka.dart';
import 'position.dart';

class UserBoardItems {
  final Side _side;
  final List <Fishka> _fishks = [];

  Side get side => _side;

  Fishka fishka(int i) => _fishks[i];
  List <Fishka> get fishks => _fishks;

  UserBoardItems(this._side) {
    reset();
  }

  void turn(Position from, Position to) {
    //
  }

  void reset() {
    _fishks.clear();

    // create fishki and place each in destination position
    for (int i = 0; i < 12; i++) {
      Position pos = Position((i % 4) * 2, i ~/ 4);
      if ((i ~/ 4) % 2 == 0) pos.x++;
      if (_side == Side.White) { pos.x = 7 - pos.x; pos.y = 7 - pos.y; }
      _fishks.add(Fishka(_side, pos));
    }
  }

  bool findFishka(Position coord) {
    for (Fishka it in _fishks) {
      if (it.coord == coord) {
        return true;
      }
    }
    return false;
  }
}