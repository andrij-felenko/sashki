import 'package:flutter/material.dart';

class GameField extends StatefulWidget {
  const GameField({
    super.key,
  });

  @override
  State<GameField> createState() => _GameField();
}

class _GameField extends State<GameField> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Field"),
      ),
    );
  }
}