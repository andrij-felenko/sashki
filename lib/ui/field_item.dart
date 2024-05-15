import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: ((widget.index ~/ 8)%2) == (widget.index%2) ? Colors.grey[200] : Colors.black,
        ),
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