import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shashki/ui/game_field.dart';
import 'model/board.dart';
import 'dart:math';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value (value: Board()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shashki',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(
            255, 12, 213, 255)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Shashki'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void resetGame() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder (
        builder: (context, constrains) {
          print('aaaa $constrains');
          double width = constrains.maxWidth;
          double height = constrains.maxHeight;
          print('assssss $width $height');
          double boardSize = min(width, height);
          double infoSize = max(width, height) - min(width, height);
          Axis axis = width < height ? Axis.vertical : Axis.horizontal;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Board().widgetSize = boardSize / 8;
          });

          return Flex (
            direction: axis,
            children: [
              SizedBox(
                width: boardSize,
                height: boardSize,
                child: const GameField(),
              ),
              Container (
                color: Colors.red,
                width: axis == Axis.vertical ? boardSize : infoSize,
                height: axis == Axis.vertical ? infoSize : boardSize,
              )
            ],
          );
        },
      ),
      /* const Flex (
        direction: Axis.vertical,
        children: [
          SizedBox(width: 100, height: 100, child: GameField()),
        ],
      )
      Center (
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 90, 10, 10),
          child: Column(
            children: <Widget>[
              const Expanded(child: GameField()),
              ElevatedButton(
                onPressed: () {}, 
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              )
            ],
          ),
        ),
      )*/
    );
  }
}
