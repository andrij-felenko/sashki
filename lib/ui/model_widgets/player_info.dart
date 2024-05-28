import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shashki/model.dart';

class PlayerInfo extends StatelessWidget {
  final Color _back;
  final Color _text;
  final Player _player;

  const PlayerInfo(this._back, this._text, this._player, {super.key});

  @override
  Widget build(BuildContext context) => Container (
    color: _back,
    child: ChangeNotifierProvider.value (
      value: _player,
      child: Consumer <Player>(
        builder: (context, item, child) => _infoAlign(context, _player),
      ),
    ),
  );

  Widget _infoAlign(BuildContext context, Player i) {
    return Align(
      child: Flex (
        direction: Axis.vertical,
        children: [
          _textItem('Player name: ${_player.user.name}'),
          _textItem('rank: ${_player.user.rank} (${_player.user.wins}-${_player.user.loses})'),
          const Divider( thickness: 1, color: Colors.black, indent: 12, endIndent: 12 ),
          _textItem('pawn - ${_player.piecesCount(Status.pawn)} - ${_player.piecesCount(Status.beaten)} - dead'),
          _textItem('queen - ${_player.piecesCount(Status.queen)}'),
          const Divider( thickness: 1, color: Colors.black, indent: 12, endIndent: 12 ),
          _textItem('turn time: 0:00'),
          _textItem('total time: 12:34'),
        ],
      ),
    );
  }

  Widget _textItem(String text) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) => Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
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

    // return Expanded(
    //   child: LayoutBuilder (
    //     builder: (context, constraints) => Center (
    //       heightFactor: 1,
    //       child: Text (
    //         text,
    //         textAlign: TextAlign.left,
    //         style: TextStyle(
    //             fontSize: constraints.maxHeight * 0.5,
    //             color: _text,
    //         ),
    //       ),
    //     )
    //   ),
    // );
  }
}