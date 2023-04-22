import 'package:pi5_flutter_application/pages/indexPage.dart';
import 'package:flutter/material.dart';
import 'package:pi5_flutter_application/pages/loginPage.dart';
import 'package:pi5_flutter_application/pages/signUpPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PI5',
      theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
          colorSchemeSeed: Colors.green),
      home: const IndexPage(),
    );
  }
}
