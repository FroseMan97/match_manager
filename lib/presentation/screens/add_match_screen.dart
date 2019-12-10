import 'package:flutter/material.dart';

class AddMatchScreen extends StatefulWidget {
  @override
  _AddMatchScreenState createState() => _AddMatchScreenState();
}

class _AddMatchScreenState extends State<AddMatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Создание матча'),),
      body: Center(child: Text('Создать матч'),),
    );
  }
}