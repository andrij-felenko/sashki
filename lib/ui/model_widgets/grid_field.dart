import 'package:flutter/material.dart';
import '../field_item.dart';
import 'package:shashki/model.dart';

class GridField extends StatelessWidget {
  const GridField({super.key});

  @override
  Widget build(BuildContext context) => GridView.builder (
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 8,
      childAspectRatio: 1,
    ),
    itemCount: 64,
    itemBuilder: _itemBuilder,
  );

  Widget _itemBuilder(BuildContext context, int index) {
    int x = index % 8;
    int y = index ~/ 8;
    return FieldItem(index, x, y, onTap: () => Board().click(Position(x, y)));
  }
}