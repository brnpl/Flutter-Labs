import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chall6',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  Future<void> makeHttpsRequest(BuildContext context) async {
    try {
    
      final response = await http.get(
        Uri.parse('https://raw.githubusercontent.com/brnpl/Flutter-Labs/refs/heads/master/_flags/chall6.txt'),
      ).timeout(Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        _showDialog(context, 'Success', '200 OK', Colors.green);
      } else {
        _showDialog(context, 'Failed', 'Status: ${response.statusCode}', Colors.red);
      }
    } catch (e) {
      _showDialog(context, 'Request Failed', 'Error: $e', Colors.red);
    }
  }

  void _showDialog(BuildContext context, String title, String message, Color color) {
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
              SizedBox(width: 10),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
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
        title: Text('chall6'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Intercept my traffic!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                makeHttpsRequest(context);
              },
              child: Text('HTTPS Request'),
            ),
          ],
        ),
      ),
    );
  }
}