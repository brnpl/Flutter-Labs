import 'package:flutter/material.dart';
import 'package:root_jailbreak_sniffer/rjsniffer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chall9',
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
  String _rootStatus = 'Checking device...';

  @override
  void initState() {
    super.initState();
    _checkRoot();
  }

  Future<void> _checkRoot() async {
    try {
      final bool compromised =
          await Rjsniffer.amICompromised() ?? false;

      final bool emulator =
          await Rjsniffer.amIEmulator() ?? false;

      final bool debugged =
          await Rjsniffer.amIDebugged() ?? false;

      setState(() {
        if (compromised) {
          _rootStatus =
              'Sorry, rooted device! Checked with Rjsniffer';
        } else if (emulator) {
          _rootStatus =
              'Sorry, cannot run on an emulator! Checked with Rjsniffer';
        } else if (debugged) {
          _rootStatus =
              'Sorry, debugger detected! Checked with Rjsniffer';
        } else {
          _rootStatus = _randomstuff();
        }
      });
    } catch (e) {
      setState(() {
        _rootStatus = "Failed to check device: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('chall9'),
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
  75, 81, 70, 76, 128, 109, 116, 116, 112,
  110, 115, 108, 100, 121, 109, 110, 119, 105,
  100, 117, 102, 119, 121, 100, 113, 110, 103,
  119, 102, 119, 110, 106, 120, 130,
];

  return String.fromCharCodes(
    encoded.map((v) => v - 5)
  );
}