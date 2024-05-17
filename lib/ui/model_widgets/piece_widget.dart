import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shashki/model/board.dart';
import 'package:shashki/model/piece.dart';

class PieceWidget extends StatelessWidget {
  final List <Piece> _pieces;
  final Color _defaultColor;
  final Color _selectedColor;

  PieceWidget(this._pieces, this._defaultColor, this._selectedColor, {Key? key})
      : super(key: key ?? UniqueKey()){
    //
  }

  @override
  Widget build(BuildContext context) => Stack (
    children: _pieces.map((item) => ChangeNotifierProvider.value (
      value: item,
      child: Consumer <Piece> (
        builder: (context, i, child) => _buildPieceItem(context, i)
      ),
    )).toList(),
  );

  Widget _buildPieceItem(BuildContext context, Piece i) {
    return Positioned(
      left: 4 + i.pos.x * 49,
      top:  4 + i.pos.y * 49,
      child: GestureDetector (
        onTap: () { Board().click(i.pos); },
        child: Container (
          width: 40,
          height: 40,
          decoration: BoxDecoration (
            borderRadius: BorderRadius.circular(20),
            /// better use this, but i`m add singleton, so...
            /// color: Provider.of <Board> (context, listen: false).selectedField == i.pos
            color: Board().selectedField == i.pos ? _selectedColor : _defaultColor,
            border: Border.all(color: Colors.white),
          ),
        ),
      )
    );
  }
}