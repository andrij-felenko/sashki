import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shashki/model/board.dart';
import 'package:shashki/model/piece.dart';

class PieceWidget extends StatelessWidget {
  final List <Piece> _pieces;
  final Color _defaultColor;
  final Color _selectedColor;

  PieceWidget(
      this._pieces,
      this._defaultColor, this._selectedColor,
      {Key? key})
  : super(key: key ?? UniqueKey()) {
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
    double emptyShift = 0.1;

    return Positioned(
      left: (i.pos.x + emptyShift) * Board().widgetSize,
      top:  (i.pos.y + emptyShift) * Board().widgetSize,
      child: GestureDetector (
        onTap: () { Board().click(i.pos); },
        child: Container (
          width: Board().widgetSize * (1 - 2 * emptyShift),
          height: Board().widgetSize * (1 - 2 * emptyShift),
          decoration: BoxDecoration (
            borderRadius: BorderRadius.circular(Board().widgetSize / 2),
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