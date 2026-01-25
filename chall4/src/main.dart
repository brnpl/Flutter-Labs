import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chall4',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _result = '';
  final Random _random = Random();

  bool amILucky() {
    return _random.nextInt(2147483647) == -1;
  }

  // Function generate flag using XOR on integers (otherwise it can be easily retrieved from strings)
  String randomstuff() {
    String input = r"EOBDxkllhjmd\qfwvqm\ubovf~"; // raw string
    List<int> output = [];

    for (int i = 0; i < input.length; i++) {
      int c = input.codeUnitAt(i) ^ 0x3;
      output.add(c);
    }

    return String.fromCharCodes(output);
  }

  void _onButtonPressed() {
    setState(() {
      if (amILucky()) {
        _result = randomstuff();
      } else {
        _result = 'Oops! Not lucky this time!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chall4'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _onButtonPressed,
              child: Text('Am I Lucky?'),
            ),
            SizedBox(height: 40),
            Text(
              _result,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
