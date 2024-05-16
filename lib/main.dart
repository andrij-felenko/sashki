import 'package:flutter/material.dart';

import 'package:shashki/ui/game_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shashki',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 58, 85, 183)),
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
      body: Center (
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
      )
    );
  }
}
