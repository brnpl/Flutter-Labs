import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chall8',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String url1 =
      'https://raw.githubusercontent.com/brnpl/Flutter-Labs/refs/heads/master/_flags/chall8_1.txt';
  static const String url2 =
      'https://raw.githubusercontent.com/brnpl/Flutter-Labs/refs/heads/master/_flags/chall8_2.txt';
  static const String url3 =
      'https://raw.githubusercontent.com/brnpl/Flutter-Labs/refs/heads/master/_flags/chall8_3.txt';

  static const List<String> fingerprints = [
    '7D:11:22:EA:96:98:52:34:1E:8D:D9:2B:CC:0C:7E:CC:00:96:30:D1:4D:A7:34:D7:CA:42:D5:B5:4A:2B:20:97'
  ];

  Future<void> method1(BuildContext context) async {
    try {
      final result = await HttpCertificatePinning.check(
        serverURL: url1,
        headerHttp: {},
        sha: SHA.SHA256,
        allowedSHAFingerprints: fingerprints,
        timeout: 10,
      );

      if (!result.contains('CONNECTION_SECURE')) {
        throw Exception('Connection Not Secure (TLS cert failed)');
      }

      final response = await http.get(Uri.parse(url1));
      _showResult(context, 'HTTPS 1', response.statusCode);
    } catch (e) {
      _showError(context, 'HTTPS 1 Error', e);
    }
  }

  Future<void> method2(BuildContext context) async {
    try {
      final dio = Dio()
        ..interceptors.add(
          CertificatePinningInterceptor(
            allowedSHAFingerprints: fingerprints,
          ),
        );

      final response = await dio.get(url2);
      _showResult(context, 'HTTPS 2', response.statusCode ?? 0);
    } catch (e) {
      _showError(context, 'HTTPS 2 Error', e);
    }
  }

  Future<void> method3(BuildContext context) async {
    try {
      final secureClient = SecureHttpClient.build(
        fingerprints,
      );

      final response = await secureClient.get(Uri.parse(url3));
      _showResult(context, 'HTTPS 3', response.statusCode);
    } catch (e) {
      _showError(context, 'HTTPS 3 Error', e);
    }
  }

  void _showResult(BuildContext context, String title, int status) {
    _showDialog(
      context,
      title,
      status == 200 ? '200 OK' : 'HTTP $status',
      status == 200 ? Colors.green : Colors.red,
    );
  }

  void _showError(BuildContext context, String title, Object e) {
    _showDialog(context, title, e.toString(), Colors.red);
  }

  void _showDialog(
    BuildContext context,
    String title,
    String message,
    Color color,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Icon(
              color == Colors.green ? Icons.check_circle : Icons.error,
              color: color,
            ),
            const SizedBox(width: 10),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('chall8'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SSL Pinning',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 25),

            ElevatedButton(onPressed: () => method1(context), child: const Text('HTTPS 1 (HttpCertificatePinning)')),
            ElevatedButton(onPressed: () => method2(context), child: const Text('HTTPS 2 (Dio)')),
            ElevatedButton(onPressed: () => method3(context), child: const Text('HTTPS 3 (SecureHttpClient)')),
          ].expand((w) => [w, const SizedBox(height: 12)]).toList()
            ..removeLast(),
        ),
      ),
    );
  }
}