import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chall5',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = MethodChannel('root_check_channel');
  String _rootStatus = 'Checking device...';

  @override
  void initState() {
    super.initState();
    _checkRoot();
  }

  Future<void> _checkRoot() async {
    try {
      final bool isRooted = await platform.invokeMethod('isRooted');
      setState(() {
        _rootStatus = isRooted
            ? 'Sorry, this device is rooted! Checked with Platform (Java/Kotlin) RootBeer'
            : _randomstuff();
      });
    } on PlatformException catch (e) {
      setState(() {
        _rootStatus = "Failed to check root: ${e.message}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('chall5'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            _rootStatus,
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

String _randomstuff() {
final encoded = [
  75,   81,   70,   76,   128,   109,
  116,   116,   112,   110,   115,   108,
  100,   117,   113,   102,   121,   107,
  116,   119,   114,   100,   104,   116,
  105,   106,   130, 
];

  return String.fromCharCodes(
    encoded.map((v) => v - 5)
  );
}
