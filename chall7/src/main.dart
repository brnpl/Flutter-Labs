import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

const MethodChannel _channel = MethodChannel('integrity_check');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final bool integrityOk =
      await _channel.invokeMethod<bool>('checkFlutterIntegrity') ?? false;

  runApp(MyApp(integrityOk: integrityOk));
}

class MyApp extends StatelessWidget {
  final bool integrityOk;

  const MyApp({super.key, required this.integrityOk});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chall7',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: integrityOk ? HomePage() : TamperedPage(),
    );
  } 
}

class TamperedPage extends StatelessWidget {
  const TamperedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('chall7'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Intercept my traffic (again)!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            const SizedBox(height: 20),
            const Text(
              'File integrity error. The application has been tampered.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            const SizedBox(height: 10),
            const Text(
              'The application cannot continue.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: null,
              child: const Text('HTTPS Request'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> makeHttpsRequest(BuildContext context) async {
    try {
      
      final response = await http.get(
        Uri.parse('https://raw.githubusercontent.com/brnpl/Flutter-Labs/refs/heads/master/_flags/chall7.txt'),
      ).timeout(const Duration(seconds: 10));
            
      if (response.statusCode == 200) {
        _showDialog(context, 'Success', '200 OK', Colors.green);
      } else {
        _showDialog(
          context,
          'Failed',
          'Status: ${response.statusCode}',
          Colors.red,
        );
      }
    } catch (e) {
      _showDialog(context, 'Request Failed', 'Error: $e', Colors.red);
    }
  }

  void _showDialog(
    BuildContext context,
    String title,
    String message,
    Color color,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                title == 'Success' ? Icons.check_circle : Icons.error,
                color: color,
              ),
              const SizedBox(width: 10),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('chall7'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Intercept my traffic (again)!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                makeHttpsRequest(context);
              },
              child: const Text('HTTPS Request'),
            ),
          ],
        ),
      ),
    );
  }
}