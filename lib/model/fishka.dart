import 'position.dart';

enum Status {
  Removed,
  Simple,
  Damka
}

enum Side {
  Black,
  White
}

class Fishka {
  Status _status = Status.Simple;
  Position _coord = Position(-1, -1);
  Side _side;

  Fishka(this._side);

  Position get coord => _coord;
  set coord(Position coord) => _coord = coord;

  Status get status => _status;
  set status(Status s) => _status = s;

  void remove()  => _status = Status.Removed;
  void upgrade() => _status = Status.Damka;

  void move (Position coord) {
    if (_status == Status.Simple) {
      if ((_side == Side.Black && coord.y == 7) ||
          (_side == Side.White && coord.y == 0)) {
        upgrade();
      }
    }

    _coord = coord;
  }
}