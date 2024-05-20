import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/player.dart';

class PlayerInfo extends StatelessWidget {
  Color _back;
  Color _text;
  Player _player;

  PlayerInfo(this._back, this._text, this._player, {super.key});

  Widget build(BuildContext context) => Container (
    color: _back,
    child: Align (
      child: Flex (
        direction: Axis.vertical,
        children: [
          _textItem('Player name: ${_player.user.name}'),
          _textItem('rank: ${_player.user.rank} (${_player.user.wins}-${_player.user.loses})'),
          Divider( thickness: 1, color: Colors.black, indent: 12, endIndent: 12 ),
          _textItem('pawn - 12 - 10 - dead'),
          _textItem('queen - 0'),
          Divider( thickness: 1, color: Colors.black, indent: 12, endIndent: 12 ),
          _textItem('turn time: 0:00'),
          _textItem('total time: 12:34'),
        ],
      ),
    ),
  );

  Widget _textItem(String text) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) => Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0), // Optional: add padding if needed
            child: Container(
              height: constraints.maxHeight,
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: constraints.maxHeight * 0.5,
                  color: _text
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return Expanded(
      child: LayoutBuilder (
        builder: (context, constraints) => Center (
          heightFactor: 1,
          child: Text (
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: constraints.maxHeight * 0.5,
                color: _text,
            ),
          ),
        )
      ),
    );
  }
}