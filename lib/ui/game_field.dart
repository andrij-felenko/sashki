import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shashki/model/fishka.dart';
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
    Provider.of <Field>(context, listen:false).click(Position(x, y));
  }

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
          Consumer <Field> (
            builder: (context, field, child) => Stack(
              children: [
                ...field.white.fishks.map((item) => ChangeNotifierProvider.value (
                  value: item,
                  child: Consumer <Fishka> (
                    builder: (context, i, child) {
                      return Positioned (
                        left: 4 + i.coord.x * 49,
                        top: 4 + i.coord.y * 49,
                        child: GestureDetector(
                          onTap: () { field.click(i.coord); },
                          child: Container (
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration (
                              borderRadius: BorderRadius.circular(20),
                              color: field.current_select_field == i.coord ? Colors.blue[50]
                                                                           : Colors.blue[500],
                              border: Border.all(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )).toList(),
                ...field.black.fishks.map((item) => ChangeNotifierProvider.value (
                  value: item,
                  child: Consumer <Fishka> (
                    builder: (context, i, child) {
                      return Positioned (
                        left: 4 + i.coord.x * 49,
                        top: 4 + i.coord.y * 49,
                        child: GestureDetector(
                          onTap: () { field.click(i.coord); },
                          child: Container (
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration (
                              borderRadius: BorderRadius.circular(20),
                              color: field.current_select_field == i.coord ? Colors.yellow[50]
                                  : Colors.yellow[500],
                              border: Border.all(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}