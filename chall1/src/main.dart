import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chall1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // FL
  // AG{
  // this_is
  // _debug_build}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('chall1'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Welcome to Flutter Labs!!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
