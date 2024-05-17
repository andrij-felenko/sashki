import 'package:flutter/cupertino.dart';

class User {
  final String _name;
  final int _wins = 0;
  final int _loses = 0;

  User(this._name) {
    //
  }

  String get name  => _name;
  int    get wins  => _wins;
  int    get loses => _loses;

  int get rank => wins - loses;
}