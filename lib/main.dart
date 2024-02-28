import 'package:flutter/material.dart';
import '_RpnCalculatorState.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPN Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RpnCalculator(),
    );
  }
}



