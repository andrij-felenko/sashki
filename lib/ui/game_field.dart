import 'package:flutter/material.dart';
import './field_item.dart';

class GameField extends StatefulWidget {
  const GameField({
    super.key,
  });

  @override
  State<GameField> createState() => _GameField();
}

class _GameField extends State<GameField> {
  void _onGridItemTap(int x, int y) {
    print('Tapped on: ($x, $y)');
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8, 
        childAspectRatio: 1, 
      ),
      itemCount: 64, 
      itemBuilder: (BuildContext context, int index) {
        int x = index % 8;
        int y = index ~/ 8;

        return FieldItem(
          index: index,
          x: x,
          y: y,
          onTap: () => _onGridItemTap(x, y),
        );
      },
    );
  }
}