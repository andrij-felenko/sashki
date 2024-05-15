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
  int _x = -1;
  int _y = -1;
  Side _side;

  Fishka(this._side);

  int get x => _x;
  int get y => _y;

  set x(int x) => _x = x;
  set y(int y) => _y = y;

  Status get status => _status;
  set status(Status s) => _status = s;

  void remove()  => _status = Status.Removed;
  void upgrade() => _status = Status.Damka;

  void move (int x, int y) {
    if (_status == Status.Simple) {
      if ((_side == Side.Black && y == 7) || (_side == Side.White && y == 0)) {
        upgrade();
      }
    }

    _x = x;
    _y = y;
  }
}