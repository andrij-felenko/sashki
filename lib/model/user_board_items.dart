import 'fishka.dart';
import 'position.dart';

class UserBoardItems {
  UserBoardItems();

  List <Fishka> _fishks;

  void turn(Position from, Position to) {
    //
  }

  bool findFishka(Position coord) {
    for (Fishka it in _fishks) {
      if (it.coord == coord)
        return true;
    }
    return false;
  }
}