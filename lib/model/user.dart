import 'package:flutter/cupertino.dart';

class User {
  String _name = "";
  int _wins = 0;
  int _loses = 0;

  User(this._name) {
    //
  }

  String get name  => _name;
  int    get wins  => _wins;
  int    get loses => _loses;

  int get count => wins - loses;


}