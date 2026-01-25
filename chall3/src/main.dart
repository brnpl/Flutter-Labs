import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chall3',
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

  void _onButtonPressed() {
    final flag = computeFlag();
    setState(() => _result = 'Flag computed in memory!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chall3'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _onButtonPressed,
              child: Text('Click to compute the flag!'),
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

String computeFlag() {
  final encoded = [71, 77, 66, 72, 124, 105, 112, 112, 108, 106, 111, 104, 96, 101, 98, 115, 117, 96, 100, 112, 101, 102, 126];
  
  return String.fromCharCodes(
    encoded.map((byte) => byte - 1).toList()
  );
}