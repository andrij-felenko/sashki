import 'package:flutter/material.dart';
import '../model/position.dart';
import '../model/field.dart';

class FieldItem extends StatefulWidget {
  const FieldItem({
    super.key,
    required this.index,
    required this.x,
    required this.y,
    required this.onTap,
  });

  final int index;
  final int x;
  final int y;
  final VoidCallback onTap;

  @override
  State<FieldItem> createState() => _FieldItem();
}

class _FieldItem extends State<FieldItem> {
  int currentItemX = 0;
  int currentItemY = 0;
  List<int> chosenCoordinates = [0, 0];

  void moveItem(int x, int y) {
    setState(() {
      // currentItemX = chosenCoordinates[0];
      // currentItemY = chosenCoordinates[1];

      currentItemX = 1;
      currentItemY = 1;
    });

    print('${x}, ${y}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: (widget.index ~/ 8)%2 == widget.index%2 ? Colors.grey[200] : Colors.black,
        ),
        // child: Center(
        //   child: widget.x == pos.x && widget.y == pos.y ? TextButton(
        //     onPressed: () { 
        //       moveItem(widget.x, widget.y); 
        //     },
        //     child: const Text('F'),
        //     style: ButtonStyle(
        //     ),
        //   ) : 
        //   Text(
        //     '(${widget.x}, ${widget.y})',
        //     style: TextStyle(
        //       color: Colors.grey[600],
        //     ),
        //   ),
        // ),
        // child: Center(
        //   child: Text(
        //     '(${widget.x}, ${widget.y})',
        //     style: TextStyle(
        //       color: Colors.grey[600],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}