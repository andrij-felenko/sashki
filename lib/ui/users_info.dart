import 'package:flutter/material.dart';
import './game_field.dart';
// import '../model/field.dart';

class UsersInfo extends StatefulWidget {
  const UsersInfo({
    super.key,
  });

  @override
  State<UsersInfo> createState() => _UsersInfo();
}

class _UsersInfo extends State<UsersInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: const Text('${111}'),
        ),
      )
    );
  }
}