import 'package:flutter/material.dart';
import 'package:shashki/model/board.dart';
import 'model_widgets/grid_field.dart';
import 'model_widgets/piece_widget.dart';

import 'package:provider/provider.dart';

class GameField extends StatefulWidget {
  const GameField( { super.key });

  @override
  State<GameField> createState() => _GameField();
}

class _GameField extends State<GameField> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const GridField(),
          Consumer <Board> (
            builder: (context, board, child) => Stack(
              children: [
                PieceWidget(board.white.pieces, Colors.blue[500]!, Colors.blue[50]!),
                PieceWidget(board.black.pieces, Colors.yellow[500]!, Colors.yellow[50]!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}