import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './field_item.dart';
import '../model/field.dart';
import '../model/position.dart';

import 'package:provider/provider.dart';

class GameField extends StatefulWidget {
  const GameField({
    super.key,
  });

  @override
  State<GameField> createState() => _GameField();
}

class _GameField extends State<GameField> {
  void _onGridItemTap(int x, int y) {
    field.click(Position(x, y)); 
  }

  static Field field = Field();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GridView.builder(
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
          ),
          ...field.white.fishks.map((item) => ChangeNotifierProvider.value(
            value: item.coord,
            child: Positioned(
              left: 4 + item.coord.x * 49,
              top: 4 + item.coord.y * 49,
                child: GestureDetector(
                  onTap: () {
                    field.click(item.coord);
                  },
                  child: ChangeNotifierProvider.value(
                    value: field.current_select_field,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: field.current_select_field == item.coord ? Colors.blue[200] : Colors.red[400], 
                        border: Border.all(color: Colors.white),
                      ),
                    )
                  )
                ), 
              ),
          )).toList(),
          ...field.black.fishks.map((item) => Positioned(
            left: 4 + item.coord.x * 49,
            top: 4 + item.coord.y * 49,
            child: GestureDetector(
              onTap: () => field.click(item.coord),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.yellow[200], 
                  border: Border.all(color: Colors.white),
                ),
              ),
            )
          )).toList(),
        ],
      ),
    );
  }
}