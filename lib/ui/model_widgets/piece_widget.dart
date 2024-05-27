import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shashki/model/board.dart';
import 'package:shashki/model/piece.dart';
import 'package:shashki/model/position.dart';

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
        builder: (context, item, child) {
          print('Rebuilding piece: ${item.pos}');

          return _buildPieceItem(context, item);
        }
      ),
    )).toList(),
  );

  Widget _buildPieceItem(BuildContext context, Piece i) {
    double emptyShift = 0.1;
    Position newPos = i.pos;
    print("ooop $newPos");

    return Positioned(
      left: (newPos.x + emptyShift) * Board().widgetSize,
      top:  (newPos.y + emptyShift) * Board().widgetSize,
      child: GestureDetector (
        onTap: () { Board().click(i.pos); },
        child: Container (
          width: Board().widgetSize * (1 - 2 * emptyShift),
          height: Board().widgetSize * (1 - 2 * emptyShift),
          decoration: BoxDecoration (
            borderRadius: BorderRadius.circular(Board().widgetSize / 2),
            color: Board().selectedField == i.pos ? _selectedColor : _defaultColor,
            border: Border.all(color: Colors.white), 
          ),
        ),
      )
    );
  }
}