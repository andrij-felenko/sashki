import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:shashki/ui/game_field.dart';
import 'package:shashki/ui/model_widgets/player_info.dart';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue, // Колір рядка стану
      statusBarIconBrightness: Brightness.light, // Колір іконок у рядку стану
    ));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:Size.fromHeight(MediaQuery.of(context).padding.top * 0),
        child: AppBar(
          backgroundColor: Colors.deepPurple, // Колір AppBar
          elevation: 0, // Без тіні
        ),
      ),
      body: LayoutBuilder (
        builder: (context, constrains) {
          double width = constrains.maxWidth;
          double height = constrains.maxHeight;
          double boardSize = min(width, height);
          double infoSize = max(width, height) - min(width, height);
          Axis axis = width < height ? Axis.vertical : Axis.horizontal;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            Board().widgetSize = boardSize / 8;
          });

          var board = Flexible(
            flex: 0,
            child: SizedBox(
              width: boardSize,
              height: boardSize,
              child: const GameField(),
            ),
          );

          var whiteP = Expanded(
            flex: 1,
            child: PlayerInfo ( Colors.black12, Colors.black, Board().white ),
          );

          var blackP = Expanded(
            flex: 1,
            child: PlayerInfo ( Colors.black54, Colors.white, Board().black ),
          );

          return Flex (
            direction: axis,
            children: [ whiteP, board, blackP ],
            // its another possible placement, maybe its better
            // children: axis == Axis.horizontal ? [whiteP, board, blackP]
            //   : [
            //     board,
            //     Expanded (
            //       child: Flex (
            //         direction: Axis.horizontal,
            //         children: [ whiteP, blackP ],
            //       ),
            //     ),
            // ],
          );
        },
      ),
    );
  }
}
