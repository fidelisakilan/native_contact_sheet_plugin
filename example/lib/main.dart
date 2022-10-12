import 'package:contact_sheet/contact_sheet.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: OutlinedButton(
            onPressed: () {
              ContactSheet().open(
                name: 'David',
                org: 'Arasaka',
                phone: ['+91000000'],
                email: 'example@gmail.com',
              );
            },
            child: const Text('Open Contact Sheet'),
          ),
        ),
      ),
    );
  }
}
